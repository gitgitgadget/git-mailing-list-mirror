From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-commit: squelch needless message during an empty merge
Date: Wed, 12 Dec 2007 19:09:16 -0800
Message-ID: <7v1w9r5m03.fsf_-_@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 04:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2eSM-0006ZQ-Ac
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 04:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbXLMDJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 22:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXLMDJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 22:09:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbXLMDJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 22:09:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CB1653B0;
	Wed, 12 Dec 2007 22:09:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B2A53AB;
	Wed, 12 Dec 2007 22:09:18 -0500 (EST)
In-Reply-To: <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 12 Dec 2007 18:47:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68115>

When recording a merge that conflicted and ends up in no changes after
manual resolution, commit callchain looked like this:

	cmd_commit() ->
            prepare_log_message() ->
                run_status() ->
		    wt_status_print()

This invocation of run_status() is asked to find out if there is a
committable change, but it unconditionally gave instructions such as
"use git-add" at the same time.  When in merge, we do allow an empty
change to be recorded, so after showing this message the code still went
ahead and made a commit.

This introduces "nowarn" parameter to run_status() to avoid these
useless messages.  If we are not allowed to create an empty commit, we
already call run_status() again in the original codepath, and the
message will be shown from that call anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |    9 +++++----
 wt-status.c      |    2 ++
 wt-status.h      |    1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 9cb7589..ad9f921 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -280,7 +280,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	return false_lock.filename;
 }
 
-static int run_status(FILE *fp, const char *index_file, const char *prefix)
+static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn)
 {
 	struct wt_status s;
 
@@ -296,6 +296,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix)
 	s.untracked = untracked_files;
 	s.index_file = index_file;
 	s.fp = fp;
+	s.nowarn = nowarn;
 
 	wt_status_print(&s);
 
@@ -412,7 +413,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 	saved_color_setting = wt_status_use_color;
 	wt_status_use_color = 0;
-	commitable = run_status(fp, index_file, prefix);
+	commitable = run_status(fp, index_file, prefix, 1);
 	wt_status_use_color = saved_color_setting;
 
 	fclose(fp);
@@ -606,7 +607,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	index_file = prepare_index(argc, argv, prefix);
 
-	commitable = run_status(stdout, index_file, prefix);
+	commitable = run_status(stdout, index_file, prefix, 0);
 
 	rollback_index_files();
 
@@ -717,7 +718,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (!prepare_log_message(index_file, prefix) && !in_merge &&
 	    !allow_empty && !(amend && is_a_merge(head_sha1))) {
-		run_status(stdout, index_file, prefix);
+		run_status(stdout, index_file, prefix, 0);
 		rollback_index_files();
 		unlink(commit_editmsg);
 		return 1;
diff --git a/wt-status.c b/wt-status.c
index 51c1879..c0c2472 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -381,6 +381,8 @@ void wt_status_print(struct wt_status *s)
 	if (!s->commitable) {
 		if (s->amend)
 			fprintf(s->fp, "# No changes\n");
+		else if (s->nowarn)
+			; /* nothing */
 		else if (s->workdir_dirty)
 			printf("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
 		else if (s->workdir_untracked)
diff --git a/wt-status.h b/wt-status.h
index 63d50f2..02afaa6 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -17,6 +17,7 @@ struct wt_status {
 	int verbose;
 	int amend;
 	int untracked;
+	int nowarn;
 	/* These are computed during processing of the individual sections */
 	int commitable;
 	int workdir_dirty;
