From: Jeff King <peff@peff.net>
Subject: Re: another packed-refs race
Date: Mon, 6 May 2013 18:18:28 -0400
Message-ID: <20130506221828.GA19851@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
 <51879C1C.5000407@alum.mit.edu>
 <20130506184122.GA23568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 00:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZTjw-0002iC-4O
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 00:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab3EFWSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 18:18:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:41949 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756251Ab3EFWSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 18:18:31 -0400
Received: (qmail 1116 invoked by uid 102); 6 May 2013 22:18:51 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 17:18:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 18:18:28 -0400
Content-Disposition: inline
In-Reply-To: <20130506184122.GA23568@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223512>

On Mon, May 06, 2013 at 02:41:22PM -0400, Jeff King wrote:

> That is a weaker guarantee, and I think we can provide it with:
> 
>   1. Load all loose refs into cache for a particular enumeration.
> 
>   2. Make sure the packed-refs cache is up-to-date (by checking its
>      stat() information and reloading if necessary).
> 
>   3. Run the usual iteration over the loose/packed ref caches.

This does seem to work in my experiments. With stock git, I can trigger
the race reliably with:

  # base load, in one terminal, as before
  git init -q repo &&
  cd repo &&
  git commit -q --allow-empty -m one &&
  one=`git rev-parse HEAD` &&
  git commit -q --allow-empty -m two &&
  two=`git rev-parse HEAD` &&
  sha1=$one &&
  while true; do
    # this re-creates the loose ref in .git/refs/heads/master
    if test "$sha1" = "$one"; then
      sha1=$two
    else
      sha1=$one
    fi &&
    git update-ref refs/heads/master $sha1 &&

    # we can remove packed-refs safely, as we know that
    # its only value is now stale. Real git would not do
    # this, but we are simulating the case that "master"
    # simply wasn't included in the last packed-refs file.
    rm -f .git/packed-refs &&

    # and now we repack, which will create an up-to-date
    # packed-refs file, and then delete the loose ref
    git pack-refs --all --prune
  done

  # in another terminal, enumerate and make sure we never miss the ref
  cd repo &&
  while true; do
    refs=`git.compile for-each-ref --format='%(refname)'`
    echo "==> $refs"
    test -z "$refs" && break
  done

It usually takes about 30 seconds to hit a problem, though I measured
failures at up to 90 seconds. With the patch below (on top of the one I
posted the other day, which refreshes the packed-refs cache in
get_packed_refs), it has been running fine for 15 minutes.

The "noop_each_fn" is a little gross. I could also just reimplement the
recursion from do_for_each_ref_in_dir (except we don't care about flags,
trim, base, etc, and would just be calling get_ref_dir recursively).
It's a slight repetition of code, but it would be less subtle than what
I have written below (which uses a no-op callback for the side effect
that it primes the loose ref cache). Which poison do you prefer?

diff --git a/refs.c b/refs.c
index 45a7ee6..59ae7e4 100644
--- a/refs.c
+++ b/refs.c
@@ -1363,19 +1363,38 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
+static int noop_each_fn(const char *ref, const unsigned char *sha1, int flags,
+			void *data)
+{
+	return 0;
+}
+
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_dir *packed_dir = get_packed_refs(refs);
-	struct ref_dir *loose_dir = get_loose_refs(refs);
+	struct ref_dir *packed_dir;
+	struct ref_dir *loose_dir;
 	int retval = 0;
 
-	if (base && *base) {
-		packed_dir = find_containing_dir(packed_dir, base, 0);
+	/*
+	 * Prime the loose ref cache; we must make sure the packed ref cache is
+	 * uptodate after we read the loose refs in order to avoid race
+	 * conditions with a simultaneous "pack-refs --prune".
+	 */
+	loose_dir = get_loose_refs(refs);
+	if (base && *base)
 		loose_dir = find_containing_dir(loose_dir, base, 0);
+	if (loose_dir) {
+		sort_ref_dir(loose_dir);
+		do_for_each_ref_in_dir(loose_dir, 0, base, noop_each_fn, 0, 0,
+				       NULL);
 	}
 
+	packed_dir = get_packed_refs(refs);
+	if (base && *base)
+		packed_dir = find_containing_dir(packed_dir, base, 0);
+
 	if (packed_dir && loose_dir) {
 		sort_ref_dir(packed_dir);
 		sort_ref_dir(loose_dir);
