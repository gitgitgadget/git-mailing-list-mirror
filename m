From: larsxschneider@gmail.com
Subject: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue,  1 Sep 2015 00:10:26 +0200
Message-ID: <1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 00:10:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWXHm-0006A9-HN
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 00:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbbHaWKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 18:10:36 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34576 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbbHaWKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 18:10:35 -0400
Received: by wicjd9 with SMTP id jd9so13748023wic.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/6wva1TyJ1HwfScnrlb7ZLqPHRrHGOuDySBv+ueVkc=;
        b=D0EZKxDypxtxqGmLwXuSEoV7EpMiYlGPH1gqNT2e+VnzpZ0AZhMBq66bDsNtYoxwvl
         YCssoP8hdQVFHtJU9wTFL2bEHl8eWCedJ7mRiSMGv48oeIptYI3DnSaCi7k10VAdZsOc
         w9+xP+fwe0SjA84KV+sJKjgpY3wv1VRWlm+wW2khBWKnlowAfldX88ufs4Gr70tFT0eD
         RQGsK2tRtomR9qcyvyff6gKmNTf2R3KqAuEtSlmtCyFN1JKjMKhngRUHXF07YwezaACn
         5/jnHnl1y+Z8PrlwvixYhWHupkBIZFLh9LQ2XXPZ/eAfOWFuO55flr9esWI9eLRt4Mbr
         h0bA==
X-Received: by 10.180.37.201 with SMTP id a9mr676390wik.83.1441059033726;
        Mon, 31 Aug 2015 15:10:33 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id x6sm719903wiy.6.2015.08.31.15.10.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 15:10:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276951>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt        |  5 +++++
 git-p4.py                       |  6 ++++++
 t/t9821-git-p4-path-encoding.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 t/t9821-git-p4-path-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..14bb79c 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -252,6 +252,11 @@ Git repository:
 	Use a client spec to find the list of interesting files in p4.
 	See the "CLIENT SPEC" section below.
 
+--path-encoding <encoding>::
+	The encoding to use when reading p4 client paths. With this option
+	non ASCII paths are properly stored in Git. For example, the encoding
+	'cp1252' is often used on Windows systems.
+
 -/ <path>::
 	Exclude selected depot paths when cloning or syncing.
 
diff --git a/git-p4.py b/git-p4.py
index 073f87b..2b3bfc4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1981,6 +1981,8 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--silent", dest="silent", action="store_true"),
                 optparse.make_option("--detect-labels", dest="detectLabels", action="store_true"),
                 optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
+                optparse.make_option("--path-encoding", dest="pathEncoding", type="string",
+                                     help="Encoding to use for paths"),
                 optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
                                      help="Import into refs/heads/ , not refs/remotes"),
                 optparse.make_option("--max-changes", dest="maxChanges",
@@ -2025,6 +2027,7 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs = None
         self.tempBranches = []
         self.tempBranchLocation = "git-p4-tmp"
+        self.pathEncoding = None
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -2213,6 +2216,9 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
+        if self.pathEncoding:
+            relPath = relPath.decode(self.pathEncoding).encode('utf8', 'replace')
+
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
 
         # total length...
diff --git a/t/t9821-git-p4-path-encoding.sh b/t/t9821-git-p4-path-encoding.sh
new file mode 100755
index 0000000..1626fc5
--- /dev/null
+++ b/t/t9821-git-p4-path-encoding.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='Clone repositories with non ASCII paths'
+
+. ./lib-git-p4.sh
+
+UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create a repo containing iso8859-1 encoded paths' '
+	cd "$cli" &&
+
+	ISO8859="$(printf "$UTF8_ESCAPED" | iconv -f utf-8 -t iso8859-1)" &&
+	>"$ISO8859" &&
+	p4 add "$ISO8859" &&
+	p4 submit -d "test commit"
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded paths' '
+	git p4 clone --destination="$git" --path-encoding=iso8859-1 //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		printf "$UTF8_ESCAPED\n" >expect &&
+		test_config core.quotepath false &&
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.9.5 (Apple Git-50.3)
