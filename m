From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sun, 03 Sep 2006 14:48:47 -0700
Message-ID: <7vslj8tydc.fsf@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	<20060829175819.GE21729@spearce.org>
	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	<20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609021138500.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 23:48:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzpU-000804-Au
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWICVsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWICVsd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:48:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1261 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750796AbWICVsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 17:48:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060903214832.FBD6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Sep 2006 17:48:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HxoY1V00c1kojtg0000000
	Sun, 03 Sep 2006 17:48:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609021138500.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 2 Sep 2006 11:43:07 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26385>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 1 Sep 2006, Junio C Hamano wrote:
>> 
>> But "git repack -a -d", which you now consider almost being
>> free, in the recent kernel repository counts 300k objects, and
>> reuses 298k objects or so.  That means we expand and recompress
>> that many objects, totalling 120MB.
>
> Sure. Do we have data for how expensive that is (ie did you apply the 
> patch and time it)?

Quite bad.  For the kernel archive of today (I usually am nearly
fully packed):

$ /usr/bin/time ~/git-master/bin/git-pack-objects p1 </var/tmp/1
Generating pack...
Done counting 301361 objects.
Deltifying 301361 objects.
 100% (301361/301361) done
Writing 301361 objects.
 100% (301361/301361) done
a13dc6646622537d29af92b4cfc6d49b82e77e49
Total 301361, written 301361 (delta 238935), reused 300995 (delta 238663)
3.58user 0.84system 0:04.44elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+62727minor)pagefaults 0swaps

$ /usr/bin/time ../git.junio/git-pack-objects p2 </var/tmp/1
Generating pack...
Done counting 301361 objects.
Deltifying 301361 objects.
 100% (301361/301361) done
Writing 301361 objects.
 100% (301361/301361) done
a13dc6646622537d29af92b4cfc6d49b82e77e49
Total 301361, written 301361 (delta 238935), reused 300995 (delta 238663)
57.84user 3.39system 1:01.36elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1022768minor)pagefaults 0swaps

By the way, the one in "next" has a thinko I just noticed.

-- >8 --
[PATCH] pack-objects: fix thinko in revalidate code

When revalidating an entry from an existing pack entry->size and
entry->type are not necessarily the size of the final object
when the entry is deltified, but for base objects they must
match.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pack-objects.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 11cc3c8..5e42387 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -247,12 +247,13 @@ static int revalidate_one(struct object_
 			  void *data, char *type, unsigned long size)
 {
 	int err;
-	if (!data)
-		return -1;
-	if (size != entry->size)
-		return -1;
-	err = check_sha1_signature(entry->sha1, data, size,
-				   type_names[entry->type]);
+	if ((!data) ||
+	    ((entry->type != OBJ_DELTA) &&
+	     ( (size != entry->size) ||
+	       strcmp(type_names[entry->type], type))))
+		err = -1;
+	else
+		err = check_sha1_signature(entry->sha1, data, size, type);
 	free(data);
 	return err;
 }
-- 
1.4.2.g99d7d



-- 
VGER BF report: U 0.528006
