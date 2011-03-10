From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 10/10] git-log: put space after commit mark
Date: Thu, 10 Mar 2011 15:45:03 +0100
Message-ID: <dfe27d480258ab4af4fa50628a9bbaff33ba6860.1299767413.git.git@drmicha.warpmail.net>
References: <4D78AC8B.7010308@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 15:49:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxhB9-0007ob-TP
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 15:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab1CJOtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 09:49:00 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33141 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836Ab1CJOs7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 09:48:59 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8D70120D53;
	Thu, 10 Mar 2011 09:48:58 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 10 Mar 2011 09:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=n8cY+D5c5xw8rvz4zTtuGnoW954=; b=XOaYnSgm349tMSVe966F0YlD3XBR/WNe9z9Us2kTSUZ5k2UQCQjSZGzQPXV5REzpVcvanZKhKF3rnkzlys0mJPqevQOdC4/Cn4axL6JK5h8BLbl7K+bOq6VypuT8tHgraGeE3AmLE0SCcJu8Ue54l/qQ+/6q5SjvYGpfzZRFudE=
X-Sasl-enc: SNwTvidvzQu7VO+Ld0Gw1a2GVpViS93MsYUlm+lbWktM 1299768537
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E7BAA446B47;
	Thu, 10 Mar 2011 09:48:57 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.317.gf445f
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net>
In-Reply-To: <cover.1299767412.git.git@drmicha.warpmail.net>
References: <cover.1299767412.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168821>

Currently, commit marks (left, right, boundary, cherry) are output right
before the commit sha1, which makes it difficult to copy sha1s. Sample
output for "git log --oneline --cherry":

=049c269 t6007: test rev-list --cherry

Change this to

= 049c269 t6007: test rev-list --cherry

which matches exactly the current output of "git log --graph".

Leave "git rev-list" output as is (no space) so that they do not break.

Adjust "git-svn" which uses "git log --pretty=raw --boundary".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-svn.perl |    2 +-
 log-tree.c   |    4 ++--
 revision.c   |    9 +++++++++
 revision.h   |    1 +
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 177dd25..a5857c1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5734,7 +5734,7 @@ sub cmd_show_log {
 	my (@k, $c, $d, $stat);
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
-		if (/^${esc_color}commit -?($::sha1_short)/o) {
+		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
 			my $cmt = $1;
 			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
diff --git a/log-tree.c b/log-tree.c
index 1257040..2a1e3a9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -381,7 +381,7 @@ void show_log(struct rev_info *opt)
 		graph_show_commit(opt->graph);
 
 		if (!opt->graph)
-			fputs(get_revision_mark(opt, commit), stdout);
+			put_revision_mark(opt, commit);
 		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
@@ -439,7 +439,7 @@ void show_log(struct rev_info *opt)
 			fputs("commit ", stdout);
 
 		if (!opt->graph)
-			fputs(get_revision_mark(opt, commit), stdout);
+			put_revision_mark(opt, commit);
 		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
 		if (opt->print_parents)
diff --git a/revision.c b/revision.c
index 4881263..725f9b7 100644
--- a/revision.c
+++ b/revision.c
@@ -2303,3 +2303,12 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 		return "+";
 	return "";
 }
+
+void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
+{
+	char *mark = get_revision_mark(revs, commit);
+	if (!strlen(mark))
+		return;
+	fputs(mark, stdout);
+	putchar(' ');
+}
diff --git a/revision.h b/revision.h
index d38f135..1c0abf0 100644
--- a/revision.h
+++ b/revision.h
@@ -168,6 +168,7 @@ extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 extern char *get_revision_mark(const struct rev_info *revs, const struct commit *commit);
+extern void put_revision_mark(const struct rev_info *revs, const struct commit *commit);
 
 extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
-- 
1.7.4.1.317.gf445f
