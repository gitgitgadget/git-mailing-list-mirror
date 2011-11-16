From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] do not let git_path clobber errno when reporting errors
Date: Wed, 16 Nov 2011 02:03:36 -0600
Message-ID: <20111116080336.GC13706@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:03:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQaTD-0004V0-Pw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab1KPIDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:03:43 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60731 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab1KPIDm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:03:42 -0500
Received: by yenq3 with SMTP id q3so1635420yen.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8uX3Cqcsb3RTqF64koEMK2skXJUmwEqw2mGjactBSOg=;
        b=sJdK5vHptETQ1sotLikBVB6AwlhpEep2+INb6Kv7PXrxOKl4BjUHkY7DwYzDKl+IjO
         dmHATEJ8b3rP8P3ItgTTRdkXl1GugTyszzhJAnIxPkfFq8xGwcaQHVxlwAwKO2jAtuOn
         XmdPLoNK2Z6MyhS4yQp81SPYlUMKlCbtkB8bc=
Received: by 10.101.149.20 with SMTP id b20mr9274165ano.142.1321430621881;
        Wed, 16 Nov 2011 00:03:41 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k20sm83519089ann.15.2011.11.16.00.03.40
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 00:03:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185522>

Because git_path() calls vsnprintf(), code like

	fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
	die_errno(_("Could not write to '%s'"), git_path("SQUASH_MSG"));

can end up printing an error indicator from vsnprintf() instead of
open() by mistake.  Store the path we are trying to write to in a
temporary variable and pass _that_ to die_errno(), so the messages
written by git cherry-pick/revert and git merge can avoid this source
of confusion.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/merge.c  |   49 +++++++++++++++++++++++++++++--------------------
 builtin/revert.c |    9 +++++----
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index dffd5ec1..2870a6af 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -316,13 +316,15 @@ static void squash_message(struct commit *commit)
 	struct rev_info rev;
 	struct strbuf out = STRBUF_INIT;
 	struct commit_list *j;
+	const char *filename;
 	int fd;
 	struct pretty_print_context ctx = {0};
 
 	printf(_("Squash commit -- not updating HEAD\n"));
-	fd = open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
+	filename = git_path("SQUASH_MSG");
+	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
-		die_errno(_("Could not write to '%s'"), git_path("SQUASH_MSG"));
+		die_errno(_("Could not write to '%s'"), filename);
 
 	init_revisions(&rev, NULL);
 	rev.ignore_merges = 1;
@@ -492,14 +494,16 @@ static void merge_name(const char *remote, struct strbuf *msg)
 
 	if (!strcmp(remote, "FETCH_HEAD") &&
 			!access(git_path("FETCH_HEAD"), R_OK)) {
+		const char *filename;
 		FILE *fp;
 		struct strbuf line = STRBUF_INIT;
 		char *ptr;
 
-		fp = fopen(git_path("FETCH_HEAD"), "r");
+		filename = git_path("FETCH_HEAD");
+		fp = fopen(filename, "r");
 		if (!fp)
 			die_errno(_("could not open '%s' for reading"),
-				  git_path("FETCH_HEAD"));
+				  filename);
 		strbuf_getline(&line, fp, '\n');
 		fclose(fp);
 		ptr = strstr(line.buf, "\tnot-for-merge\t");
@@ -847,20 +851,22 @@ static void add_strategies(const char *string, unsigned attr)
 
 static void write_merge_msg(struct strbuf *msg)
 {
-	int fd = open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
+	const char *filename = git_path("MERGE_MSG");
+	int fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"),
-			  git_path("MERGE_MSG"));
+			  filename);
 	if (write_in_full(fd, msg->buf, msg->len) != msg->len)
-		die_errno(_("Could not write to '%s'"), git_path("MERGE_MSG"));
+		die_errno(_("Could not write to '%s'"), filename);
 	close(fd);
 }
 
 static void read_merge_msg(struct strbuf *msg)
 {
+	const char *filename = git_path("MERGE_MSG");
 	strbuf_reset(msg);
-	if (strbuf_read_file(msg, git_path("MERGE_MSG"), 0) < 0)
-		die_errno(_("Could not read from '%s'"), git_path("MERGE_MSG"));
+	if (strbuf_read_file(msg, filename, 0) < 0)
+		die_errno(_("Could not read from '%s'"), filename);
 }
 
 static void write_merge_state(void);
@@ -948,13 +954,14 @@ static int finish_automerge(struct commit *head,
 
 static int suggest_conflicts(int renormalizing)
 {
+	const char *filename;
 	FILE *fp;
 	int pos;
 
-	fp = fopen(git_path("MERGE_MSG"), "a");
+	filename = git_path("MERGE_MSG");
+	fp = fopen(filename, "a");
 	if (!fp)
-		die_errno(_("Could not open '%s' for writing"),
-			  git_path("MERGE_MSG"));
+		die_errno(_("Could not open '%s' for writing"), filename);
 	fprintf(fp, "\nConflicts:\n");
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
@@ -1046,6 +1053,7 @@ static int setup_with_upstream(const char ***argv)
 
 static void write_merge_state(void)
 {
+	const char *filename;
 	int fd;
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
@@ -1053,24 +1061,25 @@ static void write_merge_state(void)
 	for (j = remoteheads; j; j = j->next)
 		strbuf_addf(&buf, "%s\n",
 			sha1_to_hex(j->item->object.sha1));
-	fd = open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
+	filename = git_path("MERGE_HEAD");
+	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"),
-			  git_path("MERGE_HEAD"));
+		die_errno(_("Could not open '%s' for writing"), filename);
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-		die_errno(_("Could not write to '%s'"), git_path("MERGE_HEAD"));
+		die_errno(_("Could not write to '%s'"), filename);
 	close(fd);
 	strbuf_addch(&merge_msg, '\n');
 	write_merge_msg(&merge_msg);
-	fd = open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 0666);
+
+	filename = git_path("MERGE_MODE");
+	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"),
-			  git_path("MERGE_MODE"));
+		die_errno(_("Could not open '%s' for writing"), filename);
 	strbuf_reset(&buf);
 	if (!allow_fast_forward)
 		strbuf_addf(&buf, "no-ff");
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
-		die_errno(_("Could not write to '%s'"), git_path("MERGE_MODE"));
+		die_errno(_("Could not write to '%s'"), filename);
 	close(fd);
 }
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 87df70ed..985f95b0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -288,17 +288,18 @@ static char *get_encoding(const char *message)
 
 static void write_cherry_pick_head(struct commit *commit)
 {
+	const char *filename;
 	int fd;
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
 
-	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
+	filename = git_path("CHERRY_PICK_HEAD");
+	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"),
-			  git_path("CHERRY_PICK_HEAD"));
+		die_errno(_("Could not open '%s' for writing"), filename);
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-		die_errno(_("Could not write to '%s'"), git_path("CHERRY_PICK_HEAD"));
+		die_errno(_("Could not write to '%s'"), filename);
 	strbuf_release(&buf);
 }
 
-- 
1.7.8.rc0
