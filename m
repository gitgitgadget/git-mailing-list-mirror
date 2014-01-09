From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Thu, 09 Jan 2014 14:24:09 -0800
Message-ID: <xmqqbnzkaj5i.fsf@gitster.dls.corp.google.com>
References: <20140108093338.GA15659@sigill.intra.peff.net>
	<20140108093716.GE15720@sigill.intra.peff.net>
	<02F63E901C46405BAAEEFBC48870A7C2@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 23:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1O1R-0004lh-RM
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 23:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbaAIWYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 17:24:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbaAIWYN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 17:24:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7911562DB0;
	Thu,  9 Jan 2014 17:24:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BYHxs4GxGcyn6sAHdxrWfVWtJkE=; b=WUVAmZ
	CKygX3fzjlx2vz8xHCqy9oKcYSNPP1iWShUwOpXqSKxdMEI/f49TS4p2BfDQjJmr
	CyCeAWf+6clIuACYwFxalw1X+JanCk2l7tYeHmnaptKJ4D/X1WVSsDrdsbWC+8Zj
	GO6R50bZRX+KZdxVGpKXy/up4T8S/b+4sExQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FJ1Y0/rqMI8dIy0INbD8dLIYbojL+0Qa
	uKZ5PAEhdVkLi9Eh0uhL9U9StSv4GHv1xKdQtAQwmxozDa9urZGBrq+YXh04L1AB
	DrsAP1tofg1bwFinU+rJSgXDViekTA9/df2RTygswp1lhWo6tkeBIpFJAYmddPHJ
	/S9dcXsRrw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C4262DAF;
	Thu,  9 Jan 2014 17:24:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8427762DAC;
	Thu,  9 Jan 2014 17:24:11 -0500 (EST)
In-Reply-To: <02F63E901C46405BAAEEFBC48870A7C2@PhilipOakley> (Philip Oakley's
	message of "Thu, 9 Jan 2014 08:39:44 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3956A20-797C-11E3-AFC9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240280>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Jeff King" <peff@peff.net>
> Sent: Wednesday, January 08, 2014 9:37 AM
>> In a triangular workflow, you may have a distinct
>> @{upstream} that you pull changes from, but publish by
>> default (if you typed "git push") to a different remote (or
>> a different branch on the remote).
>
> One of the broader issues is the lack of _documenation_ about what the
> normal' naming convention is for the uspstream remote. Especially the
> implicit convention used within our documentation (and workflow).

Sure, let's start trying to come up with what the eventual
documentation patch may want to say.

 * The "upstream" is the place the updates by the project-as-a-whole
   (including others' work but also your previous work) come from.
   It is what you use "git pull [--rebase]" to integrate the work on
   your current branch with in order to keep it in sync with the
   outside world.  Such a repository (often called "origin", and
   "git clone" sets it up for you) may be called "upstream
   repository".

   Each of your branch would often have a single branch in that
   repository (e.g. "master", which you locally use the
   "origin/master" remote-tracking branch to keep track of its most
   recently observed state).  In the simplest case, you clone from
   your "origin", you get your own "master" branch, which is set to
   integrate with the "master" branch at the "origin".  Their
   "master" (i.e. what you view as "origin/master") would be the
   "upstream branch" for your "master" branch.

   For a branch B, B@{upstream} names the remote-tracking branch
   used for the upstream branch of B.  For example, to fork a new
   branch 'foo' that has the same upstream branch as your branch
   'master' does, "git checkout -t -b foo master@{upstream}" can be
   used.

 * If you and others are using the same repository to advance the
   project, the repository you cloned from, i.e. your "upstream
   repository", is the same repository you push your changes back
   to.  There is no other repository you have to worry about.

   In such a "centralized" setting, it is likely that you may want
   to update one of three possible branches at the upstream
   repository when you push your changes back, if your local branch
   is named differently from its upstream branch.  Either:

   (1) You started working on a topic (e.g. your "fix-bug-2431"
       branch) based on an integration branch (e.g. "master" at the
       upstream, i.e. "origin/master" to you), and you want to
       publish it so that others can take a look at it and help you
       polish it while it is still not suitable for the integration
       branch.  As long as you gave a name to that topic branch that
       is descriptive and good enough for public consumption, you
       would want it to go to the same name (e.g. you would want to
       push to "fix-bug-2431" branch at the upstream repository from
       your "fix-bug-2431" branch); or

   (2) You are working on your copy (e.g. your "master" branch) of
       an integration branch (e.g. "origin/master" to you), and you
       want to update the "master" branch at the upstream
       repository.

   (3) There is another possibilty, in which you are working on a
       topic forked from an integration branch (as in (1)), and are
       done with the topic and want to push the result out directly
       to the integration branch.  Your "fix-bug-2431" branch may
       have started from "origin/master" and "git pull [--rebase]"
       on the branch would integrate with "master" branch at the
       upstream repository, and your "git push" on the
       "fix-bug-2431" branch will update that "master" branch at the
       upstream repository, which makes it look symmetric.

    The default in Git 2.0 will allow you to do (2) without any
    further set-up, and you can start living in the future by
    setting push.default to "simple".  Your current branch, when you
    run "git push", and its upstream branch must share the same
    name.

    If you want to do (1), you would want to set push.default to
    "current".  Your current branch, when you run "git push" may not
    have an explicit upstream branch (hence "git pull" without any
    other argument may fail), but the work on your branch will be
    pushed to the branch of the same name at the upstream
    repository.

    For (3), you would set push.default to "upstream".  Your current
    branch, when you run "git push", must have an explicit upstream
    branch specified and you must be pushing to the upstream
    repository for this to work for obvious reasons.

 * If you originally clone from somewhere you cannot (or do not want
   to even if you could) push to, you would want your "git push" to
   go to a repository that is different from your "upstream".  In
   such a "triangular" setting, the result of your work is published
   to your own repository (we'd call it "publish"), and others
   interested in your work would pull from there to integrate it to
   their work.  Among these other people there may be somebody who
   integrates work by all relevant people to the project mainline
   and updates the repository that you and other project participant
   all call their "upstream", and that is how you see your own work
   back in your "upstream".

   Set remote.pushdefault to name the repository that is your
   "publish" repository if you are using such a triangular workflow
   (you could use branch.*.pushremote to publish to different
   repositories per branch).

   Your local branch in such a triangular setting will have its
   "upstream" (the repository your "git pull" goes to and one of its
   branches it integrates with) and its "publish" (the repository
   and one of its branches your "git push" updates).  Like the way
   B@{upstream} can be used to refer to the former for your local
   branch B, B@{publish} can be used to refer to the latter.

   In such a "triangular" setting, it is likely that you may want to
   update the branch of the same name in your "publish" repository.
   If you have been working on your "fix-bug-2431" branch, you would
   want the result to go to "fix-bug-2431" branch there.

   The default in Git 2.0, when a triangular workflow is used by
   setting remote.pushdefault (or branch.*.pushremote), will push
   the current branch to the branch of the same name, so you do not
   have to do anything further.  You can start living in the future
   by setting push.default to "simple".

   The "upstream" setting of push.default would not make any sense
   in such a triangular workflow, so your "git push" will error out
   when you push to a repository that is not your "upstream" while
   the push.default is set to "upstream".

 * At the conceptual level, anybody who treats the work you publish
   as his or her "upstream" is your downstream, but because you do
   not control and keep track of who clones and pulls from you,
   there is no such notation as @{downstream}.

It is unfortunate that GitHub worked aroud the lack of "publish"
concept not by adding it to Git, but by introducing "fork" at the
server side, which ends up twisting the concept of "upstream" that
is sets up by "git clone".
