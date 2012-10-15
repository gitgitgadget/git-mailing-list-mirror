From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/13] Integrate wildmatch to git
Date: Mon, 15 Oct 2012 13:25:55 +0700
Message-ID: <1350282362-4505-6-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:27:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe8q-0007jc-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab2JOG05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:26:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39239 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:26:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4542541pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kOYEVlKj7geNC+HD0ErN5SyKUAD4rqHN5RvuF9QRV3M=;
        b=vmPjqXGxl5Kj7cPqZkNIGc61VvC+I1FgBNjVIBrkIIKPJuouJOmdNu7O4VGtNoSb4g
         sTKIRJpI46qeJZZNR7vSeVfWfP1W+ekFzioBkoIkif9eM19adb5OhFIgQabTnZ+tIcEP
         V/hv8awYUDtXyhw0p50tPJuKjbwuvo5DUsqDLnHeg8Rca8NjTg6ipAkHUCL+RUWRr+iv
         5p4lp0q+fqIKmcfgo7s4Xxjm61557EiNFHqwwR8vpdHZA/7y/Z6eIcwd4odIiR/jgvY8
         GONbTqtFlQSOGb1aBNIt7zYbehYMZ/3Y4mftfKV/zDwLrNPZCwDVWYx8xXmc5EW4D21y
         HcqA==
Received: by 10.68.213.138 with SMTP id ns10mr34124243pbc.157.1350282416929;
        Sun, 14 Oct 2012 23:26:56 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ox5sm8568057pbc.75.2012.10.14.23.26.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:26:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:26:45 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207704>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore           |   1 +
 Makefile             |   3 +
 t/t3070-wildmatch.sh | 188 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t3070/wildtest.txt | 165 -------------------------------------------=
-
 test-wildmatch.c     |  14 ++++
 wildmatch.c          |   5 +-
 6 files changed, 210 insertions(+), 166 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 delete mode 100644 t/t3070/wildtest.txt
 create mode 100644 test-wildmatch.c

diff --git a/.gitignore b/.gitignore
index f1acd3e..1153a4b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -193,6 +193,7 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
+/test-wildmatch
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 13293d3..bc868d1 100644
--- a/Makefile
+++ b/Makefile
@@ -503,6 +503,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-wildmatch
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -674,6 +675,7 @@ LIB_H +=3D unpack-trees.h
 LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D varint.h
+LIB_H +=3D wildmatch.h
 LIB_H +=3D xdiff-interface.h
 LIB_H +=3D xdiff/xdiff.h
=20
@@ -803,6 +805,7 @@ LIB_OBJS +=3D userdiff.o
 LIB_OBJS +=3D utf8.o
 LIB_OBJS +=3D varint.o
 LIB_OBJS +=3D walker.o
+LIB_OBJS +=3D wildmatch.o
 LIB_OBJS +=3D wrapper.o
 LIB_OBJS +=3D write_or_die.o
 LIB_OBJS +=3D ws.o
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
new file mode 100755
index 0000000..dbd3c8b
--- /dev/null
+++ b/t/t3070-wildmatch.sh
@@ -0,0 +1,188 @@
+#!/bin/sh
+
+test_description=3D'wildmatch tests'
+
+. ./test-lib.sh
+
+match() {
+    if [ $1 =3D 1 ]; then
+	test_expect_success "wildmatch:    match '$3' '$4'" "
+	    test-wildmatch wildmatch '$3' '$4'
+	"
+    else
+	test_expect_success "wildmatch: no match '$3' '$4'" "
+	    ! test-wildmatch wildmatch '$3' '$4'
+	"
+    fi
+    if [ $2 =3D 1 ]; then
+	test_expect_success "fnmatch:      match '$3' '$4'" "
+	    test-wildmatch fnmatch '$3' '$4'
+	"
+    elif [ $2 =3D 0 ]; then
+	test_expect_success "fnmatch:   no match '$3' '$4'" "
+	    ! test-wildmatch fnmatch '$3' '$4'
+	"
+#    else
+#	test_expect_success BROKEN_FNMATCH "fnmatch:       '$3' '$4'" "
+#	    ! test-wildmatch fnmatch '$3' '$4'
+#	"
+    fi
+}
+
+# Basic wildmat features
+match 1 1 foo foo
+match 0 0 foo bar
+match 1 1 '' ""
+match 1 1 foo '???'
+match 0 0 foo '??'
+match 1 1 foo '*'
+match 1 1 foo 'f*'
+match 0 0 foo '*f'
+match 1 1 foo '*foo*'
+match 1 1 foobar '*ob*a*r*'
+match 1 1 aaaaaaabababab '*ab'
+match 1 1 'foo*' 'foo\*'
+match 0 0 foobar 'foo\*bar'
+match 1 1 'f\oo' 'f\\oo'
+match 1 1 ball '*[al]?'
+match 0 0 ten '[ten]'
+match 1 1 ten '**[!te]'
+match 0 0 ten '**[!ten]'
+match 1 1 ten 't[a-g]n'
+match 0 0 ten 't[!a-g]n'
+match 1 1 ton 't[!a-g]n'
+match 1 1 ton 't[^a-g]n'
+match 1 1 'a]b' 'a[]]b'
+match 1 1 a-b 'a[]-]b'
+match 1 1 'a]b' 'a[]-]b'
+match 0 0 aab 'a[]-]b'
+match 1 1 aab 'a[]a-]b'
+match 1 1 ']' ']'
+
+# Extended slash-matching features
+match 0 0 'foo/baz/bar' 'foo*bar'
+match 1 0 'foo/baz/bar' 'foo**bar'
+match 0 0 'foo/bar' 'foo?bar'
+match 0 0 'foo/bar' 'foo[/]bar'
+match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
+match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
+match 0 0 'foo' '**/foo'
+match 1 1 '/foo' '**/foo'
+match 1 0 'bar/baz/foo' '**/foo'
+match 0 0 'bar/baz/foo' '*/foo'
+match 0 0 'foo/bar/baz' '**/bar*'
+match 1 0 'deep/foo/bar/baz' '**/bar/*'
+match 0 0 'deep/foo/bar/baz/' '**/bar/*'
+match 1 0 'deep/foo/bar/baz/' '**/bar/**'
+match 0 0 'deep/foo/bar' '**/bar/*'
+match 1 0 'deep/foo/bar/' '**/bar/**'
+match 1 0 'foo/bar/baz' '**/bar**'
+match 1 0 'foo/bar/baz/x' '*/bar/**'
+match 0 0 'deep/foo/bar/baz/x' '*/bar/**'
+match 1 0 'deep/foo/bar/baz/x' '**/bar/*/*'
+
+# Various additional tests
+match 0 0 'acrt' 'a[c-c]st'
+match 1 1 'acrt' 'a[c-c]rt'
+match 0 0 ']' '[!]-]'
+match 1 1 'a' '[!]-]'
+match 0 0 '' '\'
+match 0 0 '\' '\'
+match 0 0 '/\' '*/\'
+match 1 1 '/\' '*/\\'
+match 1 1 'foo' 'foo'
+match 1 1 '@foo' '@foo'
+match 0 0 'foo' '@foo'
+match 1 1 '[ab]' '\[ab]'
+match 1 1 '[ab]' '[[]ab]'
+match 1 1 '[ab]' '[[:]ab]'
+match 0 0 '[ab]' '[[::]ab]'
+match 1 1 '[ab]' '[[:digit]ab]'
+match 1 1 '[ab]' '[\[:]ab]'
+match 1 1 '?a?b' '\??\?b'
+match 1 1 'abc' '\a\b\c'
+match 0 0 'foo' ''
+match 1 0 'foo/bar/baz/to' '**/t[o]'
+
+# Character class tests
+match 1 1 'a1B' '[[:alpha:]][[:digit:]][[:upper:]]'
+match 0 0 'a' '[[:digit:][:upper:][:space:]]'
+match 1 1 'A' '[[:digit:][:upper:][:space:]]'
+match 1 0 '1' '[[:digit:][:upper:][:space:]]'
+match 0 0 '1' '[[:digit:][:upper:][:spaci:]]'
+match 1 1 ' ' '[[:digit:][:upper:][:space:]]'
+match 0 0 '.' '[[:digit:][:upper:][:space:]]'
+match 1 1 '.' '[[:digit:][:punct:][:space:]]'
+match 1 1 '5' '[[:xdigit:]]'
+match 1 1 'f' '[[:xdigit:]]'
+match 1 1 'D' '[[:xdigit:]]'
+match 1 0 '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:]=
[:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
+match 1 0 '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:]=
[:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
+match 1 1 '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:=
][:space:][:upper:][:xdigit:]]'
+match 1 1 '5' '[a-c[:digit:]x-z]'
+match 1 1 'b' '[a-c[:digit:]x-z]'
+match 1 1 'y' '[a-c[:digit:]x-z]'
+match 0 0 'q' '[a-c[:digit:]x-z]'
+
+# Additional tests, including some malformed wildmats
+match 1 1 ']' '[\\-^]'
+match 0 0 '[' '[\\-^]'
+match 1 1 '-' '[\-_]'
+match 1 1 ']' '[\]]'
+match 0 0 '\]' '[\]]'
+match 0 0 '\' '[\]]'
+match 0 0 'ab' 'a[]b'
+match 0 1 'a[]b' 'a[]b'
+match 0 1 'ab[' 'ab['
+match 0 0 'ab' '[!'
+match 0 0 'ab' '[-'
+match 1 1 '-' '[-]'
+match 0 0 '-' '[a-'
+match 0 0 '-' '[!a-'
+match 1 1 '-' '[--A]'
+match 1 1 '5' '[--A]'
+match 1 1 ' ' '[ --]'
+match 1 1 '$' '[ --]'
+match 1 1 '-' '[ --]'
+match 0 0 '0' '[ --]'
+match 1 1 '-' '[---]'
+match 1 1 '-' '[------]'
+match 0 0 'j' '[a-e-n]'
+match 1 1 '-' '[a-e-n]'
+match 1 1 'a' '[!------]'
+match 0 0 '[' '[]-a]'
+match 1 1 '^' '[]-a]'
+match 0 0 '^' '[!]-a]'
+match 1 1 '[' '[!]-a]'
+match 1 1 '^' '[a^bc]'
+match 1 1 '-b]' '[a-]b]'
+match 0 0 '\' '[\]'
+match 1 1 '\' '[\\]'
+match 0 0 '\' '[!\\]'
+match 1 1 'G' '[A-\\]'
+match 0 0 'aaabbb' 'b*a'
+match 0 0 'aabcaa' '*ba*'
+match 1 1 ',' '[,]'
+match 1 1 ',' '[\\,]'
+match 1 1 '\' '[\\,]'
+match 1 1 '-' '[,-.]'
+match 0 0 '+' '[,-.]'
+match 0 0 '-.]' '[,-.]'
+match 1 1 '2' '[\1-\3]'
+match 1 1 '3' '[\1-\3]'
+match 0 0 '4' '[\1-\3]'
+match 1 1 '\' '[[-\]]'
+match 1 1 '[' '[[-\]]'
+match 1 1 ']' '[[-\]]'
+match 0 0 '-' '[[-\]]'
+
+# Test recursion and the abort code (use "wildtest -i" to see iteratio=
n counts)
+match 1 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+match 1 1 '/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' =
'/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 0 0 '/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' =
'/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n=
*t'
+match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*=
n*t'
+
+test_done
diff --git a/t/t3070/wildtest.txt b/t/t3070/wildtest.txt
deleted file mode 100644
index 42c1678..0000000
--- a/t/t3070/wildtest.txt
+++ /dev/null
@@ -1,165 +0,0 @@
-# Input is in the following format (all items white-space separated):
-#
-# The first two items are 1 or 0 indicating if the wildmat call is exp=
ected to
-# succeed and if fnmatch works the same way as wildmat, respectively. =
 After
-# that is a text string for the match, and a pattern string.  Strings =
can be
-# quoted (if desired) in either double or single quotes, as well as ba=
ckticks.
-#
-# MATCH FNMATCH_SAME "text to match" 'pattern to use'
-
-# Basic wildmat features
-1 1 foo			foo
-0 1 foo			bar
-1 1 ''			""
-1 1 foo			???
-0 1 foo			??
-1 1 foo			*
-1 1 foo			f*
-0 1 foo			*f
-1 1 foo			*foo*
-1 1 foobar		*ob*a*r*
-1 1 aaaaaaabababab	*ab
-1 1 foo*		foo\*
-0 1 foobar		foo\*bar
-1 1 f\oo		f\\oo
-1 1 ball		*[al]?
-0 1 ten			[ten]
-1 1 ten			**[!te]
-0 1 ten			**[!ten]
-1 1 ten			t[a-g]n
-0 1 ten			t[!a-g]n
-1 1 ton			t[!a-g]n
-1 1 ton			t[^a-g]n
-1 1 a]b			a[]]b
-1 1 a-b			a[]-]b
-1 1 a]b			a[]-]b
-0 1 aab			a[]-]b
-1 1 aab			a[]a-]b
-1 1 ]			]
-
-# Extended slash-matching features
-0 1 foo/baz/bar		foo*bar
-1 1 foo/baz/bar		foo**bar
-0 1 foo/bar		foo?bar
-0 1 foo/bar		foo[/]bar
-0 1 foo/bar		f[^eiu][^eiu][^eiu][^eiu][^eiu]r
-1 1 foo-bar		f[^eiu][^eiu][^eiu][^eiu][^eiu]r
-0 1 foo			**/foo
-1 1 /foo		**/foo
-1 1 bar/baz/foo		**/foo
-0 1 bar/baz/foo		*/foo
-0 0 foo/bar/baz		**/bar*
-1 1 deep/foo/bar/baz	**/bar/*
-0 1 deep/foo/bar/baz/	**/bar/*
-1 1 deep/foo/bar/baz/	**/bar/**
-0 1 deep/foo/bar	**/bar/*
-1 1 deep/foo/bar/	**/bar/**
-1 1 foo/bar/baz		**/bar**
-1 1 foo/bar/baz/x	*/bar/**
-0 0 deep/foo/bar/baz/x	*/bar/**
-1 1 deep/foo/bar/baz/x	**/bar/*/*
-
-# Various additional tests
-0 1 acrt		a[c-c]st
-1 1 acrt		a[c-c]rt
-0 1 ]			[!]-]
-1 1 a			[!]-]
-0 1 ''			\
-0 1 \			\
-0 1 /\			*/\
-1 1 /\			*/\\
-1 1 foo			foo
-1 1 @foo		@foo
-0 1 foo			@foo
-1 1 [ab]		\[ab]
-1 1 [ab]		[[]ab]
-1 1 [ab]		[[:]ab]
-0 1 [ab]		[[::]ab]
-1 1 [ab]		[[:digit]ab]
-1 1 [ab]		[\[:]ab]
-1 1 ?a?b		\??\?b
-1 1 abc			\a\b\c
-0 1 foo			''
-1 1 foo/bar/baz/to	**/t[o]
-
-# Character class tests
-1 1 a1B		[[:alpha:]][[:digit:]][[:upper:]]
-0 1 a		[[:digit:][:upper:][:space:]]
-1 1 A		[[:digit:][:upper:][:space:]]
-1 1 1		[[:digit:][:upper:][:space:]]
-0 1 1		[[:digit:][:upper:][:spaci:]]
-1 1 ' '		[[:digit:][:upper:][:space:]]
-0 1 .		[[:digit:][:upper:][:space:]]
-1 1 .		[[:digit:][:punct:][:space:]]
-1 1 5		[[:xdigit:]]
-1 1 f		[[:xdigit:]]
-1 1 D		[[:xdigit:]]
-1 1 _		[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:=
][:print:][:punct:][:space:][:upper:][:xdigit:]]
-#1 1 =85		[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lo=
wer:][:print:][:punct:][:space:][:upper:][:xdigit:]]
-1 1 =7F		[^[:alnum:][:alpha:][:blank:][:digit:][:graph:][:lower:][:pri=
nt:][:punct:][:space:][:upper:][:xdigit:]]
-1 1 .		[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space=
:][:upper:][:xdigit:]]
-1 1 5		[a-c[:digit:]x-z]
-1 1 b		[a-c[:digit:]x-z]
-1 1 y		[a-c[:digit:]x-z]
-0 1 q		[a-c[:digit:]x-z]
-
-# Additional tests, including some malformed wildmats
-1 1 ]		[\\-^]
-0 1 [		[\\-^]
-1 1 -		[\-_]
-1 1 ]		[\]]
-0 1 \]		[\]]
-0 1 \		[\]]
-0 1 ab		a[]b
-0 1 a[]b	a[]b
-0 1 ab[		ab[
-0 1 ab		[!
-0 1 ab		[-
-1 1 -		[-]
-0 1 -		[a-
-0 1 -		[!a-
-1 1 -		[--A]
-1 1 5		[--A]
-1 1 ' '		'[ --]'
-1 1 $		'[ --]'
-1 1 -		'[ --]'
-0 1 0		'[ --]'
-1 1 -		[---]
-1 1 -		[------]
-0 1 j		[a-e-n]
-1 1 -		[a-e-n]
-1 1 a		[!------]
-0 1 [		[]-a]
-1 1 ^		[]-a]
-0 1 ^		[!]-a]
-1 1 [		[!]-a]
-1 1 ^		[a^bc]
-1 1 -b]		[a-]b]
-0 1 \		[\]
-1 1 \		[\\]
-0 1 \		[!\\]
-1 1 G		[A-\\]
-0 1 aaabbb	b*a
-0 1 aabcaa	*ba*
-1 1 ,		[,]
-1 1 ,		[\\,]
-1 1 \		[\\,]
-1 1 -		[,-.]
-0 1 +		[,-.]
-0 1 -.]		[,-.]
-1 1 2		[\1-\3]
-1 1 3		[\1-\3]
-0 1 4		[\1-\3]
-1 1 \		[[-\]]
-1 1 [		[[-\]]
-1 1 ]		[[-\]]
-0 1 -		[[-\]]
-
-# Test recursion and the abort code (use "wildtest -i" to see iteratio=
n counts)
-1 1 -adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1	-*-*-*-*=
-*-*-12-*-*-*-m-*-*-*
-0 1 -adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1	-*-*-*-*=
-*-*-12-*-*-*-m-*-*-*
-0 1 -adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1	-*-*-*-*=
-*-*-12-*-*-*-m-*-*-*
-1 1 /adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1	/*/*/*/*=
/*/*/12/*/*/*/m/*/*/*
-0 1 /adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1	/*/*/*/*=
/*/*/12/*/*/*/m/*/*/*
-1 1 abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt		**/*a*b*g*n*t
-0 1 abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz		**/*a*b*g*n*t
diff --git a/test-wildmatch.c b/test-wildmatch.c
new file mode 100644
index 0000000..ac56420
--- /dev/null
+++ b/test-wildmatch.c
@@ -0,0 +1,14 @@
+#include "cache.h"
+#include "wildmatch.h"
+
+int main(int argc, char **argv)
+{
+	if (!strcmp(argv[1], "wildmatch"))
+		return wildmatch(argv[3], argv[2]) ? 0 : 1;
+	else if (!strcmp(argv[1], "iwildmatch"))
+		return iwildmatch(argv[3], argv[2]) ? 0 : 1;
+	else if (!strcmp(argv[1], "fnmatch"))
+		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
+	else
+		return 1;
+}
diff --git a/wildmatch.c b/wildmatch.c
index 4653dd6..ac29471 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -9,7 +9,10 @@
 **  work differently than '*', and to fix the character-class code.
 */
=20
-#include "rsync.h"
+#include "cache.h"
+#include "wildmatch.h"
+
+typedef unsigned char uchar;
=20
 /* What character marks an inverted character class? */
 #define NEGATE_CLASS	'!'
--=20
1.8.0.rc0.29.g1fdd78f
