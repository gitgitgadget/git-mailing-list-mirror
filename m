Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB71D1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfGAOqS (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:46:18 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42024 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfGAOqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:46:18 -0400
Received: by mail-qt1-f201.google.com with SMTP id t11so13595541qtc.9
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hXhYjjwH+No4/Tii6V72pYX+PuxVipV3UqlX6/QyWZE=;
        b=UeP6RLIUhrFtMrsy4o1vPUvBZB/lQEB2s8fd/ufZugH7fVDK+blqwPStS7jgsvp6j5
         bPV+WHIMlpy7I8H+rNpOUpU40ykjDU8qGESqTSKzwDC/C9ktZufEtbRGHguG1Ulol/cf
         jaxzUL3vLlkFckKkifaWc3KB20wqPGtVoGj1DRGSWCWOvezfvF18ACiRmO7XxagQyJB2
         L7gaisg38Ni5wBpio0uxQuxLxpqgimxUi7sbg8jmdMFc23kfUIKoPAEuRtVewTR2qxZU
         LBDT83pmBqOQT7Dy/Ub5U/iRUihpdr9mx2HE3T7l+4PRmoJNyRApTYY2RJ4hfdLOQcf/
         aBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hXhYjjwH+No4/Tii6V72pYX+PuxVipV3UqlX6/QyWZE=;
        b=QzdNj/oWCXZprdHVEuVJ4I1wb389+QdSOcPqs2hpk23cwTegP8Fky5CNdPYdq8Vc89
         rG5dIQ/RMQgDxbFsz2YW63b4mu8/QXilZgUlkfIuf3BLG1tQA9gZ94KGk0BVlc4KNshd
         7eZK0K/YgZFmdJ8yF1TNeo4bdUNBZEeSY5F0U2DvZYLPMDgk3RzoIsbpnXnrMZHRU6TF
         NCftJd9pzRtht3YL6ut3CIiaESgmU0tjr48wa+WwII/1NgUaVPu0BHvU9mMpiUUrffOO
         ztvHeGvep9+4bjJkOu35znh8Vc4Z03NZlNuNTaPZ4YKrx9uSjQadpfgpyOFGqV4TclBY
         4aaw==
X-Gm-Message-State: APjAAAUUAQcvQYnjVirEaq04K4babXespOmGvsXVoZcQBheKrkr29hGy
        qkPCeH9ct4nNi/Jzg3wG6R37wtI6wns/ldNC9JDMUiyMnusofgHRwkJPo0GxeRoDPiVd0jYjsNM
        i1l3cXTSWfwiwoWCrVx7p/3BKPwB3atpJBST7XSuijq7XuzXHZzGJ
X-Google-Smtp-Source: APXvYqxaxNJuvIwB2ITGXAQtJeJwlklB2QKSyY04qVx73VyEUkTbyWUZ5HBw8W/8VqBZV1Uk3IyOiE7L
X-Received: by 2002:a0c:b5c7:: with SMTP id o7mr21353520qvf.220.1561992377062;
 Mon, 01 Jul 2019 07:46:17 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:45:45 -0400
In-Reply-To: <20190701144548.129635-1-brho@google.com>
Message-Id: <20190701144548.129635-7-brho@google.com>
Mime-Version: 1.0
References: <20190701144548.129635-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v10 6/9] blame: optionally track line fingerprints during fill_blame_origin()
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     Michael Platings <michael@platin.gs>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fill_blame_origin() is a convenient place to store data that we will use
throughout the lifetime of a blame_origin.  Some heuristics for
ignoring commits during a blame session can make use of this storage.
In particular, we will calculate a fingerprint for each line of a file
for blame_origins involved in an ignored commit.

In this commit, we only calculate the line_starts, reusing the existing
code from the scoreboard's line_starts.  In an upcoming commit, we will
actually compute the fingerprints.

This feature will be used when we attempt to pass blame entries to
parents when we "ignore" a commit.  Most uses of fill_blame_origin()
will not require this feature, hence the flag parameter.  Multiple calls
to fill_blame_origin() are idempotent, and any of them can request the
creation of the fingerprints structure.

Suggested-by: Michael Platings <michael@platin.gs>
Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c | 90 ++++++++++++++++++++++++++++++++++++++-------------------
 blame.h |  2 ++
 2 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/blame.c b/blame.c
index 4bc19750dd3c..0ae2f18048fe 100644
--- a/blame.c
+++ b/blame.c
@@ -311,12 +311,58 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
 	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
 }
 
+static const char *get_next_line(const char *start, const char *end)
+{
+	const char *nl = memchr(start, '\n', end - start);
+
+	return nl ? nl + 1 : end;
+}
+
+static int find_line_starts(int **line_starts, const char *buf,
+			    unsigned long len)
+{
+	const char *end = buf + len;
+	const char *p;
+	int *lineno;
+	int num = 0;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		num++;
+
+	ALLOC_ARRAY(*line_starts, num + 1);
+	lineno = *line_starts;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		*lineno++ = p - buf;
+
+	*lineno = len;
+
+	return num;
+}
+
+static void fill_origin_fingerprints(struct blame_origin *o)
+{
+	int *line_starts;
+
+	if (o->fingerprints)
+		return;
+	o->num_lines = find_line_starts(&line_starts, o->file.ptr,
+					o->file.size);
+	/* TODO: Will fill in fingerprints in a future commit */
+	free(line_starts);
+}
+
+static void drop_origin_fingerprints(struct blame_origin *o)
+{
+}
+
 /*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
+			     struct blame_origin *o, mmfile_t *file,
+			     int *num_read_blob, int fill_fingerprints)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -340,11 +386,14 @@ static void fill_origin_blob(struct diff_options *opt,
 	}
 	else
 		*file = o->file;
+	if (fill_fingerprints)
+		fill_origin_fingerprints(o);
 }
 
 static void drop_origin_blob(struct blame_origin *o)
 {
 	FREE_AND_NULL(o->file.ptr);
+	drop_origin_fingerprints(o);
 }
 
 /*
@@ -1140,8 +1189,10 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, ignore_diffs);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o,
+			 &sb->num_read_blob, ignore_diffs);
 	sb->num_get_patch++;
 
 	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
@@ -1352,7 +1403,8 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, 0);
 	if (!file_p.ptr)
 		return;
 
@@ -1481,7 +1533,8 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p,
+					 &sb->num_read_blob, 0);
 			if (!file_p.ptr)
 				continue;
 
@@ -1821,37 +1874,14 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 	}
 }
 
-static const char *get_next_line(const char *start, const char *end)
-{
-	const char *nl = memchr(start, '\n', end - start);
-	return nl ? nl + 1 : end;
-}
-
 /*
  * To allow quick access to the contents of nth line in the
  * final image, prepare an index in the scoreboard.
  */
 static int prepare_lines(struct blame_scoreboard *sb)
 {
-	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
-	const char *end = buf + len;
-	const char *p;
-	int *lineno;
-	int num = 0;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		num++;
-
-	ALLOC_ARRAY(sb->lineno, num + 1);
-	lineno = sb->lineno;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		*lineno++ = p - buf;
-
-	*lineno = len;
-
-	sb->num_lines = num;
+	sb->num_lines = find_line_starts(&sb->lineno, sb->final_buf,
+					 sb->final_buf_size);
 	return sb->num_lines;
 }
 
diff --git a/blame.h b/blame.h
index 2458b68f0e22..4a9e1270b036 100644
--- a/blame.h
+++ b/blame.h
@@ -51,6 +51,8 @@ struct blame_origin {
 	 */
 	struct blame_entry *suspects;
 	mmfile_t file;
+	int num_lines;
+	void *fingerprints;
 	struct object_id blob_oid;
 	unsigned short mode;
 	/* guilty gets set when shipping any suspects to the final
-- 
2.22.0.410.gd8fdbe21b5-goog

