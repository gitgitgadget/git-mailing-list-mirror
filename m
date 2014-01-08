From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] branch_get: provide per-branch pushremote pointers
Date: Wed, 8 Jan 2014 06:09:19 -0500
Message-ID: <20140108110919.GA3674@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093531.GD15720@sigill.intra.peff.net>
 <20140108102707.GA23145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 12:09:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0r0s-0007NB-IO
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 12:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbaAHLJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 06:09:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:57150 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756046AbaAHLJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 06:09:24 -0500
Received: (qmail 2232 invoked by uid 102); 8 Jan 2014 11:09:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 05:09:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 06:09:19 -0500
Content-Disposition: inline
In-Reply-To: <20140108102707.GA23145@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240207>

On Wed, Jan 08, 2014 at 05:27:07AM -0500, Jeff King wrote:

> This patch passes the test suite by itself (with or without that fixup).
> But oddly, it seems to fail t5531 when merged with 'next'. I can't
> figure out why, though. It shouldn't affect any code that doesn't look
> at branch->pushremote.

OK, I figured it out. My patch calls:

  remote_get("origin")

which creates an origin remote, even if one does not exist (it assumes
it to be a URL "origin"). Later, when we want to decide if the push is
triangular or not, we ask for:

  remote_get(NULL);

which will internally look for a remote called "origin". Before my patch
there was not such a remote, and so the push could not be triangular.
After my patch, it finds the bogus remote and says "this thing exists,
and is not what we are pushing to; therefore the push is triangular".

The solution is that I should not be passing the term "origin" to
remote_get, but rather passing NULL and relying on it to figure out the
default remote correctly. I.e.:

diff --git a/remote.c b/remote.c
index 8724388..d214fa2 100644
--- a/remote.c
+++ b/remote.c
@@ -1574,7 +1574,7 @@ struct branch *branch_get(const char *name)
 	else if (ret->remote_name)
 		ret->pushremote = remote_get(ret->remote_name);
 	else
-		ret->pushremote = remote_get("origin");
+		ret->pushremote = remote_get(NULL);
 
 	return ret;
 }

-Peff
