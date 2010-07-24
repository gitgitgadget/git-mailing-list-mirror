From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 17/22] Add test cases for '--graph' of line level log
Date: Sat, 24 Jul 2010 23:13:49 +0800
Message-ID: <1279984434-28933-18-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRt-00020D-EI
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197Ab0GXPPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:33 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:41271 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab0GXPPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:30 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so4061238pxi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zbZlk3WLwc3HbCRxURtLIMmU1iPdbo5xbe1Norz3Enw=;
        b=u1llZtR+GB7R0fDnSfZcq29VU7gfkYvYkVGlmuqg6mQme9yuGJ1+7FF/PEo23/tSgT
         lw0XeZ/z4HpoWQmqaat0PCS4FYjIxL+1NbgU6IfqA/u9B6RH+wXKbgcyX+E9OxEqMcWA
         kLEbSTYLAUM9CkBLsXYqkrjQIwBFEK6L5wkVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JDJn8pl6J98Mq6ycGBlW/YRoW+E7utiBzSEWB1Hum123qigZpSKPvOP+9OpvIJx0VA
         PAIoTbjlMWJld8SkavHWI5umDzVIpDTk+qIVgnSnvUvGRyUPljAPEEUyu0WLO/IrTSIm
         rW8FJuWOVI9RX7Tpn3nlr+l5A1GVl4qqPSies=
Received: by 10.142.136.1 with SMTP id j1mr6055589wfd.26.1279984525344;
        Sat, 24 Jul 2010 08:15:25 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151647>

t/t4301-log-line-single-history.sh:
  test the linear line of history with '--graph' option;

t/t4302-log-line-merge-history.sh:
  test the case that there are merges in the history with
  '--graph' option.

Note that, '--full-line-diff' option will take no effect when
'--graph' is also given.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/git-log.txt          |    2 +
 t/t4301-log-line-single-history.sh |  225 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |   51 ++++++++-
 3 files changed, 277 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6f712e7..1beb243 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,6 +77,8 @@ You can also specify this option more than once before each path.
 --full-line-diff::
 	Always print the interesting range even if the current commit
 	does not change any line of the range.
+	Note that this option will take no effect when '--graph' is
+	also given.
 
 [\--] <path>...::
 	Show only commits that affect any of the specified paths. To
diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
index 9cf34f8..812a41e 100755
--- a/t/t4301-log-line-single-history.sh
+++ b/t/t4301-log-line-single-history.sh
@@ -339,4 +339,229 @@ test_expect_success \
 	 test_cmp current-linenum expected-linenum &&
 	 test_cmp current-always expected-always'
 
+# Rerun all log with graph
+test_expect_success \
+    'Show the line level log of path0 with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 > current-path0-graph'
+
+test_expect_success \
+    'Show the line level log of path1 with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /output/,/^}/ path1 > current-path1-graph'
+
+test_expect_success \
+    'Show the line level log of two files with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L /func/,/^}/ path0 --graph -L /output/,/^}/ path1 > current-pathall-graph'
+
+test_expect_success \
+    'Test the line number argument with --graph' \
+    'git log --pretty=format:%s%n%b --graph -L 1,2 path0 > current-linenum-graph'
+
+test_expect_success \
+	'Test the --full-line-diff option with --graph option' \
+	'git log --pretty=format:%s%n%b --full-line-diff --graph -L 1,2 path0 > current-always-graph'
+
+cat > expected-path0-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,5 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,6 @@
+  +void func(){
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+EOF
+
+cat > expected-path1-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path1 b/path1
+| index 997d841..1d711b5 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,3 +1,4 @@
+|  void output(){
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..997d841
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,3 @@
+  +void output(){
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-pathall-graph <<\EOF
+* Final change of path0
+| 
+| diff --git a/path0 b/path0
+| index 44db133..1518c15 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,5 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+| -	int c;
+| -	c = 10 * (a + b);
+| +	printf("%d", a - b);
+|  }
+|  
+* Change the 5th line of path0
+| 
+| diff --git a/path0 b/path0
+| index 9ef1692..44db133 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+|  	int a = 10;
+|  	int b = 11;
+|  	int c;
+| -	c = a + b;
+| +	c = 10 * (a + b);
+|  }
+|  
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,6 +1,6 @@
+|  void func(){
+| -	int a = 0;
+| -	int b = 1;
+| +	int a = 10;
+| +	int b = 11;
+|  	int c;
+|  	c = a + b;
+|  }
+| diff --git a/path1 b/path1
+| index 997d841..1d711b5 100644
+| --- a/path1
+| +++ b/path1
+| @@ -1,3 +1,4 @@
+|  void output(){
+| -	printf("hello world");
+| +	const char *str = "hello world!";
+| +	printf("%s", str);
+|  }
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,6 @@
+  +void func(){
+  +	int a = 0;
+  +	int b = 1;
+  +	int c;
+  +	c = a + b;
+  +}
+  diff --git a/path1 b/path1
+  new file mode 100644
+  index 0000000..997d841
+  --- /dev/null
+  +++ b/path1
+  @@ -0,0 +1,3 @@
+  +void output(){
+  +	printf("hello world");
+  +}
+EOF
+
+cat > expected-linenum-graph <<\EOF
+* Change 2,3 lines of path0 and path1
+| 
+| diff --git a/path0 b/path0
+| index aabffdf..9ef1692 100644
+| --- a/path0
+| +++ b/path0
+| @@ -1,2 +1,2 @@
+|  void func(){
+| -	int a = 0;
+| +	int a = 10;
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..aabffdf
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +1,2 @@
+  +void func(){
+  +	int a = 0;
+EOF
+
+test_expect_success \
+    'validate the output.' \
+    'test_cmp current-path0-graph expected-path0-graph &&
+	 test_cmp current-path1-graph expected-path1-graph &&
+	 test_cmp current-pathall-graph expected-pathall-graph &&
+	 test_cmp current-linenum-graph expected-linenum-graph &&
+	 test_cmp current-always-graph expected-linenum-graph'
+
 test_done
diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
index 02e7439..cd417d3 100755
--- a/t/t4302-log-line-merge-history.sh
+++ b/t/t4302-log-line-merge-history.sh
@@ -107,8 +107,57 @@ index 0000000..f628dea
 +	printf("hello");
 +}
 EOF
+
+cat > expected-graph <<\EOF
+*   Merge two branches
+|\  
+| | 
+| | nontrivial merge found
+| | path0
+| | 
+| | @@ 2,1 @@
+| |  	printf("hello earth and moon");
+| | 
+| |   
+| * Change path0 in master
+| | 
+| | diff --git a/path0 b/path0
+| | index f628dea..bef7fa3 100644
+| | --- a/path0
+| | +++ b/path0
+| | @@ -2,1 +2,1 @@
+| | -	printf("hello");
+| | +	printf("hello earth");
+| |   
+* | Change path0 in feature
+|/  
+|   
+|   diff --git a/path0 b/path0
+|   index f628dea..a940ef6 100644
+|   --- a/path0
+|   +++ b/path0
+|   @@ -2,1 +2,1 @@
+|   -	printf("hello");
+|   +	print("hello moon");
+|  
+* Base commit
+  
+  diff --git a/path0 b/path0
+  new file mode 100644
+  index 0000000..f628dea
+  --- /dev/null
+  +++ b/path0
+  @@ -0,0 +2,1 @@
+  +	printf("hello");
+EOF
+
+test_expect_success \
+    'Show the line log of the 2 line of path0 with graph' \
+    'git log --pretty=format:%s%n%b --graph -L 2,+1 path0 > current-graph'
+
 test_expect_success \
     'validate the output.' \
-    'test_cmp current expected'
+    'test_cmp current expected &&
+     test_cmp current-graph expected-graph'
 
 test_done
-- 
1.7.0.2.273.gc2413.dirty
