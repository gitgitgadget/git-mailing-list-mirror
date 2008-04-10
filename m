From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Wed, 9 Apr 2008 20:03:49 -0400
Message-ID: <20080410000349.GA16800@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkHa-0004gj-0l
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbYDJADw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbYDJADv
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2281 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbYDJADu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:50 -0400
Received: (qmail 23610 invoked by uid 111); 10 Apr 2008 00:03:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 20:03:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 20:03:49 -0400
Content-Disposition: inline
In-Reply-To: <20080409225112.GB12103@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79159>

On Wed, Apr 09, 2008 at 06:51:12PM -0400, Jeff King wrote:

> > >   From git://host/path/to/repo
> > >    * [new branch]      foo -> FETCH_HEAD

As it turns out, there is already code to do this very thing, but:

  1. it was broken ;)

  2. you need to specify "-v"erbose mode to see it

Here is a patch that fixes the breakage, which should be done either
way. If people think this is a good thing to show in general (and I do,
but then I am not a very frequent user of "fetch without tracking
branches"), then there is an obvious one-liner to make it always show.

-- >8 --
git-fetch: fix status output when not storing tracking ref

There was code in update_local_ref for handling this case,
but it never actually got called. It assumed that storing in
FETCH_HEAD meant a blank peer_ref name, but we actually have
a NULL peer_ref in this case, so we never even made it to
the update_local_ref function.

On top of that, the display formatting was different from
all of the other cases, probably owing to the fact that
nobody had ever actually seen the output.

This patch harmonizes the output with the other cases and
moves the detection of this case into store_updated_refs,
where we can actually trigger it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-fetch.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 5841b3e..139a6b1 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -215,13 +215,6 @@ static int update_local_ref(struct ref *ref,
 	if (type < 0)
 		die("object %s not found", sha1_to_hex(ref->new_sha1));
 
-	if (!*ref->name) {
-		/* Not storing */
-		if (verbose)
-			sprintf(display, "* branch %s -> FETCH_HEAD", remote);
-		return 0;
-	}
-
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbose)
 			sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
@@ -365,16 +358,21 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 			rm->merge ? "" : "not-for-merge",
 			note);
 
-		if (ref) {
+		if (ref)
 			update_local_ref(ref, what, verbose, note);
-			if (*note) {
-				if (!shown_url) {
-					fprintf(stderr, "From %.*s\n",
-							url_len, url);
-					shown_url = 1;
-				}
-				fprintf(stderr, " %s\n", note);
+		else if (verbose)
+			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
+				SUMMARY_WIDTH, *kind ? kind : "branch",
+				 REFCOL_WIDTH, *what ? what : "HEAD");
+		else
+			*note = '\0';
+		if (*note) {
+			if (!shown_url) {
+				fprintf(stderr, "From %.*s\n",
+						url_len, url);
+				shown_url = 1;
 			}
+			fprintf(stderr, " %s\n", note);
 		}
 	}
 	fclose(fp);
-- 
1.5.5.25.g43bd4.dirty
