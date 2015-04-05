From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] address packed-refs speed regressions
Date: Sun, 5 Apr 2015 14:59:12 -0400
Message-ID: <20150405185911.GA19902@peff.net>
References: <20150405010611.GA15901@peff.net>
 <55213B93.9050207@web.de>
 <20150405185259.GB13096@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 05 20:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeplV-0004A0-TL
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 20:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbbDES7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 14:59:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:42673 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752377AbbDES7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 14:59:14 -0400
Received: (qmail 25043 invoked by uid 102); 5 Apr 2015 18:59:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 13:59:14 -0500
Received: (qmail 6413 invoked by uid 107); 5 Apr 2015 18:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 14:59:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2015 14:59:12 -0400
Content-Disposition: inline
In-Reply-To: <20150405185259.GB13096@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266814>

On Sun, Apr 05, 2015 at 02:52:59PM -0400, Jeff King wrote:

> Right now we parse all of the packed-refs file into an in-memory cache,
> and then do single lookups from that cache. Doing an mmap() and a binary
> search is way faster (and costs less memory) for doing individual
> lookups. It relies on the list being sorted. This is generally true, but
> not something we currently rely on (however, it would be easy to add a
> "sorted" flag to top of the file and have the readers fall back when the
> flag is missing). I've played with a patch to do this (it's not entirely
> trivial, because you jump into the middle of a line, and then have to
> walk backwards to find the start of the record).
> 
> For traversals, it's more complicated. Obviously if you are traversing
> all refs, you have to read the whole thing anyway. If you are traversing
> a subset of the refs, you can binary-search the start of the subset, and
> then walk forward. But that's where it gets tricky with the current
> code.

In case you are curious, here is my proof-of-concept for the packed-refs
binary search. You'll note that it's a separate program, and not
integrated into refs.c. I wrote this last August, and after trying to
integrate it into refs.c, I found the ref_cache problems I described,
and I haven't touched it since.

I also seem to have saved the patch for stuffing it into refs.c, but I
am not sure if it even compiles (I wrote only "horrible wip" in the
commit message ;) ).

-- >8 --
Subject: [PATCH] add git-quick-list

This is a proof of concept for binary-searching the
packed-refs file in order to traverse an ordered subset of
it. Note that it _only_ reads the packed-refs file
currently. To really compare to for-each-ref, it would need
to also walk the loose ref area for its prefix. On a
mostly-packed repository that shouldn't make a big speed
difference, though.

And of course we don't _really_ want a separate command here
at all. This should be part of refs.c, and everyone who
calls for_each_ref should benefit from it.

Still, the numbers are promising. Here's are comparisons
against for-each-ref on torvalds/linux, which has a 218M
packed-refs file:

  $ time git for-each-ref \
      --format='%(objectname) %(refname)' \
      refs/remotes/2325298/ |
      wc -c
  44139

  real    0m1.649s
  user    0m1.332s
  sys     0m0.304s

  $ time ~peff/git-quick-list refs/remotes/2325298/ | wc -c
  44139

  real    0m0.012s
  user    0m0.004s
  sys     0m0.004s
---
 Makefile     |   1 +
 quick-list.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 quick-list.c

diff --git a/Makefile b/Makefile
index 2457065..aa32598 100644
--- a/Makefile
+++ b/Makefile
@@ -541,6 +541,7 @@ PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += remote-testsvn.o
+PROGRAM_OBJS += quick-list.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
diff --git a/quick-list.c b/quick-list.c
new file mode 100644
index 0000000..e423f1f
--- /dev/null
+++ b/quick-list.c
@@ -0,0 +1,174 @@
+#include "cache.h"
+#include "refs.h"
+
+struct packed_refs_iterator {
+	const char *start;
+	const char *end;
+
+	const char *cur;
+	const char *ref;
+	const char *eol;
+	const char *next;
+};
+
+static void iterator_init(struct packed_refs_iterator *pos,
+			  const char *buf, size_t len)
+{
+	pos->start = buf;
+	pos->end = buf + len;
+
+	/* skip past header line */
+	if (pos->start < pos->end && *pos->start == '#') {
+		while (pos->start < pos->end && *pos->start != '\n')
+			pos->start++;
+		if (pos->start < pos->end)
+			pos->start++;
+	}
+}
+
+static int iterator_cmp(const char *key, struct packed_refs_iterator *pos)
+{
+	const char *ref = pos->ref;
+	for (; *key && ref < pos->eol; key++, ref++)
+		if (*key != *ref)
+			return (unsigned char)*key - (unsigned char)*ref;
+	return ref == pos->eol ? *key ? 1 : 0 : -1;
+}
+
+static const char *find_eol(const char *p, const char *end)
+{
+	p = memchr(p, '\n', end - p);
+	return p ? p : end;
+}
+
+static void parse_line(struct packed_refs_iterator *pos, const char *p)
+{
+	pos->cur = p;
+	if (pos->end - p < 41)
+		die("truncated packed-refs file");
+	p += 41;
+
+	pos->ref = p;
+	pos->eol = p = find_eol(p, pos->end);
+
+	/* skip newline, and then past any peel records */
+	if (p < pos->end)
+		p++;
+	while (p < pos->end && *p == '^') {
+		p = find_eol(p, pos->end);
+		if (p < pos->end)
+			p++;
+	}
+	pos->next = p;
+}
+
+static void iterator_next(struct packed_refs_iterator *pos)
+{
+	if (pos->next < pos->end)
+		parse_line(pos, pos->next);
+	else
+		pos->cur = NULL;
+}
+
+static void iterator_start(struct packed_refs_iterator *pos, const char *prefix)
+{
+	const char *lo = pos->start, *hi = pos->end;
+
+	while (lo < hi) {
+		const char *mi = lo + ((hi - lo) / 2);
+		int cmp;
+
+		/*
+		 * We landed somewhere on a line. Walk back to find
+		 * the start of the line.
+		 */
+		while (mi > lo && *(mi-1) != '\n')
+			mi--;
+
+		/*
+		 * We may have hit a peel-line. In that case, try
+		 * to walk back to the actual ref line (and skip as
+		 * many peel lines as we find, for future-proofing).
+		 */
+		while (*mi == '^') {
+			if (mi == lo)
+				die("peel line without a record before it?");
+			mi--;
+			if (mi == lo)
+				die("peel line with bare newline before it?");
+			mi--;
+			while (mi > lo && *(mi-1) != '\n')
+				mi--;
+		}
+
+		/* Now we should be at a real ref line. */
+		parse_line(pos, mi);
+		cmp = iterator_cmp(prefix, pos);
+		if (!cmp)
+			return;
+		else if (cmp < 0)
+			hi = pos->cur;
+		else
+			lo = pos->next;
+	}
+
+	if (hi < pos->end)
+		parse_line(pos, hi);
+	else
+		pos->cur = NULL;
+}
+
+static void quick_list(const char *prefix, each_ref_fn fn, void *data)
+{
+	int fd = open(git_path("packed-refs"), O_RDONLY);
+	struct stat st;
+	const char *buf = NULL;
+	size_t len;
+	struct packed_refs_iterator pos;
+
+	if (fd < 0)
+		goto out;
+	if (fstat(fd, &st) < 0)
+		goto out;
+	len = xsize_t(st.st_size);
+	buf = xmmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!buf)
+		goto out;
+
+	iterator_init(&pos, buf, len);
+	for (iterator_start(&pos, prefix);
+	     pos.cur && starts_with(pos.ref, prefix);
+	     iterator_next(&pos)) {
+		unsigned char sha1[20];
+		char *refname;
+
+		if (get_sha1_hex(pos.cur, sha1) < 0)
+			die("packed-refs contained invalid sha1");
+		refname = xmemdupz(pos.ref, pos.eol - pos.ref);
+		fn(refname, sha1, 0, data);
+		free(refname);
+	}
+
+out:
+	close(fd);
+	if (buf)
+		munmap((void *)buf, len);
+}
+
+static int show_ref(const char *refname, const unsigned char *sha1,
+		    int flags, void *data)
+{
+	printf("%s %s\n", sha1_to_hex(sha1), refname);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc != 2)
+		usage("git quick-list <prefix>");
+
+	setup_git_directory();
+	quick_list(argv[1], show_ref, NULL);
+
+	return 0;
+}
-- 
2.4.0.rc0.363.gf9f328b
