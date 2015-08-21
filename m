From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3z/3] log: make '-p' imply '-m --cc'
Date: Fri, 21 Aug 2015 14:40:22 -0700
Message-ID: <xmqqr3mw48xl.fsf@gitster.dls.corp.google.com>
References: <1440110591-12941-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 23:40:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSu33-0002No-PH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 23:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbbHUVkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 17:40:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34413 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbbHUVkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 17:40:24 -0400
Received: by padfo6 with SMTP id fo6so15122399pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=N6HQ2qGQFhuilP3gw8Jg2O9aQZzLhvPARm/uab7z7pk=;
        b=ojQbgEWOPIaBite1I6p2r1/xdtsNMjlGuMDGWrqxVICD6ZvS+9VbfwZDqLxGudl5hS
         l1XK+eGIwh4qwtjkUvyUD6hl5wwJoIugaBBxCJkFmPAYrdoQRqlGPYwCAhcJ93MNcTKw
         NroZ4YvXX5YL0kRb4qQt/S6mpwkM6aUJUBooZyrCUJ+gvEcBgYF5OLu5FS7dJISbWudY
         DBuCIV8Ewb/+mj9fg5ZNUFnzM6w1EKUnNe+UC6sRR3HeCLcoDUY0Df12vwW3UE2mNcRR
         lopVJfWWhG8FtV4ISjSzBcEbWaj50Q/b5tdxvnRUxeuUuL2eqHP644J3Nf/AxZOuv/TP
         6tBA==
X-Received: by 10.69.2.227 with SMTP id br3mr21459432pbd.9.1440193223994;
        Fri, 21 Aug 2015 14:40:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id i10sm8903179pdl.8.2015.08.21.14.40.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 14:40:23 -0700 (PDT)
In-Reply-To: <1440110591-12941-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Thu, 20 Aug 2015 15:43:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276336>

Junio C Hamano <gitster@pobox.com> writes:

> The latter was inspired by a recent discussion, most notably
>
>    http://thread.gmane.org/gmane.comp.version-control.git/273937/focus=273988
>
> but implements it with a much less UI impact.  Tweaking "git log -p"
> has a lot of fallout---interested parties can try it out and how two
> tests in t4xxx series break.

Just for the record, here is what I did before deciding that the
idea of turning '-p' into '--cc -m' is not good and instead did the
"'--cc' should show the patch without '-p' and '-m'" that is the
real [3/3].  The attached patch replaces 3/3, showss what happens if
you tweak 'log -p' to imply '-m --cc'"; the change of behaviours is
illustrated by the updated tests.

Many are good-looking, and some others are questionable.

 * "log -G<string> -p" and "log -S<string> -p" that silently turns
   "-p" into "-m --cc" shows merges that changed the occurrences of
   <string>, but if the merge is a trivial textual merge, the change
   itself is not seen (as we are doing "--cc").  This looks very
   questionable.

 * Similarly, "log -p --stat" shows the diffstat against the first
   parent for a merge but does not show the patch text, as "--cc" is
   in effect, for a trivial textual merge.  This looks strange.

 * Even though I very much do like the fact that we see _something_
   in the output for a merge commit, "log --patch-with-stat" that
   outputs a "patch" that cannot be grokked by "git apply" feels
   wrong.

All of the above led me to say "when the user explicitly asks --cc,
show the merges that way, otherwise keeping the 'merges are by
default ignored' is the right thing".


diff --git a/builtin/log.c b/builtin/log.c
index 519f170..1a77804 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -633,6 +633,14 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	    rev->prune_data.nr == 1)
 		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
 
+	/* Turn -p without -m to --cc -p -m */
+	if (rev->ignore_merges && !rev->combine_merges &&
+	    (rev->diffopt.output_format & DIFF_FORMAT_PATCH)) {
+		rev->ignore_merges = 0;
+		rev->combine_merges = 1;
+		rev->dense_combined_merges = 1;
+	}
+
 	/* Turn --cc/-c into -p --cc/-c when -p was not given */
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index a18f147..04f4eee 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -6,6 +6,23 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+ dir/sub | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.log_--patch-with-stat_master
index ae425c4..ec4b1b9 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -6,6 +6,38 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+ dir/sub | 2 ++
+ file0   | 3 +++
+ 2 files changed, 5 insertions(+)
+
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
index d5207ca..d3be9a2 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -6,6 +6,23 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+ dir/sub | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index dffc09d..a6aa60a 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -6,6 +6,38 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+ dir/sub | 2 ++
+ file0   | 3 +++
+ 2 files changed, 5 insertions(+)
+
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/diff.log_--root_--patch-with-stat_master
index 55aa980..4d0ff3d 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -6,6 +6,38 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+ dir/sub | 2 ++
+ file0   | 3 +++
+ 2 files changed, 5 insertions(+)
+
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root_-p_master
index b42c334..19dfc00 100644
--- a/t/t4013/diff.log_--root_-p_master
+++ b/t/t4013/diff.log_--root_-p_master
@@ -6,6 +6,34 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master b/t/t4013/diff.log_-GF_-p_--pickaxe-all_master
index d36f880..4b6b93a 100644
--- a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master
+++ b/t/t4013/diff.log_-GF_-p_--pickaxe-all_master
@@ -1,4 +1,12 @@
 $ git log -GF -p --pickaxe-all master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-GF_-p_master b/t/t4013/diff.log_-GF_-p_master
index 9d93f2c..a712a5a 100644
--- a/t/t4013/diff.log_-GF_-p_master
+++ b/t/t4013/diff.log_-GF_-p_master
@@ -1,4 +1,12 @@
 $ git log -GF -p master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-SF_-p_master b/t/t4013/diff.log_-SF_-p_master
index 5e32438..56c0d52 100644
--- a/t/t4013/diff.log_-SF_-p_master
+++ b/t/t4013/diff.log_-SF_-p_master
@@ -1,4 +1,12 @@
 $ git log -SF -p master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.log_-p_--first-parent_master
index 3fc896d..f5af0c6 100644
--- a/t/t4013/diff.log_-p_--first-parent_master
+++ b/t/t4013/diff.log_-p_--first-parent_master
@@ -6,6 +6,34 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_master
index bf1326d..506947be 100644
--- a/t/t4013/diff.log_-p_master
+++ b/t/t4013/diff.log_-p_master
@@ -6,6 +6,34 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
+diff --cc dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --cc file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+
 commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 35d2d7c..e950092 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -570,6 +570,9 @@ cat >expect <<\EOF
 | |
 | |     Merge HEADS DESCRIPTION
 | |
+| |  reach.t | 1 +
+| |  1 file changed, 1 insertion(+)
+| |
 | * commit COMMIT_OBJECT_NAME
 | | Author: A U Thor <author@example.com>
 | |
@@ -593,6 +596,10 @@ cat >expect <<\EOF
 | | | |
 | | | |     Merge HEADS DESCRIPTION
 | | | |
+| | | |  octopus-a.t | 1 +
+| | | |  octopus-b.t | 1 +
+| | | |  2 files changed, 2 insertions(+)
+| | | |
 | | * | commit COMMIT_OBJECT_NAME
 | | |/  Author: A U Thor <author@example.com>
 | | |
@@ -647,18 +654,30 @@ cat >expect <<\EOF
 | |
 | |     Merge branch 'tangle'
 | |
+| |  tangle-a | 1 +
+| |  1 file changed, 1 insertion(+)
+| |
 | *   commit COMMIT_OBJECT_NAME
 | |\  Merge: MERGE_PARENTS
 | | | Author: A U Thor <author@example.com>
 | | |
 | | |     Merge branch 'side' (early part) into tangle
 | | |
+| | |  1 | 1 +
+| | |  1 file changed, 1 insertion(+)
+| | |
 | * |   commit COMMIT_OBJECT_NAME
 | |\ \  Merge: MERGE_PARENTS
 | | | | Author: A U Thor <author@example.com>
 | | | |
 | | | |     Merge branch 'master' (early part) into tangle
 | | | |
+| | | |  a/two | 1 +
+| | | |  ein   | 1 +
+| | | |  ichi  | 1 +
+| | | |  one   | 1 -
+| | | |  4 files changed, 3 insertions(+), 1 deletion(-)
+| | | |
 | * | | commit COMMIT_OBJECT_NAME
 | | | | Author: A U Thor <author@example.com>
 | | | |
@@ -681,6 +700,10 @@ cat >expect <<\EOF
 | | | | |
 | | | | |     Merge branch 'side'
 | | | | |
+| | | | |  1 | 1 +
+| | | | |  2 | 1 +
+| | | | |  2 files changed, 2 insertions(+)
+| | | | |
 | * | | | commit COMMIT_OBJECT_NAME
 | | |_|/  Author: A U Thor <author@example.com>
 | |/| |
