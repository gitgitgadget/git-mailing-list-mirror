From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git status --amend
Date: Tue, 31 Mar 2015 11:35:17 -0700
Message-ID: <xmqqvbhhqal6.fsf@gitster.dls.corp.google.com>
References: <551AB64F.4030400@cs-ware.de> <20150331180414.GB19206@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sven Strickroth <sven@cs-ware.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:35:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd10Y-00010X-HV
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 20:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbbCaSfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 14:35:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbbCaSfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 14:35:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CC3C44F63;
	Tue, 31 Mar 2015 14:35:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J3WaIPVemQXC8DrvSDMfvGIwsMk=; b=ULslxK
	PVvdeQXSVgL5UvXXSCLPqCwhcPAt4wnfJoiDrjfIV02ZeT4uUIBkN1XWqa2Ss/0C
	yB0oLv+pM2MadwUHNHlfosoEMTJ9f2co1aD+JJLsUTin+Adm0yoCuGE40a0xL7RR
	B1BL8nSwuc2yp8qr5INvcdYMMshG5qcvMeHc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W2Q1haU4yhu9Zs+CQuc5n6pW+rur/h4u
	fw1N3p89/cwD1BDC+bCjPTkkoGklaca7pZc5h9cfKx5iIDil9kRerKYk+Vpu6cDR
	s4qa7vuFtvewzZunCBs0N5a3aucif77UKrL4UVbV1HHsZibrbv85zdBUk3y+A3Tq
	LNetPkFZaRI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7613F44F62;
	Tue, 31 Mar 2015 14:35:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC2CF44F60;
	Tue, 31 Mar 2015 14:35:18 -0400 (EDT)
In-Reply-To: <20150331180414.GB19206@peff.net> (Jeff King's message of "Tue,
	31 Mar 2015 14:04:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE91F960-D7D4-11E4-B41C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266546>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 31, 2015 at 04:59:27PM +0200, Sven Strickroth wrote:
>
>> for frontends or scripts it would be helpful to be able to use "git
>> status" for getting the repository status compared to HEAD~1 instead of
>> only HEAD (as provided by "git commit --amend" in the pre-filled commit
>> message).
>> 
>> Thus, I'm suggesting to add a "--amend" parameter (or a parameter with a
>> better naming) to "git status".
>> 
>> What do you think of this idea?
>
> Once upon a time "git status" really was just "git commit --dry-run".
> These days it has diverged a bit. But I think you could get what you
> want with:
>
>   git commit --dry-run --amend
>
> It even supports alternate styles like --short.

I think everything you said is correct, but your "diverged a bit"
may hide one difference that could be crucial depending on the use
case: pathspec.

What "git commit --dry-run [--other-options] <pathspec>" does, and
what "git status [--other-options] <pathspec>" does, are different.

With or without --dry-run, to "git commit", <pathspec> tells the
command to update the index at the paths specified by it from the
working tree contents before proceeding (the contents recorded for
the other paths depend on the use of -o or -i option).  But ever
since "git status" departed from being "git commit -n", a pathspec
given to the command means completely different thing.

After working on various parts of the tree, planning to conclude the
current work with "commit", "git status directory/" is a good way to
see what you did in that directory without seeing what you did
outside (which will be included in the commit, too).

But what you get from "git commit --no-edit --dry-run directory/"
would be different; it would show all the changes in the working
tree inside directory/, including the ones that you deliberately
left out of the index, as paths to be committed.

Having said all that, I am a bit torn on this topic.  Just like "git
status" is a way to ask "I've worked so far, planning to conclude
this with 'git commit'; tell me what I have achieved so far that are
in the index and in the working tree, possibly limiting to these
paths?", I think it is a reasonable thing to ask the same question
with "s/git commit/git commit --amend/".

One workaround might be to

    git reset --soft HEAD^
    git status [<pathspec>]
    ...
    git commit -c @{1}

but that is simply too error prone and ugly.  I would say it would
be better if "status" knows how to answer that "I am planning to
conclude with 'git commit --amend'" question.

The reason why I am torn is because I do not think "status --amend"
is a sensible name for that option.  "status" is not about amending
anything.

If the normal "status" is "give me status for the next commit", this
new mode would be "give me status for the 'commit --amend'".  Naming
it "git status --for-amend" crossed my mind, but it does not sound
great to me, either.

So...
