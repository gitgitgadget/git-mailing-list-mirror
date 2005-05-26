From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH Cogito] Make ls-* output consistent with diff-* output
 format.
Date: Thu, 26 May 2005 14:38:19 -0700
Message-ID: <7v8y21acs4.fsf_-_@assigned-by-dhcp.cox.net>
References: <1117137826.12036.57.camel@pegasus>
	<7vk6llbv1j.fsf@assigned-by-dhcp.cox.net>
	<1117139740.12036.59.camel@pegasus>
	<7voeaxae0r.fsf@assigned-by-dhcp.cox.net>
	<1117142741.12036.66.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>, Petr Baudis <pasky@ucw.cz>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:46:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbQ90-000405-Pc
	for gcvg-git@gmane.org; Thu, 26 May 2005 23:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVEZVoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 17:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVEZVmM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 17:42:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53704 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261815AbVEZVi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 17:38:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526213818.NMAR12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 17:38:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1117142741.12036.66.camel@pegasus> (Marcel Holtmann's message
 of "Thu, 26 May 2005 23:25:40 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MH" == Marcel Holtmann <marcel@holtmann.org> writes:

>> This is why I asked Linus about a slight format change for
>> git-ls-tree (and git-ls-files) this morning.

MH> To what is it changing?

Linus, we await your decree ;-).

To save your time reading backissues of the thread, here is the
summary of the problem this patch addresses:

    This is why I asked Linus about a slight format change for
    git-ls-tree (and git-ls-files) this morning.

    Currently, there are three incompatible format floating around.

      - diff-* brothers show the metadata (separated internally with
        SP), TAB, and path.  If it is a rename diff, another TAB and
        path follow them.

      - ls-tree gives everything with TAB separated.

      - ls-files gives everything with SP separated.

    The suggestion I made this morning is to make ls-tree and
    ls-files use SP inside metadata and TAB before path.  If we
    can agree on that is the way to go, then the output from these
    commands would become:

      - diff-* brothers:

        mode SP mode SP sha1 SP sha1 SP status TAB path [ TAB path ]

      - ls-tree:

        mode SP kind SP sha1 TAB path

      - ls-files --stage :

        mode SP sha1 SP stage TAB path

    What this means is the above piece of code can now be rewritten
    to parse with something like this, and it does not matter what
    command you have upstream:

            echo
            # List all files for for the initial commit
            if [ -z $tree2 ]; then
                    git-ls-tree "$tree1"
            else
                    git-diff-tree -r "$tree1" "$tree2"
            fi |
            cut -f2 |
            while read file; do
                ...

    Note that the above code is totally untested.  I do not use
    "cut" myself and I am writing this in my e-mail buffer.

------------
Use SP as the column separator except the ones before path which
uses TAB, to make the output format consistent across ls-* and
diff-* commands.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

ls-files.c                  |    2 
ls-tree.c                   |    2 
t/t0000-basic.sh            |   46 ++++++++++----------
t/t1000-read-tree-m-3way.sh |   98 ++++++++++++++++++++++----------------------
t/t3100-ls-tree-restrict.sh |   40 ++++++++---------
5 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -262,7 +262,7 @@ static void show_files(void)
 				       tag_cached,
 				       ce->name, line_terminator);
 			else
-				printf("%s%06o %s %d %s%c",
+				printf("%s%06o %s %d\t%s%c",
 				       ce_stage(ce) ? tag_unmerged :
 				       tag_cached,
 				       ntohl(ce->ce_mode),
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -127,7 +127,7 @@ static void list_recursive(void *buffer,
 		 * print out the info
 		 */
 		if (!matches || (matched != NULL && mtype == 0)) {
-			printf("%06o\t%s\t%s\t", mode,
+			printf("%06o %s %s\t", mode,
 			       S_ISDIR(mode) ? "tree" : "blob",
 			       sha1_to_hex(sha1));
 			print_path_prefix(&this_prefix);
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -92,14 +92,14 @@ test_expect_success \
     'git-ls-files --stage >current'
 
 cat >expected <<\EOF
-100644 f87290f8eb2cbbea7857214459a0739927eab154 0 path0
-120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0 path0sym
-100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0 path2/file2
-120000 d8ce161addc5173867a3c3c730924388daedbc38 0 path2/file2sym
-100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0 path3/file3
-120000 8599103969b43aff7e430efea79ca4636466794f 0 path3/file3sym
-100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0 path3/subp3/file3
-120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0 path3/subp3/file3sym
+100644 f87290f8eb2cbbea7857214459a0739927eab154 0	path0
+120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0	path0sym
+100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0	path2/file2
+120000 d8ce161addc5173867a3c3c730924388daedbc38 0	path2/file2sym
+100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0	path3/file3
+120000 8599103969b43aff7e430efea79ca4636466794f 0	path3/file3sym
+100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0	path3/subp3/file3
+120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0	path3/subp3/file3sym
 EOF
 test_expect_success \
     'validate git-ls-files output for a known tree.' \
@@ -116,10 +116,10 @@ test_expect_success \
     'showing tree with git-ls-tree' \
     'git-ls-tree $tree >current'
 cat >expected <<\EOF
-100644	blob	f87290f8eb2cbbea7857214459a0739927eab154	path0
-120000	blob	15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
-040000	tree	58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
-040000	tree	21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
+100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
+120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
+040000 tree 58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
+040000 tree 21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
 EOF
 test_expect_success \
     'git-ls-tree output for a known tree.' \
@@ -129,17 +129,17 @@ test_expect_success \
     'showing tree with git-ls-tree -r' \
     'git-ls-tree -r $tree >current'
 cat >expected <<\EOF
-100644	blob	f87290f8eb2cbbea7857214459a0739927eab154	path0
-120000	blob	15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
-040000	tree	58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
-100644	blob	3feff949ed00a62d9f7af97c15cd8a30595e7ac7	path2/file2
-120000	blob	d8ce161addc5173867a3c3c730924388daedbc38	path2/file2sym
-040000	tree	21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
-100644	blob	0aa34cae68d0878578ad119c86ca2b5ed5b28376	path3/file3
-120000	blob	8599103969b43aff7e430efea79ca4636466794f	path3/file3sym
-040000	tree	3c5e5399f3a333eddecce7a9b9465b63f65f51e2	path3/subp3
-100644	blob	00fb5908cb97c2564a9783c0c64087333b3b464f	path3/subp3/file3
-120000	blob	6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c	path3/subp3/file3sym
+100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
+120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
+040000 tree 58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
+100644 blob 3feff949ed00a62d9f7af97c15cd8a30595e7ac7	path2/file2
+120000 blob d8ce161addc5173867a3c3c730924388daedbc38	path2/file2sym
+040000 tree 21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
+100644 blob 0aa34cae68d0878578ad119c86ca2b5ed5b28376	path3/file3
+120000 blob 8599103969b43aff7e430efea79ca4636466794f	path3/file3sym
+040000 tree 3c5e5399f3a333eddecce7a9b9465b63f65f51e2	path3/subp3
+100644 blob 00fb5908cb97c2564a9783c0c64087333b3b464f	path3/subp3/file3
+120000 blob 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c	path3/subp3/file3sym
 EOF
 test_expect_success \
     'git-ls-tree -r output for a known tree.' \
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -81,60 +81,60 @@ test_expect_success \
     '3-way merge with git-read-tree -m' \
     "git-read-tree -m $tree_O $tree_A $tree_B"
 
-strip_object_id='s/^\([0-7]*\) [0-9a-f]* \([0-3].*\)$/\1 \2/'
-
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 test_expect_success \
     'git-ls-files --stage of the merge result' \
     'git-ls-files --stage >current- &&
-     sed -e "$strip_object_id" <current- >current'
+     sed -e "s/ $_x40 / X /" <current- >current'
 
 cat >expected <<\EOF
-100644 2 AA
-100644 3 AA
-100644 2 AN
-100644 1 DD
-100644 3 DF
-100644 2 DF/DF
-100644 1 DM
-100644 3 DM
-100644 1 DN
-100644 3 DN
-100644 2 LL
-100644 3 LL
-100644 1 MD
-100644 2 MD
-100644 1 MM
-100644 2 MM
-100644 3 MM
-100644 0 MN
-100644 3 NA
-100644 1 ND
-100644 2 ND
-100644 0 NM
-100644 0 NN
-100644 0 SS
-100644 1 TT
-100644 2 TT
-100644 3 TT
-100644 2 Z/AA
-100644 3 Z/AA
-100644 2 Z/AN
-100644 1 Z/DD
-100644 1 Z/DM
-100644 3 Z/DM
-100644 1 Z/DN
-100644 3 Z/DN
-100644 1 Z/MD
-100644 2 Z/MD
-100644 1 Z/MM
-100644 2 Z/MM
-100644 3 Z/MM
-100644 0 Z/MN
-100644 3 Z/NA
-100644 1 Z/ND
-100644 2 Z/ND
-100644 0 Z/NM
-100644 0 Z/NN
+100644 X 2	AA
+100644 X 3	AA
+100644 X 2	AN
+100644 X 1	DD
+100644 X 3	DF
+100644 X 2	DF/DF
+100644 X 1	DM
+100644 X 3	DM
+100644 X 1	DN
+100644 X 3	DN
+100644 X 2	LL
+100644 X 3	LL
+100644 X 1	MD
+100644 X 2	MD
+100644 X 1	MM
+100644 X 2	MM
+100644 X 3	MM
+100644 X 0	MN
+100644 X 3	NA
+100644 X 1	ND
+100644 X 2	ND
+100644 X 0	NM
+100644 X 0	NN
+100644 X 0	SS
+100644 X 1	TT
+100644 X 2	TT
+100644 X 3	TT
+100644 X 2	Z/AA
+100644 X 3	Z/AA
+100644 X 2	Z/AN
+100644 X 1	Z/DD
+100644 X 1	Z/DM
+100644 X 3	Z/DM
+100644 X 1	Z/DN
+100644 X 3	Z/DN
+100644 X 1	Z/MD
+100644 X 2	Z/MD
+100644 X 1	Z/MM
+100644 X 2	Z/MM
+100644 X 3	Z/MM
+100644 X 0	Z/MN
+100644 X 3	Z/NA
+100644 X 1	Z/ND
+100644 X 2	Z/ND
+100644 X 0	Z/NM
+100644 X 0	Z/NN
 EOF
 
 test_expect_success \
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -34,7 +34,7 @@ test_expect_success \
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 test_output () {
-    sed -e "s/	$_x40	/	X	/" <current >check
+    sed -e "s/ $_x40	/ X	/" <current >check
     diff -u expected check
 }
 
@@ -42,9 +42,9 @@ test_expect_success \
     'ls-tree plain' \
     'git-ls-tree $tree >current &&
      cat >expected <<\EOF &&
-100644	blob	X	path0
-120000	blob	X	path1
-040000	tree	X	path2
+100644 blob X	path0
+120000 blob X	path1
+040000 tree X	path2
 EOF
      test_output'
 
@@ -52,13 +52,13 @@ test_expect_success \
     'ls-tree recursive' \
     'git-ls-tree -r $tree >current &&
      cat >expected <<\EOF &&
-100644	blob	X	path0
-120000	blob	X	path1
-040000	tree	X	path2
-040000	tree	X	path2/baz
-100644	blob	X	path2/baz/b
-120000	blob	X	path2/bazbo
-100644	blob	X	path2/foo
+100644 blob X	path0
+120000 blob X	path1
+040000 tree X	path2
+040000 tree X	path2/baz
+100644 blob X	path2/baz/b
+120000 blob X	path2/bazbo
+100644 blob X	path2/foo
 EOF
      test_output'
 
@@ -74,8 +74,8 @@ test_expect_success \
     'ls-tree filtered' \
     'git-ls-tree $tree path1 path0 >current &&
      cat >expected <<\EOF &&
-100644	blob	X	path0
-120000	blob	X	path1
+100644 blob X	path0
+120000 blob X	path1
 EOF
      test_output'
 
@@ -83,11 +83,11 @@ test_expect_success \
     'ls-tree filtered' \
     'git-ls-tree $tree path2 >current &&
      cat >expected <<\EOF &&
-040000	tree	X	path2
-040000	tree	X	path2/baz
-100644	blob	X	path2/baz/b
-120000	blob	X	path2/bazbo
-100644	blob	X	path2/foo
+040000 tree X	path2
+040000 tree X	path2/baz
+100644 blob X	path2/baz/b
+120000 blob X	path2/bazbo
+100644 blob X	path2/foo
 EOF
      test_output'
 
@@ -95,8 +95,8 @@ test_expect_success \
     'ls-tree filtered' \
     'git-ls-tree $tree path2/baz >current &&
      cat >expected <<\EOF &&
-040000	tree	X	path2/baz
-100644	blob	X	path2/baz/b
+040000 tree X	path2/baz
+100644 blob X	path2/baz/b
 EOF
      test_output'
 
------------------------------------------------

