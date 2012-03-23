From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 23 Mar 2012 17:41:14 -0400
Message-ID: <20120323214114.GB18198@sigill.intra.peff.net>
References: <20120320043133.GA2755@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 22:41:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBCEf-0002xF-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 22:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760Ab2CWVlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 17:41:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57796
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755712Ab2CWVlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 17:41:18 -0400
Received: (qmail 19326 invoked by uid 107); 23 Mar 2012 21:41:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 17:41:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 17:41:14 -0400
Content-Disposition: inline
In-Reply-To: <20120320043133.GA2755@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193803>

On Tue, Mar 20, 2012 at 12:31:33AM -0400, Christopher Tiwald wrote:

>  Changes since v2:
> 	- Cleaned up commit message language, specifically in scenario
> 	  one.
> 	- Created one config variable per piece of non-ff push advice.
> 	  Additionally, preserved 'pushNonFastForward' as a means of
> 	  disabling all non-ff push advice. Users who set this
> 	  config option should see no change to 'git push'.

This version looks pretty good to me, but I have one question:

> @@ -1008,7 +1009,6 @@ struct ref {
>  	char *symref;
>  	unsigned int force:1,
>  		merge:1,
> -		nonfastforward:1,
>  		deletion:1;
>  	enum {
>  		REF_STATUS_NONE = 0,
> @@ -1019,6 +1019,10 @@ struct ref {
>  		REF_STATUS_REMOTE_REJECT,
>  		REF_STATUS_EXPECTING_REPORT
>  	} status;
> +	enum {
> +		NON_FF_HEAD = 1,
> +		NON_FF_OTHER
> +	} nonfastforward;
>  	char *remote_status;
>  	struct ref *peer_ref; /* when renaming */
>  	char name[FLEX_ARRAY]; /* more */

Why is this enum stored inside the ref? It doesn't actually know whether
it is a HEAD or not, and we never actually store that value there. We
always just store a boolean (remote.c, ll. 1294-1298) and access it as
one (remote.c, l. 1300; transport.c, l. 1259).

The only time we use the enum values is via the "int nonfastforward"
passed to transport_push.  I think it would be a lot clearer to leave
nonfastforward as a single bit in the ref, and then define the enum
elsewhere (or even just use #define if we are not going to use the enum
type). Like this on top of your patch:

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


I don't think your patch is buggy, because the enum is perfectly capable
of being used as a single bit. But it's confusing to read, because
ref->nonfastforward will never actually be set to the NON_FF_OTHER enum
value.

-Peff
