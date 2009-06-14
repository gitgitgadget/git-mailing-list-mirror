From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix show_entry() in tree-diff.c for TREE_IN_RECURSIVE
Date: Sat, 13 Jun 2009 17:05:11 -0700
Message-ID: <7vvdmzu1c8.fsf@alter.siamese.dyndns.org>
References: <op.uvhcoii8tdk399@sirnot.private>
	<7v63ezvgyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nick Edelen" <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 02:05:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFdE4-00041f-1M
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 02:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbZFNAFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 20:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbZFNAFL
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 20:05:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56939 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbZFNAFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 20:05:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090614000511.QYAG17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 13 Jun 2009 20:05:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3c5C1c0014aMwMQ03c5CB6; Sat, 13 Jun 2009 20:05:12 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=J_NeQprUbJUA:10 a=lrbLnaca2U4A:10
 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=miRBvqvcBl-Ig23ZI7AA:9
 a=jsE1a7j7Els5VQGSeYMA:7 a=JVmf7wcypoaY21dLKdmlrfDoMEkA:4 a=qIVjreYYsbEA:10
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <7v63ezvgyo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 13 Jun 2009 16\:42\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121530>

Junio C Hamano <gitster@pobox.com> writes:

> "Nick Edelen" <sirnot@gmail.com> writes:
> ...
>> this seems like how it should act: trees are shown under this option for
>> changes,...
>
> Please show a sample input, the output you expect and the output from the
> current code, to illustrate the alleged breakage better.
> ...
> I think the output from the code after your change is more consistent, but
> I somehow suspect that this might break people's script, like gitweb,
> rather badly, if they depended on the existing behaviour.

That is, something like the attached patch.

I cannot afford to do this to everybody, but you seem to be new to the
community, and every once in a while teaching by showing example is the
best way to do things, so...

-- >8 --
From: Nick Edelen <sirnot@gmail.com>
Subject: [PATCH] diff-tree -r -t: include added/removed directories in the output

We used to include only the modified and typechanged directories
in the ouptut, but for consistency's sake, we should also include
added and removed ones as well.

This makes the output more consistent, but it may break existing scripts
that expect to see the current output which has long been the established
behaviour.

Signed-off-by: Nick Edelen <sirnot@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This should apply at least down to 1.6.0 series, if not earlier.

 t/t4037-diff-r-t-dirs.sh |   53 ++++++++++++++++++++++++++++++++++++++++++++++
 tree-diff.c              |    6 +++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/t/t4037-diff-r-t-dirs.sh b/t/t4037-diff-r-t-dirs.sh
new file mode 100755
index 0000000..f5ce3b2
--- /dev/null
+++ b/t/t4037-diff-r-t-dirs.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='diff -r -t shows directory additions and deletions'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir dc dr dt &&
+	>dc/1 &&
+	>dr/2 &&
+	>dt/3 &&
+	>fc &&
+	>fr &&
+	>ft &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+
+	rm -fr dt dr ft fr &&
+	mkdir da ft &&
+	for p in dc/1 da/4 dt ft/5 fc
+	do
+		echo hello >$p || exit
+	done &&
+	git add -u &&
+	git add . &&
+	test_tick &&
+	git commit -m second
+'
+
+cat >expect <<\EOF
+A	da
+A	da/4
+M	dc
+M	dc/1
+D	dr
+D	dr/2
+A	dt
+D	dt
+D	dt/3
+M	fc
+D	fr
+D	ft
+A	ft
+A	ft/5
+EOF
+
+test_expect_success verify '
+	git diff-tree -r -t --name-status HEAD^ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index 9f67af6..c83a8da 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -233,6 +233,12 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 		if (!tree || type != OBJ_TREE)
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
+		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
+			newbase[baselen + pathlen] = 0;
+			opt->add_remove(opt, *prefix, mode, sha1, newbase);
+			newbase[baselen + pathlen] = '/';
+		}
+
 		init_tree_desc(&inner, tree, size);
 		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen);
 
