Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A3BC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BB420643
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOSzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:55:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:48118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726170AbgEOSzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:55:35 -0400
Received: (qmail 26370 invoked by uid 109); 15 May 2020 18:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:55:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14436 invoked by uid 111); 15 May 2020 18:55:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:55:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:55:34 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/13] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 1
Message-ID: <20200515185534.GN3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515184716.GM3692649@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515184716.GM3692649@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 02:47:16PM -0400, Jeff King wrote:

> > While there are still a lot of static variables at the top of
> > 'upload-pack.c' after this patch series, it does a lot of ground work
> > and a number of cleanups.
> 
> Yeah, I think all of use_thin_pack, use_ofs_delta, etc, should be easy
> conversions on top (and will really give us the payoff).

Hmm, none of those fields in upload_pack_data are used, even for v2!
I.e., if I apply this patch:

    diff --git a/upload-pack.c b/upload-pack.c
    index 401c9e6c4b..522ae3ff6e 100644
    --- a/upload-pack.c
    +++ b/upload-pack.c
    @@ -91,10 +91,6 @@ struct upload_pack_data {
     
     	unsigned stateless_rpc : 1;
     
    -	unsigned use_thin_pack : 1;
    -	unsigned use_ofs_delta : 1;
    -	unsigned no_progress : 1;
    -	unsigned use_include_tag : 1;
     	unsigned done : 1;
     };
     

it still compiles. So starting to use those would be a behavior change,
as we accidentally let use_ofs_delta, etc, propagate from one v2 "fetch"
command to another for ssh/git/file connections (but not for http). I
think that's fixing a bug (but one nobody is likely to see, because it
would imply the client sending different capabilities for each request).

I think we'd want something like the patch below.

Some of the other globals, like multi_ack, are really v0 only (since v2
assumes certain baseline capabilities). We could either leave them
as-is, or roll them into upload_pack_data and just let v2 code ignore
them as it does now.

diff --git a/upload-pack.c b/upload-pack.c
index 401c9e6c4b..2fa645834a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -46,8 +46,7 @@ static timestamp_t oldest_have;
 
 static int multi_ack;
 static int no_done;
-static int use_thin_pack, use_ofs_delta, use_include_tag;
-static int no_progress, daemon_mode;
+static int daemon_mode;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -186,17 +185,17 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	}
 	argv_array_push(&pack_objects.args, "pack-objects");
 	argv_array_push(&pack_objects.args, "--revs");
-	if (use_thin_pack)
+	if (pack_data->use_thin_pack)
 		argv_array_push(&pack_objects.args, "--thin");
 
 	argv_array_push(&pack_objects.args, "--stdout");
 	if (shallow_nr)
 		argv_array_push(&pack_objects.args, "--shallow");
-	if (!no_progress)
+	if (!pack_data->no_progress)
 		argv_array_push(&pack_objects.args, "--progress");
-	if (use_ofs_delta)
+	if (pack_data->use_ofs_delta)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
-	if (use_include_tag)
+	if (pack_data->use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
 	if (pack_data->filter_options.choice) {
 		const char *spec =
@@ -955,17 +954,17 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "no-done"))
 			no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
-			use_thin_pack = 1;
+			data->use_thin_pack = 1;
 		if (parse_feature_request(features, "ofs-delta"))
-			use_ofs_delta = 1;
+			data->use_ofs_delta = 1;
 		if (parse_feature_request(features, "side-band-64k"))
 			use_sideband = LARGE_PACKET_MAX;
 		else if (parse_feature_request(features, "side-band"))
 			use_sideband = DEFAULT_PACKET_MAX;
 		if (parse_feature_request(features, "no-progress"))
-			no_progress = 1;
+			data->no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
-			use_include_tag = 1;
+			data->use_include_tag = 1;
 		if (allow_filter && parse_feature_request(features, "filter"))
 			filter_capability_requested = 1;
 
@@ -997,7 +996,7 @@ static void receive_needs(struct upload_pack_data *data,
 		check_non_tip(data);
 
 	if (!use_sideband && daemon_mode)
-		no_progress = 1;
+		data->no_progress = 1;
 
 	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
 		return;
@@ -1279,19 +1278,19 @@ static void process_args(struct packet_reader *request,
 
 		/* process args like thin-pack */
 		if (!strcmp(arg, "thin-pack")) {
-			use_thin_pack = 1;
+			data->use_thin_pack = 1;
 			continue;
 		}
 		if (!strcmp(arg, "ofs-delta")) {
-			use_ofs_delta = 1;
+			data->use_ofs_delta = 1;
 			continue;
 		}
 		if (!strcmp(arg, "no-progress")) {
-			no_progress = 1;
+			data->no_progress = 1;
 			continue;
 		}
 		if (!strcmp(arg, "include-tag")) {
-			use_include_tag = 1;
+			data->use_include_tag = 1;
 			continue;
 		}
 		if (!strcmp(arg, "done")) {
