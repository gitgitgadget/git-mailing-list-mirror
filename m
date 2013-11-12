From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 9/9] remote-bzr, remote-hg: fix email address regular expression
Date: Tue, 12 Nov 2013 00:54:48 -0500
Message-ID: <1384235688-9655-10-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 06:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg6wz-0000SH-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 06:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab3KLFze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 00:55:34 -0500
Received: from smtp.bbn.com ([128.33.0.80]:13597 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab3KLFzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 00:55:18 -0500
Received: from socket.bbn.com ([192.1.120.102]:57715)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg6wX-000LqH-RR; Tue, 12 Nov 2013 00:55:17 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id D1FE0400F2
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237691>

Before, strings like "foo.bar@example.com" would be converted to
"foo. <bar@example.com>" when they should be "unknown
<foo.bar@example.com>".

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/git-remote-bzr | 7 +++----
 contrib/remote-helpers/git-remote-hg  | 7 +++----
 contrib/remote-helpers/test-hg.sh     | 3 ++-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 054161a..7e34532 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -44,8 +44,8 @@ import StringIO
 import atexit, shutil, hashlib, urlparse, subprocess
 
 NAME_RE = re.compile('^([^<>]+)')
-AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
-EMAIL_RE = re.compile('^([^<>]+[^ \\\t<>])?\\b(?:[ \\t<>]*?)\\b([^ \\t<>]+@[^ \\t<>]+)')
+AUTHOR_RE = re.compile('^([^<>]+?)? ?[<>]([^<>]*)(?:$|>)')
+EMAIL_RE = re.compile(r'([^ \t<>]+@[^ \t<>]+)')
 RAW_AUTHOR_RE = re.compile('^(\w+) (.+)? <(.*)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
@@ -193,8 +193,7 @@ def fixup_user(user):
     else:
         m = EMAIL_RE.match(user)
         if m:
-            name = m.group(1)
-            mail = m.group(2)
+            mail = m.group(1)
         else:
             m = NAME_RE.match(user)
             if m:
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c6026b9..30402d5 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -51,8 +51,8 @@ import time as ptime
 #
 
 NAME_RE = re.compile('^([^<>]+)')
-AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
-EMAIL_RE = re.compile('^([^<>]+[^ \\\t<>])?\\b(?:[ \\t<>]*?)\\b([^ \\t<>]+@[^ \\t<>]+)')
+AUTHOR_RE = re.compile('^([^<>]+?)? ?[<>]([^<>]*)(?:$|>)')
+EMAIL_RE = re.compile(r'([^ \t<>]+@[^ \t<>]+)')
 AUTHOR_HG_RE = re.compile('^(.*?) ?<(.*?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.*)> (\d+) ([+-]\d+)')
 
@@ -316,8 +316,7 @@ def fixup_user_git(user):
     else:
         m = EMAIL_RE.match(user)
         if m:
-            name = m.group(1)
-            mail = m.group(2)
+            mail = m.group(1)
         else:
             m = NAME_RE.match(user)
             if m:
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 642ad93..347e812 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -215,7 +215,8 @@ test_expect_success 'authors' '
 	author_test theta "theta < test@example.com >" "theta <test@example.com>" &&
 	author_test iota "iota >test@example.com>" "iota <test@example.com>" &&
 	author_test kappa "kappa < test <at> example <dot> com>" "kappa <unknown>" &&
-	author_test lambda "lambda@example.com" "Unknown <lambda@example.com>"
+	author_test lambda "lambda@example.com" "Unknown <lambda@example.com>" &&
+	author_test mu "mu.mu@example.com" "Unknown <mu.mu@example.com>"
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
-- 
1.8.5.rc1.208.g8ff7964
