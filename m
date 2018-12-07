Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3853820A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 08:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLGIxg (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 03:53:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:33810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725978AbeLGIxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 03:53:36 -0500
Received: (qmail 28596 invoked by uid 109); 7 Dec 2018 08:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Dec 2018 08:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25919 invoked by uid 111); 7 Dec 2018 08:53:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 07 Dec 2018 03:53:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2018 03:53:34 -0500
Date:   Fri, 7 Dec 2018 03:53:34 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH on sb/more-repo-in-api] revision: use commit graph in
 get_reference()
Message-ID: <20181207085334.GA5167@sigill.intra.peff.net>
References: <20181205045416.GB12284@sigill.intra.peff.net>
 <20181206235446.147173-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206235446.147173-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 03:54:46PM -0800, Jonathan Tan wrote:

> This makes sense - I thought I shouldn't mention the commit graph in the
> code since it seems like a layering violation, but I felt the need to
> mention commit graph in a comment, so maybe the need to mention commit
> graph in the code is there too. Subsequently, maybe the lookup-for-type
> could be replaced by a lookup-in-commit-graph (maybe by using
> parse_commit_in_graph() directly), which should be at least slightly
> faster.

That makes more sense to me. If we don't have a commit graph at all,
it's a quick noop. If we do, we might binary search in the list of
commits for a non-commit. But that's strictly faster than finding the
object's type (which involves a binary search of a larger list, followed
by actually accessing the type info).

> > In general, it would be nice if we had a more incremental API
> > for accessing objects: open, get metadata, then read the data. That
> > would make these kinds of optimizations "free".
> 
> Would this be assuming that to read the data, you would (1) first need to
> read the metadata, and (2) there would be no redundancy in reading the
> two? It seems to me that for loose objects, you would want to perform
> all your reads at once, since any read requires opening the file, and
> for commit graphs, you just want to read what you want, since the
> metadata and the data are in separate places.

By metadata here, I don't mean the commit-graph data, but just the
object type and size. So I'm imagining an interface more like:

  - object_open() locates the object, and stores either the pack
    file/offset or a descriptor to a loose path in an opaque handle
    struct

  - object_size() and object_type() on that handle would do what you
    expect. For loose objects, these would parse the header (the
    equivalent of unpack_sha1_header()). For packed ones, they'd use the
    object header in the pack (and chase down the delta bits as needed).

  - object_contents() would return the full content

  - object_read() could sequentially read a subset of the file (this
    could replace the streaming interface we currently have)

We have most of the low-level bits for this already, if you poke into
what object_info_extended() is doing. We just don't have them packaged
in an interface which can persist across multiple calls.

With an interface like that, parse_object()'s large-blob check could be
something like the patch below.

But your case here is a bit more interesting. If we have a commit graph,
then we can avoid opening (or even finding!) the on-disk object at all.
So I actually think it makes sense to just check the commit-graph first,
as discussed above.

---
diff --git a/object.c b/object.c
index e54160550c..afce58c0bc 100644
--- a/object.c
+++ b/object.c
@@ -254,23 +254,31 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	const struct object_id *repl = lookup_replace_object(r, oid);
 	void *buffer;
 	struct object *obj;
+	struct object_handle oh;
 
 	obj = lookup_object(r, oid->hash);
 	if (obj && obj->parsed)
 		return obj;
 
-	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
-	    (!obj && has_object_file(oid) &&
-	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
+	if (object_open(&oh, oid) < 0)
+		return NULL; /* missing object */
+
+	if (object_type(&oh) == OBJ_BLOB) {
+		/* this will call object_read() on 4k chunks */
+		if (check_object_signature_stream(&oh, oid)) {
 			error(_("sha1 mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
+		object_close(&oh); /* we don't care about contents */
 		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
 		return lookup_object(r, oid->hash);
 	}
 
-	buffer = read_object_file(oid, &type, &size);
+	type = object_type(&oh);
+	size = object_size(&oh);
+	buffer = object_contents(&oh);
+	object_close(&oh);
+
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
