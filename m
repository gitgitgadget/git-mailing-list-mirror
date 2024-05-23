Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113C128365
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506508; cv=none; b=GkM4LOORDjjJIwcNpNqD6h3Uo0bLiDMKo0XowhA5qPUZvjJLwWifefz+Usv0FZbsbbuypcI6Z355IzViA3+Tkap2lMEa074PU794UPH6xSNNNxdfn2PmQwf0+U33PeuZN9mlmsNCLuu5aHU2gCWie+EF//k36QQYejJ+JVBQu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506508; c=relaxed/simple;
	bh=g6rS5B9AZwXHkvGn3XPSJjkMGN/S0c5FHOQ9DYcZoog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k27cqsAKAVTDIRZ8TPWwjM5WBPuQtFvCm3+5Z2ws8xVRezIv+aP7p2xFwZaMCE3ApTk1EzR5Fkxrip3YWs4w8zwD07Hz2WXwledCLJY/f+Hdgd2yFYV9YLL16fuG7fHWtG2x1V/M0L7EkWFBKlOVULiEwOBAk98gytdw7P0opYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 18894 invoked from network); 23 May 2024 23:21:42 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 23 May 2024 23:21:42 -0000
Date: Fri, 24 May 2024 01:21:41 +0200
From: Marcel Telka <marcel@telka.sk>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
Message-ID: <Zk_PhSQU2vefKkjq@telcontar>
References: <Zkdk7R9GIfsyQjkc@telcontar>
 <xmqqsey8tnny.fsf@gitster.g>
 <Zk-nswiCF-SnyxLE@telcontar>
 <CAPig+cRddr=JTVvkh5xkptag_1C5-z1t9Pzr_OdcGFSVwRg3vg@mail.gmail.com>
 <Zk-5YCKSO32vPKDP@telcontar>
 <Zk_FiYd8uk-P5jIi@telcontar>
 <xmqqcypcqgf9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcypcqgf9.fsf@gitster.g>

On Thu, May 23, 2024 at 04:03:54PM -0700, Junio C Hamano wrote:
> Marcel Telka <marcel@telka.sk> writes:
> 
> > Okay, I found the cause.  Bash on OpenIndiana is compiled with
> > --enable-xpg-echo-default so escape sequencies are expanded by default.
> >
> >> OTOH, it seems that the fix is maybe not needed because it is solving a
> >> non-problem.
> >
> > There is a problem, but definitely the justification in the commit
> > message is not accurate because we do not care about POSIX here at all.
> > Also maybe it would be better/simpler to use `echo -E` instead of
> > `printf`, but I'm not sure here.
> 
> How "portable" is "echo -E"?  It apparently is not listd in [*], but
> it should probably not matter as we are doing this in bash.

Agreed.

> printf is a kosher way whose behaviour is pretty well standardized
> especially with respect to "%s".  As I said that I was going to
> merge it down to 'master' already, it is now part of 'master'.
> Use of printf there may hopefully educate folks to think twice
> before using 'echo' on unknown data.
> 
> By the way, it makes me feel funny that we are talking about "POSIX
> portability" when reviewing a change like this:
> 
>          print_comp ()
>          {
>                 local IFS=$'\n'
>         -	echo "${COMPREPLY[*]}" > out
>         +	printf '%s\n' "${COMPREPLY[*]}" > out
>          }
> 
> With "${ARRAY[*]}", POSIX portability is totally out of the water
> anyway, regardless of the echo/printf issue ;-).

The commit message does not say that this change is to make the code
POSIX portable ;-).  It silently assumes the portability is related to
bash only.

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
