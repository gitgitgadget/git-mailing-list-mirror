From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 26 Mar 2012 15:51:50 -0400
Message-ID: <20120326195150.GA13098@sigill.intra.peff.net>
References: <20120320043133.GA2755@gmail.com>
 <20120323214114.GB18198@sigill.intra.peff.net>
 <20120326192001.GB32387@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFxP-0007WU-0A
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab2CZTvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:51:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60143
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab2CZTvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:51:52 -0400
Received: (qmail 16442 invoked by uid 107); 26 Mar 2012 19:52:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 15:52:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 15:51:50 -0400
Content-Disposition: inline
In-Reply-To: <20120326192001.GB32387@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193965>

On Mon, Mar 26, 2012 at 03:20:01PM -0400, Christopher Tiwald wrote:

> I used the REF_STATUS_* enum as a template for what I wanted to accomplish
> when authoring v1, but did notice there was no other place my new
> options made much sense (Junio helped me remove one other call between v1
> and v2). I like the readability fixup, but it won't compile as both push.c
> and transport.c need to see these. Would something like the following
> work? It simply moves the define statements to cache.h, so that both push and
> transport can use them.

My suggestion put them in transport.h, which is included from both
places. It compiles fine for me. Am I missing something?

Generally I would try to keep their definition near the function
interface which uses them (i.e., transport_push). But I don't feel that
strongly about it.

Your patch is already in 'next', so we will have to build on top rather
than squashing. So here it is with an actual commit message:

-- >8 --
Subject: [PATCH] clean up struct ref's nonfastforward field

Each ref structure contains a "nonfastforward" field which
is set during push to show whether the ref rewound history.
Originally this was a single bit, but it was changed in
f25950f (push: Provide situational hints for non-fast-forward
errors) to an enum differentiating a non-ff of the current
branch versus another branch.

However, we never actually set the member according to the
enum values, nor did we ever read it expecting anything but
a boolean value. But we did use the side effect of declaring
the enum constants to store those values in a totally
different integer variable. The code as-is isn't buggy, but
the enum declaration inside "struct ref" is somewhat
misleading.

Let's convert nonfastforward back into a single bit, and
then define the NON_FF_* constants closer to where they
would be used (they are returned via the "int *nonfastforward"
parameter to transport_push, so we can define them there).

Signed-off-by: Jeff King <peff@peff.net>
---
This is the least-invasive patch. You could also turn the "int
*nonfastforward" into an enum, which might be even more readable.

 cache.h     |    5 +----
 transport.h |    2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 427b600..35f3075 100644
--- a/cache.h
+++ b/cache.h
@@ -1009,6 +1009,7 @@ struct ref {
 	char *symref;
 	unsigned int force:1,
 		merge:1,
+		nonfastforward:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
@@ -1019,10 +1020,6 @@ struct ref {
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
 	} status;
-	enum {
-		NON_FF_HEAD = 1,
-		NON_FF_OTHER
-	} nonfastforward;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
diff --git a/transport.h b/transport.h
index ce99ef8..1631a35 100644
--- a/transport.h
+++ b/transport.h
@@ -138,6 +138,8 @@ int transport_set_option(struct transport *transport, const char *name,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
 
+#define NON_FF_HEAD 1
+#define NON_FF_OTHER 2
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
 		   int * nonfastforward);
-- 
1.7.10.rc2.3.g0850
