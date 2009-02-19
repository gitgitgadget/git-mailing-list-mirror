From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-push: using error() and warning() as appropriate
Date: Thu, 19 Feb 2009 07:21:05 -0500
Message-ID: <20090219122104.GA4602@sigill.intra.peff.net>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La7vM-0006jT-AP
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbZBSMVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbZBSMVK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:21:10 -0500
Received: from peff.net ([208.65.91.99]:50627 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238AbZBSMVK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:21:10 -0500
Received: (qmail 23038 invoked by uid 107); 19 Feb 2009 12:21:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 19 Feb 2009 07:21:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 07:21:05 -0500
Content-Disposition: inline
In-Reply-To: <20090219120708.GM4371@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110683>

On Thu, Feb 19, 2009 at 01:07:08PM +0100, Miklos Vajna wrote:

> Change three occurrences of using inconsistent error/warning reporting
> by using the relevant error() / warning() calls to be consistent with
> the rest of the code.
> 
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> On Thu, Feb 19, 2009 at 03:17:25AM -0500, Jeff King <peff@peff.net> wrote:
> > http-push seems to be the odd man out. It contains one fprintf(stderr,
> > "Error: ...") and one totally bogus error("Error: ..."), which will
> > print "error: Error: ...". Perhaps it would be better to scan through
> > the code and switch to using error() and warning() as appropriate.
> 
> I found these 3 occurrences.

A few more are in the diff below. But there are even more:

  - several "Warning: " lines in *.sh

  - some warnings actually come with "WARNING:" on every line. I don't
    think those should be changed, as they are obviously a more
    strenuous warning.

  - there are several places that manually print "warning: " via
    fprintf. I suppose those can be cleaned up to use warning(), too.

-Peff

---
diff --git a/builtin-mv.c b/builtin-mv.c
index 01270fe..fc6bd82 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -172,9 +172,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					fprintf(stderr, "Warning: %s;"
-							" will overwrite!\n",
-							bad);
+					warning("%s; will overwrite!", bad);
 					bad = NULL;
 				} else
 					bad = "Cannot overwrite";
diff --git a/http-walker.c b/http-walker.c
index 0dbad3c..91abea7 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -235,7 +235,7 @@ static void finish_object_request(struct object_request *obj_req)
 	close(obj_req->local); obj_req->local = -1;
 
 	if (obj_req->http_code == 416) {
-		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+		warning("requested range invalid; we may already have all the data.");
 	} else if (obj_req->curl_result != CURLE_OK) {
 		if (stat(obj_req->tmpfile, &st) == 0)
 			if (st.st_size == 0)
