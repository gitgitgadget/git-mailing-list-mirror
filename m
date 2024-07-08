Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E136A29
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471231; cv=none; b=BKIgYNXSpslRslY3poX+i7bt9CYyTGYgVE93vNtpqTa0hpGQ661gaVrxEwKiKlF/Nl6khZ92uCh+7Vzchp4y67DnBfmR4AArb99jPweXHbtzDOslRdSIf4zJ9LQP5/q1Vcp75AmxTAfn68C/pxLBleXHv70g6+mAmrQEWMP5HXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471231; c=relaxed/simple;
	bh=C0CTnZYCP9m6AiZNEbPG03nv121uWfTLpJ/LYatmx9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ma02m2puM7Dd51WLOzEZGiXFLXEl63WI/Cj6paoHlakGrO6V5W5pNeI4XYg7IY9Sk3TRoXcIBzsx5Sb2GF6Uk3jImhGd2a5HPB0TndEjsB7Z8QFo5i0mPD5FG/ayyV8iH9IRqdSKBGOmuLgYw5DvoNLiHXRYap+rPQTqPJRCfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4WHwwz1w3GzRnmT;
	Mon,  8 Jul 2024 22:40:19 +0200 (CEST)
Message-ID: <ab9824ee-65e1-4e4b-b739-205f2c5d24fe@kdbg.org>
Date: Mon, 8 Jul 2024 22:40:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
 Sean Allred <allred.sean@gmail.com>
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
 <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
 <m034onpng4.fsf@epic96565.epic.com>
 <CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
 <752d41f9-6ce3-4c31-a0a2-4960c7dc1b2b@kdbg.org> <xmqqtth2petz.fsf@gitster.g>
 <028ae5d6-b587-4ffe-b837-38f2c13992ae@kdbg.org>
 <CAHPHrSfVLLn_djR1eo06fr5OPaz2RAChv8dBJ8eJKB6b6snWnA@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAHPHrSfVLLn_djR1eo06fr5OPaz2RAChv8dBJ8eJKB6b6snWnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.07.24 um 21:29 schrieb Brian Lyles:
> Could you elaborate on why git-gui's commit message edit box should
> behave differently than any other commit message editor? Why is there no
> concept as "comment lines" in git-gui?

First of all, Git GUI is not a commit message editor, not even in its
git citool incarnation. You cannot instruct git commit to use it as
message editor.

Consider the commit message that git commit presents in the editor. It
contains the message text, instructions about how to use the tool, a
list of files, and sometimes even patch text.

Git GUI does that, too: There is the part where the message is entered,
there is a list or two of files, and there is patch text. (OK, there are
no instructions.) What the user writes into the part for the message
text must go into the commit. Except that the git commit's message
editor has a limitation: it can't tell the subsequent post processing
with absolute certainty which text is message text due to the possible
comment lines. Git GUI can offer this certainty because its
corresponding section is a dedicated text edit box.

> I think that whatever path forward is taken, it needs to be predictable
> and consistent with normal `git commit` behaviors. I think that's the
> root problem here in my mind: From the perspective of the
> prepare-commit-msg hook, it's impossible to do the right thing because
> git-gui is invoking the hook consistent with normal `git commit`
> behaviors, but then creating the commit with `git commit -F` behaviors.
> This is an inconsistency with git-gui specifically.

Good that you point that out. Git GUI does the wrong thing here. It
should really request the form corresponding to git commit -F. The
second option that you suggest looks correct to me:

> So it still seems like we have two real options:
> 
> - Start washing the message, allowing the prepare-commit-msg hook to
>   provide template-like guidance to the user regardless of if they are
>   using git-gui or some other editor, or
> - Pass the "message" argument along to the prepare-commit-msg hook so
>   that it can at least avoid adding template-like content (but of course
>   then lose the value added by that template).

-- Hannes

