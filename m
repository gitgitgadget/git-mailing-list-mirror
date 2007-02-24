From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Sat, 24 Feb 2007 02:19:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKlZw-0006lY-HH
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbXBXBT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933308AbXBXBT6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:19:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:42113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933305AbXBXBT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:19:57 -0500
Received: (qmail invoked by alias); 24 Feb 2007 01:19:55 -0000
X-Provags-ID: V01U2FsdGVkX18np4xoFjonYwxGtk8keOkR2nZE8NASl4mLXtoA8O
	ZF8w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40478>

Hi,

Since most servers will not have a no-progress aware upload-pack, how 
about this? (It is slightly ugly, but at least works...)

-- snipsnap --
[PATCH] git-fetch: add --no-progress, work around non-aware upload-pack

This adds the option "--no-progress" to git-fetch, and adds a
workaround for the case when the other side's upload-pack does
not support the "no-progress" extension: it skips the side-band
packets ending in "done\r".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/fetch-options.txt |    5 +++++
 builtin-archive.c               |    2 +-
 fetch-pack.c                    |    2 +-
 git-fetch.sh                    |    3 +++
 sideband.c                      |    6 +++++-
 sideband.h                      |    2 +-
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 5b4d184..3afb28e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -22,6 +22,11 @@
 	and stores them locally.  This option disables this
 	automatic tag following.
 
+\--no-progress::
+	Tell the other side not to show progress. If the other
+	side's upload-pack is new enough, it will actually
+	heed that request.
+
 -t, \--tags::
 	Most of the tags are fetched automatically as branch
 	heads are downloaded, but tags that do not point at
diff --git a/builtin-archive.c b/builtin-archive.c
index 8ea6cb1..3d3fd1b 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -72,7 +72,7 @@ static int run_remote_archiver(const char *remote, int argc,
 		die("git-archive: expected a flush");
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
-	rv = recv_sideband("archive", fd[0], 1, 2);
+	rv = recv_sideband("archive", fd[0], 1, 2, 0);
 	close(fd[0]);
 	close(fd[1]);
 	rv |= finish_connect(pid);
diff --git a/fetch-pack.c b/fetch-pack.c
index 06f4aec..fd38616 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -482,7 +482,7 @@ static pid_t setup_sideband(int fd[2], int xd[2])
 		close(fd[0]);
 		if (xd[0] != xd[1])
 			close(xd[1]);
-		if (recv_sideband("fetch-pack", xd[0], fd[1], 2))
+		if (recv_sideband("fetch-pack", xd[0], fd[1], 2, no_progress))
 			exit(1);
 		exit(0);
 	}
diff --git a/git-fetch.sh b/git-fetch.sh
index 5ae0d28..e7a2be4 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -51,6 +51,9 @@ do
 	-n|--n|--no|--no-|--no-t|--no-ta|--no-tag|--no-tags)
 		no_tags=t
 		;;
+	--no-progress)
+		no_progress=--no-progress
+		;;
 	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
 	--update-he|--update-hea|--update-head|--update-head-|\
 	--update-head-o|--update-head-ok)
diff --git a/sideband.c b/sideband.c
index 277fa3c..6a1a181 100644
--- a/sideband.c
+++ b/sideband.c
@@ -11,7 +11,8 @@
  * stream, aka "verbose").  A message over band #3 is a signal that
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
-int recv_sideband(const char *me, int in_stream, int out, int err)
+int recv_sideband(const char *me, int in_stream, int out, int err,
+		int no_progress)
 {
 	char buf[7 + LARGE_PACKET_MAX + 1];
 	strcpy(buf, "remote:");
@@ -26,6 +27,9 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
 		band = buf[7] & 0xff;
+		if (no_progress && band != 3 && len > 7 + 5 &&
+				!prefixcmp(buf + 7 + len - 5, "done\r"))
+			continue;
 		len--;
 		switch (band) {
 		case 3:
diff --git a/sideband.h b/sideband.h
index a84b691..99a0e96 100644
--- a/sideband.h
+++ b/sideband.h
@@ -7,7 +7,7 @@
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 
-int recv_sideband(const char *me, int in_stream, int out, int err);
+int recv_sideband(const char *me, int in_stream, int out, int err, int no_progress);
 ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
