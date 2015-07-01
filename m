From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/13] rerere: explain "rerere forget" codepath
Date: Tue, 30 Jun 2015 23:04:57 -0700
Message-ID: <1435730699-9124-12-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:06:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9s-0004e5-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbGAGFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:44 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33633 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbbGAGFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:23 -0400
Received: by igcur8 with SMTP id ur8so82895865igc.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=MQUEtTmH/rhwgsEbFh6zp9T55UuyX/AoEw/BgDrMiHo=;
        b=iSMctDlnZTH+sb5TSsiQHEVD2DH9IjvBB8QMhN6zU4cZ7CEIG4P7Upt/VzK9YyAsmG
         118EUGIzPT3d5g66usxwINM9Yo/nOdGXDni/xj81Vys9dRuVwVPIWIx0WpkiXFPMvNhs
         957fR3wA5ps4h95gOJ+rQjevTcY0h5WoO/c4XmPYfg6FokcSbPGxKA5eibhz67lbRGax
         TkzY0OXDLaLIS6rw0T7zNtcoa1auNv+ozY7fcMwmpSWm0IVAX8GhuA0T0iFZbuMfX0JT
         knei7Dw5AkJk94QORmKAVy4FBG3nrPrCtOfGcgQfFWuxleqQwjdIosEOiBAXOp2NY0KY
         2d0Q==
X-Received: by 10.42.244.4 with SMTP id lo4mr1971184icb.65.1435730722454;
        Tue, 30 Jun 2015 23:05:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id 140sm685824ion.16.2015.06.30.23.05.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273128>

Explain the internals of rerere as in-code comments, while
sprinkling "NEEDSWORK" comment to highlight iffy bits and
questionable assumptions.

This covers the codepath that implements "rerere forget".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rerere.c b/rerere.c
index 3d9c33b..3782be6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -413,6 +413,10 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	strbuf_init(&io.input, 0);
 	strbuf_attach(&io.input, result.ptr, result.size, result.size);
 
+	/*
+	 * Grab the conflict ID and optionally write the original
+	 * contents with conflict markers out.
+	 */
 	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
 	strbuf_release(&io.input);
 	if (io.io.output)
@@ -777,9 +781,15 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	int ret;
 	struct string_list_item *item;
 
+	/*
+	 * Recreate the original conflict from the stages in the
+	 * index and compute the conflict ID
+	 */
 	ret = handle_cache(path, sha1, NULL);
 	if (ret < 1)
 		return error("Could not parse conflict hunks in '%s'", path);
+
+	/* Nuke the recorded resolution for the conflict */
 	hex = xstrdup(sha1_to_hex(sha1));
 	filename = rerere_path(hex, "postimage");
 	if (unlink(filename))
@@ -787,9 +797,18 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 			? error("no remembered resolution for %s", path)
 			: error("cannot unlink %s: %s", filename, strerror(errno)));
 
+	/*
+	 * Update the preimage so that the user can resolve the
+	 * conflict in the working tree, run us again to record
+	 * the postimage.
+	 */
 	handle_cache(path, sha1, rerere_path(hex, "preimage"));
 	fprintf(stderr, "Updated preimage for '%s'\n", path);
 
+	/*
+	 * And remember that we can record resolution for this
+	 * conflict when the user is done.
+	 */
 	item = string_list_insert(rr, path);
 	free(item->util);
 	item->util = hex;
@@ -808,6 +827,11 @@ int rerere_forget(struct pathspec *pathspec)
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
 
+	/*
+	 * The paths may have been resolved (incorrectly);
+	 * recover the original conflicted state and then
+	 * find the conflicted paths.
+	 */
 	unmerge_cache(pathspec);
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
-- 
2.5.0-rc0-209-g5e1f148
