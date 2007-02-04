From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: merge doesn't remove files
Date: Sat, 3 Feb 2007 23:59:33 -0500
Message-ID: <20070204045933.GC16766@spearce.org>
References: <20070203224819.20131.qmail@b1b53206edee41.315fe32.mid.smarden.org> <7vy7nezr1f.fsf@assigned-by-dhcp.cox.net> <7vd54qzoka.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gerrit Pape <pape@smarden.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 05:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDZTc-0005og-99
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 05:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbXBDE7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 23:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbXBDE7k
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 23:59:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51997 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbXBDE7k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 23:59:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDZTH-0006zo-BX; Sat, 03 Feb 2007 23:59:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 278CA20FBAE; Sat,  3 Feb 2007 23:59:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vd54qzoka.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38647>

Junio C Hamano <junkio@cox.net> wrote:
> Having said that, I think there is a worse problem with
> merge-recursive.  It loses untracked files that are not
> involved in the merge.

I tracked it down to my commit 8371234e which was supposed to fix
the bug that started this thread.

Apparently what I did was make merge-recursive remove the file from
the working directory if it was renamed, even though it wasn't in
the index when the merge started.

So merge-recursive is only deleting untracked files which are in
the merge base, but aren't in one of the heads involved in the merge.

I'm looking at patching this.  Clearly we should only delete the
old file from the working directory during a rename if the tree-ish
which was supposed to match the working directory had the file
in it.  But that tree-ish doesn't have to be the first non-base
argument to merge-recursive, does it?  In practice it usually is,
but can I assume it in the code?

I'm looking at something like the following:

diff --git a/merge-recursive.c b/merge-recursive.c
index fa320eb..bbb52a7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -891,7 +891,7 @@ static int process_renames(struct path_list *a_renames,
                        struct diff_filespec src_other, dst_other;
                        int try_merge, stage = a_renames == renames1 ? 3: 2;
 
-                       remove_file(1, ren1_src, index_only);
+                       remove_file(1, ren1_src, index_only || stage == 3);
 
                        hashcpy(src_other.sha1, ren1->src_entry->stages[stage].s
                        src_other.mode = ren1->src_entry->stages[stage].mode;

-- 
Shawn.
