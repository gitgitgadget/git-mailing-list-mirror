From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/18] rerere: explain "rerere forget" codepath
Date: Fri, 17 Jul 2015 15:24:33 -0700
Message-ID: <1437171880-21590-12-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE47-0004EM-GM
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185AbbGQWZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:03 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35420 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbGQWZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:00 -0400
Received: by pdrg1 with SMTP id g1so67946392pdr.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=GYxgk5E6AR+6SwUx2bFsLYOlo+XZ4v+sKRTgT/GWuA8=;
        b=Y59BuguflTdw91rlpCVh3pcE+YPrq9RIKBCZz/wZVbDXTn+ODZioylCEPyX8HjsiAB
         AaFIDcNjhAPa+dM3xkvPQ932yBXM4aQljM7EFdVs+CUVBymiIPrH3Y7nFQSz9ccRtT1N
         RDNDkVZ117e1RBaZoxy8j6Pogo7QdBRK5UtWAoZg3oz2vSIQNYXfjpaVjYMgBTCmfuX8
         6d3JAS9bDIO50wtsUtAxwnhu0P8KqZ6optgEGhPR4dc7Lf1/1qV67YBYHovhrBAZk14I
         OfQ1OvLzzgctll9ib/Hkf+DCZ9GhbOXwkhcuC3uJYSaf6klCjTdxqmsQzGAkpuJLmr18
         0NDw==
X-Received: by 10.68.141.232 with SMTP id rr8mr33128728pbb.7.1437171899732;
        Fri, 17 Jul 2015 15:24:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id ij17sm12394243pac.4.2015.07.17.15.24.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:59 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274116>

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
2.5.0-rc2-340-g0cccc16
