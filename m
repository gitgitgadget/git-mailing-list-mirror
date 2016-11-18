Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2325C1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 17:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbcKRR6y (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 12:58:54 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:51873 "EHLO
        homiemail-a101.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752522AbcKRR6u (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Nov 2016 12:58:50 -0500
Received: from homiemail-a101.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a101.g.dreamhost.com (Postfix) with ESMTP id E57DE117E07C;
        Fri, 18 Nov 2016 09:58:48 -0800 (PST)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a101.g.dreamhost.com (Postfix) with ESMTPSA id 525D3117E065;
        Fri, 18 Nov 2016 09:58:48 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net, spearce@spearce.org
Cc:     David Turner <dturner@twosigma.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] remote-curl: don't hang when a server dies before any output
Date:   Fri, 18 Nov 2016 12:58:39 -0500
Message-Id: <1479491919-12592-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the event that a HTTP server closes the connection after giving a
200 but before giving any packets, we don't want to hang forever
waiting for a response that will never come.  Instead, we should die
immediately.

One case where this happens is when attempting to fetch a dangling
object by SHA.

Prior to this patch, fetch-pack would wait for more data from the
server, and remote-curl would wait for fetch-pack, causing a deadlock.

Despite this patch, there is other possible malformed input that could
cause the same deadlock (e.g. a half-finished pktline, or a pktline but
no trailing flush).  There are a few possible solutions to this:

1. Allowing remote-curl to tell fetch-pack about the EOF (so that
fetch-pack could know that no more data is coming until it says
something else).  This is tricky because an out-of-band signal would
be required, or the http response would have to be re-framed inside
another layer of pkt-line or something.

2. Make remote-curl understand some of the protocol.  It turns out
that in addition to understanding pkt-line, it would need to watch for
ack/nak.  This is somewhat fragile, as information about the protocol
would end up in two places.  Also, pkt-lines which are already at the
length limit would need special handling.

Both of these solutions would require a fair amount of work, whereas
this hack is easy and solves at least some of the problem.

Still to do: it would be good to give a better error message
than "fatal: The remote end hung up unexpectedly".

Signed-off-by: David Turner <dturner@twosigma.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-curl.c               |  8 ++++++++
 t/t5551-http-fetch-smart.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index f14c41f..ee44236 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -400,6 +400,7 @@ struct rpc_state {
 	size_t pos;
 	int in;
 	int out;
+	int any_written;
 	struct strbuf result;
 	unsigned gzip_request : 1;
 	unsigned initial_buffer : 1;
@@ -456,6 +457,8 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 {
 	size_t size = eltsize * nmemb;
 	struct rpc_state *rpc = buffer_;
+	if (size)
+		rpc->any_written = 1;
 	write_or_die(rpc->in, ptr, size);
 	return size;
 }
@@ -659,6 +662,8 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
+
+	rpc->any_written = 0;
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
 		credential_fill(&http_auth);
@@ -667,6 +672,9 @@ static int post_rpc(struct rpc_state *rpc)
 	if (err != HTTP_OK)
 		err = -1;
 
+	if (!rpc->any_written)
+		err = -1;
+
 	curl_slist_free_all(headers);
 	free(gzip_body);
 	return err;
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 1ec5b27..43665ab 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -276,6 +276,36 @@ test_expect_success 'large fetch-pack requests can be split across POSTs' '
 	test_line_count = 2 posts
 '
 
+test_expect_success 'test allowreachablesha1inwant' '
+	test_when_finished "rm -rf test_reachable.git" &&
+	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
+	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
+
+	git init --bare test_reachable.git &&
+	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
+	git -C test_reachable.git fetch origin "$master_sha"
+'
+
+test_expect_success 'test allowreachablesha1inwant with unreachable' '
+	test_when_finished "rm -rf test_reachable.git; git reset --hard $(git rev-parse HEAD)" &&
+
+	#create unreachable sha
+	echo content >file2 &&
+	git add file2 &&
+	git commit -m two &&
+	git push public HEAD:refs/heads/doomed &&
+	git push public :refs/heads/doomed &&
+
+	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
+	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
+
+	git init --bare test_reachable.git &&
+	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
+	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
+'
+
 test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 	(
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-- 
2.8.0.rc4.22.g8ae061a

