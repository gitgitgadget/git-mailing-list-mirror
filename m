From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/16] remote-hg: improve email sanitation
Date: Mon, 22 Apr 2013 16:55:18 -0500
Message-ID: <1366667724-567-11-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOlq-0004Mv-S0
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab3DVV7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:59:30 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36230 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3DVV7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:59:30 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so4839466obb.15
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4ixgrODs3JZK9A7POIFm/cdiv/t/rNiI5rKg9kZMl2w=;
        b=kK4jaenAMz/3sl909ECjnRtkrGMM/gUNqTmSrMi+IVEFWdk/snJNo6u5vtGxj3vW6B
         R/szX2m4goQQ46NSe1wKIhW5DGEfy38swaa2hCe9CM85q8yhx6aSqgN1XQOCLJTXMKH6
         8E/bzdqoa3Bw3vmuFJXUYvSOT/QZZvgMgDWQHtVWFtazbc/Da+hDhCVLpZnvHHx8Zb7P
         HWntcFzGd/y1Th4Qw3GA3kUtRGHH36Y4kkAM9gbrC1WdAGhez7HXFYB5U6VoObKSdUPv
         FSKDtThCNEUwf+FqvMLisSuZaufxBB+FkdFULAzsMcCSUK5RNctJDbRUZa90+b0onWfE
         uG/Q==
X-Received: by 10.60.29.161 with SMTP id l1mr16715846oeh.111.1366667969712;
        Mon, 22 Apr 2013 14:59:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id xz9sm20872704oeb.5.2013.04.22.14.59.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:59:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222107>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 ++++++++--
 contrib/remote-helpers/test-hg.sh    |  8 ++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3c6eeb7..0084709 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -51,6 +51,7 @@ import urlparse
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
+EMAIL_RE = re.compile('^([^<>]+[^ \\\t<>])?\\b(?:[ \\t<>]*?)\\b([^ \\t<>]+@[^ \\t<>]+)')
 AUTHOR_HG_RE = re.compile('^(.*?) ?<(.*?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.*)> (\d+) ([+-]\d+)')
 
@@ -245,9 +246,14 @@ def fixup_user_git(user):
         name = m.group(1)
         mail = m.group(2).strip()
     else:
-        m = NAME_RE.match(user)
+        m = EMAIL_RE.match(user)
         if m:
-            name = m.group(1).strip()
+            name = m.group(1)
+            mail = m.group(2)
+        else:
+            m = NAME_RE.match(user)
+            if m:
+                name = m.group(1).strip()
     return (name, mail)
 
 def fixup_user_hg(user):
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index d5b8730..8de2aa7 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -137,15 +137,15 @@ test_expect_success 'authors' '
 
   author_test alpha "" "H G Wells <wells@example.com>" &&
   author_test beta "test" "test <unknown>" &&
-  author_test beta "test <test@example.com> (comment)" "test <unknown>" &&
+  author_test beta "test <test@example.com> (comment)" "test <test@example.com>" &&
   author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
   author_test delta "name<test@example.com>" "name <test@example.com>" &&
-  author_test epsilon "name <test@example.com" "name <unknown>" &&
+  author_test epsilon "name <test@example.com" "name <test@example.com>" &&
   author_test zeta " test " "test <unknown>" &&
   author_test eta "test < test@example.com >" "test <test@example.com>" &&
-  author_test theta "test >test@example.com>" "test <unknown>" &&
+  author_test theta "test >test@example.com>" "test <test@example.com>" &&
   author_test iota "test < test <at> example <dot> com>" "test <unknown>" &&
-  author_test kappa "test@example.com" "test@example.com <unknown>"
+  author_test kappa "test@example.com" "Unknown <test@example.com>"
   ) &&
 
   git clone "hg::$PWD/hgrepo" gitrepo &&
-- 
1.8.2.1.790.g4588561
