From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] git-am: flag suspiciously old or futuristic commits
Date: Wed, 29 Jul 2015 18:01:37 -0400
Message-ID: <1438207297-11686-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:01:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKZQ4-00088g-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 00:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbbG2WBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 18:01:44 -0400
Received: from mail.windriver.com ([147.11.1.11]:48104 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbbG2WBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 18:01:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t6TM1hXQ026198
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 15:01:43 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.235.1; Wed, 29 Jul 2015 15:01:25 -0700
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274960>

The linux kernel repository has some commits in it with dates from
the year 1970 and also 2030 (and possibly others).  We probably shouldi
warn people when the dates look suspect.

For commits in the future,  note that a committer in Australia
could commit on New Years Day, and send it to a maintainer in North
America and that would trip the notification on the maintainer's
New Years Eve.  But that is unlikely, and the note is still
correct; that the commit is from a future year.

For commits in the past, I chose a somewhat arbitrary 30 year
limit, which will allow stuff from post 1985; the thought being
that someone might want to import an old repo into git from some
other SCM.  We could alternatively set it to 5, which would then
catch computers with a dead CMOS battery, at the risk of pestering
the hypothetical museum curator of old bits.

Sample output:

paul@builder:~/git/linux-head$ grep Date: *patch
future.patch:Date: Sat, 18 Jul 2037 21:22:19 -0400
past.patch:Date: Sat, 18 Jul 1977 21:22:19 -0400

paul@builder:~/git/linux-head$ git am future.patch
note: commit is from future year 2037.
Applying: arch/sh: make heartbeat driver explicitly non-modular
paul@builder:~/git/linux-head$ git reset --hard HEAD~ > /dev/null
paul@builder:~/git/linux-head$ git am past.patch
note: commit is from implausibly old year 1977.
Applying: arch/sh: make heartbeat driver explicitly non-modular
paul@builder:~/git/linux-head$

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 git-am.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index 3af351ffaaf3..ff6deb8047a4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -766,6 +766,21 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 		stop_here $this
 	fi
 
+	if test -n "$GIT_AUTHOR_DATE"
+	then
+		THIS_YEAR=`date +%Y`
+		TOO_OLD=$(expr $THIS_YEAR - 30)
+		TOO_NEW=$(expr $THIS_YEAR + 1)
+		GIT_AUTHOR_YEAR=`date -d "$GIT_AUTHOR_DATE" +%Y`
+
+		if [ "$GIT_AUTHOR_YEAR" -le "$TOO_OLD" ]; then
+			say "$(gettext "note: commit is from implausibly old year $GIT_AUTHOR_YEAR.")"
+		fi
+		if [ "$GIT_AUTHOR_YEAR" -ge "$TOO_NEW" ]; then
+			say "$(gettext "note: commit is from future year $GIT_AUTHOR_YEAR.")"
+		fi
+	fi
+
 	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
 
 	case "$resume" in
-- 
2.5.0
