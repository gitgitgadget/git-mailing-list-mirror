From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/3]
Date: Thu, 14 May 2015 13:16:48 -0700
Message-ID: <xmqqegmikj7z.fsf@gitster.dls.corp.google.com>
References: <1431541434-21884-1-git-send-email-dturner@twitter.com>
	<xmqqvbfvj7ge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:16:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YszYt-000788-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbbENUQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:16:51 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36440 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934AbbENUQu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:16:50 -0400
Received: by igbpi8 with SMTP id pi8so177201503igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xTSeloUT7RDSFRwzMxRhEJy3UqKv0zVGamqlABB2jeY=;
        b=GEByIVHH4I8FxkT+0O35g4Fi+GlnAKTg46CcZgspDx1Iye0L/2or/n/u9QMl/vhjO+
         cL6pFwZZ4nM17xkNvujsoHpSyfL+VTy380pK0GNLAwjZavO8u+Rczy0QU0tSHGTE9Y3R
         duNPRXGlgPYt+jp9gQ9uy4KurMrWAzuhvNg+9SLZ4gRq81X7zCfspLEl/NHF0LYCfc+o
         +cgTK+cji/RE1hlw9OnFUW4HyBDsxrnno35FyrxvKNfqe8POIvL0Diji6G+QHZD1j3vR
         zny1bfYZWdYraUxN7t3zF74O1zxx7/ToC+xlEofKZ3kM5EjKFDziE2OVQPCQscuYCttZ
         c/fQ==
X-Received: by 10.50.79.196 with SMTP id l4mr3788208igx.48.1431634610016;
        Thu, 14 May 2015 13:16:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id k74sm55309iok.30.2015.05.14.13.16.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 13:16:49 -0700 (PDT)
In-Reply-To: <xmqqvbfvj7ge.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 May 2015 12:16:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269079>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> Oops, forgot to ammend commit before patch v8.  This patch *really*
>> includes the switch and type casting fixes.
>
> Thanks. Will replace.

I've placed the attached change on top as a suggested fix-up.

The reasons for the first two hunks should be obvious.

The last hunk is because:

 * "--follow-symlinks" (currently) works only with "--batch{-check}",
   so it flows more natural to show it after them.

 * "in-repo" is a wrong phrase, I think.  For a symbolic link
   HEAD:dir/link, you cannot give "$(git rev-parse HEAD:dir):link"
   to this machinery if its value is "../toplevel-file", even though
   the target is "in-repo", and the reason why you can't is because
   it is outside the tree "$(git rev-parse HEAD:dir)".
   
 * OPT_SET_INT() is very old fashioned ;-) kn/cat-file-literally
   topic, which I expect would graduate to 'master' before this
   series would, updates all the existing ones to OPT_BOOL(), and
   following suit to match it would reduce the need to do an evil
   merge later.

 builtin/cat-file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 095554b..43338bb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -243,7 +243,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 
 	result = get_sha1_with_context(obj_name, flags, data->sha1, &ctx);
 	if (result != FOUND) {
-		switch(result) {
+		switch (result) {
 		case MISSING_OBJECT:
 			printf("%s missing\n", obj_name);
 			break;
@@ -358,7 +358,7 @@ static int batch_objects(struct batch_options *opt)
 
 static const char * const cat_file_usage[] = {
 	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
-	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
+	N_("git cat-file (--batch | --batch-check) [--follow-symlinks] < <list-of-objects>"),
 	NULL
 };
 
@@ -402,15 +402,14 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
-		OPT_SET_INT(0, "follow-symlinks", &batch.follow_symlinks,
-			N_("follow in-repo symlinks; report out-of-repo symlinks (requires --batch or --batch-check)"),
-			    1),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
 		{ OPTION_CALLBACK, 0, "batch-check", &batch, "format",
 			N_("show info about objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
+		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
+			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
 		OPT_END()
 	};
 
-- 
2.4.1-366-g03a772b
