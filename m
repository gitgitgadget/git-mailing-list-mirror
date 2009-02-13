From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] log: do not print ellipses with --abbrev-commit
Date: Fri, 13 Feb 2009 23:10:41 +0100
Message-ID: <1234563041-25061-1-git-send-email-trast@student.ethz.ch>
References: <7vprhm81kk.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>,
	=?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 23:12:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY6Gh-0006nb-4J
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 23:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZBMWKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 17:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbZBMWKu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 17:10:50 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:46065 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbZBMWKt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 17:10:49 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 23:10:48 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 23:10:47 +0100
X-Mailer: git-send-email 1.6.2.rc0.283.g181d4
In-Reply-To: <7vprhm81kk.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 13 Feb 2009 22:10:47.0842 (UTC) FILETIME=[EC704820:01C98E27]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109778>

'git log --abbrev-commit' added an ellipsis to all commit names that
were abbreviated.  This was particularly annoying if you wanted to
cut&paste the sha1 from the terminal, since selecting by word would
pick up '...'  too.

So use find_unique_abbrev() instead of diff_unique_abbrev() in all
log-related commit sha1 printing routines, and also change the
formatting of the 'Merge: parent1 parent2' line output via
pretty_print_commit().

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > 'git log --abbrev-commit' adds an ellipsis to all commit names that
[...]
> I actually think that it is a bug that --abbrev-commit uses ellipses.
> 
> It has been there since "diff --abbrev" was first introduced by commit
> 47dd0d5 (diff: --abbrev option, 2005-12-13).  It did make sense to align
> columns in abbreviated raw diff output with ellipses, but it did not make
> much sense to do that for commit object names.

Heh.  I was actually more careful (making it customizable) because I
was afraid it would get shot down because people are used to the other
format.  It arguably does make a bit of sense for --pretty=oneline
(and to some extent --graph --pretty=oneline), though for me the
doubleclick word selection by far outweighs the slight chance of
breaking the layout because of a longer unique sha1.

> For this reason, I do not think it is necessarily a bad idea to make this
> change even unconditionally to both plumbing and Porcelain.

That makes for a smaller change, but affects t4013, where a lot of the
tests contain a 'Merge:' line.


 log-tree.c                                         |    8 ++++----
 pretty.c                                           |    4 +---
 ....log_--patch-with-stat_--summary_master_--_dir_ |    2 +-
 t/t4013/diff.log_--patch-with-stat_master          |    2 +-
 t/t4013/diff.log_--patch-with-stat_master_--_dir_  |    2 +-
 ..._--root_--cc_--patch-with-stat_--summary_master |    2 +-
 ...f.log_--root_--patch-with-stat_--summary_master |    2 +-
 t/t4013/diff.log_--root_--patch-with-stat_master   |    2 +-
 ...og_--root_-c_--patch-with-stat_--summary_master |    2 +-
 t/t4013/diff.log_--root_-p_master                  |    2 +-
 t/t4013/diff.log_--root_master                     |    2 +-
 t/t4013/diff.log_-p_master                         |    2 +-
 t/t4013/diff.log_master                            |    2 +-
 t/t4013/diff.show_master                           |    2 +-
 ..._--root_--cc_--patch-with-stat_--summary_master |    2 +-
 ...ed_--root_-c_--patch-with-stat_--summary_master |    2 +-
 16 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 194ddb1..84a74e5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -48,7 +48,7 @@ static void show_parents(struct commit *commit, int abbrev)
 	struct commit_list *p;
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
-		printf(" %s", diff_unique_abbrev(parent->object.sha1, abbrev));
+		printf(" %s", find_unique_abbrev(parent->object.sha1, abbrev));
 	}
 }
 
@@ -280,7 +280,7 @@ void show_log(struct rev_info *opt)
 					putchar('>');
 			}
 		}
-		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
+		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		show_decorations(opt, commit);
@@ -348,13 +348,13 @@ void show_log(struct rev_info *opt)
 					putchar('>');
 			}
 		}
-		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
+		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
-			       diff_unique_abbrev(parent->object.sha1,
+			       find_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
 		show_decorations(opt, commit);
 		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
diff --git a/pretty.c b/pretty.c
index cc460b5..428fbb6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -210,15 +210,13 @@ static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
 	while (parent) {
 		struct commit *p = parent->item;
 		const char *hex = NULL;
-		const char *dots;
 		if (abbrev)
 			hex = find_unique_abbrev(p->object.sha1, abbrev);
 		if (!hex)
 			hex = sha1_to_hex(p->object.sha1);
-		dots = (abbrev && strlen(hex) != 40) ?  "..." : "";
 		parent = parent->next;
 
-		strbuf_addf(sb, " %s%s", hex, dots);
+		strbuf_addf(sb, " %s", hex);
 	}
 	strbuf_addch(sb, '\n');
 }
diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
index 3ceb8e7..bd7f5c0 100644
--- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
@@ -1,6 +1,6 @@
 $ git log --patch-with-stat --summary master -- dir/
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.log_--patch-with-stat_master
index 43d7776..14595a6 100644
--- a/t/t4013/diff.log_--patch-with-stat_master
+++ b/t/t4013/diff.log_--patch-with-stat_master
@@ -1,6 +1,6 @@
 $ git log --patch-with-stat master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
index 5187a26..5a4e727 100644
--- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
+++ b/t/t4013/diff.log_--patch-with-stat_master_--_dir_
@@ -1,6 +1,6 @@
 $ git log --patch-with-stat master -- dir/
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
index c964097..df0aaa9 100644
--- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
@@ -1,6 +1,6 @@
 $ git log --root --cc --patch-with-stat --summary master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
index ad050af..c11b5f2 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
@@ -1,6 +1,6 @@
 $ git log --root --patch-with-stat --summary master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/diff.log_--root_--patch-with-stat_master
index 628c6c0..5f0c98f 100644
--- a/t/t4013/diff.log_--root_--patch-with-stat_master
+++ b/t/t4013/diff.log_--root_--patch-with-stat_master
@@ -1,6 +1,6 @@
 $ git log --root --patch-with-stat master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
index 5d4e0f1..e62c368 100644
--- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
@@ -1,6 +1,6 @@
 $ git log --root -c --patch-with-stat --summary master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root_-p_master
index 217a2eb..b42c334 100644
--- a/t/t4013/diff.log_--root_-p_master
+++ b/t/t4013/diff.log_--root_-p_master
@@ -1,6 +1,6 @@
 $ git log --root -p master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_master
index e17ccfc..e8f4615 100644
--- a/t/t4013/diff.log_--root_master
+++ b/t/t4013/diff.log_--root_master
@@ -1,6 +1,6 @@
 $ git log --root master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_master
index f8fefef..bf1326d 100644
--- a/t/t4013/diff.log_-p_master
+++ b/t/t4013/diff.log_-p_master
@@ -1,6 +1,6 @@
 $ git log -p master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_master
index e9d9e7b..a8f6ce5 100644
--- a/t/t4013/diff.log_master
+++ b/t/t4013/diff.log_master
@@ -1,6 +1,6 @@
 $ git log master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_master
index 9e6e1f2..fb08ce0 100644
--- a/t/t4013/diff.show_master
+++ b/t/t4013/diff.show_master
@@ -1,6 +1,6 @@
 $ git show master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
index 5facf25..e96ff1f 100644
--- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_master
@@ -1,6 +1,6 @@
 $ git whatchanged --root --cc --patch-with-stat --summary master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
index 10f6767..c0aff68 100644
--- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
+++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_master
@@ -1,6 +1,6 @@
 $ git whatchanged --root -c --patch-with-stat --summary master
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
-Merge: 9a6d494... c7a2ab9...
+Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
-- 
1.6.2.rc0.274.g97213
