From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 5/9] builtin/notes: Simplify early exit code in add()
Date: Wed, 12 Nov 2014 01:40:12 +0100
Message-ID: <1415752816-22782-6-git-send-email-johan@herland.net>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLzS-0005vi-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbaKLAkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:40:41 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:51784 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbaKLAkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:39 -0500
Received: by mail-lb0-f179.google.com with SMTP id l4so8575621lbv.10
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XY2XIqrQ0TthJAvqVNbCf1WRQHs1wsMGk/zanFtHWNo=;
        b=ivNBY6GrKIKGcmztj5DRLuW+WfJSDFNGnPW3yZc3o7QriqyqS/QURhNt5TXWsuBBkR
         YHmEhJnooFUvSQHST4h4J+KPqcqadV3GWmBUS90Ic8dwCeLlpljTvLsPt3Bbjoek5U2x
         MB6MH+1XScvHx9NHVZbB0wW/aPmyhfTkTeVElqlPeRLwJ6EChZ8KZNo0cgGGu7+/46kF
         hxKhVIoYxvotJ1VULFTO1jVAQ5uFnlKLse8vUxU45PPzddOFkxlJmfP8biFkTyVw/LOi
         ewFUx9t16y6c4jtHeyjK3JPr2pIwJ1HLQv3UCLIDJ/xtCTitE1s0Bms+UrS55H3dYrqs
         Bobg==
X-Received: by 10.112.169.106 with SMTP id ad10mr39040196lbc.13.1415752837611;
        Tue, 11 Nov 2014 16:40:37 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:36 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415752816-22782-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the need for 'retval' and the unnecessary goto. Also reorganize
to only call free_note_data() is actually needed.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 1017472..acdedbd 100644
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
@@ -441,23 +441,23 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	if (note) {
 		if (!force) {
-			if (!d.given) {
-				/*
-				 * Redirect to "edit" subcommand.
-				 *
-				 * We only end up here if none of -m/-F/-c/-C
-				 * or -f are given. The original args are
-				 * therefore still in argv[0-1].
-				 */
-				argv[0] = "edit";
+			free_notes(t);
+			if (d.given) {
 				free_note_data(&d);
-				free_notes(t);
-				return append_edit(argc, argv, prefix);
+				return error(_("Cannot add notes. "
+					"Found existing notes for object %s. "
+					"Use '-f' to overwrite existing notes"),
+					sha1_to_hex(object));
 			}
-			retval = error(_("Cannot add notes. Found existing notes "
-				       "for object %s. Use '-f' to overwrite "
-				       "existing notes"), sha1_to_hex(object));
-			goto out;
+			/*
+			 * Redirect to "edit" subcommand.
+			 *
+			 * We only end up here if none of -m/-F/-c/-C or -f are
+			 * given. The original args are therefore still in
+			 * argv[0-1].
+			 */
+			argv[0] = "edit";
+			return append_edit(argc, argv, prefix);
 		}
 		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
 			sha1_to_hex(object));
@@ -474,9 +474,8 @@ static int add(int argc, const char **argv, const char *prefix)
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
2.0.0.rc4.501.gdaf83ca
