From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] alloc.c: remove the redundant commit_count
 variable
Date: Thu, 10 Jul 2014 20:30:53 -0400
Message-ID: <20140711003053.GB11360@sigill.intra.peff.net>
References: <53BF28F4.8050704@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:31:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Ojt-0001gG-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 02:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbaGKAa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:30:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:59747 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313AbaGKAaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:30:55 -0400
Received: (qmail 26395 invoked by uid 102); 11 Jul 2014 00:30:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jul 2014 19:30:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 20:30:53 -0400
Content-Disposition: inline
In-Reply-To: <53BF28F4.8050704@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253241>

On Fri, Jul 11, 2014 at 12:59:48AM +0100, Ramsay Jones wrote:

> The 'commit_count' static variable is used in alloc_commit_node()
> to set the 'index' field of the commit structure to a unique value.
> This variable assumes the same value as the 'count' field of the
> 'commit_state' allocator state structure, which may be used in its
> place.

I don't think we want to do this, because there is a bug in the current
code that I have not reported yet. :)

The code you're touching here was trying to make sure that each commit
gets a unique index, under the assumption that commits only get
allocated via alloc_commit_node. But I think that assumption is wrong.
We can also get commit objects by allocating an OBJ_NONE (e.g., via
lookup_unknown_object) and then converting it into an OBJ_COMMIT when we
find out what it is.

We should be allocating a commit index to it at that point (but we don't
currently), at which point the commit_count and commit_state.count
indices will no longer be in sync.

This only happens in a few places. Most calls will probably be via
lookup_commit (which gets called when we parse_object such an unknown
object), but there are others (e.g., peel_object may fill in the type).
So we could fix it with something like:

diff --git a/commit.c b/commit.c
index fb7897c..f4f4278 100644
--- a/commit.c
+++ b/commit.c
@@ -65,8 +65,11 @@ struct commit *lookup_commit(const unsigned char *sha1)
 		struct commit *c = alloc_commit_node();
 		return create_object(sha1, OBJ_COMMIT, c);
 	}
-	if (!obj->type)
+	if (!obj->type) {
+		struct commit *c = (struct commit *)obj;
 		obj->type = OBJ_COMMIT;
+		c->index = alloc_commit_index();
+	}
 	return check_commit(obj, sha1, 0);
 }
 

where alloc_commit_index() would be a thin wrapper around "return
commit_count++". And then find and update any other callsites that need
it.

The downside is that it's hard to find those callsites. A safer
alternative would be to speculatively allocate a commit index for all
unknown objects. Then if any other code switches the type to commit,
they already have an index. But it also means we'll have holes in our
commit index space, which makes commit-slabs less efficient.

We do not call lookup_unknown_object all that often, though, so it might
be an OK tradeoff (and in at least one case, in diff_tree_stdin, I think
the code can be converted not to use lookup_unknown_object in the first
place). So worrying about the performance may not be worth it.

-Peff
