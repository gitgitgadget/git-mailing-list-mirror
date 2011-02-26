From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] commit: refer to commit template as s->fp
Date: Fri, 25 Feb 2011 23:10:49 -0600
Message-ID: <20110226051049.GD27887@elie>
References: <20110226050723.GA27864@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 06:11:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtCQs-00081Z-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 06:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab1BZFLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 00:11:01 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60225 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab1BZFLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 00:11:00 -0500
Received: by qyk7 with SMTP id 7so956271qyk.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 21:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8Q63cvRGpaHGp3DVt9upEU9plygXh/kTCrohJMsCiZk=;
        b=KxLTahQ6e1dju+unT0PV2reLu5h7O363cVzy5HLAM/8hvCvcMa6cLsEKPjZLj5BUsw
         opzYY4FfAwYXkhBb6WY8bWDksHgRjxP6qG/9GHpbl9UmsFilyIvDA8pMWctYehkNdmg9
         cNmx3BifXdBSopG9hsBYBDh9d7yfDbsFW7JXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OtCMTFDU6HzceLIQSriluTQ1Ryn9tCAj5BU+ya7E+WoulFV5UCJukCAB+cECMzH/2D
         HZAvDHFp1/rF0w3s/2UK0904LNQCzGAz27YlXPDsjJ7YLEIV/CGojkaZPRLIxf6CHfyv
         rgWoQqG8YbO7XbFLx8CjtW/HBefwO9/yPHrGc=
Received: by 10.229.88.206 with SMTP id b14mr2457114qcm.277.1298697059471;
        Fri, 25 Feb 2011 21:10:59 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id e29sm1105814qck.15.2011.02.25.21.10.56
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 21:10:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110226050723.GA27864@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167958>

Instead of maintaining a local variable for it, use s->fp to keep
track of where the commit message template should be written.

This prepares us to take advantage of the status_printf functions,
which use a struct wt_status instead of a FILE pointer to determine
where to send their output.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d7f55e3..ef5f0b2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -568,7 +568,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int commitable, saved_color_setting;
 	struct strbuf sb = STRBUF_INIT;
 	char *buffer;
-	FILE *fp;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
@@ -657,8 +656,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg2 = "";
 	}
 
-	fp = fopen(git_path(commit_editmsg), "w");
-	if (fp == NULL)
+	s->fp = fopen(git_path(commit_editmsg), "w");
+	if (s->fp == NULL)
 		die_errno("could not open '%s'", git_path(commit_editmsg));
 
 	if (cleanup_mode != CLEANUP_NONE)
@@ -682,7 +681,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_release(&sob);
 	}
 
-	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
+	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno("could not write commit template");
 
 	strbuf_release(&sb);
@@ -695,7 +694,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (use_editor && include_status) {
 		char *ai_tmp, *ci_tmp;
 		if (in_merge)
-			fprintf(fp,
+			fprintf(s->fp,
 				"#\n"
 				"# It looks like you may be committing a MERGE.\n"
 				"# If this is not correct, please remove the file\n"
@@ -704,45 +703,45 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				"#\n",
 				git_path("MERGE_HEAD"));
 
-		fprintf(fp,
+		fprintf(s->fp,
 			"\n"
 			"# Please enter the commit message for your changes.");
 		if (cleanup_mode == CLEANUP_ALL)
-			fprintf(fp,
+			fprintf(s->fp,
 				" Lines starting\n"
 				"# with '#' will be ignored, and an empty"
 				" message aborts the commit.\n");
 		else /* CLEANUP_SPACE, that is. */
-			fprintf(fp,
+			fprintf(s->fp,
 				" Lines starting\n"
 				"# with '#' will be kept; you may remove them"
 				" yourself if you want to.\n"
 				"# An empty message aborts the commit.\n");
 		if (only_include_assumed)
-			fprintf(fp, "# %s\n", only_include_assumed);
+			fprintf(s->fp, "# %s\n", only_include_assumed);
 
 		ai_tmp = cut_ident_timestamp_part(author_ident->buf);
 		ci_tmp = cut_ident_timestamp_part(committer_ident.buf);
 		if (strcmp(author_ident->buf, committer_ident.buf))
-			fprintf(fp,
+			fprintf(s->fp,
 				"%s"
 				"# Author:    %s\n",
 				ident_shown++ ? "" : "#\n",
 				author_ident->buf);
 
 		if (!user_ident_sufficiently_given())
-			fprintf(fp,
+			fprintf(s->fp,
 				"%s"
 				"# Committer: %s\n",
 				ident_shown++ ? "" : "#\n",
 				committer_ident.buf);
 
 		if (ident_shown)
-			fprintf(fp, "#\n");
+			fprintf(s->fp, "#\n");
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
-		commitable = run_status(fp, index_file, prefix, 1, s);
+		commitable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 
 		*ai_tmp = ' ';
@@ -764,7 +763,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 	strbuf_release(&committer_ident);
 
-	fclose(fp);
+	fclose(s->fp);
 
 	if (!commitable && !in_merge && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {
-- 
1.7.4.1
