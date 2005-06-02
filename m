From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Handle deltified object correctly in git-*-pull family.
Date: Thu, 02 Jun 2005 15:19:00 -0700
Message-ID: <7vu0kg1jxn.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
	<7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506020959250.1876@ppc970.osdl.org>
	<7v3bs07fmu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0506021713330.17354@localhost.localdomain>
	<Pine.LNX.4.63.0506021733520.17354@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 00:21:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddy17-0002k6-N7
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 00:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVFBWUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 18:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFBWTy
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 18:19:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:50581 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261434AbVFBWTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 18:19:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602221900.GANM20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 18:19:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0506021733520.17354@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 02 Jun 2005 17:36:37 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

>> Here you don't need to call unpack_sha1_rest() at all which would call 
>> xmalloc and another memcpy needlessly.  Instead,...

Like this...

------------
When a remote repository is deltified, we need to get the
objects that a deltified object we want to obtain is based upon.
The initial parts of each retrieved SHA1 file is inflated and
inspected to see if it is deltified, and its base object is
asked from the remote side when it is.  Since this partial
inflation and inspection has a small performance hit, it can
optionally be skipped by giving -d flag to git-*-pull commands.
This flag should be used only when the remote repository is
known to have no deltified objects.

Rsync transport does not have this problem since it fetches
everything the remote side has.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Thanks and credits goes to Nico for suggesting not to
*** use unpack_sha1_rest().

 Documentation/git-http-pull.txt  |    6 +++++-
 Documentation/git-local-pull.txt |    6 +++++-
 Documentation/git-rpull.txt      |    6 +++++-
 cache.h                          |    1 +
 pull.h                           |    3 +++
 http-pull.c                      |    4 +++-
 local-pull.c                     |    4 +++-
 pull.c                           |    7 +++++++
 rpull.c                          |    4 +++-
 sha1_file.c                      |   31 +++++++++++++++++++++++++++++++
 10 files changed, 66 insertions(+), 6 deletions(-)

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
@@ -21,6 +21,10 @@ Downloads a remote GIT repository via HT
 	Get trees associated with the commit objects.
 -a::
 	Get all the objects.
+-d::
+	Do not check for delta base objects (use this option
+	only when you know the remote repository is not
+	deltified).
 -v::
 	Report what is downloaded.
 
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
@@ -23,6 +23,10 @@ OPTIONS
 	Get trees associated with the commit objects.
 -a::
 	Get all the objects.
+-d::
+	Do not check for delta base objects (use this option
+	only when you know the remote repository is not
+	deltified).
 -v::
 	Report what is downloaded.
 
diff --git a/Documentation/git-rpull.txt b/Documentation/git-rpull.txt
--- a/Documentation/git-rpull.txt
+++ b/Documentation/git-rpull.txt
@@ -10,7 +10,7 @@ git-rpull - Pulls from a remote reposito
 
 SYNOPSIS
 --------
-'git-rpull' [-c] [-t] [-a] [-v] commit-id url
+'git-rpull' [-c] [-t] [-a] [-d] [-v] commit-id url
 
 DESCRIPTION
 -----------
@@ -25,6 +25,10 @@ OPTIONS
 	Get trees associated with the commit objects.
 -a::
 	Get all the objects.
+-d::
+	Do not check for delta base objects (use this option
+	only when you know the remote repository is not
+	deltified).
 -v::
 	Report what is downloaded.
 
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -153,6 +153,7 @@ extern char *sha1_file_name(const unsign
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
 extern int parse_sha1_header(char *hdr, char *type, unsigned long *sizep);
+extern int sha1_delta_base(const unsigned char *, unsigned char *);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
diff --git a/pull.h b/pull.h
--- a/pull.h
+++ b/pull.h
@@ -13,6 +13,9 @@ extern int get_history;
 /** Set to fetch the trees in the commit history. **/
 extern int get_all;
 
+/* Set to zero to skip the check for delta object base. */
+extern int get_delta;
+
 /* Set to be verbose */
 extern int get_verbosely;
 
diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -103,6 +103,8 @@ int main(int argc, char **argv)
 			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
 			get_history = 1;
+		} else if (argv[arg][1] == 'd') {
+			get_delta = 0;
 		} else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
@@ -113,7 +115,7 @@ int main(int argc, char **argv)
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
@@ -92,6 +92,8 @@ int main(int argc, char **argv)
 			get_tree = 1;
 		else if (argv[arg][1] == 'c')
 			get_history = 1;
+		else if (argv[arg][1] == 'd')
+			get_delta = 0;
 		else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -6,6 +6,7 @@
 
 int get_tree = 0;
 int get_history = 0;
+int get_delta = 1;
 int get_all = 0;
 int get_verbosely = 0;
 static unsigned char current_commit_sha1[20];
@@ -37,6 +38,12 @@ static int make_sure_we_have_it(const ch
 	status = fetch(sha1);
 	if (status && what)
 		report_missing(what, sha1);
+	if (get_delta) {
+		char delta_sha1[20];
+		status = sha1_delta_base(sha1, delta_sha1);
+		if (0 < status)
+			status = make_sure_we_have_it(what, delta_sha1);
+	}
 	return status;
 }
 
diff --git a/rpull.c b/rpull.c
--- a/rpull.c
+++ b/rpull.c
@@ -27,6 +27,8 @@ int main(int argc, char **argv)
 			get_tree = 1;
 		} else if (argv[arg][1] == 'c') {
 			get_history = 1;
+		} else if (argv[arg][1] == 'd') {
+			get_delta = 0;
 		} else if (argv[arg][1] == 'a') {
 			get_all = 1;
 			get_tree = 1;
@@ -37,7 +39,7 @@ int main(int argc, char **argv)
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-rpull [-c] [-t] [-a] [-v] commit-id url");
+		usage("git-rpull [-c] [-t] [-a] [-v] [-d] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -401,6 +401,37 @@ void * unpack_sha1_file(void *map, unsig
 	return unpack_sha1_rest(&stream, hdr, *size);
 }
 
+int sha1_delta_base(const unsigned char *sha1, unsigned char *base_sha1)
+{
+	int ret;
+	unsigned long mapsize, size;
+	void *map;
+	z_stream stream;
+	char hdr[64], type[20];
+	void *delta_data_head;
+
+	map = map_sha1_file(sha1, &mapsize);
+	if (!map)
+		return -1;
+	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
+	if (ret < Z_OK || parse_sha1_header(hdr, type, &size) < 0) {
+		ret = -1;
+		goto out;
+	}
+	if (strcmp(type, "delta")) {
+		ret = 0;
+		goto out;
+	}
+
+	delta_data_head = hdr + strlen(hdr) + 1;
+	ret = 1;
+	memcpy(base_sha1, delta_data_head, 20);
+ out:
+	inflateEnd(&stream);
+	munmap(map, mapsize);
+	return ret;
+}
+
 void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size)
 {
 	unsigned long mapsize;
------------

