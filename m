From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to merge branches except for one commit
Date: Wed, 28 May 2008 21:24:28 -0700
Message-ID: <7vhcchrb43.fsf@gitster.siamese.dyndns.org>
References: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Andrew Arnott" <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 06:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Zhj-0001CS-FY
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 06:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbYE2EYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 00:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbYE2EYj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 00:24:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYE2EYj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 00:24:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 581F45E6D;
	Thu, 29 May 2008 00:24:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F2F095E6C; Thu, 29 May 2008 00:24:32 -0400 (EDT)
In-Reply-To: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
 (Andrew Arnott's message of "Wed, 28 May 2008 19:32:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25E96214-2D37-11DD-AF5E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83171>

"Andrew Arnott" <andrewarnott@gmail.com> writes:

> Am I doing something wrong, un-knowledgeable of how to properly do
> merges/cherry-picks, or is this just life as we know it?

In any project, there typically is the 'master' branch that progresses the
(b)leeding edge, and there may be one or more 'maintenance' branches that
forked immediately after you tagged a commit on the 'master' branch.

You however do not necessarily want to _develop_ on these branches.  Their
primary purpose is to give "integration area" for people (the developers
and the customer end users).  If you can plan ahead and carefully decide
where you would first place each of your change, you can use merges more
effectively.

Suppose that you have (for the sake of simplicity of the discussion) two
primary integration branches.  You do not want to add any new features to
the 'maint' branch, and you want to include all the fixes there.  Also you
would want to have all the fixes you give to 'maint' to your 'master'
branch.

When you found a bug, the first thing to think about might be fixing the
bug (obviously), but before making that commit, you need to analyze where
the breakage comes from.  If the root cause of breakage is shared between
'maint' and 'master', then you are better off doing the fix on 'maint' and
then merge the whole 'maint' back to 'master'.

You might not be very confident with your "fix", however, and it is very
valid to be hesitant to make that fix directly on 'maint' branch.  In such
a case, you can fork a topic branch for that single fix off of 'maint',
test it out, and perhaps you may choose to first merge it to 'master' to
see if the fix works for other people and also if it is free of unexpected
side effects for a while, before deciding that the change is safe and is
Ok to merge it to 'maint' [*1*].

In either case (the former gives the fix to 'maint' first and then to
'master'; the latter gives the fix to 'master' first and then to 'maint'
after validating it), the general idea for keep this possible is to do the
fix on a topic branch by forking _the oldest integration branch_ that the
fix could possibly apply to.

Often you would find that there still are breakages in your fix. In such a
case, you can check out the topic branch you worked on the fix, fix the
breakage there, and merge that again to appropriate branches.  As long as
the topic forked off of the right branch, merging it again to 'maint' will
not contaminate 'maint' with unrelated things from 'master'.

You need certain discipline to effectively use merges.  In the "merge"
approach, you have the topics branches keep track of which integration
branches their commits should eventually go.

Once you make a commit on top of something else that you do not want to
pull in, you cannot merge that anymore and you need decide which
individual commits need to be backported after the fact, and this is often
cumbersome.  It is not the end of the world --- it is called "backporting"
and happens often in the real life.  But you can reduce the need for it by
bit of planning.

You can never plan ahead perfectly, so do not be too hard on yourself if
you occasionally screw up.  Cherry-picking from time to time is Ok.  With
practice, you will get used to it.  I juggle 5 integration branches to
maintain git.git itself and it took some practice for me to get
comfortable with the workflow.


[Footnote]

*1* The kernel folks have a policy that their maintenance track 2.6.X.Y
will never have any fix that is not in the mainline.  With such a policy,
you _could_ use this "fork a topic from 'maint' first, merge it into
'master' and after proving it is Ok merge the topic to 'maint'" workflow.
In practice, because different people maintain the mainline and the
maintenance track in that project, this is not done and they do the
equivalent of cherry-pick instead.
