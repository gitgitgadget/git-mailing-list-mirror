From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix index preloading for racy dirty case
Date: Mon, 17 Nov 2008 09:01:20 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811170850170.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org> <7vtza95h01.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org> <7vvdumwbnn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0811170846390.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 18:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L27VG-0002DS-Bo
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 18:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYKQRBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbYKQRBz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 12:01:55 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59471 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751541AbYKQRBz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 12:01:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHH1KhP014611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Nov 2008 09:01:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHH1KCr015850;
	Mon, 17 Nov 2008 09:01:20 -0800
In-Reply-To: <alpine.LFD.2.00.0811170846390.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.434 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101235>



In the threaded index preloading case, we must be sure to always use the 
CE_MATCH_RACY_IS_DIRTY flag when calling ie_match_stat(), in order to make 
sure that we only ever look at the stat() data, and don't try to do 
anything fancy.

Because most of git internals are not thread-safe, and must not be called 
in parallel.

Otherwise, what happens is that if the timestamps indicate that an entry 
_might_ be dirty, we might start actually comparing filesystem data with 
the object database. And we mustn't do that, because that would involve
looking up and creating the object structure, and that whole code sequence 
with read_sha1_file() where we look up and add objects to the hashes is 
definitely not thread-safe.

Nor do we want to add locking, because the whole point of the preload was 
to be simple and not affect anything else. With CE_MATCH_RACY_IS_DIRTY, we 
get what we wanted, and we'll just leave the hard cases well alone, to be 
done later in the much simpler serial case.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

On Mon, 17 Nov 2008, Linus Torvalds wrote:
> 
> Oh, damn. I had forgotten that check_fs() doesn't just do a "lstat()" any 
> more. You're right.

Never mind the "any more". I don't think it ever did.

But I do think that this is trivially fixed, and I should have thought 
about it. And while I didn't reproduce your SIGSEGV, I think this trivial 
patch should fix it.

Sorry about the mindfart.

 preload-index.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 3ce42e0..a6a6bdb 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -43,7 +43,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (lstat(ce->name, &st))
 			continue;
-		if (ie_match_stat(index, ce, &st, 0))
+		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
