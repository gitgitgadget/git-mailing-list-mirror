From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFH] git cherry vs. git rev-list --cherry, or: Why does "..." suck?
Date: Tue, 22 Mar 2011 13:07:53 +0100
Message-ID: <4D889119.3020009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 13:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q20Qs-0004xb-4i
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 13:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab1CVMLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 08:11:25 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56047 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752178Ab1CVMLY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 08:11:24 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 66A1820921
	for <git@vger.kernel.org>; Tue, 22 Mar 2011 08:11:23 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 22 Mar 2011 08:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=tGdFk+xW9Uwv+xzGlysX8Tq8E/U=; b=t5rz+185DiiN6MQksNw5DmFFnQHHRuItaTjqTStSAz4Y6THwZimTNZA9trwTqtnDUTKEJ2wECz3lVe63yn89kNTtqxRXh94h91JuJ3NuRxk+6bMmGqYdq8OuJ/Sc9P0hKoxj7U7o6rcyeEISjl4riiHb9E6toSRg15NYNdklxw4=
X-Sasl-enc: pXlk9Bp4sdHIp6CsxN8ABivBxofVxwqji+5PUo9wSMEk 1300795883
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 00CDF44450B
	for <git@vger.kernel.org>; Tue, 22 Mar 2011 08:11:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169725>

In the process of converting "git cherry" and "git format patch" to use
the new rev-list options (the saner way according to d7a17ca (git-log
--cherry-pick A...B, 2007-04-09) already!), I have a simple question and
a hard one which I both ask help for:

run_command
===========

I could use either run_command_v_opt(args, RUN_GIT_CMD) or setup the
walker, call it etc. For the former I have to check how to treat the
third argument to "git cherry", the latter seems to be more code (and I
would need to call the rev-list/log output loop somehow).

Is there a general preference for using or avoiding run_command?

(There's also the question of what details of git cherry's output I need
to preserve.)


Performance
===========

I don't get this:

git cherry A B: 0.4s
git rev-list --cherry A...B: 1.7s
(more details below)

This makes "rev-list --cherry" almost unacceptable as a replacement. But
I'd like to understand this difference (and maybe do something about
it). I'm lost with gprof, but here are more details on the timing:

A is pu at 0f169fc
B is next at 5ddab49 plus three commits which are not upstream

rev-list --count 5ddab49..A is 166 (117 without merges), for B it is 3

Now the timings (rev-list done with --count):

cherry A B: 0.4s
cherry B A: 0.4s
rev-list --cherry A...B: 1.7s

The latter computes merge bases (there are 25), the former does not. How
much is it:

merge-base A B: 0.95s
merge-base --all A B: 0.95s
rev-parse A...B: 0.95s

So this accounts for much of the difference (and we need to do something
about get_merge_bases()), but not all. How much is the patch-id computation:

rev-list --no-merges --right-only --cherry-pick A...B: 1.7s
(the above is --cherry)
rev-list --no-merges --right-only A...B: 1.0s
rev-list --no-merges --left-right A...B: 1.0s

Why does it take rev-list 0.7s to do the same patch-id computations that
cherry does in less than 0.4s? (More details on what they do below.)

rev-list --no-merges A..B: 0.04s (counting to 3, yeah)
rev-list --no-merges A..B: 0.6s (counting to 117)

The latter has no patch-id nor merge computation. Should this really
take 0.6s?

I'm stomped. Help, please!

Michael

What the commands roughly do:

cherry A B [limit]:
===================
add pending B ^A
walk B..A (on temp rev_info) and
add_commit_patch_id() on these
clear_commit_marks()
add pending ^limit if specified
walk A..B and
reverse that list and
has_commit_patch_id() on these

rev-list --cherry A...B:
========================
get_merge_bases for A,B
add pending --not merge bases
add pending A B
add_commit_patch_id() on smaller side
has_commit_patch_id() on other side (&& mark id seen)
recheck smaller side (based on id->seen)

This seems to enumerate A..B and B..A more often, but is iterating
through a commit list that time consuming? The number of patch-id
computations is the same as far as I can see.
