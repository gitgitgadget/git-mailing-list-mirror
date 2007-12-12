From: Jeff King <peff@peff.net>
Subject: Re: git annotate runs out of memory
Date: Wed, 12 Dec 2007 02:57:25 -0500
Message-ID: <20071212075725.GA7676@coredump.intra.peff.net>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org> <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 08:57:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2MTW-00008m-Op
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 08:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbXLLH53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 02:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbXLLH53
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 02:57:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3440 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbXLLH52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 02:57:28 -0500
Received: (qmail 31962 invoked by uid 111); 12 Dec 2007 07:57:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Dec 2007 02:57:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2007 02:57:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68005>

On Tue, Dec 11, 2007 at 11:50:08AM -0800, Linus Torvalds wrote:

> And, btw: the diff is totally different from the xdelta we have, so even 
> if we have an already prepared nice xdelta between the two versions, we'll 
> end up re-generating the files in full, and then do a diff on the end 
> result.
> 
> Of course, part of that is that git logically *never* works with deltas, 
> except in the actual code-paths that generate objects (or generate packs, 
> of course). So even if we had used a delta algorithm that would be 
> amenable to be turned into a diff directly, it would have been a layering 
> violation to actually do that.

That doesn't mean we can't opportunistically jump layers when available,
and fall back on the regular behavior otherwise. The nice thing about
clean and simple layers is that you can always add optimizations later
by poking sane holes.

Let's assume for the sake of argument that we can convert an xdelta into
a diff fairly cheaply.  Using the patch below, we can count the places
where we are diffing two blobs, and one blob is a delta base of the
other (assuming our magical conversion function can also reverse diffs.
;) ).

For a "git log -p" on git.git, I get:

   9951 diffs could be optimized
  10958 diffs could not be optimized

or about 48%. It would be nice if we could drop the cost by almost 50%
(if our magical function is free to call, too!).

Of course, I haven't even looked at whether converting xdeltas to
unified diffs is possible. I suspect in some cases it is (e.g., pure
addition of text) and in some cases it isn't (I assume xdelta doesn't
have any context lines, which might hurt). And it's possible that a
specialized diff user like git-blame can just learn to use the xdeltas
by itself (I didn't get a "could optimize" count for git-blame since
it seems to follow a different codepath for its diffs).

---
diff --git a/cache.h b/cache.h
index 27d90fe..0d672be 100644
--- a/cache.h
+++ b/cache.h
@@ -569,6 +569,7 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern int have_xdelta(unsigned char from[20], unsigned char to[20]);
 extern int matches_pack_name(struct packed_git *p, const char *name);
 
 /* Dumb servers support */
diff --git a/diff.c b/diff.c
index f780e3e..5402900 100644
--- a/diff.c
+++ b/diff.c
@@ -1299,6 +1299,10 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
+	fprintf(stderr, "could optimize: %s\n",
+			(have_xdelta(one->sha1, two->sha1) ||
+			have_xdelta(two->sha1, one->sha1)) ? "yes" : "no");
+
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
diff --git a/sha1_file.c b/sha1_file.c
index b0c2435..f811ddc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2422,3 +2422,20 @@ int read_pack_header(int fd, struct pack_header *header)
 		return PH_ERROR_PROTOCOL;
 	return 0;
 }
+
+int have_xdelta(unsigned char from[20], unsigned char to[20])
+{
+	struct pack_entry e;
+	unsigned char base_sha1[20];
+	const char *type;
+	unsigned long size;
+	unsigned long store_size;
+	unsigned int delta_chain_length;
+
+	if (!find_pack_entry(to, &e, NULL))
+		return 0;
+
+	type = packed_object_info_detail(e.p, e.offset, &size, &store_size,
+					 &delta_chain_length, base_sha1);
+	return !hashcmp(base_sha1, from);
+}
