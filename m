Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29ABC77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjEAWkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAWkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:40:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D910FD
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:40:39 -0700 (PDT)
Received: (qmail 15901 invoked by uid 109); 1 May 2023 22:40:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 May 2023 22:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4857 invoked by uid 111); 1 May 2023 22:40:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 May 2023 18:40:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 May 2023 18:40:38 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH v2 1/1] upload-pack: advertise capabilities when cloning
 empty repos
Message-ID: <20230501224038.GA1174291@coredump.intra.peff.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230501170018.1410567-1-sandals@crustytoothpaste.net>
 <20230501170018.1410567-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230501170018.1410567-2-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2023 at 05:00:18PM +0000, brian m. carlson wrote:

> There is one minor issue to fix, though.  When we call send_ref with
> namespaces, we would return NULL with the capabilities entry, which
> would cause a crash.  Instead, let's make sure we don't try to strip the
> namespace if we're using our special capabilities entry.

Thanks, this hunk:

> @@ -1212,7 +1213,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	static const char *capabilities = "multi_ack thin-pack side-band"
>  		" side-band-64k ofs-delta shallow deepen-since deepen-not"
>  		" deepen-relative no-progress include-tag multi_ack_detailed";
> -	const char *refname_nons = strip_namespace(refname);
> +	const char *refname_nons = !strcmp(refname, "capabilities^{}") ?
> +				   refname : strip_namespace(refname);
>  	struct object_id peeled;
>  	struct upload_pack_data *data = cb_data;

looks much better than sticking it in strip_namespace() as I did
earlier. I did wonder about refactoring further:

diff --git a/upload-pack.c b/upload-pack.c
index d7b31d0527..e1d75d7c3c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1207,19 +1207,17 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 		strbuf_addf(buf, " session-id=%s", trace2_session_id());
 }
 
-static int send_ref(const char *refname, const struct object_id *oid,
-		    int flag UNUSED, void *cb_data)
+static void write_v0_ref(struct upload_pack_data *data,
+			 const char *refname, const char *refname_nons,
+			 const struct object_id *oid)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
 		" deepen-relative no-progress include-tag multi_ack_detailed";
-	const char *refname_nons = !strcmp(refname, "capabilities^{}") ?
-				   refname : strip_namespace(refname);
 	struct object_id peeled;
-	struct upload_pack_data *data = cb_data;
 
 	if (mark_our_ref(refname_nons, refname, oid, &data->hidden_refs))
-		return 0;
+		return;
 
 	if (capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
@@ -1249,6 +1247,12 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	capabilities = NULL;
 	if (!peel_iterated_oid(oid, &peeled))
 		packet_fwrite_fmt(stdout, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+}
+
+static int send_ref(const char *refname, const struct object_id *oid,
+		    int flag UNUSED, void *cb_data)
+{
+	write_v0_ref(cb_data, refname, strip_namespace(refname), oid);
 	return 0;
 }
 
@@ -1382,8 +1386,10 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
-		if (!data.sent_capabilities)
-			send_ref("capabilities^{}", null_oid(), 0, &data);
+		if (!data.sent_capabilities) {
+			const char *ref = "capabilities^{}";
+			write_v0_ref(&data, ref, ref, null_oid());
+		}
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
 		 * uses stdio.

which avoids doing an extra strcmp() on every ref. But probably it is
not that big a deal either way.

> Add several sets of tests for HTTP as well as for local clones.

This part puzzled me a bit. There's a local test in t5700, which is
good. But it also gets HTTP tests. What do they offer versus the ones in
t5551 (or vice versa)?

-Peff
