From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 17/16] http-push: refactor parsing of remote object names
Date: Thu, 19 Jun 2014 18:08:11 -0400
Message-ID: <20140619220811.GB29685@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
 <20140619215810.GA29685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 00:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxkVG-0003ck-4E
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 00:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965678AbaFSWIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 18:08:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:47833 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965475AbaFSWIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 18:08:13 -0400
Received: (qmail 19206 invoked by uid 102); 19 Jun 2014 22:08:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 17:08:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 18:08:11 -0400
Content-Disposition: inline
In-Reply-To: <20140619215810.GA29685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252197>

On Thu, Jun 19, 2014 at 05:58:10PM -0400, Jeff King wrote:

> It's still a little more magical than I would like, but I think this is
> the best we can do while still building on get_sha1_hex. Parsing it
> left-to-right would be better, but we would essentially end up
> reimplementing get_sha1_hex.

Just for fun, that would look something like this (on top):

diff --git a/http-push.c b/http-push.c
index c5c95e8..2425c61 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1016,20 +1016,34 @@ static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData);
 
+static inline int parse_one_hex(unsigned char **to, const char **from)
+{
+	unsigned int val;
+
+	/* avoid reading past end-of-string for from[1] */
+	if (!(*from)[0])
+		return -1;
+	val = (hexval((*from)[0]) << 4) | hexval((*from)[1]);
+	if (val & ~0xff)
+		return -1;
+	*(*to)++ = val;
+	(*from) += 2;
+	return 0;
+}
+
 /* extract hex from sharded "xx/x{40}" filename */
 static int get_sha1_hex_from_objpath(const char *path, unsigned char *sha1)
 {
-	char hex[40];
+	int i;
 
-	if (strlen(path) != 41)
+	if (parse_one_hex(&sha1, &path) < 0)
 		return -1;
-
-	memcpy(hex, path, 2);
-	path += 2;
-	path++; /* skip '/' */
-	memcpy(hex, path, 38);
-
-	return get_sha1_hex(hex, sha1);
+	if (*path++ != '/')
+		return -1;
+	for (i = 1; i < 20; i++)
+		if (parse_one_hex(&sha1, &path) < 0)
+			return -1;
+	return 0;
 }
 
 static void process_ls_object(struct remote_ls_ctx *ls)

In theory we could factor parse_one_hex to share with get_sha1_hex, but
I am hesitant to touch get_sha1_hex, as it is used in a lot of tight
loops.

-Peff
