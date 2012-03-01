From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH-w 104/105] t0040 (parse-options): modernize style
Date: Wed, 29 Feb 2012 17:45:25 -0800
Message-ID: <1330566326-26075-10-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:46:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2v64-00046e-KN
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570Ab2CABqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 20:46:14 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52025 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030551Ab2CABqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 20:46:10 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so74765vbb.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:46:09 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.20.142 as permitted sender) client-ip=10.52.20.142;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.20.142 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.20.142])
        by 10.52.20.142 with SMTP id n14mr4146590vde.59.1330566369755 (num_hops = 1);
        Wed, 29 Feb 2012 17:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=RhZ78G+bZB9Kh0+ninG5zAOCVnhb4wyfW8+NZUcoA0w=;
        b=I04wMQ69HbmoVno37GXSHFbw4JW34P39ZO7R+YJZDOZIIBMVzIiO6AM1lTyfxUwxpD
         YWlbuicq0oE6z8uU6v2Yh9/rTNbyNhELuovQDnHhESmnLJzh0jNsZmROEq7JsP2bcJFp
         b3N/2JTO8TYXIwJKyAbSPpjq6XtU7Wq156i5Q=
Received: by 10.52.20.142 with SMTP id n14mr3550807vde.59.1330566369701;
        Wed, 29 Feb 2012 17:46:09 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n14sm502335vdj.22.2012.02.29.17.46.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 17:46:08 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120223002215.GE2410@tgrennan-laptop>
References: <20120223002215.GE2410@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191879>

- Guard setup with test_expect_success
- Single-quoted, tab prefaced test blocks of < 80 cols
- Redirect unwanted output

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t0040-parse-options.sh |  283 +++++++++++++++++++++-------------------------
 1 files changed, 127 insertions(+), 156 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a1e4616..6416d77 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -5,55 +5,60 @@
 
 test_description='our own option parser'
 
-. ./test-lib.sh
+if ! test -r test-lib.sh ; then
+	(cd ${0%/*} && ./${0##*/} $@)
+	exit $?
+fi
 
-cat > expect << EOF
-usage: test-parse-options <options>
-
-    -b, --boolean         get a boolean
-    -4, --or4             bitwise-or boolean with ...0100
-    --neg-or4             same as --no-or4
-
-    -i, --integer <n>     get a integer
-    -j <n>                get a integer, too
-    --set23               set integer to 23
-    -t <time>             get timestamp of <time>
-    -L, --length <str>    get length of <str>
-    -F, --file <file>     set file to <file>
-
-String options
-    -s, --string <string>
-                          get a string
-    --string2 <str>       get another string
-    --st <st>             get another string (pervert ordering)
-    -o <str>              get another string
-    --default-string      set string to default
-    --list <str>          add str to list
-
-Magic arguments
-    --quux                means --quux
-    -NUM                  set integer to NUM
-    +                     same as -b
-    --ambiguous           positive ambiguity
-    --no-ambiguous        negative ambiguity
-
-Standard options
-    --abbrev[=<n>]        use <n> digits to display SHA-1s
-    -v, --verbose         be verbose
-    -n, --dry-run         dry run
-    -q, --quiet           be quiet
+. ./test-lib.sh
 
-EOF
+silent () { "$@" >/dev/null 2>&1; }
 
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
-'
+	sed -e "s/^|//" >expect <<-\EOF &&
+		|usage: test-parse-options <options>
+
+		|    -b, --boolean         get a boolean
+		|    -4, --or4             bitwise-or boolean with ...0100
+		|    --neg-or4             same as --no-or4
+
+		|    -i, --integer <n>     get a integer
+		|    -j <n>                get a integer, too
+		|    --set23               set integer to 23
+		|    -t <time>             get timestamp of <time>
+		|    -L, --length <str>    get length of <str>
+		|    -F, --file <file>     set file to <file>
+
+		|String options
+		|    -s, --string <string>
+		|                          get a string
+		|    --string2 <str>       get another string
+		|    --st <st>             get another string (pervert ordering)
+		|    -o <str>              get another string
+		|    --default-string      set string to default
+		|    --list <str>          add str to list
+
+		|Magic arguments
+		|    --quux                means --quux
+		|    -NUM                  set integer to NUM
+		|    +                     same as -b
+		|    --ambiguous           positive ambiguity
+		|    --no-ambiguous        negative ambiguity
+
+		|Standard options
+		|    --abbrev[=<n>]        use <n> digits to display SHA-1s
+		|    -v, --verbose         be verbose
+		|    -n, --dry-run         dry run
+		|    -q, --quiet           be quiet
 
-mv expect expect.err
+	EOF
+	cp expect expect.err
+	test_must_fail test-parse-options -h 2>err | test_cmp expect - &&
+	test ! -s err
+'
 
-cat > expect << EOF
+test_expect_success 'short options' '
+	cat >expect <<-\EOF &&
 boolean: 2
 integer: 1729
 timestamp: 0
@@ -64,15 +69,13 @@ quiet: no
 dry run: yes
 file: prefix/my.file
 EOF
-
-test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file \
-	> output 2> output.err &&
-	test_cmp expect output &&
-	test ! -s output.err
+	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file 2>err |
+		test_cmp expect - &&
+	test ! -s err
 '
 
-cat > expect << EOF
+test_expect_success 'long options' '
+	cat >expect <<-\EOF &&
 boolean: 2
 integer: 1729
 timestamp: 0
@@ -83,25 +86,20 @@ quiet: no
 dry run: no
 file: prefix/fi.le
 EOF
-
-test_expect_success 'long options' '
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
 		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
-		--obsolete > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+		--obsolete 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
 test_expect_success 'missing required value' '
-	test-parse-options -s;
-	test $? = 129 &&
-	test-parse-options --string;
-	test $? = 129 &&
-	test-parse-options --file;
-	test $? = 129
+	silent test_expect_code 129 test-parse-options -s &&
+	silent test_expect_code 129 test-parse-options --string &&
+	silent test_expect_code 129 test-parse-options --file
 '
 
-cat > expect << EOF
+test_expect_success 'intermingled arguments' '
+	cat >expect <<-\EOF &&
 boolean: 1
 integer: 13
 timestamp: 0
@@ -115,15 +113,13 @@ arg 00: a1
 arg 01: b1
 arg 02: --boolean
 EOF
-
-test_expect_success 'intermingled arguments' '
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
-		> output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+		2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat > expect << EOF
+test_expect_success 'unambiguously abbreviated option' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 2
 timestamp: 0
@@ -134,25 +130,22 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'unambiguously abbreviated option' '
-	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options --int 2 --boolean --no-bo 2>err |
+		test_cmp expect - &&
+	test ! -s err
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	test-parse-options --int=2 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options --int=2 2>err | test_cmp expect -&&
+	test ! -s err
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test-parse-options --strin 123;
-	test $? = 129
+	silent test_expect_code 129 test-parse-options --strin 123
 '
 
-cat > expect << EOF
+test_expect_success 'non ambiguous option (after two options it abbreviates)' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 0
@@ -163,24 +156,21 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --st 123 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options --st 123 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat > typo.err << EOF
-error: did you mean \`--boolean\` (with two dashes ?)
-EOF
-
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean > output 2> output.err &&
-	test ! -s output &&
-	test_cmp typo.err output.err
+	cat >typo.err <<-\EOF &&
+		error: did you mean `--boolean` (with two dashes ?)
+	EOF
+	>expect
+	test_must_fail test-parse-options -boolean 2>err | test_cmp expect - &&
+	test_cmp typo.err err
 '
 
-cat > expect <<EOF
+test_expect_success 'keep some options as arguments' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 0
@@ -192,14 +182,12 @@ dry run: no
 file: (not set)
 arg 00: --quux
 EOF
-
-test_expect_success 'keep some options as arguments' '
-	test-parse-options --quux > output 2> output.err &&
-        test ! -s output.err &&
-        test_cmp expect output
+	test-parse-options --quux 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 1
@@ -211,15 +199,13 @@ dry run: no
 file: (not set)
 arg 00: foo
 EOF
-
-test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
-	test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
-		foo -q > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options -t "1970-01-01 00:00:01 +0000" \
+		--default-string foo -q 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
+	cat >expect <<-\EOF &&
 Callback: "four", 0
 boolean: 5
 integer: 4
@@ -231,24 +217,21 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
-	test-parse-options --length=four -b -4 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options --length=four -b -4 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_CALLBACK() and callback errors work' '
+	cat >expect <<-\EOF &&
 Callback: "not set", 1
 EOF
-
-test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length > output 2> output.err &&
-	test_cmp expect output &&
-	test_cmp expect.err output.err
+	test_must_fail test-parse-options --no-length 2>err |
+		test_cmp expect - &&
+	test_cmp expect.err err
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
+	cat >expect <<-\EOF &&
 boolean: 1
 integer: 23
 timestamp: 0
@@ -259,20 +242,17 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options --set23 -bbbbb --no-or4 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
 test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --neg-or4 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options --set23 -bbbbb --neg-or4 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat > expect <<EOF
+test_expect_success 'OPT_BIT() works' '
+	cat >expect <<-\EOF &&
 boolean: 6
 integer: 0
 timestamp: 0
@@ -283,26 +263,23 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_BIT() works' '
-	test-parse-options -bb --or4 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options -bb --or4 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
 test_expect_success 'OPT_NEGBIT() works' '
-	test-parse-options -bb --no-neg-or4 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options -bb --no-neg-or4 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
 test_expect_success 'OPT_BOOLEAN() with PARSE_OPT_NODASH works' '
-	test-parse-options + + + + + + > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options + + + + + + 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat > expect <<EOF
+
+test_expect_success 'OPT_NUMBER_CALLBACK() works' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 12345
 timestamp: 0
@@ -313,14 +290,12 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'OPT_NUMBER_CALLBACK() works' '
-	test-parse-options -12345 > output 2> output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options -12345 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat >expect <<EOF
+test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
+	cat >expect <<-\EOF &&
 boolean: 0
 integer: 0
 timestamp: 0
@@ -331,27 +306,23 @@ quiet: no
 dry run: no
 file: (not set)
 EOF
-
-test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
-	test-parse-options --no-ambig >output 2>output.err &&
-	test ! -s output.err &&
-	test_cmp expect output
+	test-parse-options --no-ambig 2>err | test_cmp expect - &&
+	test ! -s err
 '
 
-cat >>expect <<'EOF'
+test_expect_success '--list keeps list of strings' '
+	cat >>expect <<-\EOF &&
 list: foo
 list: bar
 list: baz
 EOF
-test_expect_success '--list keeps list of strings' '
-	test-parse-options --list foo --list=bar --list=baz >output &&
-	test_cmp expect output
+	test-parse-options --list foo --list=bar --list=baz | test_cmp expect -
 '
 
 test_expect_success '--no-list resets list' '
-	test-parse-options --list=other --list=irrelevant --list=options \
-		--no-list --list=foo --list=bar --list=baz >output &&
-	test_cmp expect output
+	test-parse-options --list=other --list=irrelevant \
+		--list=options --no-list --list=foo --list=bar --list=baz |
+		test_cmp expect -
 '
 
 test_done
-- 
1.7.8
