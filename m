From: Junio C Hamano <junkio@cox.net>
Subject: Re: [CORRECTED PATCH] git-fetch-pack: avoid unnecessary zero packing
Date: Tue, 18 Oct 2005 12:19:58 -0700
Message-ID: <7vy84qpr8h.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510181049050.17201@g5.osdl.org>
	<7vmzl6r78e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 21:21:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERx0G-0006D2-Kx
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 21:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVJRTUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 15:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVJRTUA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 15:20:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20195 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751203AbVJRTT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 15:19:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018191936.OVXM29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 15:19:36 -0400
To: Junio C Hamano <junkio@cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10223>

Junio C Hamano <junkio@cox.net> writes:

> No, I haven't (not my git day today).
>
> It strikes me that we could walk from our refs, depth reasonably
> limited to say 20 or so commit chain and/or last 5 days of
> commit time, to see if any of the remotes are reachable from our
> refs and omit issuing "want" quite cheaply.  Do you think that
> would be a worthy change to make things more efficient?

Something like this on top of your second patch?

 ------------
Subject: do not ask for objects known to be complete.

On top of optimization by Linus not to ask refs that already
match, we can shallowly walk our refs and not issue "want" for
things that we know are reachable from them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/fetch-pack.c b/fetch-pack.c
index 4597369..212e00f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "commit.h"
+#include "tag.h"
+#include <time.h>
 #include <sys/wait.h>
 
 static int quiet;
@@ -78,16 +81,58 @@ static int find_common(int fd[2], unsign
 	return retval;
 }
 
+#define COMPLETE	(1U << 0)
+
+/*
+ * 5 days - this should be configurable.
+ */
+#define RECENT		(5 * 24 * 60 * 60)
+
+static struct commit_list *complete = NULL;
+
+static int mark_complete(const char *path, const unsigned char *sha1)
+{
+	struct object *o = parse_object(sha1);
+
+	while (o && o->type == tag_type) {
+		o->flags |= COMPLETE;
+		o = parse_object(((struct tag *)o)->tagged->sha1);
+	}
+	if (o->type == commit_type) {
+		struct commit *commit = (struct commit *)o;
+		commit->object.flags |= COMPLETE;
+		insert_by_date(commit, &complete);
+	}
+	return 0;
+}
+
+static void mark_recent_complete_commits(unsigned long cutoff_date)
+{
+	while (complete && cutoff_date <= complete->item->date) {
+		if (verbose)
+			fprintf(stderr, "Marking %s as complete\n",
+				sha1_to_hex(complete->item->object.sha1));
+		pop_most_recent_commit(&complete, COMPLETE);
+	}
+}
+
 static int everything_local(struct ref *refs)
 {
 	int retval;
+	time_t now;
+
+	time(&now);
+
+	for_each_ref(mark_complete);
+	mark_recent_complete_commits((unsigned long) now - RECENT);
 
 	for (retval = 1; refs ; refs = refs->next) {
 		const unsigned char *remote = refs->old_sha1;
 		unsigned char local[20];
+		struct object *o;
 
-		if (read_ref(git_path("%s", refs->name), local) < 0 ||
-		    memcmp(remote, local, 20)) {
+		o = parse_object(remote);
+		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
 			if (!verbose)
 				continue;
