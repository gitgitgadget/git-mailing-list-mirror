From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Improve on the 'invalid object' error message at commit
 time
Date: Tue, 14 Jul 2009 11:25:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907141119190.13838@localhost.localdomain>
References: <1247577632053-3255106.post@n2.nabble.com> <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Florian Breitwieser <florian.bw@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 20:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQmhA-0002bm-8g
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 20:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbZGNSZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 14:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbZGNSZ3
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 14:25:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39609 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753978AbZGNSZ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 14:25:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6EIPHin006618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Jul 2009 11:25:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6EIPH7h010866;
	Tue, 14 Jul 2009 11:25:17 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.467 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123266>


Not that anybody should ever get it, but somebody did (probably because
of a flaky filesystem, but whatever).  And each time I see an error
message that I haven't seen before, I decide that next time it will look
better.

So this makes us write more relevant information about exactly which
file ended up having issues with a missing object.  Which will tell
whether it was a tree object, for example, or just a regular file in the
index (and which one).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Not a big deal. But since somebody actually saw this message, let's just 
make it more informative. 

A lot of the "these can't happen unless you're seriously screwed" messages 
aren't very good, because there is little upside when doing development. 
But let's try to improve on them in case they happen in the future.

Not that this would make debugging much easier, but one thing that I 
started wondering about was whether the problem Florian saw was about one 
of the files he had done "git add" on, or whether it was a tree entry that 
was the result of "find_subtree()".

 cache-tree.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 16a65df..d917437 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -329,7 +329,8 @@ static int update_one(struct cache_tree *it,
 			entlen = pathlen - baselen;
 		}
 		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
-			return error("invalid object %s", sha1_to_hex(sha1));
+			return error("invalid object %06o %s for '%.*s'",
+				mode, sha1_to_hex(sha1), entlen+baselen, path);
 
 		if (ce->ce_flags & CE_REMOVE)
 			continue; /* entry being removed */
