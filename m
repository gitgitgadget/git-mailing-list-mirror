From: Jeff King <peff@peff.net>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 10:56:07 -0500
Message-ID: <20121108155607.GD15560@sigill.intra.peff.net>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:56:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWUSy-0006n8-5E
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 16:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab2KHP4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 10:56:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36376 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab2KHP4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 10:56:11 -0500
Received: (qmail 30283 invoked by uid 107); 8 Nov 2012 15:56:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 10:56:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 10:56:07 -0500
Content-Disposition: inline
In-Reply-To: <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209167>

On Wed, Nov 07, 2012 at 11:32:37AM -0600, Uri Moszkowicz wrote:

>   #4  parse_object (sha1=0xb0ee98
> "\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D") at
> object.c:212
>   #5  0x00000000004ae9ec in handle_one_ref (path=0xb0eec0
> "refs/tags/<removed>", sha1=0xb0ee98
> "\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D", flags=2,
> cb_data=<optimized out>) at pack-refs.
>
> [...]
> 
> It looks like handle_one_ref() is called for each ref and most result
> in a call to read_sha1_file().

Right. When generating the packed-refs file, we include the "peeled"
reference for a tag (i.e., the commit that a tag object points to). So
we have to actually read any tag objects to get the value.

The upload-pack program generates a similar list, and I recently added
some optimizations. This code path could benefit from some of them by
using "peel_ref" instead of hand-rolling the tag dereferencing. The main
optimization, though, is reusing peeled values that are already in
packed-refs; we would probably need some additional magic to reuse the
values from the source repository.

However:

> It only takes a second or so for each call but when you have thousands
> of them (one for each ref) it adds up.

I am more concerned that it takes a second to read each tag. Even in my
pathological tests for optimizing upload-pack, peeling 50,000 refs took
only half a second.

> Adding --single-branch --branch <branch> doesn't appear to help as
> it is implemented afterwards. I would like to debug this problem
> further but am not familiar enough with the implementation to know
> what the next step is. Can anyone offer some suggestions? I don't see
> why a clone should be dependent on an O(#refs) operations.

Does this patch help? In a sample repo with 5000 annotated tags, it
drops my local clone time from 0.20s to 0.11s. Which is a big percentage
speedup, but this code isn't taking a long time in the first place for
me.

---
diff --git a/pack-refs.c b/pack-refs.c
index f09a054..3344749 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -40,13 +40,9 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 
 	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
 	if (is_tag_ref) {
-		struct object *o = parse_object(sha1);
-		if (o->type == OBJ_TAG) {
-			o = deref_tag(o, path, 0);
-			if (o)
-				fprintf(cb->refs_file, "^%s\n",
-					sha1_to_hex(o->sha1));
-		}
+		unsigned char peeled[20];
+		if (!peel_ref(path, peeled))
+			fprintf(cb->refs_file, "^%s\n", sha1_to_hex(peeled));
 	}
 
 	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
