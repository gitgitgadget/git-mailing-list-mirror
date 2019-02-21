Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B981F453
	for <e@80x24.org>; Thu, 21 Feb 2019 00:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBUAOv (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 19:14:51 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:47734 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUAOv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 19:14:51 -0500
Received: by mail-pl1-f202.google.com with SMTP id b10so8491073pla.14
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LTTTAwzoLNB2q/ICQM/l3fX1ULO9xa/fXrdUbe2L+Bw=;
        b=j8jk5nH2JYpYJWlituEQt0F1ifN0gk6+qJRAqdSSZ6JtgNPyd7Jn6Xbh0/7Ntv0BeG
         SSyejLr7Zb4PDpkyBu0CvbRGwF9UcXmDDXZfQhhKG48rtGOi9gtqS71syKmeXzuK8vjN
         QW+nrhAdgoadxM+BW0oWZnWGkohQZY6ERBqIaknXSQukI+4osVhODQEgF41h9FflfQxV
         d5LTxpX8DdkBUEXudEeO2iPMpI3rEPiElDUMk1dAydLTIZEVWARZP8b/ki7cLD5bCgTn
         u2ankUZFzuwr5dLLOzdHFWs23CSEb1WY2PgXwFdGx/dCAuo18Pw0UL5DINDh5WNaGoO7
         lk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LTTTAwzoLNB2q/ICQM/l3fX1ULO9xa/fXrdUbe2L+Bw=;
        b=aUV7cucIGx2CTHDkCCnOvFMWTCpt+meiGOSonAvVynlgJaLPZHZ+VFgNT2MF7+cVGF
         rmeo80XXDT8au26aAuxpMQNxNGEhP/CKXf0g32F/DGcIMuRRq/39QAKz0ZNQmsDfXaHC
         KTY2A+9jIIhShHWuMe0cKclXmdg3uxGyoHWfGFPLcwq4Q/vhAkXo9EjgmvYvnJN/Zojz
         cqkjmNXoJRCdOi8FYF0SIY6JGJyFFQ8z4QJvzA46Q9c//6SLhxhaSjEmyor/N3thdZN3
         3yiLD+f6y+51/AtsT2rYagzstj9HkguBQgqMDPTyqtPu21/ETB2UBRjZ/QEHciwXH095
         i/dA==
X-Gm-Message-State: AHQUAua0Kz4haHwvisE1qVooocWUEYRyaghUG7rAS4gn+l/DLQ/+9Bnq
        IMroZiLSmazstLDIKHivdVPwMu+BZ5y2iMxtRrKEY74bbeU1ESsVVuzyzpU5YMY89yVaIMnq4Ds
        ZHB7rCAKhy6dQ+/0UhGZNggIVBjXFkXNkKXoqNyTJTATsLbKBkD60xbSjUGOxcXI04JI+WN5ypI
        Un
X-Google-Smtp-Source: AHgI3IYYf7AHuyJ9rS2e50XVb6EeWhkBB1DlrDurN5Y6aqh/k9UQX1Mph2nSxVuAy3QZlmZGkzwBpJrkIDVPuqufoMqU
X-Received: by 2002:a62:a42:: with SMTP id s63mr13628718pfi.77.1550708090600;
 Wed, 20 Feb 2019 16:14:50 -0800 (PST)
Date:   Wed, 20 Feb 2019 16:14:47 -0800
Message-Id: <20190221001447.124088-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [RFC PATCH] http: use --stdin and --keep when downloading pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git fetches a pack using dumb HTTP, it does at least 2 things
differently from when it fetches using fetch-pack or receive-pack: (1)
it reuses the server's name for the packfile (which incorporates a hash)
for the packfile, and (2) it does not create a .keep file to avoid race
conditions with repack.

A subsequent patch will allow downloading packs over HTTP(S) as part of
a fetch. These downloads will not necessarily be from a Git repository,
and thus may not have a hash as part of its name. Also, generating a
.keep file will be necessary to avoid race conditions with repack (until
the fetch has successfully written the new refs).

Thus, teach http to pass --stdin and --keep to index-pack, the former so
that we have no reliance on the server's name for the packfile, and the
latter so that we have the .keep file.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is part of the work of CDN offloading of fetch responses.

I have plans to use the http_pack_request suite of functions to
implement the part where we download from CDN over HTTP(S), but need
this change to be able to do so. I think it's better from the code
quality perspective to reuse these functions, but this necessitates a
behavior change in that we no longer use the filename as declared by the
server, so I'm sending this as RFC to see what the community thinks.
---
 http-push.c   |  7 ++++++-
 http-walker.c |  5 ++++-
 http.c        | 42 ++++++++++++++++++++----------------------
 http.h        |  2 +-
 4 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/http-push.c b/http-push.c
index b22c7caea0..409b266b0c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -586,11 +586,16 @@ static void finish_request(struct transfer_request *request)
 			fprintf(stderr, "Unable to get pack file %s\n%s",
 				request->url, curl_errorstr);
 		} else {
+			char *lockfile;
+
 			preq = (struct http_pack_request *)request->userData;
 
 			if (preq) {
-				if (finish_http_pack_request(preq) == 0)
+				if (finish_http_pack_request(preq,
+							     &lockfile) == 0) {
+					unlink(lockfile);
 					fail = 0;
+				}
 				release_http_pack_request(preq);
 			}
 		}
diff --git a/http-walker.c b/http-walker.c
index 8ae5d76c6a..804dc82304 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -425,6 +425,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 	int ret;
 	struct slot_results results;
 	struct http_pack_request *preq;
+	char *lockfile;
 
 	if (fetch_indices(walker, repo))
 		return -1;
@@ -457,7 +458,9 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 		goto abort;
 	}
 
-	ret = finish_http_pack_request(preq);
+	ret = finish_http_pack_request(preq, &lockfile);
+	if (!ret)
+		unlink(lockfile);
 	release_http_pack_request(preq);
 	if (ret)
 		return ret;
diff --git a/http.c b/http.c
index a32ad36ddf..5f8e602cd2 100644
--- a/http.c
+++ b/http.c
@@ -2200,13 +2200,13 @@ void release_http_pack_request(struct http_pack_request *preq)
 	free(preq);
 }
 
-int finish_http_pack_request(struct http_pack_request *preq)
+int finish_http_pack_request(struct http_pack_request *preq, char **lockfile)
 {
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
-	char *tmp_idx;
-	size_t len;
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int tmpfile_fd;
+	int ret = 0;
 
 	close_pack_index(p);
 
@@ -2218,35 +2218,33 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (!strip_suffix(preq->tmpfile.buf, ".pack.temp", &len))
-		BUG("pack tmpfile does not end in .pack.temp?");
-	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile.buf);
+	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
 	argv_array_push(&ip.args, "index-pack");
-	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
-	argv_array_push(&ip.args, preq->tmpfile.buf);
+	argv_array_push(&ip.args, "--stdin");
+	argv_array_pushf(&ip.args, "--keep=git %"PRIuMAX, (uintmax_t)getpid());
 	ip.git_cmd = 1;
-	ip.no_stdin = 1;
-	ip.no_stdout = 1;
+	ip.in = tmpfile_fd;
+	ip.out = -1;
 
-	if (run_command(&ip)) {
-		unlink(preq->tmpfile.buf);
-		unlink(tmp_idx);
-		free(tmp_idx);
-		return -1;
+	if (start_command(&ip)) {
+		ret = -1;
+		goto cleanup;
 	}
 
-	unlink(sha1_pack_index_name(p->sha1));
+	*lockfile = index_pack_lockfile(ip.out);
+	close(ip.out);
 
-	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->sha1))
-	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
-		free(tmp_idx);
-		return -1;
+	if (finish_command(&ip)) {
+		ret = -1;
+		goto cleanup;
 	}
 
 	install_packed_git(the_repository, p);
-	free(tmp_idx);
-	return 0;
+cleanup:
+	close(tmpfile_fd);
+	unlink(preq->tmpfile.buf);
+	return ret;
 }
 
 struct http_pack_request *new_http_pack_request(
diff --git a/http.h b/http.h
index 4eb4e808e5..20d1c85d0b 100644
--- a/http.h
+++ b/http.h
@@ -212,7 +212,7 @@ struct http_pack_request {
 
 extern struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
-extern int finish_http_pack_request(struct http_pack_request *preq);
+int finish_http_pack_request(struct http_pack_request *preq, char **lockfile);
 extern void release_http_pack_request(struct http_pack_request *preq);
 
 /* Helpers for fetching object */
-- 
2.19.0.271.gfe8321ec05.dirty

