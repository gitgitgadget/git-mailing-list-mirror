Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13131F453
	for <e@80x24.org>; Sat, 27 Oct 2018 09:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeJ0SNX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 14:13:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:57164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726296AbeJ0SNX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 14:13:23 -0400
Received: (qmail 30389 invoked by uid 109); 27 Oct 2018 09:33:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 09:33:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5354 invoked by uid 111); 27 Oct 2018 09:32:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 05:32:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 05:33:01 -0400
Date:   Sat, 27 Oct 2018 05:33:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Jansen, Geert" <gerardu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
Message-ID: <20181027093300.GA23974@sigill.intra.peff.net>
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 04:26:50PM +0900, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > But as Junio notes the devil's in the details, another one I thought of
> > is:
> >
> >     GIT_OBJECT_DIRECTORY=/some/other/repository git clone ...
> >
> > It seems to me that ...
> 
> Actually I take all of that back ;-)
> 
> For the purpose of this patch, use of existing .cloning field in the
> transport is fine, as the sole existing user of the field wants the
> field to mean "Are we starting with an empty object store?", and not
> "Are we running the command whose name is 'git clone'?".

Taking one step back, the root problem in this thread is that stat() on
non-existing files is slow (which makes has_sha1_file slow).

One solution there is to cache the results of looking in .git/objects
(or any alternate object store) for loose files. And indeed, this whole
scheme is just a specialized form of that: it's a flag to say "hey, we
do not have any objects yet, so do not bother looking".

Could we implement that in a more direct and central way? And could we
implement it in a way that catches more cases? E.g., if I have _one_
object, that defeats this specialized optimization, but it is probably
still beneficial to cache that knowledge (and the reasonable cutoff is
probably not 1, but some value of N loose objects).

Of course any cache raises questions of cache invalidation, but I think
we've already dealt with that for this case. When we use
OBJECT_INFO_QUICK, that is a sign that we want to make this kind of
accuracy/speed tradeoff (which does a similar caching thing with
packfiles).

So putting that all together, could we have something like:

diff --git a/object-store.h b/object-store.h
index 63b7605a3e..28cde568a0 100644
--- a/object-store.h
+++ b/object-store.h
@@ -135,6 +135,18 @@ struct raw_object_store {
 	 */
 	struct packed_git *all_packs;
 
+	/*
+	 * A set of all loose objects we have. This probably ought to be split
+	 * into a set of 256 caches so that we can fault in one directory at a
+	 * time.
+	 */
+	struct oid_array loose_cache;
+	enum {
+		LOOSE_CACHE_UNFILLED = 0,
+		LOOSE_CACHE_INVALID,
+		LOOSE_CACHE_VALID
+	} loose_cache_status;
+
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
diff --git a/packfile.c b/packfile.c
index 86074a76e9..68ca4fff0e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -990,6 +990,8 @@ void reprepare_packed_git(struct repository *r)
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
 	prepare_packed_git(r);
+	oid_array_clear(&r->objects->loose_cache);
+	r->objects->loose_cache_status = LOOSE_CACHE_UNFILLED;
 }
 
 struct packed_git *get_packed_git(struct repository *r)
diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..edbe037eaa 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1172,6 +1172,40 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
+/* probably should be configurable? */
+#define LOOSE_OBJECT_CACHE_MAX 65536
+
+static int fill_loose_cache(const struct object_id *oid,
+			    const char *path,
+			    void *data)
+{
+	struct oid_array *cache = data;
+
+	if (cache->nr == LOOSE_OBJECT_CACHE_MAX)
+		return -1;
+
+	oid_array_append(data, oid);
+	return 0;
+}
+
+static int quick_has_loose(struct raw_object_store *r,
+			   struct object_id *oid)
+{
+	struct oid_array *cache = &r->loose_cache;
+
+	if (r->loose_cache_status == LOOSE_CACHE_UNFILLED) {
+		if (for_each_loose_object(fill_loose_cache, cache, 0) < 0)
+			r->loose_cache_status = LOOSE_CACHE_INVALID;
+		else
+			r->loose_cache_status = LOOSE_CACHE_VALID;
+	}
+
+	if (r->loose_cache_status == LOOSE_CACHE_INVALID)
+		return -1;
+
+	return oid_array_lookup(cache, oid) >= 0;
+}
+
 static int sha1_loose_object_info(struct repository *r,
 				  const unsigned char *sha1,
 				  struct object_info *oi, int flags)
@@ -1198,6 +1232,19 @@ static int sha1_loose_object_info(struct repository *r,
 	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
+		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK)) {
+			struct object_id oid;
+			hashcpy(oid.hash, sha1);
+			switch (quick_has_loose(r->objects, &oid)) {
+			case 0:
+				return -1; /* missing: error */
+			case 1:
+				return 0; /* have: 0 == success */
+			default:
+				/* unknown; fall back to stat */
+				break;
+			}
+		}
 		if (stat_sha1_file(r, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)

That's mostly untested, but it might be enough to run some timing tests
with. I think if we want to pursue this, we'd want to address the bits I
mentioned in the comments, and look at unifying this with the loose
cache from cc817ca3ef (which if I had remembered we added, probably
would have saved some time writing the above ;) ).

-Peff
