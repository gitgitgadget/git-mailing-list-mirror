From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sat, 11 Feb 2006 18:46:09 -0800
Message-ID: <7virrli9am.fsf@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 03:46:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F87Fl-0000rX-DW
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 03:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWBLCqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 21:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWBLCqM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 21:46:12 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10424 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932196AbWBLCqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 21:46:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212024344.SFHN17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 21:43:44 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexandre Julliard <julliard@winehq.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15972>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In a simple test, this brings down the CPU time from 47 sec to 22 sec.

I was planning to take Alexandre's patch, but the approach your
patch takes feels more correct -- it scales with the number of
objects you need to handle, instead of having fixed 256
hashbuckets.

BTW, your version dumped core in hashtable_index immediately
after I started "git-rev-list --objects HEAD".  How did you get
_any_ CPU time?

I am not sure expecting that object name pointers are always
(unsigned int *) aligned as your patch does is OK.  We may want
to have something like the attached patch on top of yours.

I am also interested to find out how much the rehashing you do
when you update obj_allocs to a larger value is costing.

Alexandle, if you have a chance, could you try Johannes' patch
on your workload to see if it works OK for you?

-- >8 --
[PATCH] do not assume object name pointers are uint aligned.

Also fix an obvious bug that caused it dump core at my first
attempt.  There might be others but I did not actively look for
them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/object.c b/object.c
index 3259862..59e5e36 100644
--- a/object.c
+++ b/object.c
@@ -13,17 +13,24 @@ int track_object_refs = 1;
 
 static int hashtable_index(const unsigned char *sha1)
 {
-	unsigned int i = *(unsigned int *)sha1;
-	return (int)(i % obj_allocs);
+	int cnt;
+	unsigned int ix = *sha1++;
+
+	for (cnt = 1; cnt < sizeof(unsigned int); cnt++) {
+		ix <<= 8;
+		ix |= *sha1++;
+	}
+	return (int)(ix % obj_allocs);
 }
 
 static int find_object(const unsigned char *sha1)
 {
-	int i = hashtable_index(sha1);
+	int i;
 
 	if (!objs)
 		return -1;
 
+	i = hashtable_index(sha1);
 	while (objs[i]) {
 		if (memcmp(sha1, objs[i]->sha1, 20) == 0)
 			return i;
