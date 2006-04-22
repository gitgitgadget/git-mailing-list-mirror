From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] Suffix /HEAD everywhere.
Date: Fri, 21 Apr 2006 22:55:47 -0700
Message-ID: <7vhd4mnogs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 22 21:10:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXNUo-0006jS-5W
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 21:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWDVTKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWDVTKG
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 15:10:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12471 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750969AbWDVTKC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 15:10:02 -0400
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3M5uHj6022294
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 05:56:17 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422055548.VPSG24510.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 01:55:48 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19043>

This is another throw-away idea, but people doing Porcelain
might be interested.

We currently allow "origin" to mean $GIT_DIR/refs/remotes/origin/HEAD,
to give consistent "git fetch origin" semantics for repositories
cloned with the --use-separate-remote option.

Why not extend this to places other than "refs/remotes/*"?  

With this patch, I could arrange the refs like this:

	$GIT_DIR/refs/heads/master/
        $GIT_DIR/refs/heads/master/HEAD (symref points at somewhere)
	$GIT_DIR/refs/heads/master/master (perhaps here)
        $GIT_DIR/refs/heads/master/topic1 (topic branched from "master")
        $GIT_DIR/refs/heads/master/topic2 (another)

and I can just say "master" to mean refs/heads/master/master,
and say "master/topic1", "master/topic1" to name the topic
branches.

This patch only does the reading side, and when somebody tries
to implement creation/update side, some unsurmountable problems
may be discovered, but it just seemed an interesting idea.  I do
not know how useful it is, tho.

-jc

diff --git a/sha1_name.c b/sha1_name.c
index 345935b..ab2eaf7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -237,13 +237,15 @@ static int ambiguous_path(const char *pa
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
 	static const char *fmt[] = {
-		"%.*s",
-		"refs/%.*s",
-		"refs/tags/%.*s",
-		"refs/heads/%.*s",
-		"refs/remotes/%.*s",
-		"refs/remotes/%.*s/HEAD",
-		NULL
+		"%.*s%s",
+		"refs/%.*s%s",
+		"refs/tags/%.*s%s",
+		"refs/heads/%.*s%s",
+		"refs/remotes/%.*s%s",
+	};
+	static const char *sfx[] = {
+		"",
+		"/HEAD",
 	};
 	const char **p;
 	const char *warning = "warning: refname '%.*s' is ambiguous.\n";
@@ -259,17 +261,21 @@ static int get_sha1_basic(const char *st
 	if (ambiguous_path(str, len))
 		return -1;
 
-	for (p = fmt; *p; p++) {
-		this_result = already_found ? sha1_from_ref : sha1;
-		pathname = git_path(*p, len, str);
-		if (!read_ref(pathname, this_result)) {
-			if (warn_ambiguous_refs) {
-				if (already_found)
-					fprintf(stderr, warning, len, str);
-				already_found++;
+	for (p = fmt; p < fmt + ARRAY_SIZE(fmt); p++) {
+		const char **s;
+		for (s = sfx; s < sfx + ARRAY_SIZE(sfx); s++) {
+			this_result = already_found ? sha1_from_ref : sha1;
+			pathname = git_path(*p, len, str, *s);
+			if (!read_ref(pathname, this_result)) {
+				if (warn_ambiguous_refs) {
+					if (already_found)
+						fprintf(stderr, warning,
+							len, str);
+					already_found++;
+				}
+				else
+					return 0;
 			}
-			else
-				return 0;
 		}
 	}
 	if (already_found)
