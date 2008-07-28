From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t7001-mv.sh: Propose ability to use git-mv on
 conflicting entries
Date: Sun, 27 Jul 2008 18:13:59 -0700
Message-ID: <7v4p6ayfmw.fsf@gitster.siamese.dyndns.org>
References: <20080727134142.GA10151@machine.or.cz>
 <20080727134704.27534.86520.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 28 03:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHKR-0005qg-Pq
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450AbYG1BOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbYG1BOK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:14:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYG1BOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:14:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 76FB93EDAB;
	Sun, 27 Jul 2008 21:14:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E82053EDA9; Sun, 27 Jul 2008 21:14:01 -0400 (EDT)
In-Reply-To: <20080727134704.27534.86520.stgit@localhost> (Petr Baudis's
 message of "Sun, 27 Jul 2008 15:47:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 795DBF00-5C42-11DD-819E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90383>

Petr Baudis <pasky@suse.cz> writes:

> I don't really know if it is ok to make "feature requests" like this by
> adding failing testcases...

Of course it depends on who you are.  It's not Ok for somebody like you,
who is known to be competent, and certainly it is not Ok to do it on a
command that you know you care more about than I do.

I've neglected builtin-mv.c since its introduction, mostly because I never
say "git mv" myself (in other words, I haven't cared very much how broken
it was.  For one thing, its indentation style is peculiar and is hard to
read and maintain).

> +# Rationale: I cannot git mv around a conflicted file. This is unnecessary
> +# restriction in case another part of conflict resolution requires me to
> +# move the file around.

Yes, I would agree this is a reasonable thing to support.  Something like
this patch, perhaps.

---
 builtin-mv.c  |   21 ++++++++++++++-------
 t/t7001-mv.sh |   21 +++++++++++++++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 4f65b5a..cc9e505 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -96,7 +96,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	/* Checking */
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
-		int length, src_is_dir;
+		int length, src_is_dir, pos;
 		const char *bad = NULL;
 
 		if (show_only)
@@ -177,7 +177,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				} else
 					bad = "Cannot overwrite";
 			}
-		} else if (cache_name_pos(src, length) < 0)
+		} else if (((pos = cache_name_pos(src, length)) < 0) &&
+			   strcmp(active_cache[-1 - pos]->name, src))
 			bad = "not under version control";
 		else if (string_list_has_string(&src_for_dst, dst))
 			bad = "multiple sources for the same target";
@@ -202,7 +203,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
-		int pos;
 		if (show_only || verbose)
 			printf("Renaming %s to %s\n", src, dst);
 		if (!show_only && mode != INDEX &&
@@ -212,10 +212,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (mode == WORKING_DIRECTORY)
 			continue;
 
-		pos = cache_name_pos(src, strlen(src));
-		assert(pos >= 0);
-		if (!show_only)
-			rename_cache_entry_at(pos, dst);
+		if (!show_only) {
+			while (1) {
+				int pos = cache_name_pos(src, strlen(src));
+				if (pos < 0)
+					pos = -1 - pos;
+				if ((active_nr <= pos) ||
+				    strcmp(active_cache[pos]->name, src))
+					break;
+				rename_cache_entry_at(pos, dst);
+			}
+		}
 	}
 
 	if (active_cache_changed) {
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b0fa407..d538f88 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -173,6 +173,27 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 
 rm -f dirty dirty2
 
+cat >expect <<\EOT
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1	staged
+100755 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 2	staged
+100755 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 3	staged
+EOT
+
+test_expect_success 'git mv should move all stages of cache entry' '
+	rm -fr .git &&
+	git init &&
+	>staged &&
+	git update-index --index-info <expect &&
+	git ls-files --stage >actual &&
+	test_cmp expect actual &&
+	git mv staged staged-mv &&
+	sed "s/staged/staged-mv/" <expect >expect-2 &&
+	git ls-files --stage >actual &&
+	test_cmp expect-2 actual
+'
+
+rm -f expect expect-2 staged actual staged-mv
+
 test_expect_success 'git mv should overwrite symlink to a file' '
 
 	rm -fr .git &&
