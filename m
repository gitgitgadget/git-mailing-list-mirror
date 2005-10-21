From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 10:11:00 -0700
Message-ID: <7vwtk6vlqz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 19:13:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET0Q6-0004gw-UC
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 19:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVJURLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 13:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVJURLD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 13:11:03 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:37555 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965036AbVJURLC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 13:11:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021171033.LTMA776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 13:10:33 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 21 Oct 2005 11:35:21 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10439>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Note that the best thing would probably be to add a binary search to that, 
> and *not* stop at the first ack'ed rev, but rather count them, and stop at 
> MAX_HAS.

Another alternative.

We send "haves" in order, without 2^n skipping nor binary search
backtrack.  Instead, add a logic in upload-pack to see if a
newly arrived "have" is a direct child of anything that we have
already heard about, and mark to ignore them.  We need to add
that MAX_HAS counting to fetch-pack side for this to work.

This is not even compile tested, but just to outline the idea.

(... now off to day-job ...)

---

diff --git a/upload-pack.c b/upload-pack.c
index 8a41caf..d98a28e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -3,9 +3,11 @@
 #include "pkt-line.h"
 #include "tag.h"
 #include "object.h"
+#include "commit.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
+#define THEY_HAVE (1U << 0)
 #define MAX_HAS (16)
 #define MAX_NEEDS (256)
 static int nr_has = 0, nr_needs = 0;
@@ -92,6 +94,20 @@ static int got_sha1(char *hex, unsigned 
 		return 0;
 	nr = nr_has;
 	if (nr < MAX_HAS) {
+		struct object *o = lookup_object(sha1);
+		if (!o || (o->parsed || !parse_object(sha1)))
+			die("oops");
+		if (o->type == commit_type) {
+			struct commit_list *parents;
+			if (o->flags & THEY_HAVE)
+				return 0;
+			o->flags |= THEY_HAVE;
+			for (parents = ((struct commit*)o)->parents;
+			     parents;
+			     parents = parents->next) {
+				parents->item->object.flags |= THEY_HAVE;
+			}
+		}
 		memcpy(has_sha1[nr], sha1, 20);
 		nr_has = nr+1;
 	}
@@ -104,6 +120,9 @@ static int get_common_commits(void)
 	unsigned char sha1[20];
 	int len;
 
+	track_object_refs = 0;
+	save_commit_buffer = 0;
+
 	for(;;) {
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
