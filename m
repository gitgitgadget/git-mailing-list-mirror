From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: protect against disappearing packs
Date: Thu, 13 Oct 2011 21:31:30 -0400
Message-ID: <20111014013130.GA7163@sigill.intra.peff.net>
References: <20111014012320.GA4395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-dev@github.com, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 03:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REWdB-0007hF-Hh
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 03:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab1JNBbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 21:31:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60084
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab1JNBbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 21:31:33 -0400
Received: (qmail 32394 invoked by uid 107); 14 Oct 2011 01:31:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Oct 2011 21:31:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2011 21:31:30 -0400
Content-Disposition: inline
In-Reply-To: <20111014012320.GA4395@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183531>

On Thu, Oct 13, 2011 at 09:23:20PM -0400, Jeff King wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 2b18de5..8681ccd 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -804,6 +804,10 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  		off_t offset = find_pack_entry_one(sha1, p);
>  		if (offset) {
>  			if (!found_pack) {
> +				if (!is_pack_valid(p)) {
> +					error("packfile %s cannot be accessed", p->pack_name);
> +					continue;
> +				}

This message is modeled after the one in find_pack_entry. However,
they're not really errors, since we will try to find the object
elsewhere (and generally succeed). So the messages could just go away.
Though they can also alert you to something fishy going on (like a
packfile with bad permissions). But perhaps we should downgrade them
like this:

-- >8 --
Subject: [PATCH] downgrade "packfile cannot be accessed" errors to warnings

These can happen if another process simultaneously prunes a
pack. But that is not usually an error condition, because a
properly-running prune should have repacked the object into
a new pack. So we will notice that the pack has disappeared
unexpectedly, print a message, try other packs (possibly
after re-scanning the list of packs), and find it in the new
pack.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c |    2 +-
 sha1_file.c            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8681ccd..ba3705d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -805,7 +805,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		if (offset) {
 			if (!found_pack) {
 				if (!is_pack_valid(p)) {
-					error("packfile %s cannot be accessed", p->pack_name);
+					warning("packfile %s cannot be accessed", p->pack_name);
 					continue;
 				}
 				found_offset = offset;
diff --git a/sha1_file.c b/sha1_file.c
index a22c5b4..27f3b9b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2038,7 +2038,7 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 			 * was loaded!
 			 */
 			if (!is_pack_valid(p)) {
-				error("packfile %s cannot be accessed", p->pack_name);
+				warning("packfile %s cannot be accessed", p->pack_name);
 				goto next;
 			}
 			e->offset = offset;
-- 
1.7.6.4.37.g43b58b
