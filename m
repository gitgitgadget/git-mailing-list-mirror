From: Anthony Ramine <n.oxyde@gmail.com>
Subject: [PATCH v2] wildmatch: properly fold case everywhere
Date: Tue, 28 May 2013 15:10:50 +0200
Message-ID: <1369746650-53869-1-git-send-email-n.oxyde@gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJgK-00065w-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934022Ab3E1NLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:11:12 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:40947 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933911Ab3E1NLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:11:11 -0400
Received: by mail-wg0-f45.google.com with SMTP id n12so5436426wgh.12
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JF232XLCKYlMxtB9UUwongosr946RooFjf8pWHMil1c=;
        b=tp9HSZCUtNkRmn8Y7Fw/75xnEMWyyceuGFLh5lbbmEKsqWdn0IWqaMHZg1js+gfCCJ
         ndCpVougfr/SnnpkatN/IvnDsooMEl5K3OkJ3GIXe73w8rByxsXD6Yvkb/v5H7ulGeM7
         DV1HxNGIpTDZIKXCMhpCNeHJS7RJ4cB08GOlDTFN82pRbJh5uDt6iuWHVwQPvxvqVJcx
         HxT1qKFvNgxWqkGRqfBNMFPn/iQ/STd27CAN8oW9mjnUPuvQ9n019HiV4t4uTDD7sAgm
         j1QBXaazob4keaL9Uxbqc4/yBD25X2jZgrHfIjJwgGOh9MCoJA4Tc1ABiCP5M97/l2WQ
         wjUQ==
X-Received: by 10.181.13.131 with SMTP id ey3mr11772825wid.41.1369746670256;
        Tue, 28 May 2013 06:11:10 -0700 (PDT)
Received: from localhost.localdomain (33-43.83-90.static-ip.oleane.fr. [90.83.43.33])
        by mx.google.com with ESMTPSA id ff10sm24215355wib.10.2013.05.28.06.11.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:11:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225645>

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
 t/t3070-wildmatch.sh | 47 +++++++++++++++++++++++++++++++++++++++++------
 wildmatch.c          |  7 +++++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4c37057..e1b45e6 100755
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
@@ -235,4 +247,27 @@ pathmatch 1 abcXdefXghi '*X*i'
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
+match 0 x 'A' '[B-Za]'
+match 1 x 'a' '[B-Za]'
+
+imatch 1 'a' '[A-Z]'
+imatch 1 'A' '[A-Z]'
+imatch 1 'A' '[a-z]'
+imatch 1 'a' '[a-z]'
+imatch 1 'a' '[[:upper:]]'
+imatch 1 'A' '[[:upper:]]'
+imatch 1 'A' '[[:lower:]]'
+imatch 1 'a' '[[:lower:]]'
+imatch 1 'A' '[B-Za]'
+imatch 1 'a' '[B-Za]'
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
