From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach git-merge to pass -X<option> to the backend strategy
 module
Date: Sun, 29 Jun 2008 01:50:42 -0700
Message-ID: <7vwsk8d3q5.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 10:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCsdP-00027i-5m
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYF2Ius (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYF2Ius
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:50:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYF2Iuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:50:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 24659288D;
	Sun, 29 Jun 2008 04:50:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0A1E3288C; Sun, 29 Jun 2008 04:50:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76DB44B4-45B8-11DD-8362-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86786>

Distinguishing slight variation of modes of operation between the vanilla
merge-recursive and merge-recursive-ours by the command name may have been
an easy way to experiment, but we should bite the bullet and allow backend
specific options to be given by the end user.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 > [Stalled/Needs more work]
 >
 > * jc/merge-theirs (Fri Jun 20 00:17:59 2008 -0700) 2 commits
 >  - git-merge-recursive-{ours,theirs}
 >  - git-merge-file --ours, --theirs
 >
 > Punting a merge by discarding your own work in conflicting parts but still
 > salvaging the parts that are cleanly automerged.  It is likely that this
 > will result in nonsense mishmash, but somehow often people want this, so
 > here they are.  The interface to the backends may need to change, though.

 Makefile                     |    3 ---
 builtin-merge-recursive.c    |   23 +++++++++++++++--------
 git-merge.sh                 |   11 ++++++++---
 t/t6034-merge-ours-theirs.sh |    4 ++--
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 82d2892..b003e3e 100644
--- a/Makefile
+++ b/Makefile
@@ -304,8 +304,6 @@ BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
-BUILT_INS += git-merge-recursive-ours$X
-BUILT_INS += git-merge-recursive-theirs$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
@@ -1383,7 +1381,6 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-recursive-ours | git-merge-recursive-theirs | \
 		git-merge-resolve | git-merge-stupid | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index a355e7a..6541e16 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -1407,12 +1407,6 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		if (8 < namelen &&
 		    !strcmp(argv[0] + namelen - 8, "-subtree"))
 			merge_recursive_variants = MERGE_RECURSIVE_SUBTREE;
-		else if (5 < namelen &&
-			 !strcmp(argv[0] + namelen - 5, "-ours"))
-			merge_recursive_variants = MERGE_RECURSIVE_OURS;
-		else if (7 < namelen &&
-			 !strcmp(argv[0] + namelen - 7, "-theirs"))
-			merge_recursive_variants = MERGE_RECURSIVE_THEIRS;
 	}
 
 	git_config(merge_config, NULL);
@@ -1423,8 +1417,21 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
 
 	for (i = 1; i < argc; ++i) {
-		if (!strcmp(argv[i], "--"))
-			break;
+		const char *arg = argv[i];
+
+		if (!prefixcmp(arg, "--")) {
+			if (!arg[2])
+				break;
+			if (!strcmp(arg+2, "ours"))
+				merge_recursive_variants = MERGE_RECURSIVE_OURS;
+			else if (!strcmp(arg+2, "theirs"))
+				merge_recursive_variants = MERGE_RECURSIVE_THEIRS;
+			else if (!strcmp(arg+2, "subtree"))
+				merge_recursive_variants = MERGE_RECURSIVE_SUBTREE;
+			else
+				die("Unknown option %s", arg);
+			continue;
+		}
 		if (bases_count < sizeof(bases)/sizeof(*bases))
 			bases[bases_count++] = argv[i];
 	}
diff --git a/git-merge.sh b/git-merge.sh
index 39b5cd9..d475852 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -17,6 +17,7 @@ commit               perform a commit if the merge succeeds (default)
 ff                   allow fast forward (default)
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
+X=                   pass merge strategy specific options
 "
 
 SUBDIRECTORY_OK=Yes
@@ -31,12 +32,12 @@ LF='
 '
 
 all_strategies='recur recursive octopus resolve stupid ours subtree'
-all_strategies="$all_strategies recursive-ours recursive-theirs"
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
 no_fast_forward_strategies='subtree ours'
-no_trivial_strategies='recursive recur subtree ours recursive-ours recursive-theirs'
+no_trivial_strategies='recursive recur subtree ours'
 use_strategies=
+backend_option=
 
 allow_fast_forward=t
 allow_trivial_merge=t
@@ -187,6 +188,10 @@ parse_config () {
 			merge_msg="$1"
 			have_message=t
 			;;
+		-X)
+			shift
+			backend_option="$backend_option --$1"
+			;;
 		--)
 			shift
 			break ;;
@@ -451,7 +456,7 @@ do
     # Remember which strategy left the state in the working tree
     wt_strategy=$strategy
 
-    git-merge-$strategy $common -- "$head_arg" "$@"
+    git-merge-$strategy $backend_option $common -- "$head_arg" "$@"
     exit=$?
     if test "$no_commit" = t && test "$exit" = 0
     then
diff --git a/t/t6034-merge-ours-theirs.sh b/t/t6034-merge-ours-theirs.sh
index 56a9247..91f0f63 100755
--- a/t/t6034-merge-ours-theirs.sh
+++ b/t/t6034-merge-ours-theirs.sh
@@ -35,7 +35,7 @@ test_expect_success 'plain recursive - should conflict' '
 
 test_expect_success 'recursive favouring theirs' '
 	git reset --hard master &&
-	git merge -s recursive-theirs side &&
+	git merge -s recursive -Xtheirs side &&
 	! grep nine file &&
 	grep nueve file &&
 	! grep 9 file &&
@@ -45,7 +45,7 @@ test_expect_success 'recursive favouring theirs' '
 
 test_expect_success 'recursive favouring ours' '
 	git reset --hard master &&
-	git merge -s recursive-ours side &&
+	git merge -s recursive -Xours side &&
 	grep nine file &&
 	! grep nueve file &&
 	! grep 9 file &&
-- 
1.5.6.1.102.g8e69d
