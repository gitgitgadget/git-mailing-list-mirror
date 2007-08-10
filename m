From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix "git commit directory/" performance anomaly
Date: Fri, 10 Aug 2007 09:51:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708100924570.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net> <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
 <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
 <7v643ovyli.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708100852540.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJXjy-000690-SD
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763847AbXHJQxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934127AbXHJQxa
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:53:30 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38267 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762484AbXHJQx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 12:53:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AGq4LK024873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 09:52:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AGpw9F031332;
	Fri, 10 Aug 2007 09:51:58 -0700
In-Reply-To: <alpine.LFD.0.999.0708100852540.30176@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55555>


This trivial patch avoids re-hashing files that are already clean in the 
index. This mirrors what commit 0781b8a9b2fe760fc4ed519a3a26e4b9bd6ccffe 
did for "git add .", only for "git commit ." instead.

This improves the cold-cache case immensely, since we don't need to bring 
in all the file contents, just the index and any files dirty in the index.

Before:

	[torvalds@woody linux]$ time git commit .
	real    1m49.537s
	user    0m3.892s
	sys     0m2.432s

After:

	[torvalds@woody linux]$ time git commit .
	real    0m14.273s
	user    0m1.312s
	sys     0m0.516s

(both after doing a "echo 3 > /proc/sys/vm/drop_caches" to get cold-cache 
behaviour - even with the index optimization git still has to "lstat()" 
all the files, so with a truly cold cache, bringing all the inodes in 
will take some time).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

On Fri, 10 Aug 2007, Linus Torvalds wrote:
> 
> Try this on the kernel archive (use a clean one, so these things *should* 
> all be no-ops):
> 
> 	time sh -c "git add . ; git commit"
> 
> which is nice and fast and takes just over a second for me, but then try
> 
> 	time git commit .
> 
> which *should* be nice and fast, but it takes forever, because we now 
> re-compute all the SHA1's for *every* file. Of course, if it's all in the 
> cache, it's still just 4s for me, but I tried with a cold cache, and it 
> was over half a minute!
> 
> (I don't actually ever do something like "git commit .", but I could see 
> people doing it. What I *do* do is that if I have multiple independent 
> changes, I may actually do "git commit fs" to commit just part of them, 
> and rather than list all the files, I literally just say "commit that 
> sub-tree". So this really is another valid performance issue).
> 
> Sad.
> 
> 			Linus
> 
---
 builtin-update-index.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 509369e..8d22dfa 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -86,9 +86,15 @@ static int process_lstat_error(const char *path, int err)
 
 static int add_one_path(struct cache_entry *old, const char *path, int len, struct stat *st)
 {
-	int option, size = cache_entry_size(len);
-	struct cache_entry *ce = xcalloc(1, size);
+	int option, size;
+	struct cache_entry *ce;
+
+	/* Was the old index entry already up-to-date? */
+	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
+		return;
 
+	size = cache_entry_size(len);
+	ce = xcalloc(1, size);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = htons(len);
 	fill_stat_cache_info(ce, st);
