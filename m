From: Johan Herland <johan@herland.net>
Subject: [PATCH 11/15] git-note: (Transfer) Teach git-fetch to auto-follow notes
Date: Sun, 27 May 2007 16:15:29 +0200
Message-ID: <200705271615.29286.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:15:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJX0-0007QX-IB
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbXE0OPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbXE0OPd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:15:33 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33397 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbXE0OPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:15:33 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00503E9WFJ00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00GZWE9TR040@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:29 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP0008CE9TJB60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:29 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48551>

This causes git-fetch to auto-follow notes in the same fashion that tags
are auto-followed by default.

Pretty much all the code in this patch is about doing the same thing for
notes as what is already done for tags.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fetch--tool.c |   11 +++++++++++
 git-fetch.sh          |   27 +++++++++++++++++++++++++++
 git-parse-remote.sh   |    4 ++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index ed4d5de..71ddc6d 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -82,6 +82,8 @@ static int update_local_ref(const char *name,
 		/* new ref */
 		if (!strncmp(name, "refs/tags/", 10))
 			msg = "storing tag";
+		else if (!strncmp(name, "refs/notes/", 11))
+			msg = "storing note";
 		else
 			msg = "storing head";
 		fprintf(stderr, "* %s: storing %s\n",
@@ -103,6 +105,11 @@ static int update_local_ref(const char *name,
 		show_new(type, sha1_new);
 		return update_ref("updating tag", name, sha1_new, NULL);
 	}
+	else if (!strncmp(name, "refs/notes/", 11)) {
+		fprintf(stderr, "* %s: updating with %s\n", name, note);
+		show_new(type, sha1_new);
+		return update_ref("updating note", name, sha1_new, NULL);
+	}
 
 	current = lookup_commit_reference(sha1_old);
 	updated = lookup_commit_reference(sha1_new);
@@ -163,6 +170,10 @@ static int append_fetch_head(FILE *fp,
 		kind = "tag";
 		what = remote_name + 10;
 	}
+	else if (!strncmp(remote_name, "refs/notes/", 11)) {
+		kind = "note";
+		what = remote_name + 11;
+	}
 	else if (!strncmp(remote_name, "refs/remotes/", 13)) {
 		kind = "remote branch";
 		what = remote_name + 13;
diff --git a/git-fetch.sh b/git-fetch.sh
index 0e05cf1..a2a7874 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -353,6 +353,33 @@ case "$no_tags$tags" in
 	esac
 esac
 
+# automated note following
+case "" in # --notes and --no-notes options?
+'')
+	case "$reflist" in
+	*:refs/*)
+		# effective only when we are following remote branch
+		# using local tracking branch.
+		notelist=$(IFS='	' &&
+		echo "$ls_remote_result" |
+		git-show-ref --exclude-existing=refs/notes/ |
+		while read sha1 name
+		do
+			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
+			echo >&2 "Auto-following $name"
+			echo ".${name}:${name}"
+		done)
+	esac
+	case "$notelist" in
+	'') ;;
+	?*)
+		# do not deepen a shallow tree when following notes
+		shallow_depth=
+		fetch_main "$notelist" || exit ;;
+	esac
+esac
+
+
 # If the original head was empty (i.e. no "master" yet), or
 # if we were told not to worry, we do not have to check.
 case "$orig_head" in
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 0506b12..95dcc10 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -144,13 +144,13 @@ canon_refs_list_for_fetch () {
 		case "$remote" in
 		'' | HEAD ) remote=HEAD ;;
 		refs/*) ;;
-		heads/* | tags/* | remotes/* ) remote="refs/$remote" ;;
+		heads/* | tags/* | notes/* | remotes/* ) remote="refs/$remote" ;;
 		*) remote="refs/heads/$remote" ;;
 		esac
 		case "$local" in
 		'') local= ;;
 		refs/*) ;;
-		heads/* | tags/* | remotes/* ) local="refs/$local" ;;
+		heads/* | tags/* | notes/* | remotes/* ) local="refs/$local" ;;
 		*) local="refs/heads/$local" ;;
 		esac
 
-- 
1.5.2.101.gee49f
