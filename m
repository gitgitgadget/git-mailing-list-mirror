From: Jeff King <peff@peff.net>
Subject: Re: How to fix (and find) many git-* --check errors?
Date: Fri, 8 Aug 2008 09:23:26 -0400
Message-ID: <20080808132326.GC19705@sigill.intra.peff.net>
References: <489C40BC.8000008@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=22Peter_Valdemar_M=C3=B8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 15:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRRxG-0008NI-8d
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 15:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYHHNX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 09:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbYHHNX2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 09:23:28 -0400
Received: from peff.net ([208.65.91.99]:2995 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbYHHNX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 09:23:27 -0400
Received: (qmail 20047 invoked by uid 111); 8 Aug 2008 13:23:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 08 Aug 2008 09:23:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Aug 2008 09:23:26 -0400
Content-Disposition: inline
In-Reply-To: <489C40BC.8000008@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91664>

On Fri, Aug 08, 2008 at 02:49:00PM +0200, "Peter Valdemar M=C3=B8rch (L=
ists)" wrote:

> (The diff between "the empty commit" and HEAD - well between the firs=
t
> commit and HEAD anyway. Is there a ref for "totally empty" or the
> revision before the first commit? Or a more elegant way to get this
> list?)

It is not advertised, but we always recognize the empty sha1 of the
empty tree:

  git diff --check 4b825dc642cb6eb9a060e54bf8d69288fbee4904

In fact, just the other day I was using this for the Nth time and got
tired of looking it up in the code, so I wrote the patch below. I don't
know if it is too crazy to be included in mainline git (it was discusse=
d
a long time ago, but I think the general response was "what would it be
good for?").

---
 cache.h     |    4 ++++
 refs.c      |    4 ++++
 sha1_file.c |    3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 30f1d62..4aa02ae 100644
--- a/cache.h
+++ b/cache.h
@@ -567,6 +567,10 @@ static inline unsigned int hexval(unsigned char c)
 #define MINIMUM_ABBREV 4
 #define DEFAULT_ABBREV 7
=20
+#define EMPTY_TREE_SHA1 \
+	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
+	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode(const char *str, unsigned char *sha1, un=
signed *mode);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
diff --git a/refs.c b/refs.c
index 39a3b23..0acbcbc 100644
--- a/refs.c
+++ b/refs.c
@@ -427,6 +427,10 @@ const char *resolve_ref(const char *ref, unsigned =
char *sha1, int reading, int *
 				}
 				list =3D list->next;
 			}
+			if (!strcmp(ref, "EMPTY")) {
+				hashcpy(sha1, (unsigned char *)EMPTY_TREE_SHA1);
+				return ref;
+			}
 			if (reading || errno !=3D ENOENT)
 				return NULL;
 			hashclr(sha1);
diff --git a/sha1_file.c b/sha1_file.c
index 2aff59b..38aad13 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1985,8 +1985,7 @@ static int cached_object_nr, cached_object_alloc;
=20
 static struct cached_object empty_tree =3D {
 	/* empty tree sha1: 4b825dc642cb6eb9a060e54bf8d69288fbee4904 */
-	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60"
-	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04",
+	EMPTY_TREE_SHA1,
 	OBJ_TREE,
 	"",
 	0
--=20
1.6.0.rc1.260.g4782
