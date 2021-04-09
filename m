Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BAC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FA660FE8
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 17:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhDIRve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:51:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:46486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDIRvd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 13:51:33 -0400
Received: (qmail 475 invoked by uid 109); 9 Apr 2021 17:51:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 17:51:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14349 invoked by uid 111); 9 Apr 2021 17:51:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 13:51:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 13:51:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] blob.c: remove buffer & size arguments to
 parse_blob_buffer()
Message-ID: <YHCUFwZMitOXELpq@coredump.intra.peff.net>
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <patch-1.3-68a7709fe5-20210409T080534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-68a7709fe5-20210409T080534Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 10:07:27AM +0200, Ævar Arnfjörð Bjarmason wrote:

> As noted in the comment introduced in 837d395a5c0 (Replace
> parse_blob() with an explanatory comment, 2010-01-18) the old
> parse_blob() function and the current parse_blob_buffer() exist merely
> to provide consistency in the API.
> 
> We're not going to parse blobs like we "parse" commits, trees or
> tags. So let's not have the parse_blob_buffer() take arguments that
> pretends that we do. Its only use is to set the "parsed" flag.
> 
> See bd2c39f58f9 ([PATCH] don't load and decompress objects twice with
> parse_object(), 2005-05-06) for the introduction of parse_blob_buffer().

OK. Calling it parse_blob_buffer() is a little silly since it doesn't
even take a buffer anymore. But I guess parse_blob() might imply that it
actually loads the contents from disk to check them (which the other
parse_foo() functions do), so that's not a good name.

So this might be the least bad thing. Given that there are only two
callers, just setting blob->object.parsed might not be unreasonable,
either. But I don't think it's worth spending too much time on.

> @@ -266,7 +266,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
>  			error(_("hash mismatch %s"), oid_to_hex(oid));
>  			return NULL;
>  		}
> -		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
> +		parse_blob_buffer(lookup_blob(r, oid));
>  		return lookup_object(r, oid);

Not new in your patch, but I wondered if this could cause a segfault
when lookup_blob() returns NULL. I _think_ the answer is "no". We'd hit
this code path when either:

  - lookup_object() returns an object with type OBJ_BLOB, in which case
    lookup_blob() would return that same object

  - lookup_object() returned NULL, in which case lookup_blob() will call
    it again, get NULL again, and then auto-create the blob and return
    it

So I think it is OK. But there are a bunch of duplicate hash lookups in
this code. It would be clearer and more efficient as:

diff --git a/object.c b/object.c
index 2c32691dc4..2dfa038f13 100644
--- a/object.c
+++ b/object.c
@@ -262,12 +262,14 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
+		if (!obj)
+			obj = create_object(r, oid, alloc_blob_node(r));
 		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
-		return lookup_object(r, oid);
+		parse_blob_buffer(obj, NULL, 0);
+		return obj;
 	}
 
 	buffer = repo_read_object_file(r, oid, &type, &size);

but I doubt the efficiency matters much in practice. Those hash lookups
will be lost in the noise of computing the hash of the blob contents.

-Peff
