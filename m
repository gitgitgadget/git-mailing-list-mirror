From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] diffstat summary line varies by locale: miscellany
Date: Tue, 13 Mar 2012 00:05:54 -0500
Message-ID: <20120313050554.GG12550@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 06:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Jw7-0006BR-59
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 06:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758234Ab2CMFGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 01:06:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55811 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab2CMFGH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 01:06:07 -0400
Received: by yhmm54 with SMTP id m54so143078yhm.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JGgczyAPE+tobgQ19kkHElVOTPJsGuo7BjnK8zrC08Q=;
        b=yLAtarhWWwXgVE1KrB0FApiGuHxi9A88K66s51xX7sdG18jklDzNLGtJS+vinTqqcw
         VVQEwEOZlWNGtUl0/QhztxAywMhtG2YxFyBzEpgQTc21LH/zBvCrBTl74AnZzhnXbPf0
         IGrKDXUzFNSlblemj3Trt0rtlbvhliMD8/lnIVu4ifCXWVIrb9DApppq96ySQN4v5PXz
         krQ1Rg2ZqLTVvvcJAOtEqu6bdfzhFz3khpKQtDzEf9ZQpGwPgV0eEO54HPCyum2tqFCt
         w+I/uBGW9SsPogqIM7ZzTngULsPxNWz0WAe1bUzf241yfDiYwWXiU2a/KrirnE4dHUC0
         U3og==
Received: by 10.60.12.231 with SMTP id b7mr10214920oec.38.1331615166782;
        Mon, 12 Mar 2012 22:06:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id yv3sm24354913obb.3.2012.03.12.22.06.05
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 22:06:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313045100.GA12474@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192978>

These changes are in the same spirit as the six patches that
precede them, but they haven't been split into individually
justifiable patches yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The t4013-diff-various.sh change is what I would be most interested in
feedback on.

Thanks for reading, and sorry for the rough state of these patches.
I am sending them out now mostly so others do not have to start from
scratch repeating the same work in order to keep using the
GETTEXT_POISON facility.

Good night,
Jonathan

 t/t4013-diff-various.sh        |    7 ++++-
 t/t4014-format-patch.sh        |    9 ++----
 t/t4016-diff-quote.sh          |   35 ++++++++++++++--------
 t/t4030-diff-textconv.sh       |    6 +++-
 t/t4031-diff-rewrite-binary.sh |   10 +++++--
 t/t4043-diff-rename-binary.sh  |    8 ++---
 t/t4045-diff-relative.sh       |   16 ++++++++--
 t/t4047-diff-dirstat.sh        |   65 +++++++++++++++++++---------------------
 8 files changed, 94 insertions(+), 62 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 93a6f208..e77c09c3 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -128,7 +128,12 @@ do
 		} >"$actual" &&
 		if test -f "$expect"
 		then
-			test_cmp "$expect" "$actual" &&
+			case $cmd in
+			*format-patch* | *-stat*)
+				test_i18ncmp "$expect" "$actual";;
+			*)
+				test_cmp "$expect" "$actual";;
+			esac &&
 			rm -f "$actual"
 		else
 			# this is to help developing new tests.
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7dfe716c..b473b6d6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -518,11 +518,6 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 '
 
 cat > expect << EOF
----
- file |   16 ++++++++++++++++
- 1 file changed, 16 insertions(+)
-
-diff --git a/file b/file
 index 40f36c6..2dc5c23 100644
 --- a/file
 +++ b/file
@@ -537,7 +532,9 @@ EOF
 test_expect_success 'format-patch respects -U' '
 
 	git format-patch -U4 -2 &&
-	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	sed -e "1,/^diff/d" -e "/^+5/q" \
+		<0001-This-is-an-excessively-long-subject-line-for-a-messa.patch \
+		>output &&
 	test_cmp expect output
 
 '
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index ab0c2f05..3ec71184 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -57,22 +57,33 @@ test_expect_success TABS_IN_FILENAMES 'git diff --summary -M HEAD' '
 	test_cmp expect actual
 '
 
-test_expect_success TABS_IN_FILENAMES 'setup expected files' '
-cat >expect <<\EOF
- pathname.1 => "Rpathname\twith HT.0"            |    0
- pathname.3 => "Rpathname\nwith LF.0"            |    0
- "pathname\twith HT.3" => "Rpathname\nwith LF.1" |    0
- pathname.2 => Rpathname with SP.0               |    0
- "pathname\twith HT.2" => Rpathname with SP.1    |    0
- pathname.0 => Rpathname.0                       |    0
- "pathname\twith HT.0" => Rpathname.1            |    0
- 7 files changed, 0 insertions(+), 0 deletions(-)
-EOF
+test_expect_success TABS_IN_FILENAMES 'git diff --numstat -M HEAD' '
+	cat >expect <<-\EOF &&
+	0	0	pathname.1 => "Rpathname\twith HT.0"
+	0	0	pathname.3 => "Rpathname\nwith LF.0"
+	0	0	"pathname\twith HT.3" => "Rpathname\nwith LF.1"
+	0	0	pathname.2 => Rpathname with SP.0
+	0	0	"pathname\twith HT.2" => Rpathname with SP.1
+	0	0	pathname.0 => Rpathname.0
+	0	0	"pathname\twith HT.0" => Rpathname.1
+	EOF
+	git diff --numstat -M HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success TABS_IN_FILENAMES 'git diff --stat -M HEAD' '
+	cat >expect <<-\EOF &&
+	 pathname.1 => "Rpathname\twith HT.0"            |    0
+	 pathname.3 => "Rpathname\nwith LF.0"            |    0
+	 "pathname\twith HT.3" => "Rpathname\nwith LF.1" |    0
+	 pathname.2 => Rpathname with SP.0               |    0
+	 "pathname\twith HT.2" => Rpathname with SP.1    |    0
+	 pathname.0 => Rpathname.0                       |    0
+	 "pathname\twith HT.0" => Rpathname.1            |    0
+	 7 files changed, 0 insertions(+), 0 deletions(-)
+	EOF
 	git diff --stat -M HEAD >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_done
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 4ac162cf..06b05df8 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -91,7 +91,11 @@ EOF
 test_expect_success 'diffstat does not run textconv' '
 	echo file diff=fail >.gitattributes &&
 	git diff --stat HEAD^ HEAD >actual &&
-	test_cmp expect.stat actual
+	test_i18ncmp expect.stat actual &&
+
+	head -n1 <expect.stat >expect.line1 &&
+	head -n1 <actual >actual.line1 &&
+	test_cmp expect.line1 actual.line1
 '
 # restore working setup
 echo file diff=foo >.gitattributes
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index 7d7470f2..c8296fa4 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -44,10 +44,16 @@ test_expect_success 'rewrite diff can show binary patch' '
 	grep "GIT binary patch" diff
 '
 
-test_expect_success 'rewrite diff --stat shows binary changes' '
+test_expect_success 'rewrite diff --numstat shows binary changes' '
+	git diff -B --numstat --summary >diff &&
+	grep -e "-	-	" diff &&
+	grep " rewrite file" diff
+'
+
+test_expect_success 'diff --stat counts binary rewrite as 0 lines' '
 	git diff -B --stat --summary >diff &&
 	grep "Bin" diff &&
-	grep "0 insertions.*0 deletions" diff &&
+	test_i18ngrep "0 insertions.*0 deletions" diff &&
 	grep " rewrite file" diff
 '
 
diff --git a/t/t4043-diff-rename-binary.sh b/t/t4043-diff-rename-binary.sh
index 06012811..2a2cf913 100755
--- a/t/t4043-diff-rename-binary.sh
+++ b/t/t4043-diff-rename-binary.sh
@@ -23,9 +23,8 @@ test_expect_success 'move the files into a "sub" directory' '
 '
 
 cat > expected <<\EOF
- bar => sub/bar |  Bin 5 -> 5 bytes
- foo => sub/foo |    0
- 2 files changed, 0 insertions(+), 0 deletions(-)
+-	-	bar => sub/bar
+0	0	foo => sub/foo
 
 diff --git a/bar b/sub/bar
 similarity index 100%
@@ -38,7 +37,8 @@ rename to sub/foo
 EOF
 
 test_expect_success 'git show -C -C report renames' '
-	git show -C -C --raw --binary --stat | tail -n 12 > current &&
+	git show -C -C --raw --binary --numstat >patch-with-stat &&
+	tail -n 11 patch-with-stat >current &&
 	test_cmp expected current
 '
 
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index bd119be1..18fadcf0 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -29,6 +29,18 @@ test_expect_success "-p $*" "
 "
 }
 
+check_numstat() {
+expect=$1; shift
+cat >expected <<EOF
+1	0	$expect
+EOF
+test_expect_success "--numstat $*" "
+	echo '1	0	$expect' >expected &&
+	git diff --numstat $* HEAD^ >actual &&
+	test_cmp expected actual
+"
+}
+
 check_stat() {
 expect=$1; shift
 cat >expected <<EOF
@@ -37,7 +49,7 @@ cat >expected <<EOF
 EOF
 test_expect_success "--stat $*" "
 	git diff --stat $* HEAD^ >actual &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 "
 }
 
@@ -52,7 +64,7 @@ test_expect_success "--raw $*" "
 "
 }
 
-for type in diff stat raw; do
+for type in diff numstat stat raw; do
 	check_$type file2 --relative=subdir/
 	check_$type file2 --relative=subdir
 	check_$type dir/file2 --relative=sub
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 29e80a58..ed7e0933 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -252,50 +252,47 @@ EOF
 '
 
 cat <<EOF >expect_diff_stat
- changed/text             |    2 +-
- dst/copy/changed/text    |   10 ++++++++++
- dst/copy/rearranged/text |   10 ++++++++++
- dst/copy/unchanged/text  |   10 ++++++++++
- dst/move/changed/text    |   10 ++++++++++
- dst/move/rearranged/text |   10 ++++++++++
- dst/move/unchanged/text  |   10 ++++++++++
- rearranged/text          |    2 +-
- src/move/changed/text    |   10 ----------
- src/move/rearranged/text |   10 ----------
- src/move/unchanged/text  |   10 ----------
- 11 files changed, 62 insertions(+), 32 deletions(-)
+1	1	changed/text
+10	0	dst/copy/changed/text
+10	0	dst/copy/rearranged/text
+10	0	dst/copy/unchanged/text
+10	0	dst/move/changed/text
+10	0	dst/move/rearranged/text
+10	0	dst/move/unchanged/text
+1	1	rearranged/text
+0	10	src/move/changed/text
+0	10	src/move/rearranged/text
+0	10	src/move/unchanged/text
 EOF
 
 cat <<EOF >expect_diff_stat_M
- changed/text                      |    2 +-
- dst/copy/changed/text             |   10 ++++++++++
- dst/copy/rearranged/text          |   10 ++++++++++
- dst/copy/unchanged/text           |   10 ++++++++++
- {src => dst}/move/changed/text    |    2 +-
- {src => dst}/move/rearranged/text |    2 +-
- {src => dst}/move/unchanged/text  |    0
- rearranged/text                   |    2 +-
- 8 files changed, 34 insertions(+), 4 deletions(-)
+1	1	changed/text
+10	0	dst/copy/changed/text
+10	0	dst/copy/rearranged/text
+10	0	dst/copy/unchanged/text
+1	1	{src => dst}/move/changed/text
+1	1	{src => dst}/move/rearranged/text
+0	0	{src => dst}/move/unchanged/text
+1	1	rearranged/text
 EOF
 
 cat <<EOF >expect_diff_stat_CC
- changed/text                      |    2 +-
- {src => dst}/copy/changed/text    |    2 +-
- {src => dst}/copy/rearranged/text |    2 +-
- {src => dst}/copy/unchanged/text  |    0
- {src => dst}/move/changed/text    |    2 +-
- {src => dst}/move/rearranged/text |    2 +-
- {src => dst}/move/unchanged/text  |    0
- rearranged/text                   |    2 +-
- 8 files changed, 6 insertions(+), 6 deletions(-)
+1	1	changed/text
+1	1	{src => dst}/copy/changed/text
+1	1	{src => dst}/copy/rearranged/text
+0	0	{src => dst}/copy/unchanged/text
+1	1	{src => dst}/move/changed/text
+1	1	{src => dst}/move/rearranged/text
+0	0	{src => dst}/move/unchanged/text
+1	1	rearranged/text
 EOF
 
-test_expect_success 'sanity check setup (--stat)' '
-	git diff --stat HEAD^..HEAD >actual_diff_stat &&
+test_expect_success 'sanity check setup (--numstat)' '
+	git diff --numstat HEAD^..HEAD >actual_diff_stat &&
 	test_cmp expect_diff_stat actual_diff_stat &&
-	git diff --stat -M HEAD^..HEAD >actual_diff_stat_M &&
+	git diff --numstat -M HEAD^..HEAD >actual_diff_stat_M &&
 	test_cmp expect_diff_stat_M actual_diff_stat_M &&
-	git diff --stat -C -C HEAD^..HEAD >actual_diff_stat_CC &&
+	git diff --numstat -C -C HEAD^..HEAD >actual_diff_stat_CC &&
 	test_cmp expect_diff_stat_CC actual_diff_stat_CC
 '
 
-- 
1.7.9.2
