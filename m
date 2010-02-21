From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cherry_pick_list: quit early if one side is empty
Date: Sun, 21 Feb 2010 01:50:10 -0500
Message-ID: <20100221065009.GB2840@coredump.intra.peff.net>
References: <20100220072728.GA12168@coredump.intra.peff.net>
 <a39e9a6e6f043121568de106f41f5b01eb38a200.1266665083.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Laine Walker-Avina <lwalkera@pasco.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 21 08:17:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj5e9-0005dK-QJ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 07:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab0BUGuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 01:50:12 -0500
Received: from peff.net ([208.65.91.99]:36361 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025Ab0BUGuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 01:50:11 -0500
Received: (qmail 8137 invoked by uid 107); 21 Feb 2010 06:50:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 21 Feb 2010 01:50:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2010 01:50:10 -0500
Content-Disposition: inline
In-Reply-To: <a39e9a6e6f043121568de106f41f5b01eb38a200.1266665083.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140597>

On Sat, Feb 20, 2010 at 12:42:04PM +0100, Thomas Rast wrote:

> > Does it really make sense to treat binary files as anything other than a
> > blob for generating patch id? That is, should we simply turn it into:
> > 
> >   binary diff
> >   $from_sha1
> >   $to_sha1
> > 
> > and hash that for the patch id?
> 
> I tend to agree, but I can't seem to find out what flags to flip :-(

You would need to call diff_filespec_is_binary when flushing the diff
queue, which handles both attributes and autodetection. Something like:

diff --git a/diff.c b/diff.c
index 989dbc5..97ce40a 100644
--- a/diff.c
+++ b/diff.c
@@ -3381,6 +3381,14 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 		diff_fill_sha1_info(p->one);
 		diff_fill_sha1_info(p->two);
+
+		if (diff_filespec_is_binary(p->one) ||
+		    diff_filespec_is_binary(p->two)) {
+			/* TODO: write binary patch into buffer */
+			git_SHA1_Update(&ctx, buffer, len);
+			continue;
+		}
+
 		if (fill_mmfile(&mf1, p->one) < 0 ||
 				fill_mmfile(&mf2, p->two) < 0)
 			return error("unable to read files to diff");

However, thinking on it more, it is a bit more complicated than that.
The patch-id we generate for --cherry-pick is not purely internal. You
can also generate patch-id's by handing the patch text to git-patch-id,
which strips out whitespace and line numbers.  Which means that whatever
we generate should probably match the binary patch format output by the
regular diff.

On the other hand, what we do now for cherry-pick totally does not match
what "git log" would output, and nobody has complained, so perhaps it is
not a big deal.

And I guess they don't technically need to match. The --cherry-pick
thing is internal (i.e., as long as you use the same format for both
sides, you are fine). But I suspect there are other code paths that use
that patch-id code.

-Peff
