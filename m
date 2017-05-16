Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00217201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdEPHyV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:54:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbdEPHyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:54:21 -0400
Received: (qmail 13049 invoked by uid 109); 16 May 2017 07:54:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 07:54:20 +0000
Received: (qmail 25715 invoked by uid 111); 16 May 2017 07:54:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 03:54:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 03:54:18 -0400
Date:   Tue, 16 May 2017 03:54:18 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Demonstrate and partially work around a
 gitattributes problem
Message-ID: <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1494861793.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 05:23:44PM +0200, Johannes Schindelin wrote:

> Granted, it is a bit of a less common use case to call
> 
> 	git diff <commit1>:<file1> <commit2>:<file2>
> 
> There are valid scenarios for such calls, of course.
> 
> And sometimes, one may want to compare even files that are stored in
> subdirectories instead of the top-level directory. Example:
> 
> 	git diff cafebabe:t/README bee7e55:t/README
> 
> Now, the surprising part is that Git tries to read a .gitattributes
> files interpreting the *entire* prefix `cafebabe:t/` as a *directory
> path*. I.e. it will try to read the *file* (not the blob)
> `cafebabe:t/.gitattributes`.

You also get a very silly-looking diff header:

  $ git diff HEAD:Makefile HEAD~100:Makefile
  diff --git a/HEAD:Makefile b/HEAD~100:Makefile
  index e35542e63..9b36068ac 100644
  --- a/HEAD:Makefile
  +++ b/HEAD~100:Makefile
  [...]

I think the problem is that diff's blob-compare should be feeding the
actual path to the diff machinery, rather than the original name. True,
that carries less information, but it matches the other cases. For
instance:

  git diff HEAD~100:Makefile Makefile

will diff a blob and a file, and uses the file's path (so "HEAD~100"
does not appear at all in the output).

Likewise, doing:

  git diff HEAD~100 HEAD -- Makefile

will show you the diff over "Makefile", without bothering to mention
the commit endpoints.

So I think we should just be feeding "Makefile" to the diff code even
for the 2-blob case.

Something like the patch below almost gets us there, but it suffers from
the fact that the revision machinery doesn't record the path for the
blobs it parses. So:

  1. It's a little inefficient, because it has to re-resolve the names
     again.

  2. It works for "git diff $commit:file1 $commit:file2", because each
     of the blobs has a name we can re-resolve. But connecting them with
     "$commit:file1..$commit:file2" doesn't work, because that name is
     given to _both_ blobs, and can't be resolved as a single sha1. I'd
     argue that this is actually a bug in the revision code.

Both would be solved if handle_revision_arg used get_sha1_with_context
to record the path while resolving (struct object_entry already has a
slot for it, but the revision code never sets it).

-Peff

---
diff --git a/builtin/diff.c b/builtin/diff.c
index d184aafab..e8c541f00 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -406,10 +406,30 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			obj->flags |= flags;
 			add_object_array(obj, name, &ent);
 		} else if (obj->type == OBJ_BLOB) {
+			struct object_context oc;
+
 			if (2 <= blobs)
 				die(_("more than two blobs given: '%s'"), name);
-			hashcpy(blob[blobs].oid.hash, obj->oid.hash);
-			blob[blobs].name = name;
+
+			/*
+			 * We already resolved this once as a blob via the
+			 * rev_info machinery, but it did not bother to collect
+			 * any path information. Let's re-resolve to get it.
+			 *
+			 * There are a few corner cases where there is no path
+			 * information (e.g., a tag pointing straight at a
+			 * blob). In that case we'll fall back to just using
+			 * the name the user gave us.
+			 */
+			if (!get_sha1_with_context(entry->name, 0, blob[blobs].oid.hash, &oc) &&
+			    !hashcmp(blob[blobs].oid.hash, obj->oid.hash) &&
+			    oc.path[0]) {
+				blob[blobs].name = xstrdup(oc.path);
+			} else {
+				blob[blobs].name = name;
+				hashcpy(blob[blobs].oid.hash, obj->oid.hash);
+			}
+
 			blob[blobs].mode = entry->mode;
 			blobs++;
 
