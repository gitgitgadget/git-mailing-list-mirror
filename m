From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk strangeness..
Date: Mon, 27 Mar 2006 18:54:45 -0800
Message-ID: <7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 04:54:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO4M5-0006jD-QZ
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 04:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWC1Cys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 21:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWC1Cys
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 21:54:48 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37326 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751208AbWC1Cyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 21:54:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328025446.OSHW25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Mar 2006 21:54:46 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17448.40941.256361.866229@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Tue, 28 Mar 2006 13:31:09 +1100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18105>

Paul Mackerras <paulus@samba.org> writes:

> The other option would be to make git-rev-list list the open-circle
> commits explicitly, with an indication that they are not in the
> requested set but are parents of commits in the requested set.

I might be off the mark, but are you thinking about something
like the attached patch?

> Do you think that having the open-circle commits in the graph is
> useful?

Of course.

-- >8 --
rev-list: --parents-with-boundary

The new flag acts like --parents, but uninteresting parents are
marked by prefied '-' sign.

        $ git-rev-list --parents-with-boundary HEAD^^..HEAD
        acb7257... 9c48666...
        9c48666... -dff86e2..

---
diff --git a/rev-list.c b/rev-list.c
index 441c437..58fc449 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -39,6 +39,8 @@
 static int bisect_list = 0;
 static int verbose_header = 0;
 static int abbrev = DEFAULT_ABBREV;
+#define SHOW_PARENTS 1
+#define SHOW_PARENTS_BOUNDARY 2
 static int show_parents = 0;
 static int show_timestamp = 0;
 static int hdr_termination = 0;
@@ -59,7 +61,11 @@
 			parents = parents->next;
 			if (o->flags & TMP_MARK)
 				continue;
-			printf(" %s", sha1_to_hex(o->sha1));
+			if (show_parents == SHOW_PARENTS_BOUNDARY &&
+			    o->flags & UNINTERESTING)
+				printf(" -%s", sha1_to_hex(o->sha1));
+			else
+				printf(" %s", sha1_to_hex(o->sha1));
 			o->flags |= TMP_MARK;
 		}
 		/* TMP_MARK is a general purpose flag that can
@@ -337,7 +343,11 @@
 			continue;
 		}
 		if (!strcmp(arg, "--parents")) {
-			show_parents = 1;
+			show_parents = SHOW_PARENTS;
+			continue;
+		}
+		if (!strcmp(arg, "--parents-with-boundary")) {
+			show_parents = SHOW_PARENTS_BOUNDARY;
 			continue;
 		}
 		if (!strcmp(arg, "--timestamp")) {
