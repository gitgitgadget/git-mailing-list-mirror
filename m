From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add -d flag to git-pull-* family.
Date: Wed, 01 Jun 2005 01:24:22 -0700
Message-ID: <7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
	<7vacmapo18.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 10:23:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdOUd-00054v-O6
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 10:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVFAIZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 04:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFAIZJ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 04:25:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26017 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261278AbVFAIYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 04:24:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601082424.IDPN26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 04:24:24 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <7vacmapo18.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 31 May 2005 23:52:03 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When a remote repository is deltified, we need to get the
objects that a deltified object we want to obtain is based upon.
Since checking representation type of all objects we retreive
from remote side may be costly, this is made into a separate
option -d; -a implies it for convenience and safety.

Rsync transport does not have this problem since it fetches
everything the remote side has.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-http-pull.txt  |    4 +++-
Documentation/git-local-pull.txt |    4 +++-
Documentation/git-rpull.txt      |    4 +++-
http-pull.c                      |    5 ++++-
local-pull.c                     |    5 ++++-
pull.c                           |   15 +++++++++++++++
pull.h                           |    3 +++
rpull.c                          |    5 ++++-
8 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-http-pull.txt b/Documentation/git-http-pull.txt
--- a/Documentation/git-http-pull.txt
+++ b/Documentation/git-http-pull.txt
@@ -9,7 +9,7 @@ git-http-pull - Downloads a remote GIT r
 
 SYNOPSIS
 --------
-'git-http-pull' [-c] [-t] [-a] [-v] commit-id url
+'git-http-pull' [-c] [-t] [-a] [-v] [-d] commit-id url
 
 DESCRIPTION
 -----------
@@ -17,6 +17,8 @@ Downloads a remote GIT repository via HT
 
 -c::
 	Get the commit objects.
+-d::
+	Get objects that deltified objects are based upon.
 -t::
 	Get trees associated with the commit objects.
 -a::
diff --git a/Documentation/git-local-pull.txt b/Documentation/git-local-pull.txt
--- a/Documentation/git-local-pull.txt
+++ b/Documentation/git-local-pull.txt
@@ -9,7 +9,7 @@ git-local-pull - Duplicates another GIT 
 
 SYNOPSIS
 --------
-'git-local-pull' [-c] [-t] [-a] [-l] [-s] [-n] [-v] commit-id path
+'git-local-pull' [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] commit-id path
 
 DESCRIPTION
 -----------
@@ -19,6 +19,8 @@ OPTIONS
 -------
 -c::
 	Get the commit objects.
+-d::
+	Get objects that deltified objects are based upon.
 -t::
 	Get trees associated with the commit objects.
 -a::
diff --git a/Documentation/git-rpull.txt b/Documentation/git-rpull.txt
--- a/Documentation/git-rpull.txt
+++ b/Documentation/git-rpull.txt
@@ -10,7 +10,7 @@ git-rpull - Pulls from a remote reposito
 
 SYNOPSIS
 --------
-'git-rpull' [-c] [-t] [-a] [-v] commit-id url
+'git-rpull' [-c] [-t] [-a] [-v] [-d] commit-id url
 
 DESCRIPTION
 -----------
@@ -21,6 +21,8 @@ OPTIONS
 -------
 -c::
 	Get the commit objects.
+-d::
+	Get objects that deltified objects are based upon.
 -t::
 	Get trees associated with the commit objects.
 -a::
diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -103,17 +103,20 @@ int main(int argc, char **argv)
 			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
 			get_history = 1;
+		} else if (argv[arg][1] == 'd') {
+			get_delta = 1;
 		} else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
 			get_history = 1;
+			get_delta = 1;
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-http-pull [-c] [-t] [-a] [-v] commit-id url");
+		usage("git-http-pull [-c] [-t] [-a] [-d] [-v] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -74,7 +74,7 @@ int fetch(unsigned char *sha1)
 }
 
 static const char *local_pull_usage = 
-"git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] commit-id path";
+"git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] commit-id path";
 
 /* 
  * By default we only use file copy.
@@ -92,10 +92,13 @@ int main(int argc, char **argv)
 			get_tree = 1;
 		else if (argv[arg][1] == 'c')
 			get_history = 1;
+		else if (argv[arg][1] == 'd')
+			get_delta = 1;
 		else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
 			get_history = 1;
+			get_delta = 1;
 		}
 		else if (argv[arg][1] == 'l')
 			use_link = 1;
diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -6,6 +6,7 @@
 
 int get_tree = 0;
 int get_history = 0;
+int get_delta = 0;
 int get_all = 0;
 int get_verbosely = 0;
 static unsigned char current_commit_sha1[20];
@@ -37,6 +38,20 @@ static int make_sure_we_have_it(const ch
 	status = fetch(sha1);
 	if (status && what)
 		report_missing(what, sha1);
+	if (get_delta) {
+		unsigned long mapsize, size;
+		void *map, *buf;
+		char type[20];
+
+		map = map_sha1_file(sha1, &mapsize);
+		if (map) {
+			buf = unpack_sha1_file(map, mapsize, type, &size);
+			munmap(map, mapsize);
+			if (buf && !strcmp(type, "delta"))
+				status = make_sure_we_have_it(what, buf);
+			free(buf);
+		}
+	}
 	return status;
 }
 
diff --git a/pull.h b/pull.h
--- a/pull.h
+++ b/pull.h
@@ -13,6 +13,9 @@ extern int get_history;
 /** Set to fetch the trees in the commit history. **/
 extern int get_all;
 
+/* Set to fetch the base of delta objects.*/
+extern int get_delta;
+
 /* Set to be verbose */
 extern int get_verbosely;
 
diff --git a/rpull.c b/rpull.c
--- a/rpull.c
+++ b/rpull.c
@@ -27,17 +27,20 @@ int main(int argc, char **argv)
 			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
 			get_history = 1;
+		} else if (argv[arg][1] == 'd') {
+			get_delta = 1;
 		} else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
 			get_history = 1;
+			get_delta = 1;
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-rpull [-c] [-t] [-a] [-v] commit-id url");
+		usage("git-rpull [-c] [-t] [-a] [-v] [-d] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
------------------------------------------------

