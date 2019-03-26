Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E76520248
	for <e@80x24.org>; Tue, 26 Mar 2019 05:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfCZFUO (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 01:20:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:36030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725308AbfCZFUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 01:20:13 -0400
Received: (qmail 8505 invoked by uid 109); 26 Mar 2019 05:20:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 05:20:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14974 invoked by uid 111); 26 Mar 2019 05:20:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 01:20:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 01:20:11 -0400
Date:   Tue, 26 Mar 2019 01:20:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch-pack: respect --no-update-shallow in v2
Message-ID: <20190326052011.GB1933@sigill.intra.peff.net>
References: <cover.1553546216.git.jonathantanmy@google.com>
 <c4d2f409e246cce02ebfdb8c7110e3700d066ec8.1553546216.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4d2f409e246cce02ebfdb8c7110e3700d066ec8.1553546216.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 01:43:23PM -0700, Jonathan Tan wrote:

> In protocol v0, when sending "shallow" lines, the server distinguishes
> between lines caused by the remote repo being shallow and lines caused
> by client-specified depth settings. Unless "--update-shallow" is
> specified, there is a difference in behavior: refs that reach the former
> "shallow" lines, but not the latter, are rejected. But in v2, the server
> does not, and the client treats all "shallow" lines like lines caused by
> client-specified depth settings.
> 
> Full restoration of v0 functionality is not possible without protocol
> change,

That's rather unfortunate. Is this because the v2 ls-refs phase is
separate, and that's when a v0 server would tell us about its shallows?
It looks like in v2 it comes in a separate "shallow-info" section.

What would the protocol change look like?  Would we just need a
capability to instruct the server to mark the two different types of
shallow distinctly? Or do we actually need to convey the information
separately (e.g., in the ls-refs phase)?

None of that matters for your patch here, but I'm just wondering what
the path forward is.

> but we can implement a heuristic: if we specify any depth
> setting, treat all "shallow" lines like lines caused by client-specified
> depth settings (that is, unaffected by "--no-update-shallow"), but
> otherwise, treat them like lines caused by the remote repo being shallow
> (that is, affected by "--no-update-shallow"). This restores most of v0
> behavior, except in the case where a client fetches from a shallow
> repository with depth settings.

That seems like the best we can do without the protocol change. And even
if we adjust the protocol, we need some fallback behavior for existing
v2 servers, so this is worth doing.

>  fetch-pack.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)

The patch looks reasonable to me, though I am far from an expert on the
shallow bits of the protocol. One thing I did notice:

>  static void receive_shallow_info(struct fetch_pack_args *args,
> -				 struct packet_reader *reader)
> +				 struct packet_reader *reader,
> +				 struct shallow_info *si)
>  {
> -	int line_received = 0;
> +	struct oid_array *shallows;
> +	int unshallow_received = 0;
> +
> +	shallows = xcalloc(1, sizeof(*shallows));

This has to be heap-allocated, since we pass off ownership to "si"
(sometimes). But in the v0 case, it comes from the transport's
&data->shallows of a local variable in cmd_fetch_pack(), and we never
free it. So I think this oid_array ends up getting leaked.

Perhaps it's worth passing down the shallows array we get from the
caller of fetch_pack(). Something like the patch below (I think it is
never NULL, which means in your patch 1 you can simplify the conditional
for the BUG).

diff --git a/fetch-pack.c b/fetch-pack.c
index 672c79c91a..af2ee47a83 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1254,13 +1254,11 @@ static int process_acks(struct fetch_negotiator *negotiator,
 
 static void receive_shallow_info(struct fetch_pack_args *args,
 				 struct packet_reader *reader,
+				 struct oid_array *shallows,
 				 struct shallow_info *si)
 {
-	struct oid_array *shallows;
 	int unshallow_received = 0;
 
-	shallows = xcalloc(1, sizeof(*shallows));
-
 	process_section_header(reader, "shallow-info", 0);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		const char *arg;
@@ -1303,7 +1301,6 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		for (i = 0; i < shallows->nr; i++)
 			register_shallow(the_repository, &shallows->oid[i]);
 		oid_array_clear(shallows);
-		free(shallows);
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
 		args->deepen = 1;
@@ -1320,7 +1317,6 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		else
 			alternate_shallow_file = NULL;
 	} else {
-		free(shallows);
 		alternate_shallow_file = NULL;
 	}
 }
@@ -1365,6 +1361,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    const struct ref *orig_ref,
 				    struct ref **sought, int nr_sought,
 				    struct shallow_info *si,
+				    struct oid_array *shallows,
 				    char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -1439,7 +1436,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		case FETCH_GET_PACK:
 			/* Check for shallow-info section */
 			if (process_section_header(&reader, "shallow-info", 1))
-				receive_shallow_info(args, &reader, si);
+				receive_shallow_info(args, &reader, shallows, si);
 
 			if (process_section_header(&reader, "wanted-refs", 1))
 				receive_wanted_refs(&reader, sought, nr_sought);
@@ -1681,7 +1678,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 			BUG("Protocol V2 does not provide shallows at this point in the fetch");
 		memset(&si, 0, sizeof(si));
 		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
-					   &si, pack_lockfile);
+					   &si, shallow, pack_lockfile);
 	} else {
 		prepare_shallow_info(&si, shallow);
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
