From: Anthony Ramine <n.oxyde@gmail.com>
Subject: [PATCH] wildmatch: properly fold case everywhere
Date: Tue, 28 May 2013 14:32:41 +0200
Message-ID: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 14:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJ5W-0002VT-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933893Ab3E1MdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:33:09 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36399 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933862Ab3E1MdH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:33:07 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so2421585wgh.30
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cfBnBLWk8RKtbjQfoZKNv+kL4QxfLPScZpt+YBQhSA4=;
        b=id5m9/StMbj7m/Uo1h/v3YZig1GCPnhlpJ92PlgjyLbH/yQ1aQZPh90EFnTuN4zVM9
         2d3q1waHqrjRDKY/2q0IB9VgU4mACVB3guMo42aCpF0negM0D+XrMAjCBDnVCjl9a2iE
         S8Ngwss+cqa004ioZxfn29RZA6VYWaIXMb/muTqInUuv93Ye0X0SJHvNe28wLwDMaSC6
         bUkGPOGAlO0tTmRZNsTBFJp6Qp/KJCocvR+u35xHOW8ShC/TMiu0dQgCTpIlCbsEaZfo
         0ypDRrmn6xkLt208HdDvjH/Ktnv7W/09pfrG9mLdliq/LicuFxuZMmMZnLP7Eqo7ai7r
         Jigg==
X-Received: by 10.180.183.206 with SMTP id eo14mr11940307wic.36.1369744386511;
        Tue, 28 May 2013 05:33:06 -0700 (PDT)
Received: from localhost.localdomain (33-43.83-90.static-ip.oleane.fr. [90.83.43.33])
        by mx.google.com with ESMTPSA id q13sm24012183wie.8.2013.05.28.05.33.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:33:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225631>

Case folding is not done correctly when matching against the [:upper:]
character class and uppercased character ranges (e.g. A-Z).
Specifically, an uppercase letter fails to match against any of them
when case folding is requested because plain characters in the pattern
and the whole string and preemptively lowercased to handle the base case
fast.

That optimization is kept and ISLOWER() is used in the [:upper:] case
when case folding is requested, while matching against a character range
is retried with toupper() if the character was lowercase.

Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>
---
 t/t3070-wildmatch.sh | 43 +++++++++++++++++++++++++++++++++++++------
 wildmatch.c          |  7 +++++++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4c37057..17315aa 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -6,20 +6,20 @@ test_description='wildmatch tests'
 
 match() {
     if [ $1 = 1 ]; then
-	test_expect_success "wildmatch:    match '$3' '$4'" "
+	test_expect_success "wildmatch:     match '$3' '$4'" "
 	    test-wildmatch wildmatch '$3' '$4'
 	"
     else
-	test_expect_success "wildmatch: no match '$3' '$4'" "
+	test_expect_success "wildmatch:  no match '$3' '$4'" "
 	    ! test-wildmatch wildmatch '$3' '$4'
 	"
     fi
     if [ $2 = 1 ]; then
-	test_expect_success "fnmatch:      match '$3' '$4'" "
+	test_expect_success "fnmatch:       match '$3' '$4'" "
 	    test-wildmatch fnmatch '$3' '$4'
 	"
     elif [ $2 = 0 ]; then
-	test_expect_success "fnmatch:   no match '$3' '$4'" "
+	test_expect_success "fnmatch:    no match '$3' '$4'" "
 	    ! test-wildmatch fnmatch '$3' '$4'
 	"
 #    else
@@ -29,13 +29,25 @@ match() {
     fi
 }
 
+imatch() {
+    if [ $1 = 1 ]; then
+	test_expect_success "iwildmatch:    match '$2' '$3'" "
+	    test-wildmatch iwildmatch '$2' '$3'
+	"
+    else
+	test_expect_success "iwildmatch: no match '$2' '$3'" "
+	    ! test-wildmatch iwildmatch '$2' '$3'
+	"
+    fi
+}
+
 pathmatch() {
     if [ $1 = 1 ]; then
-	test_expect_success "pathmatch:    match '$2' '$3'" "
+	test_expect_success "pathmatch:     match '$2' '$3'" "
 	    test-wildmatch pathmatch '$2' '$3'
 	"
     else
-	test_expect_success "pathmatch: no match '$2' '$3'" "
+	test_expect_success "pathmatch:  no match '$2' '$3'" "
 	    ! test-wildmatch pathmatch '$2' '$3'
 	"
     fi
@@ -235,4 +247,23 @@ pathmatch 1 abcXdefXghi '*X*i'
 pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
 pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
 
+# Case-sensitivy features
+match 0 x 'a' '[A-Z]'
+match 1 x 'A' '[A-Z]'
+match 0 x 'A' '[a-z]'
+match 1 x 'a' '[a-z]'
+match 0 x 'a' '[[:upper:]]'
+match 1 x 'A' '[[:upper:]]'
+match 0 x 'A' '[[:lower:]]'
+match 1 x 'a' '[[:lower:]]'
+
+imatch 1 'a' '[A-Z]'
+imatch 1 'A' '[A-Z]'
+imatch 1 'A' '[a-z]'
+imatch 1 'a' '[a-z]'
+imatch 1 'a' '[[:upper:]]'
+imatch 1 'A' '[[:upper:]]'
+imatch 1 'A' '[[:lower:]]'
+imatch 1 'a' '[[:lower:]]'
+
 test_done
diff --git a/wildmatch.c b/wildmatch.c
index 7192bdc..ea318d3 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					}
 					if (t_ch <= p_ch && t_ch >= prev_ch)
 						matched = 1;
+					else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch)) {
+						t_ch = toupper(t_ch);
+						if (t_ch <= p_ch && t_ch >= prev_ch)
+							matched = 1;
+					}
 					p_ch = 0; /* This makes "prev_ch" get set to 0. */
 				} else if (p_ch == '[' && p[1] == ':') {
 					const uchar *s;
@@ -245,6 +250,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					} else if (CC_EQ(s,i, "upper")) {
 						if (ISUPPER(t_ch))
 							matched = 1;
+						else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch))
+							matched = 1;
 					} else if (CC_EQ(s,i, "xdigit")) {
 						if (ISXDIGIT(t_ch))
 							matched = 1;
-- 
1.8.3
