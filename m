Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D593201A4
	for <e@80x24.org>; Tue, 16 May 2017 08:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdEPIKb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 04:10:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:52530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdEPIK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 04:10:27 -0400
Received: (qmail 14132 invoked by uid 109); 16 May 2017 08:10:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 08:10:25 +0000
Received: (qmail 25783 invoked by uid 111); 16 May 2017 08:10:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 04:10:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 04:10:23 -0400
Date:   Tue, 16 May 2017 04:10:23 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Demonstrate and partially work around a
 gitattributes problem
Message-ID: <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
 <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 03:54:18AM -0400, Jeff King wrote:

> Something like the patch below almost gets us there, but it suffers from
> the fact that the revision machinery doesn't record the path for the
> blobs it parses. So:
> 
>   1. It's a little inefficient, because it has to re-resolve the names
>      again.
> 
>   2. It works for "git diff $commit:file1 $commit:file2", because each
>      of the blobs has a name we can re-resolve. But connecting them with
>      "$commit:file1..$commit:file2" doesn't work, because that name is
>      given to _both_ blobs, and can't be resolved as a single sha1. I'd
>      argue that this is actually a bug in the revision code.
> 
> Both would be solved if handle_revision_arg used get_sha1_with_context
> to record the path while resolving (struct object_entry already has a
> slot for it, but the revision code never sets it).

This turned out much easier than I feared. With the patch below:

  - your t0003 test passes

  - the diff headers are much more sensible (IMHO)

  - it fixes a semi-related bug in which "git diff $blob1 $blob2"
    compared the modes correctly, but "git diff $blob1..$blob2" did not
    (because the ".." code path did not correctly record the modes).

I'll stop here for now to get any comments/feedback. There are a few
changes I'd make to polish this up:

  - the mode fix should be its own preparatory patch

  - teaching revision.c to pass out path info should be its own patch

  - the "struct blobinfo" in builtin/diff.c should probably call it
    "path" instead of "name" for clarity. In fact, I kind of wonder if
    this should just be an object_array element, as that has all of
    the information.

  - the way that "struct object_context" handles the paths with a
    fixed-size buffer is badly designed (by me, long ago). I may see
    what it would take to refactor that to match the technique in
    sha1_object_info_extended(), which I think has worked well in
    practice.

    That's orthogonal to this series, but it's been bugging me for a
    long time, and obviously the caller here would have to adapt.

---
diff --git a/builtin/diff.c b/builtin/diff.c
index d184aafab..8ed1e99e3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -409,7 +409,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			if (2 <= blobs)
 				die(_("more than two blobs given: '%s'"), name);
 			hashcpy(blob[blobs].oid.hash, obj->oid.hash);
-			blob[blobs].name = name;
+			blob[blobs].name = entry->path ? entry->path : name;
 			blob[blobs].mode = entry->mode;
 			blobs++;
 
diff --git a/revision.c b/revision.c
index 8a8c1789c..72b9af7de 100644
--- a/revision.c
+++ b/revision.c
@@ -1431,7 +1431,7 @@ static void prepare_show_merge(struct rev_info *revs)
 
 int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
 {
-	struct object_context oc;
+	struct object_context oc, oc2;
 	char *dotdot;
 	struct object *object;
 	unsigned char sha1[20];
@@ -1470,8 +1470,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				return -1;
 			}
 		}
-		if (!get_sha1_committish(this, from_sha1) &&
-		    !get_sha1_committish(next, sha1)) {
+		if (!get_sha1_with_context(this, GET_SHA1_COMMITTISH, from_sha1, &oc) &&
+		    !get_sha1_with_context(next, GET_SHA1_COMMITTISH, sha1, &oc2)) {
 			struct object *a_obj, *b_obj;
 
 			if (!cant_be_filename) {
@@ -1523,8 +1523,12 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 					REV_CMD_LEFT, a_flags);
 			add_rev_cmdline(revs, b_obj, next,
 					REV_CMD_RIGHT, flags);
-			add_pending_object(revs, a_obj, this);
-			add_pending_object(revs, b_obj, next);
+			add_pending_object_with_path(revs, a_obj, this,
+						     oc.mode,
+						     oc.path[0] ? oc.path : NULL);
+			add_pending_object_with_path(revs, b_obj, next,
+						     oc2.mode,
+						     oc2.path[0] ? oc2.path : NULL);
 			return 0;
 		}
 		*dotdot = '.';
@@ -1574,7 +1578,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
-	add_pending_object_with_mode(revs, object, arg, oc.mode);
+	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	return 0;
 }
 
