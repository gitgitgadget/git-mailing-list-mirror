From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/12] remote.c: provide per-branch pushremote name
Date: Thu, 7 May 2015 05:38:37 -0400
Message-ID: <20150507093836.GB14524@peff.net>
References: <20150501224414.GA25551@peff.net>
 <20150501224644.GD1534@peff.net>
 <CAPig+cT7pSxZahd1hmcwCW8ifZfvQ4YW6L7xXUrD7dTJt76srQ@mail.gmail.com>
 <20150505193339.GF10463@peff.net>
 <CAPig+cQ+AbgTXAWKaN4obdGLWFDxjfr4yAaJZgvnLLzzoqdPRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 07 11:38:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqIGS-0006FT-VU
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 11:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbbEGJil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 05:38:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:55101 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784AbbEGJij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 05:38:39 -0400
Received: (qmail 11941 invoked by uid 102); 7 May 2015 09:38:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 May 2015 04:38:39 -0500
Received: (qmail 7509 invoked by uid 107); 7 May 2015 09:39:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 May 2015 05:39:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 May 2015 05:38:37 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQ+AbgTXAWKaN4obdGLWFDxjfr4yAaJZgvnLLzzoqdPRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268527>

On Tue, May 05, 2015 at 03:48:29PM -0400, Eric Sunshine wrote:

> > Yeah, it's just that it goes in the opposite direction I was trying for,
> > which is to have as little code as possible in the wrapper functions (in
> > fact, I think after my changes you could even bump the read_config()
> > call into remote_get_1; before my changes, it depended on the pushremote
> > config being set before the call).
> 
> I also noticed that read_config() could be moved into remote_get_1().
> In fact, with that change, then the wrappers really do collapse nicely
> to 1-liners, so the "clever" function pointer approach probably is
> cleaner; and it's nicely generalized over the previous round with the
> boolean argument to remote_get_1().

I ended up with this patch, which will go right after the one we're
discussing:

-- >8 --
Subject: remote.c: hoist read_config into remote_get_1

Before the previous commit, we had to make sure that
read_config() was called before entering remote_get_1,
because we needed to pass pushremote_name by value. But now
that we pass a function, we can let remote_get_1 handle
loading the config itself, turning our wrappers into true
one-liners.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index a91d063..e6b29b3 100644
--- a/remote.c
+++ b/remote.c
@@ -718,6 +718,8 @@ static struct remote *remote_get_1(const char *name,
 	struct remote *ret;
 	int name_given = 0;
 
+	read_config();
+
 	if (name)
 		name_given = 1;
 	else
@@ -741,13 +743,11 @@ static struct remote *remote_get_1(const char *name,
 
 struct remote *remote_get(const char *name)
 {
-	read_config();
 	return remote_get_1(name, remote_for_branch);
 }
 
 struct remote *pushremote_get(const char *name)
 {
-	read_config();
 	return remote_get_1(name, pushremote_for_branch);
 }
 
-- 
2.4.0.488.gf55b16a
