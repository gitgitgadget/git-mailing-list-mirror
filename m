From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Sun, 8 Jun 2014 08:04:39 -0400
Message-ID: <20140608120439.GA21827@sigill.intra.peff.net>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
 <20140604194353.23903.89933.chriscool@tuxfamily.org>
 <xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
 <CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
 <CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
 <CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
 <20140608112333.GA9691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 14:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtbqU-0007lX-Dn
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 14:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbaFHMEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 08:04:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:39714 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753582AbaFHMEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 08:04:42 -0400
Received: (qmail 26456 invoked by uid 102); 8 Jun 2014 12:04:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Jun 2014 07:04:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jun 2014 08:04:39 -0400
Content-Disposition: inline
In-Reply-To: <20140608112333.GA9691@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251055>

On Sun, Jun 08, 2014 at 07:23:33AM -0400, Jeff King wrote:

>   4. Keep a static commit_slab that points to the length for each parsed
>      commit. We pay the same memory cost as (2), but as it's not part of
>      the struct, the cache effects are minimized.

I think I favor this solution, which would look something like this:

-- >8 --
Subject: [PATCH] commit: add slab for commit buffer size

We store the commit object buffer for later reuse as
commit->buffer. However, since we store only a pointer, we
must treat the result as a NUL-terminated string. This is
generally OK for pretty-printing, but could be a problem for
other uses.

Adding a "len" member to "struct commit" would solve this,
but at the cost of bloating the struct even for callers who
do not care about the size or buffer (e.g., traversals like
rev-list or merge-base). Instead, let's use a commit_slab so
that the memory is used only when save_commit_buffer is in
effect (and even then, it should have less cache impact on
most uses of "struct commit").

Signed-off-by: Jeff King <peff@peff.net>
---
I think it would make sense to actually take this one step further,
though, and move commit->buffer into the slab, as well. That has two
advantages:

  1. It further decreases the size of "struct commit" for callers who do
     not use save_commit_buffer.

  2. It ensures that no new callers crop up who set "commit->buffer" but
     to not save the size in the slab (you can see in the patch below
     that I had to modify builtin/blame.c, which (ab)uses
     commit->buffer).

It would be more disruptive to existing callers, but I think the end
result would be pretty clean. The API would be something like:

  /* attach buffer to commit */
  set_commit_buffer(struct commit *, void *buf, unsigned long size);

  /* get buffer, either from slab cache or by calling read_sha1_file */
  void *get_commit_buffer(struct commit *, unsigned long *size);

  /* free() an allocated buffer from above, noop for cached buffer */
  void unused_commit_buffer(struct commit *, void *buf);

  /* drop saved commit buffer to free memory */
  void free_commit_buffer(struct commit *);

The "get" function would serve the existing callers in pretty.c, as well
as the one I'm adding elsewhere in show_signature. And it should work as
a drop-in read_sha1_file/free replacement for you here.

 builtin/blame.c |  2 +-
 commit.c        | 13 ++++++++++++-
 commit.h        |  1 +
 object.c        |  2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a52a279..1945ea4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2313,7 +2313,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		    ident, ident, path,
 		    (!contents_from ? path :
 		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
-	commit->buffer = strbuf_detach(&msg, NULL);
+	set_commit_buffer(commit, strbuf_detach(&msg, NULL), msg.len);
 
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
diff --git a/commit.c b/commit.c
index f479331..71143ed 100644
--- a/commit.c
+++ b/commit.c
@@ -302,6 +302,17 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	return 0;
 }
 
+define_commit_slab(commit_size_slab, unsigned long);
+static struct commit_size_slab commit_size;
+
+void set_commit_buffer(struct commit *item, void *buffer, unsigned long size)
+{
+	if (!commit_size.stride)
+		init_commit_size_slab(&commit_size);
+	*commit_size_slab_at(&commit_size, item) = size;
+	item->buffer = buffer;
+}
+
 int parse_commit(struct commit *item)
 {
 	enum object_type type;
@@ -324,7 +335,7 @@ int parse_commit(struct commit *item)
 	}
 	ret = parse_commit_buffer(item, buffer, size);
 	if (save_commit_buffer && !ret) {
-		item->buffer = buffer;
+		set_commit_buffer(item, buffer, size);
 		return 0;
 	}
 	free(buffer);
diff --git a/commit.h b/commit.h
index a9f177b..7704ab2 100644
--- a/commit.h
+++ b/commit.h
@@ -48,6 +48,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
 struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_name);
 
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
+void set_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 int parse_commit(struct commit *item);
 void parse_commit_or_die(struct commit *item);
 
diff --git a/object.c b/object.c
index 57a0890..c1c6a24 100644
--- a/object.c
+++ b/object.c
@@ -198,7 +198,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
 			if (!commit->buffer) {
-				commit->buffer = buffer;
+				set_commit_buffer(commit, buffer, size);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
-- 
2.0.0.729.g520999f
