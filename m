X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 21:32:23 -0500
Message-ID: <20061220023223.GC27638@spearce.org>
References: <Pine.LNX.4.64.0612191709320.6766@woody.osdl.org> <929899.78332.qm@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 02:32:40 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <929899.78332.qm@web31809.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34897>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwrFv-00019f-8q for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964787AbWLTCc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWLTCc2
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:32:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54138 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964787AbWLTCc2 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 21:32:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwrFe-0004HI-T9; Tue, 19 Dec 2006 21:32:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3B7C320FB65; Tue, 19 Dec 2006 21:32:24 -0500 (EST)
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> wrote:
> --- Linus Torvalds <torvalds@osdl.org> wrote:
> > Can you run that by hand under gdb and get a backtrace?
> 
> Linus,
> 
> Auto-merging init/Kconfig
> Auto-merging init/version.c
> 
> Program received signal SIGSEGV, Segmentation fault.
> xdl_merge (orig=Variable "orig" is not available.
> ) at xdiff/xmerge.c:200
> 200                     t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
> (gdb) bt
> #0  xdl_merge (orig=Variable "orig" is not available.
> ) at xdiff/xmerge.c:200
> #1  0x000000000040322c in merge_file (o=0x7fffd4f762f0, a=0x7fffd4f76270, b=0x7fffd4f762b0,
> branch1=0x7fffd4f77976 "HEAD", 
>     branch2=0x7fffd4f7797b "cc016448b0bf0764928275d034e367753bde8162") at merge-recursive.c:667
> #2  0x0000000000404e87 in merge_trees (head=0x12e4a00, merge=0x555328, common=0x555350,
> branch1=Variable "branch1" is not available.
> ) at merge-recursive.c:1074
> #3  0x0000000000405376 in merge (h1=0x5452f0, h2=0x545370, branch1=0x7fffd4f77976 "HEAD",
> branch2=0x7fffd4f7797b "cc016448b0bf0764928275d034e367753bde8162", call_depth=0, 
>     ancestor=0x5453f0, result=0x7fffd4f764e0) at merge-recursive.c:1245
> #4  0x00000000004056a5 in main (argc=Variable "argc" is not available.
> ) at merge-recursive.c:1312
> 
> I also ran git-bisect twice over two well known but overlapping
> good-bad regions and I get the same commit as being the culprit.
> It seems to be commit 1510fea781cb0517eeba8c378964f7bc4f9577ab.

Oww, the finger points at me!  :-)

Hmm.  1510fe does not look right to me.  That return 0 should only
be activating when FAST_WORKING_DIRECTORY == 0, so you really want
this patch below.  Normally NO_FAST_WORKING_DIRECTORY is _not_
defined, which means FAST_WORKING_DIRECTORY == 1, and in that case
the if should always be false and the compiler should be stripping
the code out entirely.

What's odd is that the xdl_merge routine is crashing out because
this code activated.  It really should not have, so more work is
still required...

diff --git a/diff.c b/diff.c
index 77ba641..1c1de11 100644
--- a/diff.c
+++ b/diff.c
@@ -1194,7 +1194,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
+	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
 		return 0;
 
