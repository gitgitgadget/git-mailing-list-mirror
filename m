From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: file disappears after git rebase (missing one commit)
Date: Sat, 18 Aug 2007 13:55:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708181334200.30176@woody.linux-foundation.org>
References: <e7bda7770708181237u34253bf1h7c3fe0987d13d3b3@mail.gmail.com> 
 <alpine.LFD.0.999.0708181247330.30176@woody.linux-foundation.org>
 <e7bda7770708181329i7a64e613y88187a608c323a07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Torgil Svensson <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMVKo-0004Ey-Gl
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 22:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbXHRUzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 16:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbXHRUzS
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 16:55:18 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55106 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751063AbXHRUzR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2007 16:55:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7IKtESX023904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 18 Aug 2007 13:55:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7IKt8nH011428;
	Sat, 18 Aug 2007 13:55:08 -0700
In-Reply-To: <e7bda7770708181329i7a64e613y88187a608c323a07@mail.gmail.com>
X-Spam-Status: No, hits=-2.751 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56112>



On Sat, 18 Aug 2007, Torgil Svensson wrote:
> 
> > In other words, "git rebase" really is just a series of cherry-picks, 
> > but it avoids patches that have the same patch ID as something that is 
> > already upstream. That helps *enormously*, but it so happens that the 
> > patch ID's don't work really well for binary diffs.
> 
> Git cherry-pick seems to work on that particular patch:

Yes, cherry-picking itself works, it's just that "git rebase" probably 
won't even *try* to cherry-pick it because it thinks it is already 
applied.

> > Try this patch - see if it helps. Totally untested! It will enable 
> > patch ID's on binary diffs too, which should avoid this issue.
> 
> That didn't help. Same symptom.

Yeah, I was thinking about the external "git-patch-id" program, which 
actually takes the diff and looks at it from there. But 
"--ignore-if-in-upstream" does its own binary file testing, and doesn't 
use the generic diff code at all. 

So the following patch is likely much better..

		Linus

---
 diff.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 97cc5bc..a7e7671 100644
--- a/diff.c
+++ b/diff.c
@@ -2919,10 +2919,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 				fill_mmfile(&mf2, p->two) < 0)
 			return error("unable to read files to diff");
 
-		/* Maybe hash p->two? into the patch id? */
-		if (diff_filespec_is_binary(p->two))
-			continue;
-
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
 		if (p->one->mode == 0)
