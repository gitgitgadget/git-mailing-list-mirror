From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential: do not store credentials received from
 helpers
Date: Sat, 7 Apr 2012 01:21:10 -0400
Message-ID: <20120407052110.GA12164@sigill.intra.peff.net>
References: <20120407033417.GA13914@sigill.intra.peff.net>
 <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
 <20120407045612.GA965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 07:21:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGO5Q-0006rX-Ay
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 07:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab2DGFVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 01:21:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53131
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109Ab2DGFVN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 01:21:13 -0400
Received: (qmail 19502 invoked by uid 107); 7 Apr 2012 05:21:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Apr 2012 01:21:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2012 01:21:10 -0400
Content-Disposition: inline
In-Reply-To: <20120407045612.GA965@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194937>

On Sat, Apr 07, 2012 at 12:56:12AM -0400, Jeff King wrote:

> > So if I use the cache helper, and its set to expire at the default of
> > 15 minutes, I have to type my password in every 15 minutes, even if I
> > am doing a Git operation roughly every 8 minutes during a work day?
> 
> Yes. It's less convenient, but safer and more predictable (you put your
> password in at 2:30, it's gone at 2:45). Keep in mind that you can also
> bump the cache time. And like I said, if we do want have it behave the
> other way, that's OK, but it should be explicit (and it can be optional,
> even if it defaults to auto-refresh on use).

And here's what the optional version looks like:

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 390f194..1f801f7 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -136,6 +136,9 @@ static void serve_one_client(FILE *in, FILE *out)
 	else if (!strcmp(action.buf, "get")) {
 		struct credential_cache_entry *e = lookup_credential(&c);
 		if (e) {
+			int new_expiration = time(NULL) + timeout;
+			if (new_expiration > e->expiration)
+				e->expiration = new_expiration;
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
 		}
diff --git a/credential-cache.c b/credential-cache.c
index 9a03792..5751b48 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -87,6 +87,7 @@ int main(int argc, const char **argv)
 {
 	char *socket_path = NULL;
 	int timeout = 900;
+	int refresh = 0;
 	const char *op;
 	const char * const usage[] = {
 		"git credential-cache [options] <action>",
@@ -97,6 +98,8 @@ int main(int argc, const char **argv)
 			    "number of seconds to cache credentials"),
 		OPT_STRING(0, "socket", &socket_path, "path",
 			   "path of cache-daemon socket"),
+		OPT_BOOL(0, "refresh-on-use", &refresh,
+			   "refresh timestamp when credential is accessed"),
 		OPT_END()
 	};
 
@@ -112,7 +115,9 @@ int main(int argc, const char **argv)
 
 	if (!strcmp(op, "exit"))
 		do_cache(socket_path, op, timeout, 0);
-	else if (!strcmp(op, "get") || !strcmp(op, "erase"))
+	else if (!strcmp(op, "get"))
+		do_cache(socket_path, op, refresh ? timeout : 0, FLAG_RELAY);
+	else if(!strcmp(op, "erase"))
 		do_cache(socket_path, op, timeout, FLAG_RELAY);
 	else if (!strcmp(op, "store"))
 		do_cache(socket_path, op, timeout, FLAG_RELAY|FLAG_SPAWN);
