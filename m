From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v2] git-p4: add option to preserve user names
Date: Thu, 21 Apr 2011 20:50:22 +0100
Message-ID: <1303415423-12445-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 21:51:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCzu1-00009u-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 21:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab1DUTuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 15:50:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38608 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab1DUTuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 15:50:54 -0400
Received: by wwa36 with SMTP id 36so67855wwa.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 12:50:53 -0700 (PDT)
Received: by 10.216.235.41 with SMTP id t41mr292306weq.97.1303415453659;
        Thu, 21 Apr 2011 12:50:53 -0700 (PDT)
Received: from localhost.localdomain ([212.183.128.7])
        by mx.google.com with ESMTPS id d59sm1112125wed.45.2011.04.21.12.50.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 12:50:52 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.7.1
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171915>

Patches from git passed into p4 end up with the committer
being identified as the person who ran git-p4.

This patch adds an option --preserve-user. When enabled, git-p4
will modify the changelist after it has been submitted ("p4 change -f")
and set the username to the one matching the git author.

If the person running git-p4 does not have sufficient permissions,
git-p4 will refuse to run (detected using "p4 protects").
It's possible that complicated permissions setups might confuse
git-p4 - it just looks to see if the user has admin or super on
the repo. In theory they might have permissions in some parts
and not in others.

If there are commits with authors who do not have p4 accounts, then
git-p4 will refuse to run unless git-p4.allowMissingP4Users is true,
in which case it falls back to the standard behaviour for those
commits.

The code has to get the p4 changelist number. The way it
does this is by simply doing 'p4 changes -c <client>', which
means if someone else is using the same clientspec at the
same time, there is a potential race hazard. The alternative
is to rewrite the submit logic to submit a properly marshalled
template, which felt a bit too intrusive.

I've hoisted the p4 user name cache to a separate class, since it
gets used in a couple of different places now.

I've added an option git-p4.skipSubmitModTimeCheck so that I can
write a test case without having to jump through hoops with the
editor.

Luke Diamand (1):
  git-p4: add option to preserve user names

 contrib/fast-import/git-p4     |  179 +++++++++++++++++++++++++++++++---------
 contrib/fast-import/git-p4.txt |   29 +++++++
 t/t9800-git-p4.sh              |   84 +++++++++++++++++++
 3 files changed, 254 insertions(+), 38 deletions(-)
