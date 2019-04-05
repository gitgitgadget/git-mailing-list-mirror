Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B4B20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfDESDM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:03:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:48632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESDL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:03:11 -0400
Received: (qmail 10908 invoked by uid 109); 5 Apr 2019 18:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28055 invoked by uid 111); 5 Apr 2019 18:03:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:03:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:03:07 -0400
Date:   Fri, 5 Apr 2019 14:03:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/13] a rabbit hole of update-server-info (and midx!) fixes
Message-ID: <20190405180306.GA21113@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 07:21:04PM -0400, Jeff King wrote:

> This patch series started with patch 12: I just wanted to drop the
> unused "force" parameter from update_info_refs().
> [...]
> And here we are. I present them here in reverse rabbit-hole order (which
> is also roughly important fixes first, and minor cleanups last). The
> individual chunks are mostly independent, but the server-info cleanups
> rely on the shared pack_basename() helper added as part of the midx fix.

Here's a v2 which addresses the feedback on the last round (thank you
both). In particular:

  - the rabbit hole goes one deeper, as fixing the midx bug reveals that
    the revindex code just assumes that the pack .idx has been loaded.
    Patch 2 corrects this, which addresses most of the test failures
    with GIT_TEST_MULTI_PACK_INDEX.

  - There was one other failure, which is that t5570 corrupted a .idx
    and expected us to notice (which no longer happens when the midx is
    able to provide the answer). I've tweaked the test to address this.

  - I took René's suggestion of making midx_contains_pack() friendlier
    by handling either a .pack or a .idx argument. I had to tweak the
    suggested code just a little, and I added comments, since it took me
    a little staring to make sure everything was correct.

    I split that out from the basename fix, so that's now patches 5 and
    6. It also lets us drop the patch to factor out pack_name_to_idx().

Other than that, it's substantially the same as v1. I did move the
public declaration of pack_basename() to the patch where it is added,
rather than doing it later, which shows up in the range diff below.

  [01/13]: packfile.h: drop extern from function declarations
  [02/13]: pack-revindex: open index if necessary
  [03/13]: t5319: fix bogus cat-file argument
  [04/13]: t5319: drop useless --buffer from cat-file
  [05/13]: midx: check both pack and index names for containment
  [06/13]: packfile: fix pack basename computation
  [07/13]: http: simplify parsing of remote objects/info/packs
  [08/13]: server-info: fix blind pointer arithmetic
  [09/13]: server-info: simplify cleanup in parse_pack_def()
  [10/13]: server-info: use strbuf to read old info/packs file
  [11/13]: server-info: drop nr_alloc struct member
  [12/13]: server-info: drop objdirlen pointer arithmetic
  [13/13]: update_info_refs(): drop unused force parameter

 http.c                      | 35 ++++++---------
 midx.c                      | 36 +++++++++++++++-
 midx.h                      |  2 +-
 pack-bitmap.c               |  3 +-
 pack-revindex.c             | 13 ++++--
 pack-revindex.h             |  2 +-
 packfile.c                  | 18 ++++++--
 packfile.h                  | 86 ++++++++++++++++++++-----------------
 server-info.c               | 57 +++++++++++-------------
 t/t5319-multi-pack-index.sh | 29 ++++++++++---
 t/t5570-git-daemon.sh       |  1 +
 11 files changed, 172 insertions(+), 110 deletions(-)

10:  bead52a5dc =  1:  829e666ec9 packfile.h: drop extern from function declarations
 -:  ---------- >  2:  d46c0eafd0 pack-revindex: open index if necessary
 1:  3d1978ccaf =  3:  5b965de360 t5319: fix bogus cat-file argument
 2:  ce74312004 =  4:  32ef03e059 t5319: drop useless --buffer from cat-file
 3:  ea637c9cf1 <  -:  ---------- packfile: factor out .pack to .idx name conversion
 -:  ---------- >  5:  d87a2aa2bf midx: check both pack and index names for containment
 4:  4723e1b952 !  6:  c2bed91a3f packfile: check midx coverage with .idx rather than .pack
    @@ -1,35 +1,40 @@
     Author: Jeff King <peff@peff.net>
     
    -    packfile: check midx coverage with .idx rather than .pack
    +    packfile: fix pack basename computation
     
    -    When we have a .midx that covers many packfiles, we try to avoid opening
    -    the .idx for those packfiles. However, there are a few problems with the
    -    filename comparison we use:
    +    When we have a multi-pack-index that covers many packfiles, we try to
    +    avoid opening the .idx for those packfiles. To do that we feed the pack
    +    name to midx_contains_pack(). But that function wants to see only the
    +    basename, which we compute using strrchr() to find the final slash. But
    +    that leaves an extra "/" at the start of our string.
     
    -      - we ask midx_contains_pack() about the .pack name, not the .idx name.
    -        But it compares to the latter.
    +    We can fix this by incrementing the pointer. That also raises the
    +    question of what to do when the name does not have a '/' at all. This
    +    should generally not happen (we always find files in "pack/"), but it
    +    doesn't hurt to be defensive here.
     
    -      - we compute the basename of the pack using strrchr() to find the
    -        final slash. But that leaves an extra "/" at the start of our
    -        string; we need to advance past it.
    -
    -        That also raises the question of what to do when the name does not
    -        have a slash at all. This should generally not happen (we always
    -        find files in "pack/"), but it doesn't hurt to be defensive here.
    +    Let's wrap all of that up in a helper function and make it publicly
    +    available, since a later patch will need to use it, too.
     
         The tests don't notice because there's nothing about opening those .idx
         files that would cause us to give incorrect output. It's just a little
         slower. The new test checks this case by corrupting the covered .idx,
         and then making sure we don't complain about it.
     
    +    We also have to tweak t5570, which intentionally corrupts a .idx file
    +    and expects us to notice it. When run with GIT_TEST_MULTI_PACK_INDEX,
    +    this will fail since we now will (correctly) not bother opening the .idx
    +    at all. We can fix that by unconditionally dropping any midx that's
    +    there, which ensures we'll have to read the .idx.
    +
      diff --git a/packfile.c b/packfile.c
      --- a/packfile.c
      +++ b/packfile.c
     @@
      #endif
      }
      
    -+static const char *pack_basename(struct packed_git *p)
    ++const char *pack_basename(struct packed_git *p)
     +{
     +	const char *ret = strrchr(p->pack_name, '/');
     +	if (ret)
    @@ -43,25 +48,31 @@
       * Do not call this directly as this leaks p->pack_fd on error return;
       * call open_packed_git() instead.
     @@
    - 	ssize_t read_result;
    - 	const unsigned hashsz = the_hash_algo->rawsz;
      
    --	if (!p->index_data) {
    -+	if (!p->index_data && the_repository->objects->multi_pack_index) {
    + 	if (!p->index_data) {
      		struct multi_pack_index *m;
     -		const char *pack_name = strrchr(p->pack_name, '/');
    -+		char *idx_name = pack_name_to_idx(pack_basename(p));
    ++		const char *pack_name = pack_basename(p);
      
      		for (m = the_repository->objects->multi_pack_index;
      		     m; m = m->next) {
    --			if (midx_contains_pack(m, pack_name))
    -+			if (midx_contains_pack(m, idx_name))
    - 				break;
    - 		}
    -+		free(idx_name);
    +
    + diff --git a/packfile.h b/packfile.h
    + --- a/packfile.h
    + +++ b/packfile.h
    +@@
    +  */
    + char *sha1_pack_index_name(const unsigned char *sha1);
      
    - 		if (!m && open_pack_index(p))
    - 			return error("packfile %s index unavailable", p->pack_name);
    ++/*
    ++ * Return the basename of the packfile, omitting any containing directory
    ++ * (e.g., "pack-1234abcd[...].pack").
    ++ */
    ++const char *pack_basename(struct packed_git *p);
    ++
    + struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
    + 
    + typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
     
      diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
      --- a/t/t5319-multi-pack-index.sh
    @@ -87,3 +98,15 @@
      test_expect_success 'add more objects' '
      	for i in $(test_seq 6 10)
      	do
    +
    + diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
    + --- a/t/t5570-git-daemon.sh
    + +++ b/t/t5570-git-daemon.sh
    +@@
    + test_expect_success 'fetch notices corrupt idx' '
    + 	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
    + 	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
    ++	 rm -f objects/pack/multi-pack-index &&
    + 	 p=$(ls objects/pack/pack-*.idx) &&
    + 	 chmod u+w $p &&
    + 	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
 5:  0bf3fb7758 =  7:  15a7d0c690 http: simplify parsing of remote objects/info/packs
 6:  3f711f74f1 =  8:  aee572065c server-info: fix blind pointer arithmetic
 7:  5a77637699 =  9:  a9d226960a server-info: simplify cleanup in parse_pack_def()
 8:  cbc7b6fa71 = 10:  388e7bf2be server-info: use strbuf to read old info/packs file
 9:  9601aa240c = 11:  76ca72f4bf server-info: drop nr_alloc struct member
11:  23ff6ba3dc ! 12:  8753c537a7 server-info: drop objdirlen pointer arithmetic
    @@ -18,36 +18,6 @@
         future-proofs us, and should hopefully be more obviously safe to
         somebody reading the code.
     
    - diff --git a/packfile.c b/packfile.c
    - --- a/packfile.c
    - +++ b/packfile.c
    -@@
    - #endif
    - }
    - 
    --static const char *pack_basename(struct packed_git *p)
    -+const char *pack_basename(struct packed_git *p)
    - {
    - 	const char *ret = strrchr(p->pack_name, '/');
    - 	if (ret)
    -
    - diff --git a/packfile.h b/packfile.h
    - --- a/packfile.h
    - +++ b/packfile.h
    -@@
    -  */
    - char *sha1_pack_index_name(const unsigned char *sha1);
    - 
    -+/*
    -+ * Return the basename of the packfile, omitting any containing directory
    -+ * (e.g., "pack-1234abcd[...].pack").
    -+ */
    -+const char *pack_basename(struct packed_git *p);
    -+
    - struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
    - 
    - typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
    -
      diff --git a/server-info.c b/server-info.c
      --- a/server-info.c
      +++ b/server-info.c
12:  3f9cff4360 = 13:  96c5a26a99 update_info_refs(): drop unused force parameter
