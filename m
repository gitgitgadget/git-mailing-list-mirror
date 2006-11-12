X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Rework cvsexportcommit to handle binary files for all cases.
Date: Sun, 12 Nov 2006 16:29:42 +0100
Message-ID: <200611121629.43104.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 12 Nov 2006 15:28:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31260>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjHFr-0007vu-9C for gcvg-git@gmane.org; Sun, 12 Nov
 2006 16:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932927AbWKLP2O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 10:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWKLP2O
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 10:28:14 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12839 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S932927AbWKLP2M (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 10:28:12 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 1CC33802806; Sun, 12 Nov 2006 16:24:42 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 05110-02; Sun, 12 Nov
 2006 16:24:40 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 8FB39802803; Sun, 12 Nov 2006 16:24:36 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now adding, removing and changing binary files works. I added test cases to make sure
it works and can be verified by others. Som other corner cases were resolved too.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 5e23851f8cf866112baf3e76973a8ca649d5c105..78c847ec906af8044e43f55d860a0652eff3e759 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -139,6 +139,17 @@ foreach my $f (@files) {
 	push @dfiles, $fields[5];
     }
 }
+my (@binfiles, @abfiles, @dbfiles, @bfiles, @mbfiles);
+@binfiles = grep m/^Binary files/, safe_pipe_capture('git-diff-tree', '-p', $parent, $commit);
+map { chomp } @binfiles;
+@abfiles = grep s/^Binary files \/dev\/null and b\/(.*) differ$/$1/, @binfiles;
+@dbfiles = grep s/^Binary files a\/(.*) and \/dev\/null differ$/$1/, @binfiles;
+@mbfiles = grep s/^Binary files a\/(.*) and b\/(.*) differ$/$1/, @binfiles;
+push @bfiles, @abfiles;
+push @bfiles, @dbfiles;
+push @bfiles, @mbfiles;
+push @mfiles, @mbfiles;
+
 $opt_v && print "The commit affects:\n ";
 $opt_v && print join ("\n ", @afiles,@mfiles,@dfiles) . "\n\n";
 undef @files; # don't need it anymore
@@ -153,6 +164,10 @@ foreach my $d (@dirs) {
 }
 foreach my $f (@afiles) {
     # This should return only one value
+    if ($f =~ m,(.*)/[^/]*$,) {
+        my $p="m,^".$1."\$,";
+	next if grep $p,@dirs;
+    }
     my @status = grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'status' ,$f));
     if (@status > 1) { warn 'Strange! cvs status returned more than one line?'};
     if (-d dirname $f and $status[0] !~ m/Status: Unknown$/
@@ -162,6 +177,7 @@ foreach my $f (@afiles) {
 	warn "Status was: $status[0]\n";
     }
 }
+
 foreach my $f (@mfiles, @dfiles) {
     # TODO:we need to handle removed in cvs
     my @status = grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'status' ,$f));
@@ -200,24 +216,32 @@ foreach my $d (@dirs) {
 
 print "'Patching' binary files\n";
 
-my @bfiles = grep(m/^Binary/, safe_pipe_capture('git-diff-tree', '-p', $parent, $commit));
-@bfiles = map { chomp } @bfiles;
 foreach my $f (@bfiles) {
     # check that the file in cvs matches the "old" file
     # extract the file to $tmpdir and compare with cmp
-    my $tree = safe_pipe_capture('git-rev-parse', "$parent^{tree}");
-    chomp $tree;
-    my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
-    chomp $blob;
-    `git-cat-file blob $blob > $tmpdir/blob`;
-    if (system('cmp', '-s', $f, "$tmpdir/blob")) {
-	warn "Binary file $f in CVS does not match parent.\n";
-	$dirty = 1;
-	next;
+    my $p="m/^$f$/";
+    if (not(grep $p,@afiles)) {
+        my $tree = safe_pipe_capture('git-rev-parse', "$parent^{tree}");
+	chomp $tree;
+	my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
+	chomp $blob;
+        `git-cat-file blob $blob > $tmpdir/blob`;
+        if (system('cmp', '-s', $f, "$tmpdir/blob")) {
+	    warn "Binary file $f in CVS does not match parent.\n";
+	    if (not $opt_f) {
+	        $dirty = 1;
+		next;
+	    }
+        }
+    }
+    if (not(grep m/^$f$/,@dfiles)) {
+	my $tree = safe_pipe_capture('git-rev-parse', "$commit^{tree}");
+	chomp $tree;
+	my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
+	chomp $blob;
+	# replace with the new file
+	`git-cat-file blob $blob > $f`;
     }
-
-    # replace with the new file
-     `git-cat-file blob $blob > $f`;
 
     # TODO: something smart with file modes
 
@@ -231,7 +255,10 @@ ## apply non-binary changes
 my $fuzz = $opt_p ? 0 : 2;
 
 print "Patching non-binary files\n";
-print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz ) 2>&1`;
+
+if (scalar(@afiles)+scalar(@dfiles)+scalar(@mfiles) ne scalar(@bfiles)) {
+    print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz ) 2>&1`;
+}
 
 my $dirtypatch = 0;
 if (($? >> 8) == 2) {
@@ -242,7 +269,11 @@ if (($? >> 8) == 2) {
 }
 
 foreach my $f (@afiles) {
-    system('cvs', 'add', $f);
+    if (grep /^$f$/,@bfiles) {
+      system('cvs', 'add','-kb',$f);
+    } else {
+      system('cvs', 'add', $f);
+    }
     if ($?) {
 	$dirty = 1;
 	warn "Failed to cvs add $f -- you may need to do it manually";
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
new file mode 100755
index 0000000000000000000000000000000000000000..0ae03f80694a5d4ca3e61b40f6787a89fe8a496e
--- /dev/null
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -0,0 +1,145 @@
+#!/bin/bash
+#
+# Copyright (c) Robin Rosenberg
+#
+test_description='CVS export comit. '
+
+. ./test-lib.sh
+
+cvs >/dev/null 2>&1
+if test $? -ne 1
+then
+    test_expect_success 'skipping git-cvsexportcommit tests, cvs not found' :
+    test_done
+    exit
+fi
+
+export CVSROOT=$(pwd)/cvsroot
+export CVSWORK=$(pwd)/cvswork
+rm -rf "$CVSROOT" "$CVSWORK"
+mkdir "$CVSROOT" &&
+cvs init &&
+cvs -Q co -d "$CVSWORK" . &&
+export GIT_DIR=$(pwd)/.git &&
+echo >empty &&
+git add empty &&
+git commit -a -m "Initial" 2>/dev/null ||
+exit 1
+
+test_expect_success \
+    'New file' \
+    'mkdir A B C D E F &&
+     echo hello1 >A/newfile1.txt &&
+     echo hello2 >B/newfile2.txt &&
+     cp ../test9200a.png C/newfile3.png &&
+     cp ../test9200a.png D/newfile4.png &&
+     git add A/newfile1.txt &&
+     git add B/newfile2.txt &&
+     git add C/newfile3.png &&
+     git add D/newfile4.png &&
+     git commit -a -m "Test: New file" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd "$CVSWORK" &&
+     git cvsexportcommit -c $id &&
+     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" = "newfile1.txt/1.1/" &&
+     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" = "newfile2.txt/1.1/" &&
+     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" = "newfile3.png/1.1/-kb" &&
+     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" = "newfile4.png/1.1/-kb" &&
+     diff A/newfile1.txt ../A/newfile1.txt &&
+     diff B/newfile2.txt ../B/newfile2.txt &&
+     diff C/newfile3.png ../C/newfile3.png &&
+     diff D/newfile4.png ../D/newfile4.png
+     )'
+
+test_expect_success \
+    'Remove two files, add two and update two' \
+    'echo Hello1 >>A/newfile1.txt &&
+     rm -f B/newfile2.txt &&
+     rm -f C/newfile3.png &&
+     echo Hello5  >E/newfile5.txt &&
+     cp ../test9200b.png D/newfile4.png &&
+     cp ../test9200a.png F/newfile6.png &&
+     git add E/newfile5.txt &&
+     git add F/newfile6.png &&
+     git commit -a -m "Test: Remove, add and update" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd "$CVSWORK" &&
+     git cvsexportcommit -c $id &&
+     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" = "newfile1.txt/1.2/" &&
+     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" = "newfile4.png/1.2/-kb" &&
+     test "$(echo $(sort E/CVS/Entries|cut -d/ -f2,3,5))" = "newfile5.txt/1.1/" &&
+     test "$(echo $(sort F/CVS/Entries|cut -d/ -f2,3,5))" = "newfile6.png/1.1/-kb" &&
+     diff A/newfile1.txt ../A/newfile1.txt &&
+     diff D/newfile4.png ../D/newfile4.png &&
+     diff E/newfile5.txt ../E/newfile5.txt &&
+     diff F/newfile6.png ../F/newfile6.png
+     )'
+
+# Should fail (but only on the git-cvsexportcommit stage)
+test_expect_success \
+    'Fail to change binary more than one generation old' \
+    'cat F/newfile6.png >>D/newfile4.png &&
+     git commit -a -m "generatiion 1" &&
+     cat F/newfile6.png >>D/newfile4.png &&
+     git commit -a -m "generation 2" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd "$CVSWORK" &&
+     ! git cvsexportcommit -c $id
+     )'
+
+# Should fail, but only on the git-cvsexportcommit stage
+test_expect_success \
+    'Fail to remove binary file more than one generation old' \
+    'git reset --hard HEAD^ &&
+     cat F/newfile6.png >>D/newfile4.png &&
+     git commit -a -m "generation 2 (again)" &&
+     rm -f D/newfile4.png &&
+     git commit -a -m "generation 3" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd "$CVSWORK" &&
+     ! git cvsexportcommit -c $id
+     )'
+
+# We reuse the state from two tests back here
+
+# This test is here because a patch for only binary files will
+# fail with gnu patch, so cvsexportcommit must handle that.
+test_expect_success \
+    'Remove only binary files' \
+    'git reset --hard HEAD^^^ &&
+     rm -f D/newfile4.png &&
+     git commit -a -m "test: remove only a binary file" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd "$CVSWORK" &&
+     git cvsexportcommit -c $id &&
+     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" = "newfile1.txt/1.2/" &&
+     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort E/CVS/Entries|cut -d/ -f2,3,5))" = "newfile5.txt/1.1/" &&
+     test "$(echo $(sort F/CVS/Entries|cut -d/ -f2,3,5))" = "newfile6.png/1.1/-kb" &&
+     diff A/newfile1.txt ../A/newfile1.txt &&
+     diff E/newfile5.txt ../E/newfile5.txt &&
+     diff F/newfile6.png ../F/newfile6.png
+     )'
+
+test_expect_success \
+    'Remove only a text file' \
+    'rm -f A/newfile1.txt &&
+     git commit -a -m "test: remove only a binary file" &&
+     id=$(git rev-list --max-count=1 HEAD) &&
+     (cd "$CVSWORK" &&
+     git cvsexportcommit -c $id &&
+     test "$(echo $(sort A/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort B/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort C/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort D/CVS/Entries|cut -d/ -f2,3,5))" = "" &&
+     test "$(echo $(sort E/CVS/Entries|cut -d/ -f2,3,5))" = "newfile5.txt/1.1/" &&
+     test "$(echo $(sort F/CVS/Entries|cut -d/ -f2,3,5))" = "newfile6.png/1.1/-kb" &&
+     diff E/newfile5.txt ../E/newfile5.txt &&
+     diff F/newfile6.png ../F/newfile6.png
+     )' 
+
+test_done
diff --git a/t/test9200a.png b/t/test9200a.png
new file mode 100644
index 0000000000000000000000000000000000000000..7b181d15cebb4c86a6ad7fed3dbf30ce2223b4c5
GIT binary patch
literal 5660
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

diff --git a/t/test9200b.png b/t/test9200b.png
new file mode 100644
index 0000000000000000000000000000000000000000..ac22ccbd3ee9f03a3b38249ac8efdbe96b5da2cd
GIT binary patch
literal 275
zc%17D@N?(olHy`uVBq!ia0vp^9zZP3!VDyJZ(h*_aRPioToo7?5)xuJtY5{@z;N#D
z@dFGDFJ3(R{{7qk|No7uYm$J<7)yfuf*Bm1-ADs*lDyqr7&=&GL8fsQctjR6FmMZl
zFeAgPITAoY_7YEDSN3bH%%X-S`j4JZ016d)x;TbtoKN<6ufXCZA)&>gl@*-uLV<^+
zZOfu-7cOu}w0W9H3$HwJqlx472Q4Ervph31wm>lpQB&rr2^-hlWNOq5Vkv20<q=-Z
z@v30LY2AXTcBx4_L=O5$-0^JfxTAF7fm=Y}A_nHk3XTg7IPfqqTq@aCrp)Sh2xvKj
Mr>mdKI;Vst05+voj{pDw

-- 
1.4.2
