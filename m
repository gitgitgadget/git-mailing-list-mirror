Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939F41F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfFTQir (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:38:47 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39999 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbfFTQiq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:38:46 -0400
Received: by mail-qk1-f202.google.com with SMTP id c1so4338760qkl.7
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3vUH0ayNmtnhK3Sm2/bdUw0LamMwoFqtqmHkcM8KVZ8=;
        b=lmvDqIoXX4f/19L/HaS3ey2Wj8/+ukkcnWRfacMRdS8+NFg56qouJkXzwoFF9UQeJb
         EXTdk5uXOiSAmlT4keK7XQBxu5QDKiLZoBebn9Au1+wDXLbiXH/mAyxgEbA8KKQSsmkI
         edh9VCBYApiE5RlSSQDsEmFxo99LVKvaG/nh9yeBCXcWwYTF1I1NF7ttmU4Xm2aSaf81
         KF/iVFQnsjnD82wN1fFxpbTlFG9qBK16ELZhyTLzpNmegWkcLGd+Nd6mqo+rqbMKb5HS
         uJLfMIrUOP1E94pePBFEdMaxrCsrqvIo8gtbYPKnC0BQlg9H5vCz0LJPrWku3AqHoauu
         /5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3vUH0ayNmtnhK3Sm2/bdUw0LamMwoFqtqmHkcM8KVZ8=;
        b=DF0MY80teN4xD+nufDULOyBhCsH54FFDG0In33ueM6nthRB4ezIZwBUDpQkv48VVn1
         YUuPUp7boQ2PqoFD39PAg7q6fMMMKp6yyF6mQAtJe8VmgQKSKA5ysyhvSW+ErHioA+L+
         c+PnZSUGERriOAuZuzrwbSXTn7SyHQ3pjVvuS2dNm+QN8pAfxje7nrjgaj9d5qFpjqx+
         DfaeY2K2tEfPVR9R7I0gOnZPZXl8EIntr46cY0WaqoKLurbQMrKCVHGnQq9dSt/S7OM3
         SuVoeSUQ0OYaclJGnZi14p/MXBCQLTCskbfKNw87KdC/HcO1DmnU04ha4rbih8G4b/MB
         GUmQ==
X-Gm-Message-State: APjAAAUbAzrPhk30r9h0sb7Pju+CUMR7iBmQ99JnEU3e9LDUrCS8pAoY
        Qb7NrwgAGXBI7qbscNA49qzGXwqRUxNg3ZtogzGYt+bG6n+DwzPLl1VWh4+X2+2PbM8a3XwwmBL
        3FrAH6agV/+4uXoQiI4yIiW1okKTrq2HzZp+x4hHPMJXMWdCq+6N8
X-Google-Smtp-Source: APXvYqxSObrAOercP/Ul4GSEGOB/E9oG90O34jzLve3b95IxS7kVoQ0s/+rJRNqPCFCdNbcPXveMoDfx
X-Received: by 2002:a37:b87:: with SMTP id 129mr87336730qkl.132.1561048725777;
 Thu, 20 Jun 2019 09:38:45 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:38:17 -0400
In-Reply-To: <20190620163820.231316-1-brho@google.com>
Message-Id: <20190620163820.231316-7-brho@google.com>
Mime-Version: 1.0
References: <20190620163820.231316-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 6/9] blame: optionally track line fingerprints during fill_blame_origin()
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
index 21ae76603f5c..49698a306e5a 100644
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
+static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
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
+		fill_origin_fingerprints(o, file);
 }
 
 static void drop_origin_blob(struct blame_origin *o)
 {
 	FREE_AND_NULL(o->file.ptr);
+	drop_origin_fingerprints(o);
 }
 
 /*
@@ -1141,8 +1190,10 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
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
@@ -1353,7 +1404,8 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, 0);
 	if (!file_p.ptr)
 		return;
 
@@ -1482,7 +1534,8 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p,
+					 &sb->num_read_blob, 0);
 			if (!file_p.ptr)
 				continue;
 
@@ -1822,37 +1875,14 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
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

