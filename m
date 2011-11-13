From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] sequencer: handle single-commit pick as special case
Date: Sun, 13 Nov 2011 15:23:02 -0800
Message-ID: <7vpqgvmwtl.fsf@alter.siamese.dyndns.org>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
 <1321181181-23923-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 00:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPjOJ-0007gs-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 00:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab1KMXXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 18:23:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab1KMXXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 18:23:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47549579E;
	Sun, 13 Nov 2011 18:23:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkgHUFKFxSDndmsXTECU7VqoMHQ=; b=B6uOOy
	eflVVhCE2I1TbGJ0SQmpq53Ua8kxzSpr0RFVOa844H/I1PvSZsBxAOjoaE+TiZHG
	WkjEtG0xeAjyGwfB/kjNMZMqcXC5+z2meGlRvj5LDZgp/1Xz4L0rxMIn79bEnqi8
	jsS6qN/9zHOFc/eV/iCudjISnQMa+aZdu3mMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D3thDgqEBDT70Zy9ZBPNiOx36TB6Uvfa
	bS2dDyxyKbC/1ifJobIO1tIesC1HdcF/vM7pYM0RGt4MnvYXLCttjcjqadQaPLoQ
	zcKz2kPXS+vAj41GUzH3s1XDtTZL97oiZ2nX7w8A4SeFWLVUraOrvXmsDY82OoMQ
	LFmZ62b47vA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E5E3579D;
	Sun, 13 Nov 2011 18:23:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93D1A579C; Sun, 13 Nov 2011
 18:23:03 -0500 (EST)
In-Reply-To: <1321181181-23923-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 13 Nov 2011 16:16:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F5928CA-0E4E-11E1-AC46-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185354>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Prior to v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than one
> commit, 2010-06-02), 'git cherry-pick' could only pick one commit at a
> time, and it used '.git/CHERRY_PICK_HEAD' to pass on information to a
> subsequent invocation in case of a conflict.  While
> '.git/CHERRY_PICK_HEAD' can only keep information about one commit,
> the sequencer uses '.git/sequencer' to persist information in the
> general case.
>
> A problem arises because a single-commit cherry-pick operation can be
> completed successfully using 'git commit'.  This removes
> '.git/CHERRY_PICK_HEAD' without informing the sequencer, leaving
> behind a stale sequencer state as a result.  We have worked around
> this problem already by prematurely removing the sequencer state in
> d3f4628e (revert: Remove sequencer state when no commits are pending,
> 2011-06-06).  However, this gets in the way of our future plan to
> eliminate a glaring workflow inconsistency:
>
>   $ git cherry-pick foo
>   ... .git/sequencer is created ....
>   ... .git/CHERRY_PICK_HEAD is created ...
>   ... conflict ...
>   .... .git/sequencer is prematurely removed ...

Isn't the real problem that .git/sequencer is created in the first place,
when this form of the command knows it will use CHERRY_PICK_HEAD?

>   $ echo "resolved" >problematicfile
>   $ git add problematicfile
>   $ git commit
>   ... .git/CHERRY_PICK_HEAD is removed ...
>   $ git cherry-pick --continue
>   error: No cherry-pick in progress

This is the right thing to happen, no? There is no in-progress cherry-pick
anymore after that commit. The user said "I want to replay this commit",
the command couldn't finish it by itself and asked the user to help
resolving the conflict, and the user resolved and recorded the result.

It is a different story if the sequence were like this:

    $ git cherry-pick foo
    ... conflict happens
    $ edit problematicfile
    $ git add problematicfile
    $ git cherry-pick --continue
    ... This should notice CHERRY_PICK_HEAD and record it.
    ... After that, there is nothing remaining to be done.

In other words, the user said "I want to replay this commit", the command
couldn't finish it by itself and asked the user to help resolving the
conflict, the user resolved and told the command to continue. The command
should continue recording the result.

And if "continue" does not work in this sequence, that is a bug worth
fixing.

>   $ git cherry-pick foo..bar
>   ... .git/sequencer is created ....
>   ... CHERRY_PICK_HEAD is created ...
>   ... conflict in bar~1 ...
>   $ echo "resolved" >problematicfile
>   $ git add problematicfile
>   $ git commit
>   ... CHERRY_PICK_HEAD is removed ...
>   $ git cherry-pick --continue # Success!

This again is the right thing to happen, as the user had to help the
command while replaying bar~1 and then told it to continue, which
successfully replayed bar.

I do not see an inconsistency here, let alone any "glaring" one.
