From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Thu, 05 Jul 2012 10:03:09 -0700
Message-ID: <7vd34arvhu.fsf@alter.siamese.dyndns.org>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 19:03:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmpTA-0003OC-Lw
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 19:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab2GERDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 13:03:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab2GERDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 13:03:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 779E684FD;
	Thu,  5 Jul 2012 13:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v0jJ0SSVttt/
	n4Z0oT92Caw3bU4=; b=YmJZt9Kv/LH4GBAWZ/rMEBfyYXELy9ktJmnqfkyBLpZd
	FyeFsIKWb3ykETukxLqTq4sgesg9oF6GfueyovFtCgmOQ5kX6SlQmljt7b5erFeZ
	K3UdfDoH8T1VjL5i7svNAQm99y4Gxjoy/gsZgqvzNQteq9Nm2ohQnU/HfG5rhiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NxQPZ4
	g02X2Yz0zbuZ/66p2oTTh3hMLOHfp42BP66DRMLJyXU7/c4lLDbiE4cBEB9RCRoK
	toYsGDb1kI9CrQKXDBMjOFhs3A2iM764TDPMOxgQIPLnUtA4HVcpLdcpaJci5YUT
	JBdJcfuua42K93NPdB1z6UDfuh8aLjXxbmbGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E24784FC;
	Thu,  5 Jul 2012 13:03:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9932284F4; Thu,  5 Jul 2012
 13:03:10 -0400 (EDT)
In-Reply-To: <1341480589-1890-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 5 Jul 2012 11:29:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CBFC246-C6C3-11E1-9D6B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201051>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The branch command assumes HEAD as the starting point if none is
> specified. This causes --set-upstream to behave unexpectedly if the
> user types
>
>     git branch --set-upstream origin/master
>
> git-branch will assume a second argument of HEAD and create config
> entries for a local branch origin/master to track the current
> branch. This is rarely, if ever, what the user wants to do.
>
> Catch invocations with --set-upstream and only one branch so the
> command above sets up the current branch to track origin's master
> branch.

If you look at the set of management operations "git branch"
(i.e. other than "listing" [*1*]) allows you to do, the first name
on the command line always is the branch that is manipulated for
everything other than the "set upstream" operation.  In that sense,
the current implementation consistently handles command line
arguments with other options, and your patch breaks the consistency
in the UI.

I think it was a mistake that nobody noticed that it is likely that
the operation most often will be done for the current branch and the
usual "give me one branch name to operate on, or I'll operate on the
current branch" command line convention of "git branch" commannd is
not a good fit for it, when "set upstream" feature was added, and
suggested an alternative syntax that avoids the mistake you quoted
above, perhaps something like:

	git branch --set-upstream-to=3Dorigin/master [HEAD]

which would have been very clear whose upstream is set to what (with
or without the name of the other branch).  In other words, make the
name "origin/master" *NOT* the first branch name on the command line
in the usual sense, but a parameter to the --set-upstream option, so
that "give me one branch name to operate on, or I'll operate on the
current branch" convention is still kept.

You also broke people who corrected another kind of mistake in this
workflow:

    git checkout frotz
    hack hack
    # ok, shared infrastructure between two branches are
    # sound, and I can build the other topic on top of this
    # state
    git branch nitfol
    # oops, forgot to mark that nitfol is derived on frotz with --track
    git branch --set-upstream nitfol

where the last one meant "git branch --set-upstream nitfol frotz",
to retroactively mark the upstream of the named branch, no?

Even though my instinct tends to agree with your "is rarely, if
ever", I do not think it is sane to change the behaviour of a
command that produced one result without failing to produce
something entirely different like your patch does (it would have
been a different story if an operation that everybody got failure
and did not produce a useful result were updated to produce a useful
result).

Coming from the above observation, while I am sympathetic to your
cause and agree that we would want to do something about it, I am
having a hard time to convince myself that your patch is the best
way to go.

I am not entirely happy with the hypothetical "set-upstream-to"
myself, either.


[Footnote]

*1* The point of "listing" is you do not know the names and asking
the command to produce them, so it is OK to be different.  The "set
upstream" operation in question does not share the excuse to be
different.
