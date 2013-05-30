From: Anthony Ramine <n.oxyde@gmail.com>
Subject: [PATCH v5] wildmatch: properly fold case everywhere
Date: Thu, 30 May 2013 12:19:10 +0200
Message-ID: <1369909150-73114-1-git-send-email-n.oxyde@gmail.com>
References: <1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 30 12:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhzxN-0001rR-JD
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 12:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968104Ab3E3KTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 06:19:37 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:60191 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab3E3KTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 06:19:36 -0400
Received: by mail-we0-f173.google.com with SMTP id p57so60693wes.32
        for <git@vger.kernel.org>; Thu, 30 May 2013 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hqsmEA+87q28MLAELDZUXJ3qvFm2su0kUYWQbcjWATM=;
        b=wn9FDz75HcJLDCXQkS8zNKAOIO+jyU3JVq47QXV5oLGfdegdJdzUWpNFWvtJ0luGUg
         MV9fnZDHej29jkRkC+1q7za0N/wLLXK4XXFqR6O0B9BH0De+dn52IOpSgDsAgjeXCv7/
         ehM4nojwGTAO0vHhuDaeS43hUhdO8AcnSgo/SBifQcteSyoaVRG84nxTPFdP4L80Km7M
         ido7fV8vXz3Tt5kqf0+Cvjy9AlalK+CfHwHOockNIAfuhKA4ij1/5+8QF+EYPNlzl4Y+
         LbKJrYGODgvnti6amDaUC3PieMbCNngby9R0r2fMeWn3mpl7R7aSuy7Boz1rCm8sh2+V
         Qj0g==
X-Received: by 10.180.184.75 with SMTP id es11mr3831787wic.38.1369909171453;
        Thu, 30 May 2013 03:19:31 -0700 (PDT)
Received: from localhost.localdomain (33-43.83-90.static-ip.oleane.fr. [90.83.43.33])
        by mx.google.com with ESMTPSA id d10sm36973734wik.0.2013.05.30.03.19.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 03:19:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225954>

Case folding is not done correctly when matching against the [:upper:]
character class and uppercased character ranges (e.g. A-Z).
Specifically, an uppercase letter fails to match against any of them
when case folding is requested because plain characters in the pattern
and the whole string are preemptively lowercased to handle the base case
fast.

That optimization is kept and ISLOWER() is used in the [:upper:] case
when case folding is requested, while matching against a character range
is retried with toupper() if the character was lowercase, as the bounds
of the range itself cannot be modified (in a case-insensitive context,
[A-_] is not equivalent to [a-_]).

Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
---
 t/t3070-wildmatch.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++------
 wildmatch.c          |  7 +++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

I added Duy as reviewer and fixed a typo in the commit message reported by
Eric Sunshine.

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4c37057..38446a0 100755
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
@@ -235,4 +247,35 @@ pathmatch 1 abcXdefXghi '*X*i'
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
+match 0 x 'A' '[B-a]'
+match 1 x 'a' '[B-a]'
+match 0 x 'z' '[Z-y]'
+match 1 x 'Z' '[Z-y]'
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
+imatch 1 'A' '[B-a]'
+imatch 1 'a' '[B-a]'
+imatch 1 'z' '[Z-y]'
+imatch 1 'Z' '[Z-y]'
+
 test_done
diff --git a/wildmatch.c b/wildmatch.c
index 7192bdc..f91ba99 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					}
 					if (t_ch <= p_ch && t_ch >= prev_ch)
 						matched = 1;
+					else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch)) {
+						uchar t_ch_upper = toupper(t_ch);
+						if (t_ch_upper <= p_ch && t_ch_upper >= prev_ch)
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
