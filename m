From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Mon, 12 Nov 2007 20:58:22 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> <18212.13862.637991.30536@cargo.ozlabs.ibm.com> <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> <18217.41899.54812.227152@cargo.ozlabs.ibm.com> <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com> <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com> <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org> <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 05:58:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrnrS-00031V-AG
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 05:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760801AbXKME6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 23:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760781AbXKME6g
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 23:58:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51557 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760764AbXKME6f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 23:58:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAD4wRRO017040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Nov 2007 20:58:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAD4wMg2026967;
	Mon, 12 Nov 2007 20:58:22 -0800
In-Reply-To: <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64752>


When we do history simplification in early-output, we end up in the 
interesting situation that the early output may do simplification with a 
partial tree - in particular, there may be parents that simply haven't 
been handled yet, and don't have their parenthood parsed.

The history simplification would get this case totally wrong, and assume 
that the parent list of a parent being NULL meant that it was a root 
commit, and rewrite the whole parent as such.

This would cause unconnected commits in the gitk output.

This fixes it, by saying that if you reach a parent that hasn't been 
parsed yet, history simplification will simply stop and leave it alone: 
later on, when we have the full history, we will *continue* the 
simplification and eventually get the right information.

However, while the parent is now correctly rewritten, it looks like gitk 
is confused by this. Gitk will remember the original parent information, 
even if a replay has given new parenthood information. Since the partial 
early-output information is triggered by timing, this means that gitk will 
show some totally random parent that quite possibly won't even be part of 
the final commit set at all!

On the kernel, at least with my machine, I can trigger this with something 
like

	gitk fs/read_write.c

where currently the log (with --parents) reads like this:

	commit a16877ca9cec211708a161057a7cbfbf2cbc3a53 d96e6e71647846e0dab097efd9b8bf3a3a556dca
	Author: Pavel Emelyanov <xemul@openvz.org>
	Date:   Mon Oct 1 14:41:11 2007 -0700
	
	    Cleanup macros for distinguishing mandatory locks
	..

	commit d96e6e71647846e0dab097efd9b8bf3a3a556dca d6b29d7cee064f28ca097e906de7453541351095
	Author: Jens Axboe <jens.axboe@oracle.com>
	Date:   Mon Jun 11 12:18:52 2007 +0200
	
	    Remove remnants of sendfile()
	...

but with early-output (and this fixed patch), I get something like this:

	Final output: 1 incomplete
	commit a16877ca9cec211708a161057a7cbfbf2cbc3a53 31b54f40e12e4d04941762be6615edaf3c6ed811
	Author: Pavel Emelyanov <xemul@openvz.org>
	Date:   Mon Oct 1 14:41:11 2007 -0700

	    Cleanup macros for distinguishing mandatory locks
	...

	Final output: 26 done
	commit a16877ca9cec211708a161057a7cbfbf2cbc3a53 d96e6e71647846e0dab097efd9b8bf3a3a556dca
	Author: Pavel Emelyanov <xemul@openvz.org>
	Date:   Mon Oct 1 14:41:11 2007 -0700
	
	    Cleanup macros for distinguishing mandatory locks
	..

ie notice how the early-output doesn't have the right parent, since it 
hasn't gotten that far back in history yet. So now the final output will 
have the parenthood rewritten (correctly), but gitk will have cached the 
old random incorrect parenthood, and doesn't react properly to the updated 
and fixed one at replay time.

Anyway, this is a real fix, but gitk remains a bit useless as is.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 revision.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 931f978..8872a91 100644
--- a/revision.c
+++ b/revision.c
@@ -1352,6 +1352,8 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 		if (!revs->limited)
 			if (add_parents_to_list(revs, p, &revs->commits) < 0)
 				return rewrite_one_error;
+		if (!p->object.parsed)
+			return rewrite_one_ok;
 		if (p->parents && p->parents->next)
 			return rewrite_one_ok;
 		if (p->object.flags & (TREECHANGE | UNINTERESTING))
