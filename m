Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 279AD1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 21:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758726AbcLUVdG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:33:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61807 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758663AbcLUVdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:33:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D1ED58BFC;
        Wed, 21 Dec 2016 16:33:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fpuv7xa/qWlnorM1OHLFIb1fH+o=; b=aB5Yyr
        O7logrS5yj5id8p0kI/wsGNaL9NYwLeNYTkQkaIMXL+f+68wdxYa0402MTLw632g
        HITO1EPY4GcgTBRb6icy14fp9lwuD//1+K3P/3if7jF5CIsgShWU3MTcYd+rtJkU
        /DK3EHKc0DsRY9TnNPVak45Q4AwXEBKey2rJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1vrHuxLu0OdUDm36b0deOvPwWGOV1Ta
        3yILWwq5Ext0VPWfwkauErxOMPWMRlukuXY/amUe1SAcDQC5WTcJWsqKgku5WMsT
        EkXRXOafJCwtsbGdpFiySf+31j9Gcwo41ji+gutYREy2RpeekYOPg7Ov9wc1cdrh
        nPJS3oQRLjQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12C9158BFB;
        Wed, 21 Dec 2016 16:33:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAF1158BF9;
        Wed, 21 Dec 2016 16:33:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kai Zhang <kai@netskope.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: Git pull hang occasionally
References: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com>
        <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Dec 2016 13:32:59 -0800
In-Reply-To: <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 21 Dec 2016 12:59:27 -0800")
Message-ID: <xmqqshphge7o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C322216-C7C5-11E6-AA86-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> And the unexpected discrepancy is reported by find_symref() as
> fatal.  The server side dies, and somehow that fact is lost between
> the upload-pack process and the client and somebody in the middle
> (e.g. fastcgi interface or nginx webserver on the server side, or
> the remote-curl helper on the client side) keeps the "git fetch"
> process waiting.
>
> So there seem to be two issues.  
>
>  - Because of the unlocked read, find_symref() can observe an
>    inconsistent state.  Perhaps it should be updated not to die but
>    to retry, expecting that transient inconsistency will go away.
>
>  - A fatal error in upload-pack is not reported back to the client
>    to cause it exit is an obvious one, and even if we find a way to
>    make this fatal error in find_symref() not to trigger, fatal
>    errors in other places in the code can trigger the same symptom.

I wonder if the latter is solved by recent patch 296b847c0d
("remote-curl: don't hang when a server dies before any output",
2016-11-18) on the client side.

-- >8 --
From: David Turner <dturner@twosigma.com>
Date: Fri, 18 Nov 2016 15:30:49 -0500
Subject: [PATCH] remote-curl: don't hang when a server dies before any output

In the event that a HTTP server closes the connection after giving a
200 but before giving any packets, we don't want to hang forever
waiting for a response that will never come.  Instead, we should die
immediately.

One case where this happens is when attempting to fetch a dangling
object by its object name.  In this case, the server dies before
sending any data.  Prior to this patch, fetch-pack would wait for
data from the server, and remote-curl would wait for fetch-pack,
causing a deadlock.

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
index f14c41f4c0..ee4423659f 100644
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
index 1ec5b2747a..43665ab4a8 100755
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
2.11.0-442-g0c85c54a77

