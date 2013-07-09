From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/2] t4211: fix broken test when one -L range is subset of another
Date: Tue,  9 Jul 2013 01:55:04 -0400
Message-ID: <1373349305-63917-2-git-send-email-sunshine@sunshineco.com>
References: <1373349305-63917-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 07:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQtf-0008KF-L0
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab3GIFz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:55:27 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:48279 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab3GIFz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:55:26 -0400
Received: by mail-yh0-f50.google.com with SMTP id i72so2152653yha.23
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yogEInKFykuQUOI0t3682gBTazm9RZ/MHCdyLkobtuE=;
        b=iYRJAfAJFiz/bmU5kf/FQ36S7P9CgFic/Fs8FiMASfAaiB7Vd6r9m5v5VtGAPcigwD
         4tDSN7TYu3Rs3ZTbc4T/k/JJ5OL9PWM0W/6GwO3B0bFapEd91/5zCeRRMsQW6zYQudel
         o7fvNo8r5MqBUqq3JmfEeKT5dP/YgA06rDWy/MNWpFEeS+uuLws9sJLE8Y0HPEvXDDNk
         7VU1Ji/ZnvPqLokMs1KPJOJTij2tujhLgZNFJJPQlqJ2QsJMOm2nrIdS4Y1r2miBf4OJ
         G/S2OUhqGlMoeGmYn2UHxOu5ov+yv84TpbBOOCyNNX3kCbvssc48t1mM0UWQdYYU9l4g
         4R6g==
X-Received: by 10.236.63.73 with SMTP id z49mr14042171yhc.161.1373349325819;
        Mon, 08 Jul 2013 22:55:25 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id e69sm42754928yhl.3.2013.07.08.22.55.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 22:55:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373349305-63917-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229916>

t4211 attempts to test multiple git-log -L ranges where one range is a
superset of the other, and falsely succeeds because its "expected"
output is incorrect.

Overlapping -L ranges handed to git-log are coalesced by
line-log.c:sort_and_merge_range_set() into a set of non-overlapping,
disjoint ranges. When one range is a subset of another,
sort_and_merge_range_set() should coalesce both ranges to the superset
range, but instead the coalesced range often is incorrectly truncated to
the end of the subset range. For example, ranges 2-8 and 3-4 are
coalesced incorrectly to 2-4.

One can observe this incorrect behavior with git-log -L using the test
repository created by t4211. The superset/subset ranges t4211 employs
are 4-$ and 8-12 (where $ represents end-of-file). The coalesced range
should be 4-$. Manually invoking git-log with the same ranges the test
employs, we see:

  % git log -L 4:a.c simple |
    awk '/^commit [0-9a-f]{40}/ { print substr($2,1,7) }'
  4659538
  100b61a
  39b6eb2
  a6eb826
  f04fb20
  de4c48a

  % git log -L 8,12:a.c simple | awk ...
  f04fb20
  de4c48a

  % git log -L 4:a.c -L 8,12:a.c simple | awk ...
  a6eb826
  f04fb20
  de4c48a

This last output is incorrect. 8-12 is a subset of 4-$, hence the output
of the coalesced range should be the same as the 4-$ output shown first.
In fact, the above incorrect output is the truncated bogus range 4-12:

  % git log -L 4,12:a.c simple | awk ...
  a6eb826
  f04fb20
  de4c48a

Fix the test to correctly fail in the presence of the
sort_and_merge_range_set() coalescing bug. Do so by changing the
"expected" output to the commits mentioned in the 4-$ output above.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4211-line-log.sh              |   4 +-
 t/t4211/expect.multiple-superset | 134 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 5 deletions(-)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 7776f93..549df9e 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -50,8 +50,8 @@ canned_test "-M -L ':f:b.c' parallel-change" parallel-change-f-to-main
 canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
 canned_test "-L 4,18:a.c -L :main:a.c simple" multiple-overlapping
 canned_test "-L :main:a.c -L 4,18:a.c simple" multiple-overlapping
-canned_test "-L 4:a.c -L 8,12:a.c simple" multiple-superset
-canned_test "-L 8,12:a.c -L 4:a.c simple" multiple-superset
+canned_test_failure "-L 4:a.c -L 8,12:a.c simple" multiple-superset
+canned_test_failure "-L 8,12:a.c -L 4:a.c simple" multiple-superset
 
 test_bad_opts "-L" "switch.*requires a value"
 test_bad_opts "-L b.c" "argument.*not of the form"
diff --git a/t/t4211/expect.multiple-superset b/t/t4211/expect.multiple-superset
index a1f5bc4..d930b6e 100644
--- a/t/t4211/expect.multiple-superset
+++ b/t/t4211/expect.multiple-superset
@@ -1,3 +1,100 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,21 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,19 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit 39b6eb2d5b706d3322184a169f666f25ed3fbd00
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:41 2013 +0100
+
+    touch comment
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,19 +3,19 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * A comment.
++ * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
 commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
 Author: Thomas Rast <trast@student.ethz.ch>
 Date:   Thu Feb 28 10:45:16 2013 +0100
@@ -7,7 +104,7 @@ Date:   Thu Feb 28 10:45:16 2013 +0100
 diff --git a/a.c b/a.c
 --- a/a.c
 +++ b/a.c
-@@ -3,9 +3,9 @@
+@@ -3,19 +3,19 @@
 -int f(int x)
 +long f(long x)
  {
@@ -18,6 +115,17 @@ diff --git a/a.c b/a.c
  	}
  	return s;
  }
+ 
+ /*
+  * A comment.
+  */
+ 
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
 
 commit f04fb20f2c77850996cba739709acc6faecc58f7
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -28,7 +136,7 @@ Date:   Thu Feb 28 10:44:55 2013 +0100
 diff --git a/a.c b/a.c
 --- a/a.c
 +++ b/a.c
-@@ -3,8 +3,9 @@
+@@ -3,18 +3,19 @@
  int f(int x)
  {
  	int s = 0;
@@ -38,6 +146,16 @@ diff --git a/a.c b/a.c
  	}
 +	return s;
  }
+ 
+ /*
+  * A comment.
+  */
+ 
+ int main ()
+ {
+ 	printf("%d\n", f(15));
+ 	return 0;
+ }
 
 commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -48,7 +166,7 @@ Date:   Thu Feb 28 10:44:48 2013 +0100
 diff --git a/a.c b/a.c
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,8 @@
+@@ -0,0 +3,18 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -57,3 +175,13 @@ diff --git a/a.c b/a.c
 +		s++;
 +	}
 +}
++
++/*
++ * A comment.
++ */
++
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
-- 
1.8.3.2
