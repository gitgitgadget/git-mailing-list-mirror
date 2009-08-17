From: Tim Niemueller <niemueller@kbsg.rwth-aachen.de>
Subject: rev-list behavior in mail notification when pushing multiple branches
Date: Mon, 17 Aug 2009 18:13:32 +0200
Organization: http://robocup.rwth-aachen.de
Message-ID: <4A8981AC.20703@kbsg.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 18:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4q4-0001M1-NA
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbZHQQNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbZHQQNc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:13:32 -0400
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:49928 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbZHQQNb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:13:31 -0400
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.40])
 by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
 with ESMTP id <0KOJ00LOJ3QK6A30@mta-2.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Mon, 17 Aug 2009 18:13:32 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="4.43,396,1246831200";   d="scan'208";a="22765374"
Received: from relay-auth-2.ms.rz.rwth-aachen.de (HELO relay-auth-2)
 ([134.130.7.79]) by ironport-in-1.rz.rwth-aachen.de with ESMTP; Mon,
 17 Aug 2009 18:13:32 +0200
Received: from evilgenius.niemueller.de ([unknown] [137.226.232.177])
 by relay-auth-2.ms.rz.rwth-aachen.de
 (Sun Java(tm) System Messaging Server 7.0-3.01 64bit (built Dec  9 2008))
 with ESMTPA id <0KOJ00DEN3QKH960@relay-auth-2.ms.rz.rwth-aachen.de> for
 git@vger.kernel.org; Mon, 17 Aug 2009 18:13:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre)
 Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
X-Enigmail-Version: 0.96a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126214>

Hi.

We are using git to manage a project which is separated in multiple
repositories. We use email notification for commits to the central
repositories, but the log output in these mails is not what we expect.
We use the contrib hook script from the git repository.

The main repository contains the trunk, in the real sense, meaning that
it is composed of infrastructure code shared among all repositories, not
in the svn sense. The other repositories contain the trunk master branch
as "trunk" branch. Their own master branch is based on trunk, but
extended by additional modules. We regularly merge from the main
repository into the other repositories trunk.

Consider the following situation:

--*---X-------Y     master branch
     /       /
A---B--C*---D       trunk branch

master has been ultimately derived from trunk. At X trunk changes up to
C have been merged into the master. Then trunk evolves but master
remains unchanged. We merge again everything up to D from trunk. Now
assume that we haven't pushed since B/X and now push after D/Y. Then
there are two mails to be generated, one for master X..Y, effectively
containing log message Y (merged...), and one for trunk B..D, C* is any
number of intermediate commits to the trunk.

It happens to be that master has been pushed first. The email contains
the expected output in the log section. However, for the trunk branch
the output unexpectedly is empty, meaning that information about C* is
never send in any mail.

The reason is the following: in show_new_revisions "rev-parse --not" is
used to generate "stop" points for rev-list. The stop point issued for
the master branch is Y. This causes rev-list to stop immediately, since
this is the last commit in the chronological order.

What we would like to have is the that the master mail only states
"merged trunk changes" (as it is right now, if there were commits
between X and Y these should be included as well), while the trunk mail
issues all C* commits and D.

I have tried to come up with a way to filter out entries from the mails
that have been issued on "the other" branch(es) originally (although
they are now /after/ merging also part of the this branch's history).
Since gitk can show this there should be a way to figure it out, but my
git-fu isn't strong enough, yet. Can someone give advice on how to
achieve this, or how you solved the problem, if you did?

Thanks,
	Tim

-- 
AllemaniACs RoboCup Team            KBSG - Knowledge-Based Systems Group
========================================================================
http://robocup.rwth-aachen.de                     RWTH Aachen University
http://www.kbsg.rwth-aachen.de                           Ahornstrasse 55
http://www.fawkesrobotics.org                             D-52056 Aachen
