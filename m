From: Jeff King <peff@peff.net>
Subject: Re: Possible bug in 1.6.6 with reset --hard and $GIT_WORK_TREE
Date: Tue, 29 Dec 2009 16:50:15 -0500
Message-ID: <20091229215015.GA1529@coredump.intra.peff.net>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
 <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
 <20091229200426.6117@nanako3.lavabit.com>
 <fcaeb9bf0912290336m69303c3es8138c4e6497b801a@mail.gmail.com>
 <1a04eebf0912291309u7a222d9ch7e0926d30a5899b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Fyn Fynn <fynfynn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:50:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjxS-0007jf-47
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZL2VuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbZL2VuT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:50:19 -0500
Received: from peff.net ([208.65.91.99]:55389 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbZL2VuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:50:18 -0500
Received: (qmail 29988 invoked by uid 107); 29 Dec 2009 21:55:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 29 Dec 2009 16:55:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2009 16:50:15 -0500
Content-Disposition: inline
In-Reply-To: <1a04eebf0912291309u7a222d9ch7e0926d30a5899b7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135835>

On Tue, Dec 29, 2009 at 01:09:20PM -0800, Fyn Fynn wrote:

> But it is more likely that the breaking of the original action between
> 1.6.4 and 1.6.6 came about as an untended consequence of 952dfc6,
> which oversimplified by assuming that the worktree can only be found
> if we're inside it, ignoring the possibility that GIT_WORK_TREE was
> provided.

Yes, it is an unintended breakage. We discussed the possibility of
automatically moving to the work tree when inside the repo, but decided
it could be done later, as other builtins which use NEEDS_WORK_TREE
(e.g., clean) already fail in that instance.

However, I did not take into account that those commands fail only with
automatic repo detection; they _do_ work with GIT_WORK_TREE. So instead
of just dying, we need to be emulating the code in git.c which sets up
the work tree (and which will die itself if we run into an error).

So I think what we really want is this:

diff --git a/builtin-reset.c b/builtin-reset.c
index 11d1c6e..e4418bc 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -286,10 +286,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
-	if ((reset_type == HARD || reset_type == MERGE)
-	    && !is_inside_work_tree())
-		die("%s reset requires a work tree",
-		    reset_type_names[reset_type]);
+	if (reset_type == HARD || reset_type == MERGE)
+		setup_work_tree();
 
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset

I'll try to write a few tests and make sure that's sane.

-Peff
