From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: avoid excessive re-reading of pack directory
Date: Tue, 9 Jun 2015 13:24:37 -0400
Message-ID: <20150609172436.GA32034@peff.net>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
 <20150605121817.GA22125@peff.net>
 <20150605122921.GA7586@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
	git@vger.kernel.org
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Tue Jun 09 19:24:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2NGj-0001tv-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 19:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbbFIRYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 13:24:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:43491 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932623AbbFIRYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 13:24:45 -0400
Received: (qmail 16916 invoked by uid 102); 9 Jun 2015 17:24:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 12:24:43 -0500
Received: (qmail 17305 invoked by uid 107); 9 Jun 2015 17:24:46 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 13:24:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jun 2015 13:24:37 -0400
Content-Disposition: inline
In-Reply-To: <20150605122921.GA7586@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271204>

On Fri, Jun 05, 2015 at 08:29:21AM -0400, Jeff King wrote:

> On Fri, Jun 05, 2015 at 08:18:17AM -0400, Jeff King wrote:
> 
> >   1. Devise some torture to tests to see whether my patch series is in
> >      fact racy on Linux.
> >
> >   2. Assuming it is, scrap it and make a has_sha1_file_quick() which
> >      might sometimes return a false negative (if somebody else is
> >      repacking). Use that in index-pack (and possibly other places, but
> >      we can start with index-pack).
> > 
> > If we skip step 1 out of pessimism (which I think is a reasonable thing
> > to do), then step 2 should not be all that much work. I'm going to be
> > offline for a few days, though, so I won't get to it until next week at
> > the earliest. If you (or someone else) wants to take a stab at it,
> > please feel free.
> 
> Actually, it really is a tiny bit of work. I knocked this out in less
> than 10 minutes. It passes the test suite, but it's entirely possible
> that I did something boneheaded that does not fix your problem. ;)
> 
> Please test and confirm that it makes things better on your system.

I tested this on my system, and confirmed that for a "git clone
--no-local --bare git.git":

  1. It cuts the number of openat/getdents/close syscalls by several
     orders of magnitude.

  2. The overall time drops from ~11.4s to ~10.5s. I suppose if I timed
     only the `index-pack` process, it would be even higher (as a
     percentage improvement).

So I expect it should fix the problem on your NFS system.

Here's the patch again. Same as before, but I'm cc-ing Junio, as I think
it is good to apply.

-- >8 --
Subject: index-pack: avoid excessive re-reading of pack directory

Since 45e8a74 (has_sha1_file: re-check pack directory before
giving up, 2013-08-30), we spend extra effort for
has_sha1_file to give the right answer when somebody else is
repacking. Usually this effort does not matter, because
after finding that the object does not exist, the next step
is usually to die().

However, some code paths make a large number of
has_sha1_file checks which are _not_ expected to return 1.
The collision test in index-pack.c is such a case. On a
local system, this can cause a performance slowdown of
around 5%. But on a system with high-latency system calls
(like NFS), it can be much worse.

This patch introduces a "quick" flag to has_sha1_file which
callers can use when they would prefer high performance at
the cost of false negatives during repacks. There may be
other code paths that can use this, but the index-pack one
is the most obviously critical, so we'll start with
switching that one.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c |  2 +-
 cache.h              | 11 ++++++++++-
 sha1_file.c          |  4 +++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7ea2020..0761dfd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -784,7 +784,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	assert(data || obj_entry);
 
 	read_lock();
-	collision_test_needed = has_sha1_file(sha1);
+	collision_test_needed = has_sha1_file_with_flags(sha1, HAS_SHA1_QUICK);
 	read_unlock();
 
 	if (collision_test_needed && !data) {
diff --git a/cache.h b/cache.h
index 571c98f..98edc2c 100644
--- a/cache.h
+++ b/cache.h
@@ -943,8 +943,17 @@ extern int has_sha1_pack(const unsigned char *sha1);
  * Return true iff we have an object named sha1, whether local or in
  * an alternate object database, and whether packed or loose.  This
  * function does not respect replace references.
+ *
+ * If the QUICK flag is set, do not re-check the pack directory
+ * when we cannot find the object (this means we may give a false
+ * negative answer if another process is simultaneously repacking).
  */
-extern int has_sha1_file(const unsigned char *sha1);
+#define HAS_SHA1_QUICK 0x1
+extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
+static inline int has_sha1_file(const unsigned char *sha1)
+{
+	return has_sha1_file_with_flags(sha1, 0);
+}
 
 /*
  * Return true iff an alternate object database has a loose object
diff --git a/sha1_file.c b/sha1_file.c
index 7e38148..dc8746b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3161,7 +3161,7 @@ int has_sha1_pack(const unsigned char *sha1)
 	return find_pack_entry(sha1, &e);
 }
 
-int has_sha1_file(const unsigned char *sha1)
+int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	struct pack_entry e;
 
@@ -3169,6 +3169,8 @@ int has_sha1_file(const unsigned char *sha1)
 		return 1;
 	if (has_loose_object(sha1))
 		return 1;
+	if (flags & HAS_SHA1_QUICK)
+		return 0;
 	reprepare_packed_git();
 	return find_pack_entry(sha1, &e);
 }
-- 
2.4.2.752.geeb594a
