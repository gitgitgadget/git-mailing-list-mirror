Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473252D627
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0BED6C
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 14:02:56 -0800 (PST)
Received: (qmail 21605 invoked by uid 109); 13 Nov 2023 22:02:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 22:02:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7125 invoked by uid 111); 13 Nov 2023 22:02:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 17:02:57 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 17:02:54 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <20231113220254.GA2065691@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>

On Fri, Nov 10, 2023 at 03:51:18PM -0800, Elijah Newren wrote:

> This is unsafe; the object may need to be read later within the same
> merge. [...]
>
> I think (untested) that you could fix this by creating two packs
> instead of just one.  In particular, add a call to
> flush_odb_transcation() after the "redo_after_renames" block in
> merge_ort_nonrecursive_internal().

It might not be too hard to just let in-process callers access the
objects we've written. A quick and dirty patch is below, which works
with the test you suggested (the test still fails because it finds a
conflict, but it gets past the "woah, I can't find that sha1" part).

I don't know if that is sufficient, though. Would other spawned
processes (hooks, external merge drivers, and so on) need to be able to
see these objects, too?

The patch teaches the packfile code about the special bulk checkin pack.
It might be cleaner to invert it, and just have the bulk checkin code
register a magic packed_git (it would need to fake the .idx somehow).

diff --git a/bulk-checkin.c b/bulk-checkin.c
index bd6151ba3c..566fc36e68 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -30,6 +30,8 @@ static struct bulk_checkin_packfile {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
+
+	struct packed_git *fake_packed_git;
 } bulk_checkin_packfile;
 
 static void finish_tmp_packfile(struct strbuf *basename,
@@ -82,6 +84,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 
 clear_exit:
 	free(state->written);
+	free(state->fake_packed_git);
 	memset(state, 0, sizeof(*state));
 
 	strbuf_release(&packname);
@@ -530,3 +533,37 @@ void end_odb_transaction(void)
 
 	flush_odb_transaction();
 }
+
+static struct packed_git *fake_packed_git(struct bulk_checkin_packfile *state)
+{
+	struct packed_git *p = state->fake_packed_git;
+	if (!p) {
+		FLEX_ALLOC_STR(p, pack_name, "/fake/in-progress.pack");
+		state->fake_packed_git = p;
+		p->pack_fd = state->f->fd;
+		p->do_not_close = 1;
+	}
+
+	hashflush(state->f);
+	p->pack_size = state->f->total; /* maybe add 20 to simulate trailer? */
+
+	return p;
+}
+
+int bulk_checkin_pack_entry(const struct object_id *oid, struct pack_entry *e)
+{
+	size_t i;
+	/*
+	 * this really ought to have some more efficient data structure for
+	 * lookup; ditto for the existing already_written()
+	 */
+	for (i = 0; i < bulk_checkin_packfile.nr_written; i++) {
+		struct pack_idx_entry *p = bulk_checkin_packfile.written[i];
+		if (oideq(&p->oid, oid)) {
+			e->p = fake_packed_git(&bulk_checkin_packfile);
+			e->offset = p->offset;
+			return 0;
+		}
+	}
+	return -1;
+}
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 89786b3954..153fe87c06 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -44,4 +44,7 @@ void flush_odb_transaction(void);
  */
 void end_odb_transaction(void);
 
+struct pack_entry;
+int bulk_checkin_pack_entry(const struct object_id *oid, struct pack_entry *e);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 9cc0a2e37a..05194b1d9b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -23,6 +23,7 @@
 #include "commit-graph.h"
 #include "pack-revindex.h"
 #include "promisor-remote.h"
+#include "bulk-checkin.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *hash,
@@ -2045,6 +2046,9 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	struct list_head *pos;
 	struct multi_pack_index *m;
 
+	if (!bulk_checkin_pack_entry(oid, e))
+		return 1;
+
 	prepare_packed_git(r);
 	if (!r->objects->packed_git && !r->objects->multi_pack_index)
 		return 0;
