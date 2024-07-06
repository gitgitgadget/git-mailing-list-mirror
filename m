Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64874070
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274650; cv=none; b=o2YG6X1p8ZTIPnadnaCKeUKKd/fPvqXEl3m0jfykSdlNzTQrA1CB1GGOwECAKHWqI5aq8g5+TnoSUnbV/J1uIY6N6oix0YR39AaVpfrD2N4oqKr2gS8/sMkndwVCiO00qxJJd/HyLss7R6cvOwp1Su1Y01sZ4aH/vmMPr1kvUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274650; c=relaxed/simple;
	bh=tq+4FKE7h3MfQOM3NWkXbHPCrLA5vEfnVpeo1Q/j4wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rr3IUi/rLawX/GHpw980WeAm+xualvr9xW+gaAvfaU+1c7Vq1S1c4RpzenRtD2CFWgcgto288LTwoMBq1w7KGzCrqIyjJcTn3BwXfveKqtQBjs8fii4/M0mEMm3Jb0FVENC09dZQU7Gc6BUMDEHJsv2bmH79jxnpEFE8kW2w8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WGXDc15TPz5wDj
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 16:04:00 +0200 (CEST)
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4WGXDR6BFmzRpKn;
	Sat,  6 Jul 2024 16:03:51 +0200 (CEST)
Message-ID: <752d41f9-6ce3-4c31-a0a2-4960c7dc1b2b@kdbg.org>
Date: Sat, 6 Jul 2024 16:03:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: brianmlyles <brianmlyles@gmail.com>, git@vger.kernel.org,
 Sean Allred <allred.sean@gmail.com>
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
 <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
 <m034onpng4.fsf@epic96565.epic.com>
 <CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 05.07.24 um 23:47 schrieb Eric Sunshine:
> On Fri, Jul 5, 2024 at 4:56 PM Sean Allred <allred.sean@gmail.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> On Fri, Jul 5, 2024 at 3:23 PM brianmlyles <brianmlyles@gmail.com> wrote:
>>>> - Have git-gui create the commit in a way that causes the message to be
>>>>   washed
>>>
>>> A patch to make git-gui strip comment lines had been previously
>>> applied[1,2], however, it badly broke git-gui when running with old
>>> Tcl versions, such as on macOS[3,4]. The breakage was not
>>> insurmountable, and a patch[5,6] was submitted to resolve it.
>>> Unfortunately, the then-maintainer of git-gui lost interest in the
>>> project about that point, thus left the issue hanging. Thus, to this
>>> day, git-gui still doesn't strip comment lines.
>>
>> There is a third option -- new plumbing in git (a la
>> git-interpret-trailers) to expose the logic of `cleanup_message`. This
>> comes with some nice flexibility, but introduces complexity around
>> transferring state (e.g. passed options to git-commit) that would
>> probably be best to avoid.
> 
> Could the cleanup_message() functionality be exposed as a new option
> of git-stripspace?
> 
>> I haven't looked super closely at the patches you've linked, Eric, but
>> it seems like those are specific to stripping comment characters. As
>> I've noted elsewhere[1], there's potentially more to strip than just
>> comments (like patch scissors). I suspect the only paths forward to
>> guarantee that message-washing happens would either be an option to
>> git-commit to explicitly enable it OR (probably preferred) have git-gui
>> invoke git-commit with an appropriate editor instead of using -F.
>>
>> [1]: https://lore.kernel.org/git/m0h6d3pphu.fsf@epic96565.epic.com/T/#u
> 
> You're correct that my interest in the issue was strictly due to the
> annoyance of git-gui failing to strip comments (in particular, the
> list of conflicted files automatically inserted into
> .git/MERGE_MSG)[*]. The subject of patch scissors did not come up in
> the linked discussions, and it wasn't apparent from Brian's message
> which started this thread that he was also concerned about patch
> scissors (his message mentioned only comments).
> 
> I responded separately to the message you cited above.
> 
> [*]: https://lore.kernel.org/git/CAPig+cTQaPTNnGcd583B=xoVUR1qPb372Y_x9szROfMcA5h+tA@mail.gmail.com/

Let's take a step back and ask why is there cruft in a commit message
that needs to be cleaned in the first place? It is because with the
command line `git commit` there is no side-channel that could
communicate the circumstances that lead up to a commit. This is not the
case in git gui. There are many instruments that can be used at the same
time that the commit message is authored; there is no reason to have a
list of conflicted files or the commit's patch text in the commit message.

My take-away is:

- The commit message that is entered in the edit box must appear in the
commit unmodified. There is no such concept as "comment lines" in git
gui's commit message edit box. The commit-msg hook can overrule
nevertheless as a means to enforce message hygiene, but otherwise the
user must have full authority.

- A commit message template and the MERGE_MSG file are populated in a
manner that is suitable for `git commit`, i.e. can (and do) contain
comment lines. It is, therefore, necessary to remove them when their
text is used to populate git gui's edit box.

I suggest that removing comment lines ("message-washing") should not
happen as a post-processing step, but as a preprocessing step when text
is gathered from particular sources that are known to contain
inessential cruft.

-- Hannes

