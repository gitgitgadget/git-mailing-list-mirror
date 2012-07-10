From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rerere: make rr-cache fanout directory honor umask
Date: Tue, 10 Jul 2012 02:37:22 -0400
Message-ID: <20120710063721.GA6347@sigill.intra.peff.net>
References: <alpine.LNX.2.00.1207061700060.2056@iabervon.org>
 <20120707215029.GA26819@blimp.dmz>
 <7vobnpn224.fsf@alter.siamese.dyndns.org>
 <20120709225829.GA8397@sigill.intra.peff.net>
 <7v1ukkjzyz.fsf@alter.siamese.dyndns.org>
 <7vwr2cikwa.fsf@alter.siamese.dyndns.org>
 <7vsjd0ikfe.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 08:37:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoU4n-0006Im-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 08:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab2GJGh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 02:37:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56439
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2GJGh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 02:37:28 -0400
Received: (qmail 26139 invoked by uid 107); 10 Jul 2012 06:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jul 2012 02:37:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2012 02:37:22 -0400
Content-Disposition: inline
In-Reply-To: <7vsjd0ikfe.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201236>

On Mon, Jul 09, 2012 at 04:28:21PM -0700, Junio C Hamano wrote:

> This is the last remaining call to mkdir(2) that restricts the permission
> bits by passing 0755.  Just use the same mkdir_in_gitdir() used to create
> the leaf directories.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks obviously correct to me.

I notice that grepping finds a few 0644 modes, too. Most of them are
false-positives (e.g., we store and transmit 100644 as a shorthand for
"normal non-executable permissions"). This is the only one that looked
legitimate to me:

-- >8 --
Subject: [PATCH] add: create ADD_EDIT.patch with mode 0666

We should be letting the user's umask take care of
restricting permissions. Even though this is a temporary
file and probably nobody would notice, this brings us in
line with other temporary file creations in git (e.g.,
choosing "e"dit from git-add--interactive).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 41edd63..815ac4b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -287,7 +287,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
-	out = open(file, O_CREAT | O_WRONLY, 0644);
+	out = open(file, O_CREAT | O_WRONLY, 0666);
 	if (out < 0)
 		die (_("Could not open '%s' for writing."), file);
 	rev.diffopt.file = xfdopen(out, "w");
-- 
1.7.10.5.16.ga1c6f1c
