Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23750C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiITUlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiITUlx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:41:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB975490
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:41:52 -0700 (PDT)
Received: (qmail 31130 invoked by uid 109); 20 Sep 2022 20:41:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 20:41:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14830 invoked by uid 111); 20 Sep 2022 20:41:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 16:41:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 16:41:51 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [INVESTIGATION] why is fsck --connectivity-only so much more
 expensive than rev-list --objects --all?
Message-ID: <YyoljwDIn7PxRlC9@coredump.intra.peff.net>
References: <9304B938-4A59-456B-B091-DBBCAA1823B2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9304B938-4A59-456B-B091-DBBCAA1823B2@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 03:27:29PM -0400, John Cai wrote:

> One observation is that `git-fsck` seems to use up alot more memory in calling
> unpack_compressed_entry() than `git-rev-list` does.

That just means it's data coming from a pack. The interesting parts are
further up the stack, I think:

> | | ->40.48% (826,445,820B) 0x2B2447: unpack_compressed_entry (packfile.c:1601)
> | | | ->40.48% (826,445,820B) 0x2B46AB: unpack_entry (packfile.c:1768)
> | | | | ->40.48% (826,445,820B) 0x2B4A23: cache_or_unpack_entry (packfile.c:1438)
> | | | |   ->40.48% (826,445,820B) 0x2B4A23: packed_object_info (packfile.c:1516)
> | | | |     ->40.48% (826,445,820B) 0x29EA83: do_oid_object_info_extended (object-file.c:1620)
> | | | |       ->40.48% (826,445,820B) 0x29EBDB: oid_object_info_extended (object-file.c:1639)
> | | | |         ->40.48% (826,445,820B) 0x29EDC3: read_object (object-file.c:1671)
> | | | |           ->40.48% (826,445,820B) 0x29EE5B: read_object_file_extended (object-file.c:1714)
> | | | |             ->40.12% (819,056,147B) 0x2143BB: repo_read_object_file (object-store.h:253)
> | | | |             | ->40.12% (819,056,147B) 0x2143BB: repo_parse_commit_internal (commit.c:511)
> | | | |             |   ->40.12% (819,056,147B) 0x2143BB: repo_parse_commit_internal (commit.c:495)
> | | | |             |     ->40.12% (819,056,147B) 0x25A747: repo_parse_commit (commit.h:90)
> | | | |             |       ->40.12% (819,056,147B) 0x25A747: fsck_walk_commit (fsck.c:355)

OK, so we're holding onto commit buffers after parsing them. We probably
should tell the parser not to do that. It's useful for git-log, etc,
which are going to pretty-print the buffer, but not for this use. You
can set the global save_commit_buffer to do that.

> | | ->08.61% (175,870,114B) 0x2B9DC3: patch_delta (patch-delta.c:36)
> | | | ->08.61% (175,870,114B) 0x2B42EB: unpack_entry (packfile.c:1829)
> | | |   ->08.61% (175,870,114B) 0x2B4A23: cache_or_unpack_entry (packfile.c:1438)
> | | |     ->08.61% (175,870,114B) 0x2B4A23: packed_object_info (packfile.c:1516)
> | | |       ->08.61% (175,870,114B) 0x29EA83: do_oid_object_info_extended (object-file.c:1620)
> | | |         ->08.61% (175,870,114B) 0x29EBDB: oid_object_info_extended (object-file.c:1639)
> | | |           ->08.61% (175,870,114B) 0x29EDC3: read_object (object-file.c:1671)
> | | |             ->08.61% (175,870,114B) 0x29EE5B: read_object_file_extended (object-file.c:1714)
> | | |               ->04.52% (92,219,588B) 0x3461CB: repo_read_object_file (object-store.h:253)
> | | |               | ->04.52% (92,219,588B) 0x3461CB: parse_tree_gently.part.0 (tree.c:132)
> | | |               |   ->04.52% (92,219,588B) 0x25A4EB: parse_tree (tree.h:24)
> | | |               |     ->04.52% (92,219,588B) 0x25A4EB: fsck_walk_tree (fsck.c:307)

And this is data we've allocated for trees. It kind of looks like
fsck_walk_tree() never bothers to clean up the trees it parses, leaving
the buffers attached to the tree structs. But that can't be the case,
because linux.git has something like 16GB of trees. These may be entries
we keep in the internal delta cache, though it should be a bit smaller
than what you have here (the default is 96MB; you can drop it with
core.deltaBaseCacheLimit, but runtime may suffer).

There's a call to free_tree_buffer() in builtin/fsck.c:traverse_one();
that may be what ends up freeing things. It's been a while since I've
traced through the call paths for fsck.

> But, not having delved too deeply into the code, I wanted to ask the list if
> anything jumps out as to why `git-fsck` consumes so much more memory than
> `git-rev-list`--perhaps there is opportunity for improvement/optimization?

The patch below improves my peak heap (as reported by massif) for "git
fsck --connectivity-only" on linux.git from ~2GB to ~1GB.

But in general, I think "rev-list" is a better tool for connectivity
checks. One problem with fsck is that it tries to read the set of
available objects up front, making it racy in a repository which is
receiving pushes, or which may be repacked (e.g., if somebody makes a
new object and references it, "fsck --connectivity-only" may fail to
notice the new object but will see the updated ref, and think the ref is
corrupt).

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f7916f06ed..949073a00d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -853,6 +853,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	errors_found = 0;
 	read_replace_refs = 0;
+	save_commit_buffer = 0;
 
 	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
 

-Peff
