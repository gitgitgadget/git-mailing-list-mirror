From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 06:22:40 -0500
Message-ID: <20141208112240.GA3191@peff.net>
References: <20141208054812.GA30154@peff.net>
 <20141208055706.GA30207@peff.net>
 <alpine.DEB.1.00.1412081201180.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 12:22:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxwP3-00047E-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 12:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbaLHLWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 06:22:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:49887 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752419AbaLHLWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 06:22:42 -0500
Received: (qmail 11132 invoked by uid 102); 8 Dec 2014 11:22:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 05:22:42 -0600
Received: (qmail 22276 invoked by uid 107); 8 Dec 2014 11:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 06:22:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2014 06:22:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1412081201180.13845@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261010>

On Mon, Dec 08, 2014 at 12:17:10PM +0100, Johannes Schindelin wrote:

> > I do admit that I am tempted to teach index-pack to always NUL-terminate
> > objects in memory that we feed to fsck, just to be on the safe side. It
> > doesn't cost much, and could prevent a silly mistake (either in the
> > future, or one that I missed in my analysis). The fsck code otherwise
> > generally expects to get the output of read_sha1_file, which has the
> > safety-NUL appended.
> 
> If we do that, we have to NUL-terminate all of the objects, correct? I
> mean, even the blobs and the trees and stuff, because we cannot know
> beforehand what type of object we're gonna read, right?

I think that is right. It should be a pretty simple change. It looks
like we already use xmallocz when creating deltas, and we just need to
handle regular objects. I think it could be as simple as this one-liner,
but I didn't test anything:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a369f55..390845d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -447,7 +447,7 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
 	if (type == OBJ_BLOB && size > big_file_threshold)
 		buf = fixed_buf;
 	else
-		buf = xmalloc(size);
+		buf = xmallocz(size);
 
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);

-Peff
