From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/17] Create read_or_die utility routine.
Date: Sat, 23 Dec 2006 02:33:55 -0500
Message-ID: <20061223073355.GF9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1OM-0001pR-ND
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWLWHd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWLWHd7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:33:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38761 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbWLWHd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:33:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Ns-00037S-Mw; Sat, 23 Dec 2006 02:33:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6008E20FB65; Sat, 23 Dec 2006 02:33:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35285>

Like write_or_die read_or_die reads the entire length requested
or it kills the current process with a die call.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h        |    1 +
 write_or_die.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 936555c..77f2338 100644
--- a/cache.h
+++ b/cache.h
@@ -428,6 +428,7 @@ extern char git_default_name[MAX_GITNAME];
 extern char git_commit_encoding[MAX_ENCODING_LENGTH];
 
 extern int copy_fd(int ifd, int ofd);
+extern void read_or_die(int fd, void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 
diff --git a/write_or_die.c b/write_or_die.c
index bfe4eeb..a56d992 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,5 +1,24 @@
 #include "cache.h"
 
+void read_or_die(int fd, void *buf, size_t count)
+{
+	char *p = buf;
+	ssize_t loaded;
+
+	while (count > 0) {
+		loaded = xread(fd, p, count);
+		if (loaded == 0)
+			die("unexpected end of file");
+		else if (loaded < 0) {
+			if (errno == EPIPE)
+				exit(0);
+			die("read error (%s)", strerror(errno));
+		}
+		count -= loaded;
+		p += loaded;
+	}
+}
+
 void write_or_die(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
-- 
1.4.4.3.g87d8
