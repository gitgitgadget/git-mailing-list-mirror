Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236BD1F406
	for <e@80x24.org>; Thu, 10 May 2018 16:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966427AbeEJQKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 12:10:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:35074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965033AbeEJQKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 12:10:02 -0400
Received: (qmail 9337 invoked by uid 109); 10 May 2018 16:10:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 16:10:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26034 invoked by uid 111); 10 May 2018 16:10:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 12:10:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 12:10:00 -0400
Date:   Thu, 10 May 2018 12:10:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 6/6] get_short_oid: document & warn if we ignore the
 type selector
Message-ID: <20180510160959.GA10199@sigill.intra.peff.net>
References: <20180501184016.15061-10-avarab@gmail.com>
 <20180510124303.6020-7-avarab@gmail.com>
 <20180510160322.GC6462@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510160322.GC6462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 12:03:22PM -0400, Jeff King wrote:

> But some cases _don't_ issue an error. For example, try this:
> 
>   $ git log ..06faf
> 
> which returns an empty output! We return the single matching tree, even
> though the ".." triggers the commit hint. The revision machinery just
> queues the tree, and then later when we see we're not doing an --objects
> traversal, it just gets ignored. (That's a separate issue, but it shows
> that the hints are just that: hints. The code that runs after does not
> necessarily require a matching type).

I actually have a patch that generates a warning for this case (below).
I've been running with it for about a year, but it annoyingly produces
warnings for "git log --all":

  $ git log --all
  warning: ignoring blob object in traversal: refs/tags/junio-gpg-pub

I guess ideally it would distinguish between items added explicitly and
those added by a wildcard (or perhaps the wildcard adder should be more
careful about adding useless objects).

---
diff --git a/revision.c b/revision.c
index 1cff11833e..816d6b75ee 100644
--- a/revision.c
+++ b/revision.c
@@ -215,6 +215,16 @@ void add_pending_oid(struct rev_info *revs, const char *name,
 	add_pending_object(revs, object, name);
 }
 
+static void warn_ignored_object(struct object *object, const char *name)
+{
+	if (object->flags & UNINTERESTING)
+		return;
+
+	warning(_("ignoring %s object in traversal: %s"),
+		type_name(object->type),
+		(name && *name) ? name : oid_to_hex(&object->oid));
+}
+
 static struct commit *handle_commit(struct rev_info *revs,
 				    struct object_array_entry *entry)
 {
@@ -272,8 +282,10 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)object;
-		if (!revs->tree_objects)
+		if (!revs->tree_objects) {
+			warn_ignored_object(object, name);
 			return NULL;
+		}
 		if (flags & UNINTERESTING) {
 			mark_tree_contents_uninteresting(tree);
 			return NULL;
@@ -286,8 +298,10 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 * Blob object? You know the drill by now..
 	 */
 	if (object->type == OBJ_BLOB) {
-		if (!revs->blob_objects)
+		if (!revs->blob_objects) {
+			warn_ignored_object(object, name);
 			return NULL;
+		}
 		if (flags & UNINTERESTING)
 			return NULL;
 		add_pending_object_with_path(revs, object, name, mode, path);
