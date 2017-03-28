Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92051FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755847AbdC1TrL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:47:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbdC1TrK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:47:10 -0400
Received: (qmail 11813 invoked by uid 109); 28 Mar 2017 19:46:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:59 +0000
Received: (qmail 7887 invoked by uid 111); 28 Mar 2017 19:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:47:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:56 -0400
Date:   Tue, 28 Mar 2017 15:46:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 15/18] convert unchecked snprintf into xsnprintf
Message-ID: <20170328194656.d4sgj67psmpnnmua@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These calls to snprintf should always succeed, because their
input is small and fixed. Let's use xsnprintf to make sure
this is the case (and to make auditing for actual truncation
easier).

These could be candidates for turning into heap buffers, but
they fall into a few broad categories that make it not worth
doing:

  - formatting single numbers is simple enough that we can
    see the result should fit

  - the size of a sha1 is likewise well-known, and I didn't
    want to cause unnecessary conflicts with the ongoing
    process to convert these constants to GIT_MAX_HEXSZ

  - the interface for curl_errorstr is dictated by curl

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c      |  4 ++--
 http.c      | 10 +++++-----
 imap-send.c |  2 +-
 sha1_file.c |  4 ++--
 submodule.c |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/grep.c b/grep.c
index 0dbdc1d00..39b4b60d2 100644
--- a/grep.c
+++ b/grep.c
@@ -1164,7 +1164,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	}
 	if (opt->linenum) {
 		char buf[32];
-		snprintf(buf, sizeof(buf), "%d", lno);
+		xsnprintf(buf, sizeof(buf), "%d", lno);
 		output_color(opt, buf, strlen(buf), opt->color_lineno);
 		output_sep(opt, sign);
 	}
@@ -1651,7 +1651,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				     opt->color_filename);
 			output_sep(opt, ':');
 		}
-		snprintf(buf, sizeof(buf), "%u\n", count);
+		xsnprintf(buf, sizeof(buf), "%u\n", count);
 		opt->output(opt, buf, strlen(buf));
 		return 1;
 	}
diff --git a/http.c b/http.c
index 96d84bbed..8d94e2c63 100644
--- a/http.c
+++ b/http.c
@@ -1366,9 +1366,9 @@ static int handle_curl_result(struct slot_results *results)
 		 * FAILONERROR it is lost, so we can give only the numeric
 		 * status code.
 		 */
-		snprintf(curl_errorstr, sizeof(curl_errorstr),
-			 "The requested URL returned error: %ld",
-			 results->http_code);
+		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
+			  "The requested URL returned error: %ld",
+			  results->http_code);
 	}
 
 	if (results->curl_result == CURLE_OK) {
@@ -1410,8 +1410,8 @@ int run_one_slot(struct active_request_slot *slot,
 {
 	slot->results = results;
 	if (!start_active_slot(slot)) {
-		snprintf(curl_errorstr, sizeof(curl_errorstr),
-			 "failed to start HTTP request");
+		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
+			  "failed to start HTTP request");
 		return HTTP_START_FAILED;
 	}
 
diff --git a/imap-send.c b/imap-send.c
index 5c7e27a89..857591660 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -964,7 +964,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 		int gai;
 		char portstr[6];
 
-		snprintf(portstr, sizeof(portstr), "%d", srvc->port);
+		xsnprintf(portstr, sizeof(portstr), "%d", srvc->port);
 
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_socktype = SOCK_STREAM;
diff --git a/sha1_file.c b/sha1_file.c
index 71063890f..43990dec7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3762,8 +3762,8 @@ static int for_each_file_in_obj_subdir(int subdir_nr,
 			char hex[GIT_SHA1_HEXSZ+1];
 			struct object_id oid;
 
-			snprintf(hex, sizeof(hex), "%02x%s",
-				 subdir_nr, de->d_name);
+			xsnprintf(hex, sizeof(hex), "%02x%s",
+				  subdir_nr, de->d_name);
 			if (!get_oid_hex(hex, &oid)) {
 				if (obj_cb) {
 					r = obj_cb(&oid, path->buf, data);
diff --git a/submodule.c b/submodule.c
index 3200b7bb2..e11ea7d0a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1221,7 +1221,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	memset(&rev_opts, 0, sizeof(rev_opts));
 
 	/* get all revisions that merge commit a */
-	snprintf(merged_revision, sizeof(merged_revision), "^%s",
+	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 			oid_to_hex(&a->object.oid));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
-- 
2.12.2.845.g55fcf8b10

