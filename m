From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2/4] git-*-fetch: Gracefully recover from retrieval failure
Date: Wed, 14 Sep 2005 16:45:45 +0400
Message-ID: <20050914124545.GE24405@master.mivlgu.local>
References: <20050914124206.GC24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 14:47:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFWe6-0002IR-C6
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 14:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVINMps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 08:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVINMps
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 08:45:48 -0400
Received: from mivlgu.ru ([81.18.140.87]:705 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S965151AbVINMpr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 08:45:47 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id E4713180119; Wed, 14 Sep 2005 16:45:45 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050914124206.GC24405@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8520>

If the fetch process is interrupted in the middle after retrieving
some commits, there was no easy way to recover by re-running fetch,
because fetch.c:process_commit() stops at commits which were already
retrieved.

This patch adds the --recover option to git-*-fetch family; with this
option git-*-fetch will walk the whole commit tree instead of stopping
at existing commits, so that missing commits in the middle (and trees
and blobs referenced by them) can be discovered and fetched.

---

 This patch really requires "[PATCH 1/4] Do not try to process objects
 more than once during fetch" - otherwise commit objects are processed
 zillion times, and the fetch just never completes.


 Documentation/git-http-fetch.txt  |    3 +++
 Documentation/git-local-fetch.txt |    3 +++
 Documentation/git-ssh-fetch.txt   |    3 +++
 fetch.c                           |    4 +++-
 fetch.h                           |    6 ++++++
 http-fetch.c                      |    2 ++
 local-fetch.c                     |    2 ++
 ssh-fetch.c                       |    2 ++
 8 files changed, 24 insertions(+), 1 deletions(-)

2b0b8ebb6bba7ac390cccc35a026acf0c4ee6c56
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -21,6 +21,9 @@ Downloads a remote GIT repository via HT
 	Get trees associated with the commit objects.
 -a::
 	Get all the objects.
+--recover::
+	Check all referenced commits instead of stopping at existing
+	ones to recover after earlier fetch that was interrupted.
 -v::
 	Report what is downloaded.
 
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -23,6 +23,9 @@ OPTIONS
 	Get trees associated with the commit objects.
 -a::
 	Get all the objects.
+--recover::
+	Check all referenced commits instead of stopping at existing
+	ones to recover after earlier fetch that was interrupted.
 -v::
 	Report what is downloaded.
 
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
--- a/Documentation/git-ssh-fetch.txt
+++ b/Documentation/git-ssh-fetch.txt
@@ -31,6 +31,9 @@ commit-id::
 	Get trees associated with the commit objects.
 -a::
 	Get all the objects.
+--recover::
+	Check all referenced commits instead of stopping at existing
+	ones to recover after earlier fetch that was interrupted.
 -v::
 	Report what is downloaded.
 -w::
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -16,6 +16,7 @@ const unsigned char *current_ref = NULL;
 int get_tree = 0;
 int get_history = 0;
 int get_all = 0;
+int get_recover = 0;
 int get_verbosely = 0;
 static unsigned char current_commit_sha1[20];
 
@@ -80,7 +81,8 @@ static int process_commit(struct commit 
 	if (get_history) {
 		struct commit_list *parents = commit->parents;
 		for (; parents; parents = parents->next) {
-			if (has_sha1_file(parents->item->object.sha1))
+			if (!get_recover &&
+			    has_sha1_file(parents->item->object.sha1))
 				continue;
 			if (process(parents->item->object.sha1,
 				    commit_type))
diff --git a/fetch.h b/fetch.h
--- a/fetch.h
+++ b/fetch.h
@@ -37,6 +37,12 @@ extern int get_history;
 /* Set to fetch the trees in the commit history. */
 extern int get_all;
 
+/*
+ * Set to walk the whole commit tree without stopping at commits we already
+ * have (so that we could detect and fetch missing commits in the middle).
+ */
+extern int get_recover;
+
 /* Set to be verbose */
 extern int get_verbosely;
 
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -341,6 +341,8 @@ int main(int argc, char **argv)
 		} else if (argv[arg][1] == 'w') {
 			write_ref = argv[arg + 1];
 			arg++;
+		} else if (!strcmp(argv[arg], "--recover")) {
+			get_recover = 1;
 		}
 		arg++;
 	}
diff --git a/local-fetch.c b/local-fetch.c
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -211,6 +211,8 @@ int main(int argc, char **argv)
 			get_verbosely = 1;
 		else if (argv[arg][1] == 'w')
 			write_ref = argv[++arg];
+		else if (!strcmp(argv[arg], "--recover"))
+			get_recover = 1;
 		else
 			usage(local_pull_usage);
 		arg++;
diff --git a/ssh-fetch.c b/ssh-fetch.c
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -106,6 +106,8 @@ int main(int argc, char **argv)
 		} else if (argv[arg][1] == 'w') {
 			write_ref = argv[arg + 1];
 			arg++;
+		} else if (!strcmp(argv[arg], "--recover")) {
+			get_recover = 1;
 		}
 		arg++;
 	}
