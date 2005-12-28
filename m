From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/6] git-describe: really prefer tags only.
Date: Tue, 27 Dec 2005 16:42:14 -0800
Message-ID: <7v1wzy3vdl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<Pine.LNX.4.64.0512241409300.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 01:43:26 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErPPV-0003w8-QV
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 01:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVL1Am0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 19:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVL1Am0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 19:42:26 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:53656 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932422AbVL1AmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 19:42:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228004110.HEOC20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 19:41:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14086>

Often there are references other than annotated tags under
refs/tags hierarchy that are used to "keep things just in case".
default to use annotated tags only, still leaving the option to
use any ref with --all flag.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Linus Torvalds <torvalds@osdl.org> writes:

 > On Sat, 24 Dec 2005, Linus Torvalds wrote:
 >> 
 >> This is useful for two things:
 >> 
 >>  - automatic version naming in Makefiles, for example. We could use it in 
 >>    git itself: when doing "git --version", we could use this to give a 
 >>    much more useful description of exactly what version was installed.
 >
 > This trivial patch fails to do that correctly, but maybe somebody could 
 > fix it. 

 Here is a 6-patch series towards that.  Will be in the proposed
 updates later tonight.

 describe.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

170c7e67e7792e0d5ce2328c1d7b8d4139a7c7e7
diff --git a/describe.c b/describe.c
index ebfa429..e1b6588 100644
--- a/describe.c
+++ b/describe.c
@@ -1,12 +1,13 @@
 #include "cache.h"
 #include "commit.h"
+#include "tag.h"
 #include "refs.h"
 
 #define SEEN (1u << 0)
 
 static const char describe_usage[] = "git-describe [--all] <committish>*";
 
-static int all = 0;	/* Default to tags only */
+static int all = 0;	/* Default to annotated tags only */
 
 static int names = 0, allocs = 0;
 static struct commit_name {
@@ -49,9 +50,15 @@ static int get_name(const char *path, co
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	if (!commit)
 		return 0;
-	if (!all && strncmp(path, "refs/tags/", 10))
-		return 0;
-	add_to_known_names(path, commit);
+	if (!all) {
+		struct object *object;
+		if (strncmp(path, "refs/tags/", 10))
+			return 0;
+		object = parse_object(sha1);
+		if (object->type != tag_type)
+			return 0;
+	}
+	add_to_known_names(all ? path : path + 10, commit);
 	return 0;
 }
 
-- 
1.0.5-geb9d
