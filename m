From: Josh Triplett <josht@vnet.ibm.com>
Subject: [PATCH] git-format-patch: Make the second and subsequent mails
	replies to the first
Date: Mon, 10 Jul 2006 08:44:25 -0700
Message-ID: <1152546266.8890.19.camel@josh-work.beaverton.ibm.com>
Reply-To: git@vger.kernel.org, josht@vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 10 17:44:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzxvy-00072W-Fz
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 17:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWGJPo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWGJPo0
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 11:44:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:46475 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965112AbWGJPoZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 11:44:25 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AFiOIv011995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 11:44:25 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6AFinIq141890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 09:44:49 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6AFiNhm016264
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 09:44:23 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AFiMFD016249
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 09:44:22 -0600
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23624>

Add message_id and ref_message_id fields to struct rev_info, used in show_log
with CMIT_FMT_EMAIL to set Message-Id and In-Reply-To/References respectively.
Use these in git-format-patch to make the second and subsequent patch mails
replies to the first patch mail.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
git-send-email already does this, but this change helps people who use
things like git-imap-send or similar to send the patch emails by other
means.

 builtin-log.c |   23 +++++++++++++++++++++++
 log-tree.c    |    5 +++++
 revision.h    |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 864c6cd..9d0cae1 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -220,6 +220,17 @@ static void get_patch_ids(struct rev_inf
 	o2->flags = flags2;
 }
 
+static void gen_message_id(char *dest, unsigned int length, char *base)
+{
+	const char *committer = git_committer_info(1);
+	const char *email_start = strrchr(committer, '<');
+	const char *email_end = strrchr(committer, '>');
+	if(!email_start || !email_end || email_start > email_end - 1)
+		die("Could not extract email from committer identity.");
+	snprintf(dest, length, "%s.%u.git.%.*s", base, time(NULL),
+		 email_end - email_start - 1, email_start + 1);
+}
+
 int cmd_format_patch(int argc, const char **argv, char **envp)
 {
 	struct commit *commit;
@@ -233,6 +244,8 @@ int cmd_format_patch(int argc, const cha
 	int ignore_if_in_upstream = 0;
 	struct diff_options patch_id_opts;
 	char *add_signoff = NULL;
+	char message_id[1024];
+	char ref_message_id[1024];
 
 	init_revisions(&rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
@@ -359,6 +372,16 @@ int cmd_format_patch(int argc, const cha
 		int shown;
 		commit = list[nr];
 		rev.nr = total - nr + (start_number - 1);
+		/* Make the second and subsequent mails replies to the first */
+		if (nr == (total - 2)) {
+			strncpy(ref_message_id, message_id,
+				sizeof(ref_message_id));
+			ref_message_id[sizeof(ref_message_id)-1] = '\0';
+			rev.ref_message_id = ref_message_id;
+		}
+		gen_message_id(message_id, sizeof(message_id),
+			       sha1_to_hex(commit->object.sha1));
+		rev.message_id = message_id;
 		if (!use_stdout)
 			reopen_stdout(commit, rev.nr, keep_subject);
 		shown = log_tree_commit(&rev, commit);
diff --git a/log-tree.c b/log-tree.c
index 9d8d46f..4971988 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -97,6 +97,11 @@ void show_log(struct rev_info *opt, cons
 			subject = "Subject: ";
 
 		printf("From %s Mon Sep 17 00:00:00 2001\n", sha1);
+		if (opt->message_id)
+			printf("Message-Id: <%s>\n", opt->message_id);
+		if (opt->ref_message_id)
+			printf("In-Reply-To: <%s>\nReferences: <%s>\n",
+			       opt->ref_message_id, opt->ref_message_id);
 		if (opt->mime_boundary) {
 			static char subject_buffer[1024];
 			static char buffer[1024];
diff --git a/revision.h b/revision.h
index c010a08..e23ec8f 100644
--- a/revision.h
+++ b/revision.h
@@ -61,6 +61,8 @@ struct rev_info {
 	struct log_info *loginfo;
 	int		nr, total;
 	const char	*mime_boundary;
+	const char	*message_id;
+	const char	*ref_message_id;
 	const char	*add_signoff;
 	const char	*extra_headers;
 
-- 
1.4.1.gbe4c7-dirty
