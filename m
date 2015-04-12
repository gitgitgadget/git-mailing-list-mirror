From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase --root conflicts with --committer-date-is-author-date
Date: Sat, 11 Apr 2015 23:19:37 -0700
Message-ID: <xmqqwq1h50na.fsf@gitster.dls.corp.google.com>
References: <55296823.4010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Elliot Wolk <elliot.wolk@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 08:19:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhBFJ-0001He-RU
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 08:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbbDLGTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 02:19:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865AbbDLGTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 02:19:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18DEC3D1DC;
	Sun, 12 Apr 2015 02:19:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bF38rSo/RQTh27DbSdQhc6ltnMU=; b=Oqd1Fp
	FJSHxEP+bfP+y13dbbqXl6B3Vjct44bIeNjp/CanjDEgZt/qDg+8iKm8T1WQN1Dr
	o2hOy0Gfs1Zk9nCR8sTS7RUDO7vJ6tEqBG9r0uFdUoySTXFxTYHWcN5s9nXDuden
	tT1+/6oIyI1B56ILxYbRzIDh6U4kFY7q/OAzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNmEYkgGK/p+rpGG+uFbF069dbGMWqmt
	TOrdEZkOHRxjwIHGOTTVe4ncdIYDJaX9Ev8CXlvexuwXUbthuTEsrEsbA8wk+YSD
	5I0VcLGUR4qwsl54OeMVoyjmL74kyGo0F3quCN3VfDmWbAWUqJaP9XDIQWVwHOzE
	GhR48ZpnKpo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EB263D1DB;
	Sun, 12 Apr 2015 02:19:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 656E93D1DA;
	Sun, 12 Apr 2015 02:19:38 -0400 (EDT)
In-Reply-To: <55296823.4010409@gmail.com> (Elliot Wolk's message of "Sat, 11
	Apr 2015 14:29:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5C06ACE-E0DB-11E4-BB1D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267040>

I think that the reason for this behaviour is that "rebase --root"
implicitly forces "rebase -i" to run (instead of the 'format-patch
piped to am'), and --committer-date-is-author-date is not supported
by the "rebase -i" codepath at all.

I see Thomas did "rebase --root" support in v1.6.2 era both in the
normal and interactive rebase codepaths, but df5df20c (rebase -i:
support --root without --onto, 2012-06-26) started forcing --root
rebase to always use the "rebase -i" codepath.

Teaching "rebase -i" to support --committer-date-is-author-date like
the normal rebase codepath is one thing, but I wonder why we force
"rebase -i" on people who merely wanted to do "--root".  The way
df5df20c (rebase -i: support --root without --onto, 2012-06-26)
explains it does not read like a valid justification, at least to
me.  It says:

    Implicitly use rebase -i for non-interactive rebase of --root
    without an --onto argument now that rebase -i can correctly do
    this.

which is "because we can", not "because it is a good thing to do for
such and such reasons".  This is an ancient change in v1.7.12 days.

Chris, do you remember if there was a reason why it was a bad idea
to teach the normal rebase codepath to handle "--root"?  I think we
would have needed to allow "am" to apply a creation patch and start
a new history on an unborn branch in order to do so, but I am not
sure if there was a valid reason why such a change to "am" would
have been a bad idea.

Thanks.

Elliot Wolk <elliot.wolk@gmail.com> writes:

> ============
> version:
>
> git version 2.1.4
> Linux wolke-w520 3.19.3-towo.1-siduction-amd64 #1 SMP PREEMPT
> siduction 3.19-9 (2015-03-26) x86_64 GNU/Linux
> ============
> summary:
>
> if i do `git rebase --committer-date-is-author-date --root', the
> committer date is set to now, instead of set to the author date.
> when rebasing onto the first commit, it works perfectly well.
> ============
> reproduce:
>
> set -x
> cd
> mkdir test
> cd test
> git init
> echo line >> a; git add a; git commit -m 'jan1' --date '2015-01-01'
> echo line >> a; git add a; git commit -m 'jan2' --date '2015-01-02'
> echo line >> a; git add a; git commit -m 'jan3' --date '2015-01-03'
> git log --format=format:%s-%cD-%aD%n
> git rebase --committer-date-is-author-date HEAD^^
> git log --format=format:%s-%cD-%aD%n
> git rebase --committer-date-is-author-date --root
> git log --format=format:%s-%cD-%aD%n
> git rebase --committer-date-is-author-date HEAD^^
> git log --format=format:%s-%cD-%aD%n
> git rebase --committer-date-is-author-date --root
> git log --format=format:%s-%cD-%aD%n
> ============
> expected:
>
> jan3-Sat, 03 Jan 2015 13:28:06 -0500-Sat, 3 Jan 2015 13:28:06 -0500
> jan2-Sat, 02 Jan 2015 13:28:06 -0500-Fri, 2 Jan 2015 13:28:06 -0500
> jan1-Sat, 01 Jan 2015 13:28:06 -0500-Thu, 1 Jan 2015 13:28:06 -0500
> ============
> actual:
>
> jan3-Sat, 11 Apr 2015 14:28:06 -0400-Sat, 3 Jan 2015 13:28:06 -0500
> jan2-Sat, 11 Apr 2015 14:28:06 -0400-Fri, 2 Jan 2015 13:28:06 -0500
> jan1-Sat, 11 Apr 2015 14:28:06 -0400-Thu, 1 Jan 2015 13:28:06 -0500
>
> {full output: http://pastie.org/10086950}
> ============
> sorry if dupe/wrong-venue/poorly-formatted/incomprehensible. i tried.
