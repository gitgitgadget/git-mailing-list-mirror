From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: linux-2.6.git mirror
Date: Thu, 18 Oct 2007 16:24:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710181617090.26902@woody.linux-foundation.org>
References: <598D5675D34BE349929AF5EDE9B03E2701684C77@az33exm24.fsl.freesca
 le.net> <alpine.LFD.0.999.0710181518120.26902@woody.linux-foundation.org>
 <598D5675D34BE349929AF5EDE9B03E270168517F@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 01:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiek4-0006dQ-Aj
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 01:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956AbXJRXZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 19:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbXJRXZQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 19:25:16 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54457 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334AbXJRXZO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 19:25:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9INOpaD015726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Oct 2007 16:24:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9INOlVw003850;
	Thu, 18 Oct 2007 16:24:49 -0700
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270168517F@az33exm24.fsl.freescale.net>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61574>



On Thu, 18 Oct 2007, Medve Emilian-EMMEDVE1 wrote:
> 
> > > Is this something I should be worried about?
> > 
> > No, but if it still happens with a newer git, holler.
> 
> I tested this with Junio's latest master and a couple of stable releases
> from the maint branch with the same result.

Ok, what is going on is:

 - append_fetch_head() looks up the SHA1 for all heads (including tags):

        if (get_sha1(head, sha1))
                return error("Not a valid object name: %s", head);

 - it then wants to check if it's a candidate for merging (because 
   fetching also does the whole "list which heads to merge" in case it is 
   going to be part of a "pull"):

        commit = lookup_commit_reference(sha1);
        if (!commit)
                not_for_merge = 1;

 - and that "lookup_commit_reference()" is just very vocal about the case 
   where it fails. It really shouldn't be, and it shouldn't affect the 
   actual end result, but that basically explains why you get that scary 
   warning.

In short, the warning is just bogus, and should be harmless, but I agree 
that it's ugly. I think the appended patch should fix it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

And yes, I think this should go into Shawns tree of fixes, assuming that 
Emil confirms that it fixes it for him.

			Linus

 builtin-fetch--tool.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 1e43d79..e26817d 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -131,7 +131,7 @@ static int append_fetch_head(FILE *fp,
 
 	if (get_sha1(head, sha1))
 		return error("Not a valid object name: %s", head);
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference_gently(sha1, 1);
 	if (!commit)
 		not_for_merge = 1;
 
