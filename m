From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 5/9] builtin/notes: Simplify early exit code in add()
Date: Sun,  9 Nov 2014 13:30:51 +0100
Message-ID: <1415536255-19961-6-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnReZ-00085I-JK
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaKIMbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:19 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36036 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbaKIMbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:12 -0500
Received: by mail-lb0-f176.google.com with SMTP id 10so4668152lbg.35
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/B8t1fWd7azbKBEgQJn+0+SxthX4ZI5O9Cd1QwWXfSo=;
        b=kzPmYPig5qFkNLrGlA8diEvBRwKdAULLZaLYs05A5PqfNLy94gUnM8BRmil0k6ybKu
         Rz2ClxHHATkMsPn2H0IRnRsVdDNM1N9ubqV2UGlB5GYotVCeN3NAK4mWaDDYxAZFNQmR
         jaAniUgWZt6nAbdI1+f1iGmtQqjxXhns4HeMKoUyXfcERlwMR8tRH/91jekeYAvTchU0
         UB/wgaFLs9dATQ2VsfqP1xQrkpsRLxKLf9obCTUF09IRrg4fpImbXaccfEtuaKpBOhBG
         3p6MKBN2nHH1Ffn6AhtWUqInmfzgZFroZHEpnZF0KI002o7GOY240nD+1dyE+zajHkNm
         CWrw==
X-Received: by 10.152.20.130 with SMTP id n2mr8253243lae.39.1415536270788;
        Sun, 09 Nov 2014 04:31:10 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:09 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 1017472..f1480cf 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -399,7 +399,7 @@ static int append_edit(int argc, const char **argv, const char *prefix);
 
 static int add(int argc, const char **argv, const char *prefix)
 {
-	int retval = 0, force = 0;
+	int force = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
@@ -441,6 +441,8 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (note) {
 		if (!force) {
+			free_note_data(&d);
+			free_notes(t);
 			if (!d.given) {
 				/*
 				 * Redirect to "edit" subcommand.
@@ -450,14 +452,11 @@ static int add(int argc, const char **argv, const char *prefix)
 				 * therefore still in argv[0-1].
 				 */
 				argv[0] = "edit";
-				free_note_data(&d);
-				free_notes(t);
 				return append_edit(argc, argv, prefix);
 			}
-			retval = error(_("Cannot add notes. Found existing notes "
+			return error(_("Cannot add notes. Found existing notes "
 				       "for object %s. Use '-f' to overwrite "
 				       "existing notes"), sha1_to_hex(object));
-			goto out;
 		}
 		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
 			sha1_to_hex(object));
@@ -474,9 +473,8 @@ static int add(int argc, const char **argv, const char *prefix)
 	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
 		 is_null_sha1(new_note) ? "removed" : "added", "add");
 	commit_notes(t, logmsg);
-out:
 	free_notes(t);
-	return retval;
+	return 0;
 }
 
 static int copy(int argc, const char **argv, const char *prefix)
-- 
2.1.1.392.g062cc5d
