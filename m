From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 1/2] notes/pretty: allow callers to set the notes format from struct rev_info
Date: Tue, 26 Apr 2011 10:54:28 +0200
Message-ID: <cb2af8d1ef663a68ea96dbb916dcfa0aee71abcb.1303808057.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 10:54:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEe2Z-000103-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 10:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab1DZIyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 04:54:32 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53608 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279Ab1DZIyb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 04:54:31 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3061C205FB
	for <git@vger.kernel.org>; Tue, 26 Apr 2011 04:54:31 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 26 Apr 2011 04:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=ph9JQ77L4++RGR0Ujtc59xGxlyA=; b=hQxnQ/9BBeiHyHGGKvP+wEFwSCHULFt9yRxfiRrSLwCvCWb6hA4oiuGYWWLYC5HHx0ecebC41UyAvKJvewik/Rgmk0t88RSkhINGs9O7wPk3IPMQB/JSSnDudkIfveqmymNSCQz2XJQ0n2cdsj5jJegAjmpzmjUiOn41saNYIJ4=
X-Sasl-enc: x23hAOctSrth/I+dAAjPOxtObbn81CRQoFHda9YQlC8y 1303808070
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7FEDF404856;
	Tue, 26 Apr 2011 04:54:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172079>

The notes display format is customisable, but this possibility is hidden
from callers which go through struct rev_info's show_notes member and the
pretty-machinery.

Change the show_notes member to an int which determines the format, and
set it to NOTES_DEFAULT (which is NOTES_SHOW_HEADER | NOTES_INDENT)
where we set it to 1 before. This allows callers to choose a different
form.

The only form which cannot be chosen that way is "bare" (no indent, no
header) because "0" means "do not show notes" for this code path. But
current callers which need that (e.g. "%N" processing) call the notes
formatters directly instead. And for future callers which need to
request "bare" through rev_info's show_notes we can always introduce
another notes format flag NOTES_BARE when we need it.

No functional change with this commit.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/log.c |    2 +-
 notes.h       |    1 +
 pretty.c      |    2 +-
 revision.c    |    4 ++--
 revision.h    |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9db43ed..5e71caa 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -81,7 +81,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	userformat_find_requirements(NULL, &w);
 
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
-		rev->show_notes = 1;
+		rev->show_notes = NOTES_DEFAULT;
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
 
diff --git a/notes.h b/notes.h
index 83bd6e0..81d16e3 100644
--- a/notes.h
+++ b/notes.h
@@ -238,6 +238,7 @@ void free_notes(struct notes_tree *t);
 /* Flags controlling how notes are formatted */
 #define NOTES_SHOW_HEADER 1
 #define NOTES_INDENT 2
+#define NOTES_DEFAULT (NOTES_SHOW_HEADER | NOTES_INDENT)
 
 /*
  * Fill the given strbuf with the notes associated with the given object.
diff --git a/pretty.c b/pretty.c
index e1d8a8f..dc371a4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1271,7 +1271,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 
 	if (context->show_notes)
 		format_display_notes(commit->object.sha1, sb, encoding,
-				     NOTES_SHOW_HEADER | NOTES_INDENT);
+				     context->show_notes);
 
 	free(reencoded);
 }
diff --git a/revision.c b/revision.c
index 0f38364..f24ffb8 100644
--- a/revision.c
+++ b/revision.c
@@ -1366,11 +1366,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--show-notes")) {
-		revs->show_notes = 1;
+		revs->show_notes = NOTES_DEFAULT;
 		revs->show_notes_given = 1;
 	} else if (!prefixcmp(arg, "--show-notes=")) {
 		struct strbuf buf = STRBUF_INIT;
-		revs->show_notes = 1;
+		revs->show_notes = NOTES_DEFAULT;
 		revs->show_notes_given = 1;
 		if (!revs->notes_opt.extra_notes_refs)
 			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
diff --git a/revision.h b/revision.h
index 9fd8f30..e50eb49 100644
--- a/revision.h
+++ b/revision.h
@@ -84,9 +84,9 @@ struct rev_info {
 			always_show_header:1;
 
 	/* Format info */
+	unsigned int	show_notes;
 	unsigned int	shown_one:1,
 			show_merge:1,
-			show_notes:1,
 			show_notes_given:1,
 			pretty_given:1,
 			abbrev_commit:1,
-- 
1.7.5.270.gafca7
