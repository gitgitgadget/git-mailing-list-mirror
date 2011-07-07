From: Jeff King <peff@peff.net>
Subject: Re: generation numbers (was: [PATCH 0/4] Speed up git tag --contains)
Date: Thu, 7 Jul 2011 14:59:08 -0400
Message-ID: <20110707185908.GB12044@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706150103.GA2693@thunk.org>
 <20110706181200.GD17978@sigill.intra.peff.net>
 <201107062046.43820.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 20:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QetnB-0005Ti-CR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 20:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab1GGS7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 14:59:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33631
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab1GGS7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 14:59:10 -0400
Received: (qmail 1569 invoked by uid 107); 7 Jul 2011 18:59:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jul 2011 14:59:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2011 14:59:08 -0400
Content-Disposition: inline
In-Reply-To: <201107062046.43820.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176770>

On Wed, Jul 06, 2011 at 08:46:42PM +0200, Jakub Narebski wrote:

> > > Is it worth it to try to replicate this information across repositories?
> > 
> > Probably not. I suggested notes-cache just because the amount of code is
> > very trivial.
> 
> Well, generation numbers are universal and would help everybody.  For
> new commits with 'generation' header those would be always replicated,
> for old commits with 'generation' notes / notes-cache the can be
> replicated.

Sure. But it's not worth trying to transfer them between repositories,
when it only takes a few seconds to generate them locally (approximately
the same amount of time that "git rev-list --all >/dev/null" takes).

> > One problem with notes storage is that it's not well optimized for tiny
> > pieces of data like this (e.g., the generation number should fit in a
> > 32-bit unsigned int, as its max is the size of the longest single path
> > in the history graph). But notes are much more general; we will actually
> > map each commit to a blob object containing the generation number, which
> > is pretty wasteful.
> 
> Wasn't textconv-cache using commit-less notes?  The same can be done
> for generation notes-cache.

No, textconv actually uses parentless commits. But the issue I'm talking
about is not the history storage. It's the value storage. Instead of
pointing to a 32-bit int, we point to a 160-bit sha1 that references an
object containing the value (and the object header is going to be as big
as the value itself). So it's wasteful in storage, and it's wasteful in
the amount of work to do a lookup.

You could "cheat" and instead of storing the sha1 of a blob object in
the notes tree, use the lower 32 bits to store an actual value. I don't
think that currently breaks any assumptions in the notes code, but it
definitely is against the intent of it.

I wrote a patch to calculate and cache commit generation numbers on the
fly, and output them via the "%G" format placeholder. So we can get some
timings (these are from git.git):

  # baseline to compare against; print the commiter timestamp of every
  # commit, which is about how expensive it would be to parse and print
  # an embedded generation number
  $ time git log --format=%ct >/dev/null
  real    0m0.388s
  user    0m0.380s
  sys     0m0.004s

  # and the baseline amount of storage used (fully packed)
  $ du -s .git/objects
  47072   .git/objects

  # now the cost to generate the whole cache; slower, obviously, but it
  # only needs to happen once
  $ time git log --format=%G >/dev/null
  real    0m2.180s
  user    0m1.204s
  sys     0m0.960s

  # at which point everything is loose, and we are wasting tons of space
  $ du -s .git/objects
  171692  .git/objects

  # and traversing with generation lookup is still a bit slower than
  # without it
  $ time git log --format=%G >/dev/null
  real    0m0.822s
  user    0m0.544s
  sys     0m0.272s

  # but repacking helps with the space; now we're using only ~3M
  $ git gc
  $ du -s .git/objects
  50236   .git/objects

  # and traversal is faster, but still about 33% slower than our
  # baseline
  real    0m0.490s
  user    0m0.468s
  sys     0m0.020s

So I suspect we could do better with a data structure optimized for this
type of storage.

> Though it is still wasteful...  By the way, would we be using text
> representation (like in 'generation' commit header) or 32-bit integer
> binary representation in some ordering, or variable-length integer (I
> think git uses them somewhere)?

For a local lookup cache, I would use a fixed-size binary integer just
to keep the lookup data structure simple (then you know the width of
each record ahead of time). For a generation commit header, obviously we
would go with the ascii representation as we do for other headers.

> Nb. I wonder if 32-bit unsigned int would always be enough, for example
> Linux kernel + history.

Yeah, it should be plenty. There are only 250K commits in linux-2.6, and
the absolute worst case generation number is 250K (if they are all
linear). But the history is an n-ary tree, and the highest generation is
actually the height of the tree. So the more branchy the history, the
smaller the height.

The generation of v3.0-rc6, representing 6 years of history, is 79044.
At that rate, the linux-2.6 repository will overflow in a mere 320,000
years.

> I think it would be simpler to use generation header + generation notes.
> Or start with generation notes only.

The patch implementing generation notes is below. The implementation is
quite simple, but it would be nice if it were faster.

---
 commit.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h |    2 +
 pretty.c |    3 ++
 3 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index ac337c7..493517c 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "notes-cache.h"
 
 int save_commit_buffer = 1;
 
@@ -878,3 +879,83 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_release(&buffer);
 	return result;
 }
+
+static struct notes_cache generations;
+
+static int generation_from_cache(struct commit *c, unsigned long *g)
+{
+	char *buf, *end;
+	size_t len;
+
+	buf = notes_cache_get(&generations, c->object.sha1, &len);
+	if (!buf)
+		return -1;
+
+	errno = 0;
+	*g = strtoul(buf, &end, 10);
+	if (errno == ERANGE || *end != '\0') {
+		free(buf);
+		return -1;
+	}
+
+	free(buf);
+	return 0;
+}
+
+static void generation_to_cache(struct commit *c, unsigned long g)
+{
+	char buf[64];
+	int len;
+
+	len = snprintf(buf, sizeof(buf), "%lu", g);
+	notes_cache_put(&generations, c->object.sha1, buf, len);
+}
+
+static unsigned long commit_generation_recurse(struct commit *c)
+{
+	struct commit_list *p;
+	unsigned long r;
+
+	if (!generation_from_cache(c, &r))
+		return r;
+
+	if (parse_commit(c) < 0)
+		die("unable to parse commit: %s", sha1_to_hex(c->object.sha1));
+
+	if (!c->parents)
+		return 0;
+
+	r = 0;
+	for (p = c->parents; p; p = p->next) {
+		unsigned long pgen = commit_generation_recurse(p->item);
+		if (pgen > r)
+			r = pgen;
+	}
+	r++;
+
+	generation_to_cache(c, r);
+	return r;
+}
+
+int installed_generation_writer;
+static void write_generation_cache(void)
+{
+	notes_cache_write(&generations);
+}
+
+unsigned long commit_generation(const struct commit *commit)
+{
+	unsigned long r;
+
+	if (!generations.tree.initialized)
+		notes_cache_init(&generations, "generations", "v1");
+
+	r = commit_generation_recurse((struct commit *)commit);
+
+	if (!installed_generation_writer) {
+		atexit(write_generation_cache);
+		installed_generation_writer = 1;
+	}
+
+	return r;
+}
diff --git a/commit.h b/commit.h
index a2d571b..bff6b36 100644
--- a/commit.h
+++ b/commit.h
@@ -176,4 +176,6 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
 
+unsigned long commit_generation(const struct commit *commit);
+
 #endif /* COMMIT_H */
diff --git a/pretty.c b/pretty.c
index f45eb54..8f1b321 100644
--- a/pretty.c
+++ b/pretty.c
@@ -965,6 +965,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			return 2;
 		}
 		return 0;	/* unknown %g placeholder */
+	case 'G':
+		strbuf_addf(sb, "%lu", commit_generation(commit));
+		return 1;
 	case 'N':
 		if (c->pretty_ctx->show_notes) {
 			format_display_notes(commit->object.sha1, sb,
-- 
1.7.6.7.ge7132.dirty
