From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v1 4/4] add test cases for '--graph' of line level log
Date: Sun, 11 Jul 2010 14:27:37 +0800
Message-ID: <1278829657-26607-5-git-send-email-struggleyb.nku@gmail.com>
References: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXq3J-0003wy-DN
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0GKGaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:30:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51755 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0GKGaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:30:00 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1400513pwi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=27YNrQONi2PR19fxBMeWBGe8r3xQ1xVtsGa9qBQhaYE=;
        b=AM0k7VUChNTKHlvOQf7H6yHiikBUuCKkT/OkrnBFbkGV78oJWZ2wFcXCtlUDwaOcKs
         XCfgyYmhVDzGO5TEt5NyVJBlEO40kP7wk6t4gBE4YByCGB8t/ooxfVIVnRqPuwl8xR2I
         xUGZe7bApnsXLZZZHkyuAb7HLbRHSqZn6qrlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JK1lAJt7Sumqr9ecrvvqXU2v1oFr9k9c3/AztdvXg13IK7pkK254V7+gl7JMJLSnH/
         s9D1esnr6i3APN/68WmsJ6mI/IZGoWQ3zNtNQ7AoYnq2k78Ed1usTWI1XOVfK+GBnmLn
         XQAKXavsmKP1Ytp/YbzEfIOUzFYKix5hzhNgk=
Received: by 10.142.127.9 with SMTP id z9mr14358589wfc.185.1278829800108;
        Sat, 10 Jul 2010 23:30:00 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id b19sm1874759rvf.3.2010.07.10.23.29.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:29:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150761>

t/t4301-log-line-single-history.sh:
  test the linear line of history with '--graph' option;

t/t4302-log-line-merge-history.sh:
  test the case that there are merges in the history with
  '--graph' option.

Note that, '--always-print' option will take no effect when
'--graph' is also given.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/git-log.txt          |    2 +
 t/t4301-log-line-single-history.sh |  225 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |   51 ++++++++-
 3 files changed, 277 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 14a9703..96ae0fe 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -101,6 +101,8 @@ of lines before or after the line given by <start>.
 --always-print::
 	Always print the interesting range even if the current commit
 	does not change any line of the range.
+	Note that this option will take no effect when '--graph' is
+	also given.
 
 
 include::rev-list-options.txt[]
diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
index 9981496..29091af 100755
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
+	'Test the --always-print option with --graph option' \
+	'git log --pretty=format:%s%n%b --always-print --graph -L 1,2 path0 > current-always-graph'
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
