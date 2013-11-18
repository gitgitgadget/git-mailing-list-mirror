From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 9/9] remote-bzr, remote-hg: fix email address regular expression
Date: Sun, 17 Nov 2013 23:12:50 -0500
Message-ID: <1384747970-25481-10-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDd-000452-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab3KRENr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:47 -0500
Received: from smtp.bbn.com ([128.33.0.80]:31444 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab3KRENZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:25 -0500
Received: from socket.bbn.com ([192.1.120.102]:57941)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGDE-0009cx-OZ; Sun, 17 Nov 2013 23:13:24 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 008243FFEF
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237973>

Before, strings like "foo.bar@example.com" would be converted to
"foo. <bar@example.com>" when they should be "unknown
<foo.bar@example.com>".

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
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
