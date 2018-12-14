Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368EF20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 18:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbeLNStf (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 13:49:35 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46854 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730405AbeLNStf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Dec 2018 13:49:35 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=thomas.baccab.home.arpa); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1gXsWh-0005fc-Hh; Fri, 14 Dec 2018 19:49:31 +0100
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        avarab@gmail.com
Subject: [PATCH v3] log -G: ignore binary files
Date:   Fri, 14 Dec 2018 19:49:12 +0100
Message-Id: <f7cb34c6268f556772fa4ee374e2541ba518e2b8.1544811828.git.thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
In-Reply-To: <1535679074.141165.1542834055343@ox.hosteurope.de>
References: <1535679074.141165.1542834055343@ox.hosteurope.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1544813373;347b340d;
X-HE-SMSGID: 1gXsWh-0005fc-Hh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -G<regex> option of log looks for the differences whose patch text
contains added/removed lines that match regex.

Currently -G looks also into patches of binary files (which
according to [1]) is binary as well.

This has a couple of issues:

- It makes the pickaxe search slow. In a proprietary repository of the
  author with only ~5500 commits and a total .git size of ~300MB
  searching takes ~13 seconds

    $time git log -Gwave > /dev/null

    real    0m13,241s
    user    0m12,596s
    sys     0m0,644s

  whereas when we ignore binary files with this patch it takes ~4s

    $time ~/devel/git/git log -Gwave > /dev/null

    real    0m3,713s
    user    0m3,608s
    sys     0m0,105s

  which is a speedup of more than fourfold.

- The internally used algorithm for generating patch text is based on
  xdiff and its states in [1]

  > The output format of the binary patch file is proprietary
  > (and binary) and it is basically a collection of copy and insert
  > commands [..]

  which means that the current format could change once the internal
  algorithm is changed as the format is not standardized. In addition
  the git binary patch format used for preparing patches for git apply
  is *different* from the xdiff format as can be seen by comparing

  git log -p -a

    commit 6e95bf4bafccf14650d02ab57f3affe669be10cf
    Author: A U Thor <author@example.com>
    Date:   Thu Apr 7 15:14:13 2005 -0700

        modify binary file

    diff --git a/data.bin b/data.bin
    index f414c84..edfeb6f 100644
    --- a/data.bin
    +++ b/data.bin
    @@ -1,2 +1,4 @@
     a
     a^@a
    +a
    +a^@a

  with git log --binary

    commit 6e95bf4bafccf14650d02ab57f3affe669be10cf
    Author: A U Thor <author@example.com>
    Date:   Thu Apr 7 15:14:13 2005 -0700

        modify binary file

    diff --git a/data.bin b/data.bin
    index f414c84bd3aa25fa07836bb1fb73db784635e24b..edfeb6f501[..]
    GIT binary patch
    literal 12
    QcmYe~N@Pgn0zx1O01)N^ZvX%Q

    literal 6
    NcmYe~N@Pgn0ssWg0XP5v

  which seems unexpected.

To resolve these issues this patch makes -G<regex> ignore binary files
by default. Textconv filters are supported and also -a/--text for
getting the old and broken behaviour back.

The -S<block of text> option of log looks for differences that changes
the number of occurrences of the specified block of text (i.e.
addition/deletion) in a file. As we want to keep the current behaviour,
add a test to ensure it stays that way.

[1]: http://www.xmailserver.org/xdiff.html

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---

Changes since v2:
 - Introduce a setup step for the new tests 
 - Really start with a clean history in the tests
 - Added more complex commit history for the tests
 - Use test_when_finished for cleanup instead of doing nothing
 - Enhanced commit message to motivate the change better
 - Added some more documentation

 Documentation/diff-options.txt |  5 +++++
 Documentation/gitdiffcore.txt  |  3 ++-
 diffcore-pickaxe.c             |  6 ++++++
 t/t4209-log-pickaxe.sh         | 35 ++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0378cd574e..b94d332f71 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -524,6 +524,8 @@ struct), and want to know the history of that block since it first
 came into being: use the feature iteratively to feed the interesting
 block in the preimage back into `-S`, and keep going until you get the
 very first version of the block.
++
+Binary files are searched as well.
 
 -G<regex>::
 	Look for differences whose patch text contains added/removed
@@ -543,6 +545,9 @@ While `git log -G"regexec\(regexp"` will show this commit, `git log
 -S"regexec\(regexp" --pickaxe-regex` will not (because the number of
 occurrences of that string did not change).
 +
+Unless `--text` is supplied patches of binary files without a textconv
+filter will be ignored.
++
 See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c0a60f3158..c970d9fe43 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -242,7 +242,8 @@ textual diff has an added or a deleted line that matches the given
 regular expression.  This means that it will detect in-file (or what
 rename-detection considers the same file) moves, which is noise.  The
 implementation runs diff twice and greps, and this can be quite
-expensive.
+expensive.  To speed things up binary files without textconv filters
+will be ignored.
 
 When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
 that match their respective criterion are kept in the output.  When
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 69fc55ea1e..4cea086f80 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -154,6 +154,12 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
+	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
+	    !o->flags.text &&
+	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
+	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
+		return 0;
+
 	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 844df760f7..5d06f5f45e 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,4 +106,39 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
+test_expect_success 'setup log -[GS] binary & --text' '
+	git checkout --orphan GS-binary-and-text &&
+	git read-tree --empty &&
+	printf "a\na\0a\n" >data.bin &&
+	git add data.bin &&
+	git commit -m "create binary file" data.bin &&
+	printf "a\na\0a\n" >>data.bin &&
+	git commit -m "modify binary file" data.bin &&
+	git rm data.bin &&
+	git commit -m "delete binary file" data.bin &&
+	git log >full-log
+'
+
+test_expect_success 'log -G ignores binary files' '
+	git log -Ga >log &&
+	test_must_be_empty log
+'
+
+test_expect_success 'log -G looks into binary files with -a' '
+	git log -a -Ga >log &&
+	test_cmp log full-log
+'
+
+test_expect_success 'log -G looks into binary files with textconv filter' '
+	test_when_finished "rm .gitattributes" &&
+	echo "* diff=bin" >.gitattributes &&
+	git -c diff.bin.textconv=cat log -Ga >log &&
+	test_cmp log full-log
+'
+
+test_expect_success 'log -S looks into binary files' '
+	git log -Sa >log &&
+	test_cmp log full-log
+'
+
 test_done
-- 
2.19.0.271.gfe8321ec05.dirty

