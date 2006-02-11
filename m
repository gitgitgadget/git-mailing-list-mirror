From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git clone" less of a deathly quiet experience
Date: Fri, 10 Feb 2006 20:31:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Feb 11 05:31:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7mQ1-0003fO-QB
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 05:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWBKEbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 23:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBKEbW
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 23:31:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbWBKEbV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 23:31:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1B4VCDZ014471
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Feb 2006 20:31:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1B4V9ul019092;
	Fri, 10 Feb 2006 20:31:10 -0800
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15923>


I was on IRC today (which is definitely not normal, but hey, I tried it), 
and somebody was complaining about how horribly slow "git clone" was on 
the WineHQ repository.

The WineHQ git repo is actually fairly big: 120+MB packed, 220+ thousand 
objects. So creating the pack is actually a big operation, and yes, it's 
too slow. We should be better at it, and it would be good if the pack-file 
generation were much faster.

However, it turns out that the "slow" git-pack-objects was only using up 
2.3% of CPU time. The fact is, the primary reason it took a long time is 
that even packed, it had to get 120 MB of data. So in this case, it 
appears that the fact that it uses a lot of CPU is actually a good 
trade-off, because the damn thing would have been even slower if it hadn't 
been packed.

(Of course, pre-generated packs would be good regardless)

Anyway, what _really_ made for a pissed-off user was that "git clone" was 
just very very silent all the time. No updates on what the hell it was 
doing. Was it working at all? Was something broken? Is git just a piece of 
cr*p? But "git clone" would not say a peep about it.

It used to be that "git-unpack-objects" would give nice percentages, but 
now that we don't unpack the initial clone pack any more, it doesn't. And 
I'd love to do that nice percentage view in the pack objects downloader 
too, but the thing doesn't even read the pack header, much less know how 
much it's going to get, so I was lazy and didn't.

Instead, it at least prints out how much data it's gotten, and what the 
packign speed is. Which makes the user realize that it's actually doing 
something useful instead of sitting there silently (and if the recipient 
knows how large the final result is, he can at least make a guess about 
when it migt be done).

So with this patch, I get something like this on my DSL line:

	[torvalds@g5 ~]$ time git clone master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6 clone-test
	Packing 188543 objects
	  48.398MB  (154 kB/s)

where even the speed approximation seem sto be roughtly correct (even 
though my algorithm is a truly stupid one, and only really gives "speed in 
the last half second or so").

Anyway, _something_ like this is definitely needed. It could certainly be 
better (if it showed the same kind of thing that git-unpack-objects did, 
that would be much nicer, but would require parsing the object stream as 
it comes in). But this is  big step forward, I think.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Comments? Hate-mail? Improvements?

diff --git a/cache.h b/cache.h
index bdbe2d6..c255421 100644
--- a/cache.h
+++ b/cache.h
@@ -348,6 +348,6 @@ extern int copy_fd(int ifd, int ofd);
 
 /* Finish off pack transfer receiving end */
 extern int receive_unpack_pack(int fd[2], const char *me, int quiet);
-extern int receive_keep_pack(int fd[2], const char *me);
+extern int receive_keep_pack(int fd[2], const char *me, int quiet);
 
 #endif /* CACHE_H */
diff --git a/clone-pack.c b/clone-pack.c
index f634431..719e1c4 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -6,6 +6,8 @@ static const char clone_pack_usage[] =
 "git-clone-pack [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
 static const char *exec = "git-upload-pack";
 
+static int quiet = 0;
+
 static void clone_handshake(int fd[2], struct ref *ref)
 {
 	unsigned char sha1[20];
@@ -123,7 +125,9 @@ static int clone_pack(int fd[2], int nr_
 	}
 	clone_handshake(fd, refs);
 
-	status = receive_keep_pack(fd, "git-clone-pack");
+	if (!quiet)
+		fprintf(stderr, "Generating pack ...\r");
+	status = receive_keep_pack(fd, "git-clone-pack", quiet);
 
 	if (!status) {
 		if (nr_match == 0)
@@ -154,8 +158,10 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (*arg == '-') {
-			if (!strcmp("-q", arg))
+			if (!strcmp("-q", arg)) {
+				quiet = 1;
 				continue;
+			}
 			if (!strncmp("--exec=", arg, 7)) {
 				exec = arg + 7;
 				continue;
diff --git a/fetch-clone.c b/fetch-clone.c
index 859f400..b67d976 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include <sys/wait.h>
+#include <sys/time.h>
 
 static int finish_pack(const char *pack_tmp_name, const char *me)
 {
@@ -129,10 +130,12 @@ int receive_unpack_pack(int fd[2], const
 	die("git-unpack-objects died of unnatural causes %d", status);
 }
 
-int receive_keep_pack(int fd[2], const char *me)
+int receive_keep_pack(int fd[2], const char *me, int quiet)
 {
 	char tmpfile[PATH_MAX];
 	int ofd, ifd;
+	unsigned long total;
+	static struct timeval prev_tv;
 
 	ifd = fd[0];
 	snprintf(tmpfile, sizeof(tmpfile),
@@ -141,6 +144,8 @@ int receive_keep_pack(int fd[2], const c
 	if (ofd < 0)
 		return error("unable to create temporary file %s", tmpfile);
 
+	gettimeofday(&prev_tv, NULL);
+	total = 0;
 	while (1) {
 		char buf[8192];
 		ssize_t sz, wsz, pos;
@@ -165,6 +170,27 @@ int receive_keep_pack(int fd[2], const c
 			}
 			pos += wsz;
 		}
+		total += sz;
+		if (!quiet) {
+			static unsigned long last;
+			struct timeval tv;
+			unsigned long diff = total - last;
+			/* not really "msecs", but a power-of-two millisec (1/1024th of a sec) */
+			unsigned long msecs;
+
+			gettimeofday(&tv, NULL);
+			msecs = tv.tv_sec - prev_tv.tv_sec;
+			msecs <<= 10;
+			msecs += (int)(tv.tv_usec - prev_tv.tv_usec) >> 10;
+			if (msecs > 500) {
+				prev_tv = tv;
+				last = total;
+				fprintf(stderr, "%4lu.%03luMB  (%lu kB/s)        \r",
+					total >> 20,
+					1000*((total >> 10) & 1023)>>10,
+					diff / msecs );
+			}
+		}
 	}
 	close(ofd);
 	return finish_pack(tmpfile, me);
diff --git a/fetch-pack.c b/fetch-pack.c
index 27f5d2a..aa6f42a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -378,7 +378,7 @@ static int fetch_pack(int fd[2], int nr_
 		fprintf(stderr, "warning: no common commits\n");
 
 	if (keep_pack)
-		status = receive_keep_pack(fd, "git-fetch-pack");
+		status = receive_keep_pack(fd, "git-fetch-pack", quiet);
 	else
 		status = receive_unpack_pack(fd, "git-fetch-pack", quiet);
 
