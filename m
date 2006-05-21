From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Sun, 21 May 2006 12:24:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
 <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org>
 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org> <446FA262.7080900@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 21 21:29:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhtcJ-0003NK-Tk
	for gcvg-git@gmane.org; Sun, 21 May 2006 21:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWEUT32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 15:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWEUT32
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 15:29:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964922AbWEUT31 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 15:29:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4LJOHtH031327
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 May 2006 12:24:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4LJOG7a002682;
	Sun, 21 May 2006 12:24:17 -0700
To: Donnie Berkholz <spyderous@gentoo.org>
In-Reply-To: <446FA262.7080900@gentoo.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20459>



On Sat, 20 May 2006, Donnie Berkholz wrote:
> 
> I don't want to post the link publicly for a few reasons, including the
> huge amount of bandwidth it would suck up for lots of people to download
> it. I've sent it to you off-list, and if anyone else would also like it,
> please drop me a note.

Ok. It's still converting (that's a big archive), but it has passed the 
cvsps stage without errors for me, and the conversion so far seems ok. But 
it has only gotten to 

	Author: vapier <vapier>  2002-09-23 12:32:42
	Changed GPL to GPL-2 in LICENSE and updated SRC_URI to use mirror:

so it has converted only slightly more than the first two years of 
history in the roughly 30 minutes I've let it run. So it will take several 
hours.

The reason it works for me is likely simply the fact that I had a few 
patches to my cvsps already. I'm appending the stupid patches, I'm not 
guaranteeing that they are correct at all, although the three _committed_ 
patches are almost certainly correct (and the last uncommitted one is 
almost certainly totally broken). The patches are against clean cvsps 2.1.

Also, when I say "the conversion so far seems ok", I obviously don't 
actually know what the hell the archive is supposed to look like, so I can 
only say that the end result seems not totally insane.

To do a good conversion, you'll want to make sure that you have a author 
name conversion file. See the "-A" flag in "git help cvsimport" (if you 
have the man-pages installed).

		Linus

---
commit 534120d9a47062eecd7b53fd7ac0b70d97feb4fd
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Mar 22 11:20:59 2006 -0800

    Increase log-length limit to 64kB
    
    Yeah, it should be dynamic. I'm lazy.
---
 cvsps_types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cvsps_types.h b/cvsps_types.h
index b41e2a9..dba145d 100644
--- a/cvsps_types.h
+++ b/cvsps_types.h
@@ -8,7 +8,7 @@ #define CVSPS_TYPES_H
 
 #include <time.h>
 
-#define LOG_STR_MAX 32768
+#define LOG_STR_MAX 65536
 #define AUTH_STR_MAX 64
 #define REV_STR_MAX 64
 #define MIN(a, b) ((a) < (b) ? (a) : (b))


commit 82fcf7e31bbeae3b01a8656549e9b8fd89d598eb
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Mar 22 11:23:37 2006 -0800

    Improve handling of file collisions in the same patchset
    
    Take the file revision into account.
---
 cvsps.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index 1e64e3c..c22147e 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -2384,8 +2384,31 @@ void patch_set_add_member(PatchSet * ps,
     for (next = ps->members.next; next != &ps->members; next = next->next) 
     {
 	PatchSetMember * m = list_entry(next, PatchSetMember, link);
-	if (m->file == psm->file && ps->collision_link.next == NULL) 
-		list_add(&ps->collision_link, &collisions);
+	if (m->file == psm->file) {
+		int order = compare_rev_strings(psm->post_rev->rev, m->post_rev->rev);
+
+		/*
+		 * Same revision too? Add it to the collision list
+		 * if it isn't already.
+		 */
+		if (!order) {
+			if (ps->collision_link.next == NULL)
+				list_add(&ps->collision_link, &collisions);
+			return;
+		}
+
+		/*
+		 * If this is an older revision than the one we already have
+		 * in this patchset, just ignore it
+		 */
+		if (order < 0)
+			return;
+
+		/*
+		 * This is a newer one, remove the old one
+		 */
+		list_del(&m->link);
+	}
     }
 
     psm->ps = ps;

commit 3d1ebcef6b4f9f6c9064efd64da4dd30d93c3c96
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Mar 22 17:20:20 2006 -0800

    Fix branch ancestor calculation
    
    Not having any ancestor at all means that any valid ancestor (even of
    "depth 0") is fine.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 cvsps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index c22147e..2695a0f 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -2599,7 +2599,7 @@ static void determine_branch_ancestor(Pa
 	 * note: rev is the pre-commit revision, not the post-commit
 	 */
 	if (!head_ps->ancestor_branch)
-	    d1 = 0;
+	    d1 = -1;
 	else if (strcmp(ps->branch, rev->branch) == 0)
 	    continue;
 	else if (strcmp(head_ps->ancestor_branch, "HEAD") == 0)


uncommitted diff
Author: Linus Torvalds <torvalds@g5.osdl.org>

    Probably totally broken dot counting
---
 cvsps.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/cvsps.c b/cvsps.c
index 2695a0f..2ad1595 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -2357,9 +2357,16 @@ static int revision_affects_branch(CvsFi
 static int count_dots(const char * p)
 {
     int dots = 0;
+    int len = strlen(p);
 
-    while (*p)
-	if (*p++ == '.')
+    while (len > 2) {
+	if (memcmp(p+len-2, ".1", 2))
+		break;
+	len -= 2;
+    }
+
+    while (len)
+	if (p[--len] == '.')
 	    dots++;
 
     return dots;
@@ -2613,7 +2620,7 @@ static void determine_branch_ancestor(Pa
 	/* HACK: we sometimes pretend to derive from the import branch.  
 	 * just don't do that.  this is the easiest way to prevent... 
 	 */
-	d2 = (strcmp(rev->rev, "1.1.1.1") == 0) ? 0 : count_dots(rev->rev);
+	d2 = count_dots(rev->rev);
 	
 	if (d2 > d1)
 	    head_ps->ancestor_branch = rev->branch;
