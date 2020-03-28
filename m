Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F30C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B4A20716
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgC1OkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:40:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:54462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726325AbgC1OkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 10:40:25 -0400
Received: (qmail 24262 invoked by uid 109); 28 Mar 2020 14:40:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 14:40:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1626 invoked by uid 111); 28 Mar 2020 14:50:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 10:50:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 10:40:23 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Inefficiency of partial shallow clone vs shallow clone +
 "old-style" sparse checkout
Message-ID: <20200328144023.GB1198080@coredump.intra.peff.net>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 12:08:17AM +0300, Konstantin Tokarev wrote:

> Is it a known thing that addition of --filter=blob:none to workflow
> with shalow clone (e.g. --depth=1) and following sparse checkout may
> significantly slow down process and result in much larger .git
> repository?
> 
> In case anyone is interested, I've posted my measurements at [1].
> 
> I understand this may have something to do with GitHub's server side
> implementation, but AFAIK there are some GitHub folks here as well.

I think the problem is on the client side. Just with a local git.git
clone, try this:

  $ git config uploadpack.allowfilter true
  $ git clone --no-local --bare --depth=1 --filter=blob:none . both.git
  Cloning into bare repository 'both.git'...
  remote: Enumerating objects: 197, done.
  remote: Counting objects: 100% (197/197), done.
  remote: Compressing objects: 100% (153/153), done.
  remote: Total 197 (delta 3), reused 171 (delta 3), pack-reused 0
  Receiving objects: 100% (197/197), 113.63 KiB | 28.41 MiB/s, done.
  Resolving deltas: 100% (3/3), done.
  remote: Enumerating objects: 1871, done.
  remote: Counting objects: 100% (1871/1871), done.
  remote: Compressing objects: 100% (870/870), done.
  remote: Total 1871 (delta 1001), reused 1855 (delta 994), pack-reused 0
  Receiving objects: 100% (1871/1871), 384.93 KiB | 38.49 MiB/s, done.
  Resolving deltas: 100% (1001/1001), done.
  remote: Enumerating objects: 1878, done.
  remote: Counting objects: 100% (1878/1878), done.
  remote: Compressing objects: 100% (872/872), done.
  remote: Total 1878 (delta 1004), reused 1864 (delta 999), pack-reused 0
  Receiving objects: 100% (1878/1878), 386.41 KiB | 25.76 MiB/s, done.
  Resolving deltas: 100% (1004/1004), done.
  remote: Enumerating objects: 1903, done.
  remote: Counting objects: 100% (1903/1903), done.
  remote: Compressing objects: 100% (882/882), done.
  remote: Total 1903 (delta 1020), reused 1890 (delta 1014), pack-reused 0
  Receiving objects: 100% (1903/1903), 391.05 KiB | 16.29 MiB/s, done.
  Resolving deltas: 100% (1020/1020), done.
  remote: Enumerating objects: 1975, done.
  remote: Counting objects: 100% (1975/1975), done.
  remote: Compressing objects: 100% (915/915), done.
  remote: Total 1975 (delta 1059), reused 1959 (delta 1052), pack-reused 0
  Receiving objects: 100% (1975/1975), 405.58 KiB | 16.90 MiB/s, done.
  Resolving deltas: 100% (1059/1059), done.
  [...and so on...]

Oops. The backtrace for the clone during this process looks like:

  [...]
  #11 0x000055b980be01dc in fetch_objects (remote_name=0x55b981607620 "origin", oids=0x55b9816217a8, oid_nr=1)
      at promisor-remote.c:47
  #12 0x000055b980be0812 in promisor_remote_get_direct (repo=0x55b980dcab00 <the_repo>, oids=0x55b9816217a8, oid_nr=1)
      at promisor-remote.c:247
  #13 0x000055b980c3e475 in do_oid_object_info_extended (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8, 
      oi=0x55b980dcaec0 <blank_oi>, flags=0) at sha1-file.c:1511
  #14 0x000055b980c3e579 in oid_object_info_extended (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8, oi=0x0, flags=0)
      at sha1-file.c:1544
  #15 0x000055b980c3f7bc in repo_has_object_file_with_flags (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8, flags=0)
      at sha1-file.c:1980
  #16 0x000055b980c3f7ee in repo_has_object_file (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8) at sha1-file.c:1986
  #17 0x000055b980a54533 in write_followtags (refs=0x55b981610900, 
      msg=0x55b981601230 "clone: from /home/peff/compile/git/.") at builtin/clone.c:646
  #18 0x000055b980a54723 in update_remote_refs (refs=0x55b981610900, mapped_refs=0x55b98160fe20, 
      remote_head_points_at=0x0, branch_top=0x55b981601130 "refs/heads/", 
      msg=0x55b981601230 "clone: from /home/peff/compile/git/.", transport=0x55b98160da90, check_connectivity=1, 
      check_refs_are_promisor_objects_only=1) at builtin/clone.c:699
  #19 0x000055b980a5625b in cmd_clone (argc=2, argv=0x7fff5e0a1e70, prefix=0x0) at builtin/clone.c:1280
  [...]

So I guess the problem is not with shallow clones specifically, but they
lead us to not having fetched the commits pointed to by tags, which
leads to us trying to fault in those commits (and their trees) rather
than realizing that we weren't meant to have them. And the size of the
local repo balloons because you're fetching all those commits one by
one, and not getting the benefit of the deltas you would when you do a
single --filter=blob:none fetch.

I guess we need something like this:

diff --git a/builtin/clone.c b/builtin/clone.c
index 488bdb0741..a1879994f5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -643,7 +643,8 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (ends_with(ref->name, "^{}"))
 			continue;
-		if (!has_object_file(&ref->old_oid))
+		if (!has_object_file_with_flags(&ref->old_oid,
+						OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
 		update_ref(msg, ref->name, &ref->old_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);

which seems to produce the desired result.

-Peff
