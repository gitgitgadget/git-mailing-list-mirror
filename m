Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBFC61F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 05:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfKNF7I (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 00:59:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:47064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725601AbfKNF7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 00:59:07 -0500
Received: (qmail 22173 invoked by uid 109); 14 Nov 2019 05:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 05:59:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 952 invoked by uid 111); 14 Nov 2019 06:02:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 01:02:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 00:59:06 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
Message-ID: <20191114055906.GA10643@sigill.intra.peff.net>
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 08:35:47PM -0800, Bryan Turner wrote:

> When using a command like `git rev-list dc41e --`, it's possible to
> get output like this: (from newer Git versions)
> error: short SHA1 dc41e is ambiguous
> hint: The candidates are:
> hint:   dc41eeb01ba commit 2012-11-23 - Stuff from the commit message
> hint:   dc41e0d508b tree
> hint:   dc41e5bef41 tree
> hint:   dc41e11ee18 blob
> fatal: bad revision 'dc41e'
>
> Is there any way to ask rev-list to be a little...pickier about what
> it considers a candidate? Almost without question the two trees and
> the blob aren't what I'm asking for, which means there's actually only
> one real candidate.

Try "dc41e^{commit}", which will realize that trees and blobs cannot
peel to a commit (there would still be an ambiguity with a tag).

I think one could argue that without "--objects" in play, rev-list
should automatically disambiguate in favor of a committish. But that's
not true for every command.

You can also set core.disambiguate to "committish" (or even "commit").
At the time we added that option (and started reporting the list of
candidates), we pondered whether it might make sense to make that the
default. That would probably help in a lot of cases, but the argument
against it is that when it goes wrong, it may be quite confusing (so
we're better off with the current message, which punts back to the
user).

I think it also comes up fairly rarely these days, as short sha1s we
print have some headroom built in (as you can see above; the one you've
input is really quite short compared to anything Git would have printed
in that repo).

> Also, while considering this, I noticed that `git rev-list
> dc41e11ee18` (the blob from the output above) doesn't fail. It
> silently exits, nothing written to stdout or stderr, with 0 status. A
> little surprising; I would have expected rev-list to complain that
> dc41e11ee18 isn't a valid commit-ish value.

Yeah, this is a separate issue. If the revision machinery has pending
trees or blobs but isn't asked to show them via "--objects", then it
just ignores them.

I've been running with the patch below for several years; it just adds a
warning when we ignore such an object. I've been tempted to send it for
inclusion, but it has some rough edges:

  - there are some fast-export calls in the test scripts that trigger
    this. I don't remember the details, and what the fix would look
    like.

  - it makes wildcards like "rev-list --all" complain, because they may
    add a tag-of-blob, for example (in git.git, junio-gpg-pub triggers
    this). Things like "--all" would probably need to get smarter, and
    avoid adding non-commits in the first place (when --objects is not
    in use, of course)

---
 revision.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 0e39b2b8a5..7dc2d9a822 100644
--- a/revision.c
+++ b/revision.c
@@ -393,6 +393,16 @@ void add_pending_oid(struct rev_info *revs, const char *name,
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
@@ -458,8 +468,10 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)object;
-		if (!revs->tree_objects)
+		if (!revs->tree_objects) {
+			warn_ignored_object(object, name);
 			return NULL;
+		}
 		if (flags & UNINTERESTING) {
 			mark_tree_contents_uninteresting(revs->repo, tree);
 			return NULL;
@@ -472,8 +484,10 @@ static struct commit *handle_commit(struct rev_info *revs,
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
-- 
2.24.0.739.gb5632e4929

