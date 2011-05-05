From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v3] git-p4: add option to preserve user names
Date: Thu,  5 May 2011 07:43:38 +0100
Message-ID: <1304577819-703-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu May 05 08:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHsIE-0002E6-UH
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab1EEGoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 02:44:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45743 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1EEGoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 02:44:04 -0400
Received: by wya21 with SMTP id 21so1363470wya.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 23:44:03 -0700 (PDT)
Received: by 10.216.237.136 with SMTP id y8mr5808890weq.76.1304577843432;
        Wed, 04 May 2011 23:44:03 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id o23sm1144293wbc.10.2011.05.04.23.43.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 23:44:02 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.7.1
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172806>

This is version 3 of my patch. It's almost the same as
the previous one, except that:

 - it skips changing the user if the user field is already
   correct

 - it puts a comment into the submit template saying what
   the user will be changed to (so you know it hasn't
   forgotten).

 - fixes a bug in actually forming the changespec (I think
   it was relying on the way python orders dictionaries).
---

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

 contrib/fast-import/git-p4     |  188 ++++++++++++++++++++++++++++++++--------
 contrib/fast-import/git-p4.txt |   29 ++++++
 t/t9800-git-p4.sh              |   84 ++++++++++++++++++
 3 files changed, 263 insertions(+), 38 deletions(-)
