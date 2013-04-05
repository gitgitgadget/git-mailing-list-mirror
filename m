From: Jeff King <peff@peff.net>
Subject: [PATCH 8/9] remote-curl: die directly with http error messages
Date: Fri, 5 Apr 2013 18:22:15 -0400
Message-ID: <20130405222215.GH22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQR-0001b9-OE
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163009Ab3DEWWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:22:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58255 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162989Ab3DEWWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:22:24 -0400
Received: (qmail 18452 invoked by uid 107); 5 Apr 2013 22:24:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:24:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:22:15 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220192>

When we encounter an unknown http error (e.g., a 403), we
hand the error code to http_error, which then prints it with
error(). After that we die with the redundant message "HTTP
request failed".

Instead, let's just drop http_error entirely, which does
nothing but pass arguments to error(), and instead die
directly with a useful message.

So before:

  $ git clone https://example.com/repo.git
  Cloning into 'repo'...
  error: unable to access 'https://example.com/repo.git': The requested URL returned error: 403 Forbidden
  fatal: HTTP request failed

and after:

  $ git clone https://example.com/repo.git
  Cloning into 'repo'...
  fatal: unable to access 'https://example.com/repo.git': The requested URL returned error: 403 Forbidden

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 9abe4b7..60eda63 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -216,8 +216,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		die("Authentication failed for '%s'", url);
 	default:
 		show_http_message(&type, &buffer);
-		http_error(url);
-		die("HTTP request failed");
+		die("unable to access '%s': %s", url, curl_errorstr);
 	}
 
 	last= xcalloc(1, sizeof(*last_discovery));
-- 
1.8.2.rc0.33.gd915649
