From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] status/commit: do not suggest "reset HEAD <path>" while
 merging
Date: Sat, 12 Dec 2009 01:02:03 -0800
Message-ID: <1260608523-15579-4-git-send-email-gitster@pobox.com>
References: <1260608523-15579-1-git-send-email-gitster@pobox.com>
 <1260608523-15579-2-git-send-email-gitster@pobox.com>
 <1260608523-15579-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 10:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJNsV-0001Ra-BF
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 10:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758080AbZLLJCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 04:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758029AbZLLJCn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 04:02:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758016AbZLLJCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 04:02:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 545ACA68F5
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7d4M
	cvoEdkVVl8wDR6MUc7HAXvE=; b=o+b/tzxYyIieEFa/yYmeIzLR8HUJZJ/2tWap
	ksgMjLeIMZZbqrNr2705rrKs/lAn/CR9UDsu0JS+LQ4PJ1hooLCRTKmuycbTx8vv
	I4GE50+p0ZNGL7S1AkUWVMyO6XUGKGADhmBb57n48mbmdGt0+BEMjC0obaTPagpP
	y7XzhEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WaKkZE
	h7xjg2SP0hx6BtzLaqPhOakpm/YhUaNtsfz7imTW8F8YQ79Wu/ONW3W95eQL8Yye
	ArfRAN5SqaEWQ38u9n8HzATIPZ2Apc6dlk0z3+AGEYQ2VkDH9fnID2/XBrWBdz14
	tGW9MqmsvQ27RGl1bbWchfLRyz76U5Nd8hQ18=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51379A68F4
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8AD65A68F3 for
 <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:26 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc2.5.g49666
In-Reply-To: <1260608523-15579-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 121FC67A-E6FD-11DE-A49F-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135127>

Suggesting "'reset HEAD <path>' to unstage" is dead wrong if we are about
to record a merge commit.  For either an unmerged path (i.e. with
unresolved conflicts), or an updated path, it would result in discarding
what the other branch did.

Note that we do not do anything special in a case where we are amending a
merge.  The user is making an evil merge starting from an already
committed merge, and running "reset HEAD <path>" is the right way to get
rid of the local edit that has been added to the index.

Once "reset --unresolve <path>" becomes available, we might want to
suggest it for a merged path that has unresolve information, but until
then, just remove the incorrect advice.

We might also want to suggest "checkout --conflict <path>" to revert the
file in the work tree to the state of failed automerge for an unmerged
path, but we never did that, and this commit does not change that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c    |    2 ++
 t/t7060-wtstatus.sh |    1 -
 wt-status.c         |   14 ++++++++++----
 wt-status.h         |    1 +
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 17dd462..7218454 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -960,6 +960,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
+	s.in_merge = in_merge;
 	wt_status_collect(&s);
 
 	if (s.relative_paths)
@@ -1056,6 +1057,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
 	in_merge = file_exists(git_path("MERGE_HEAD"));
+	s.in_merge = in_merge;
 
 	if (s.use_color == -1)
 		s.use_color = git_use_color_default;
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 6c1af26..6dd7077 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -31,7 +31,6 @@ test_expect_success 'Report new path with conflict' '
 cat >expect <<EOF
 # On branch side
 # Unmerged paths:
-#   (use "git reset HEAD <file>..." to unstage)
 #   (use "git add/rm <file>..." as appropriately to mark resolution)
 #
 #	deleted by us:      foo
diff --git a/wt-status.c b/wt-status.c
index 5271b6a..3f62c44 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -47,8 +47,11 @@ void wt_status_prepare(struct wt_status *s)
 static void wt_status_print_unmerged_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
+
 	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
-	if (!s->is_initial)
+	if (s->in_merge)
+		;
+	else if (!s->is_initial)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
 	else
 		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
@@ -59,12 +62,14 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
+
 	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
-	if (!s->is_initial) {
+	if (s->in_merge)
+		; /* NEEDSWORK: use "git reset --unresolve"??? */
+	else if (!s->is_initial)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
-	} else {
+	else
 		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
-	}
 	color_fprintf_ln(s->fp, c, "#");
 }
 
@@ -72,6 +77,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 					 int has_deleted)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
+
 	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
 	if (!has_deleted)
 		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
diff --git a/wt-status.h b/wt-status.h
index a4bddcf..c60f40a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -34,6 +34,7 @@ struct wt_status {
 	const char **pathspec;
 	int verbose;
 	int amend;
+	int in_merge;
 	int nowarn;
 	int use_color;
 	int relative_paths;
-- 
1.6.6.rc2.5.g49666
