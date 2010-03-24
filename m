From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 4/7] fmt-merge-msg: use pretty.c routines
Date: Wed, 24 Mar 2010 00:16:01 -0700
Message-ID: <1269414964-9518-5-git-send-email-bebarino@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:17:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpw-0006wZ-SH
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab0CXHQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44767 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab0CXHQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:18 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so1867821gwa.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CDGVRxj3Nog65DPn8Sc/YNASeS8dIsWSaArcUm9yL1c=;
        b=soTZnR4wOMVBeUWoNIgIOfQ+pgO2cH9uifOl4GK+S/T2jvHjsWON+ZEtTsTGvPGLQD
         f/Z+ZGXd0LMh+kVMLgCe87UxqNQ0q98TIlb7vtFWwG/MCzHW/ZYDYhcwxUY0Qc3rQEEr
         pyw7V2/BjJVT3DLMP8RFw4UYQbuo2uLyHa7Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P/vYRu6uSe6hjV9QveTPARuT6XtRlTj2A/qSWKdlHa4VuxIRnbOShIWslxn/327Zx6
         bWOb42hG8rk507xk7J8ahfAjFZBoj/IIfOpEXdJ3mT5BfFh32yVYtZnOvjvMviAdMbe8
         cXeW6ojIUWw4rs19Ak5hw5Af/FrpAh6vTlg2U=
Received: by 10.101.134.13 with SMTP id l13mr8966829ann.160.1269414977747;
        Wed, 24 Mar 2010 00:16:17 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm5237492iwn.0.2010.03.24.00.16.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
In-Reply-To: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143069>

This command duplicates functionality of the '%s' pretty format.
Simplify the code a bit by using the pretty printing routine
instead of open-coding it here.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin/fmt-merge-msg.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 9bb2625..44b74f4 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -185,6 +185,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	struct object *branch;
 	struct list subjects = { NULL, NULL, 0, 0 };
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
+	struct strbuf sb = STRBUF_INIT;
 
 	branch = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
 	if (!branch || branch->type != OBJ_COMMIT)
@@ -198,7 +199,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	if (prepare_revision_walk(rev))
 		die("revision walk setup failed");
 	while ((commit = get_revision(rev)) != NULL) {
-		char *oneline, *bol, *eol;
+		struct pretty_print_context ctx = {0};
 
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
@@ -208,30 +209,16 @@ static void shortlog(const char *name, unsigned char *sha1,
 		if (subjects.nr > limit)
 			continue;
 
-		bol = strstr(commit->buffer, "\n\n");
-		if (bol) {
-			unsigned char c;
-			do {
-				c = *++bol;
-			} while (isspace(c));
-			if (!c)
-				bol = NULL;
-		}
+		format_commit_message(commit, "%s", &sb, &ctx);
+		strbuf_ltrim(&sb);
 
-		if (!bol) {
+		if (!sb.len)
 			append_to_list(&subjects, xstrdup(sha1_to_hex(
 							commit->object.sha1)),
 					NULL);
-			continue;
-		}
-
-		eol = strchr(bol, '\n');
-		if (eol) {
-			oneline = xmemdupz(bol, eol - bol);
-		} else {
-			oneline = xstrdup(bol);
-		}
-		append_to_list(&subjects, oneline, NULL);
+		else
+			append_to_list(&subjects, strbuf_detach(&sb, NULL),
+					NULL);
 	}
 
 	if (count > limit)
-- 
1.7.0.3.254.g4503b
