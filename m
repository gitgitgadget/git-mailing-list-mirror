From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/16] t4200: use cut instead of sed
Date: Thu, 13 Mar 2008 08:59:20 -0400
Message-ID: <20080313125920.GF19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213756.GI26286@coredump.intra.peff.net> <7vejaf1b0d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:00:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZn2Q-0001am-Ud
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbYCMM7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbYCMM7X
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:59:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4831 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbYCMM7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:59:22 -0400
Received: (qmail 30078 invoked by uid 111); 13 Mar 2008 12:59:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 08:59:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 08:59:20 -0400
Content-Disposition: inline
In-Reply-To: <7vejaf1b0d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77072>

On Wed, Mar 12, 2008 at 09:52:18PM -0700, Junio C Hamano wrote:

> > Some versions of sed (like the one on Solaris) don't like to
> > match literal tabs, and simply print nothing. Instead, let's
> > use cut.
> 
> > -sha1=$(sed -e 's/	.*//' .git/rr-cache/MERGE_RR)
> 
> This is a bit hard to believe.  On one of my ancient Sun box:

Ah, sorry. I tested this line by hand, found it didn't work, and
stupidly jumped to the assumption that it was the literal tab (that
being the only interesting thing in the input).

But the actual problem is that MERGE_RR lacks a trailing newline. I
don't see any code to add newlines, even though it seems possible that
we will write out several paths. So I think we need a newline here:

diff --git a/builtin-rerere.c b/builtin-rerere.c
index c607aad..e4a1dc1 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -58,7 +58,8 @@ static int write_rr(struct path_list *rr, int out_fd)
 		int length = strlen(path) + 1;
 		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
 		    write_in_full(out_fd, "\t", 1) != 1 ||
-		    write_in_full(out_fd, path, length) != length)
+		    write_in_full(out_fd, path, length) != length ||
+		    write_in_full(out_fd, "\n", 1) != 1)
 			die("unable to write rerere record");
 	}
 	if (commit_lock_file(&write_lock) != 0)

And unless I am missing something, rerere on multiple paths is very
broken (but that seems weird, since this code is so old).

-Peff
