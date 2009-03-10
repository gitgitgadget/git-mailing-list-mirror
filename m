From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] recv_sideband: Bands #2 and #3 always go to stderr
Date: Tue, 10 Mar 2009 22:54:17 +0100
Message-ID: <200903102254.17517.j6t@kdbg.org>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 22:55:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh9vW-000871-My
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 22:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbZCJVy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 17:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZCJVyZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 17:54:25 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41683 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457AbZCJVyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 17:54:25 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 98CC5CDF82;
	Tue, 10 Mar 2009 22:54:18 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0C45A3FFC3;
	Tue, 10 Mar 2009 22:54:18 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <49B61703.8030602@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112851>

This removes the last parameter of recv_sideband, by which the callers
told which channel bands #2 and #3 should be written to.

Sayeth Shawn Pearce:

   The definition of the streams in the current sideband protocol
   are rather well defined for the one protocol that uses it,
   fetch-pack/receive-pack:

     stream #1:  pack data
     stream #2:  stderr messages, progress, meant for tty
     stream #3:  abort message, remote is dead, goodbye!

Since both callers of the function passed 2 for the parameter, we hereby
remove it and send bands #2 and #3 to stderr explicitly using fprintf.

This has the nice side-effect that these two streams pass through our
ANSI emulation layer on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Acked-by: Nicolas Pitre <nico@cam.org>
---
 This patch has an updated commit message and this small change:

  				} else {
  					int l = brk ? brk : len;
 -					if (l > 0)
 -						fprintf(stderr, "%.*s", l, b);
 +					fprintf(stderr, "%.*s", l, b);
  					len -= l;
  				}

 I also has undergone some practical tests in addition to the
 test suite.

 -- Hannes

 builtin-archive.c    |    2 +-
 builtin-fetch-pack.c |    2 +-
 sideband.c           |   19 ++++++++-----------
 sideband.h           |    2 +-
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 60adef9..ab50ceb 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -52,7 +52,7 @@ static int run_remote_archiver(int argc, const char **argv,
 		die("git archive: expected a flush");
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
-	rv = recv_sideband("archive", fd[0], 1, 2);
+	rv = recv_sideband("archive", fd[0], 1);
 	close(fd[0]);
 	close(fd[1]);
 	rv |= finish_connect(conn);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index c2e5adc..2b36099 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -482,7 +482,7 @@ static int sideband_demux(int fd, void *data)
 {
 	int *xd = data;
 
-	return recv_sideband("fetch-pack", xd[0], fd, 2);
+	return recv_sideband("fetch-pack", xd[0], fd);
 }
 
 static int get_pack(int xd[2], char **pack_lockfile)
diff --git a/sideband.c b/sideband.c
index cca3360..899b1ff 100644
--- a/sideband.c
+++ b/sideband.c
@@ -19,7 +19,7 @@
 
 #define FIX_SIZE 10  /* large enough for any of the above */
 
-int recv_sideband(const char *me, int in_stream, int out, int err)
+int recv_sideband(const char *me, int in_stream, int out)
 {
 	unsigned pf = strlen(PREFIX);
 	unsigned sf;
@@ -41,8 +41,7 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 		if (len == 0)
 			break;
 		if (len < 1) {
-			len = sprintf(buf, "%s: protocol error: no band designator\n", me);
-			safe_write(err, buf, len);
+			fprintf(stderr, "%s: protocol error: no band designator\n", me);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
 		band = buf[pf] & 0xff;
@@ -50,8 +49,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 		switch (band) {
 		case 3:
 			buf[pf] = ' ';
-			buf[pf+1+len] = '\n';
-			safe_write(err, buf, pf+1+len+1);
+			buf[pf+1+len] = '\0';
+			fprintf(stderr, "%s\n", buf);
 			return SIDEBAND_REMOTE_ERROR;
 		case 2:
 			buf[pf] = ' ';
@@ -95,12 +94,12 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 					memcpy(save, b + brk, sf);
 					b[brk + sf - 1] = b[brk - 1];
 					memcpy(b + brk - 1, suffix, sf);
-					safe_write(err, b, brk + sf);
+					fprintf(stderr, "%.*s", brk + sf, b);
 					memcpy(b + brk, save, sf);
 					len -= brk;
 				} else {
 					int l = brk ? brk : len;
-					safe_write(err, b, l);
+					fprintf(stderr, "%.*s", l, b);
 					len -= l;
 				}
 
@@ -112,10 +111,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 			safe_write(out, buf + pf+1, len);
 			continue;
 		default:
-			len = sprintf(buf,
-				      "%s: protocol error: bad band #%d\n",
-				      me, band);
-			safe_write(err, buf, len);
+			fprintf(stderr, "%s: protocol error: bad band #%d\n",
+				me, band);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
 	}
diff --git a/sideband.h b/sideband.h
index a84b691..d72db35 100644
--- a/sideband.h
+++ b/sideband.h
@@ -7,7 +7,7 @@
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
 
-int recv_sideband(const char *me, int in_stream, int out, int err);
+int recv_sideband(const char *me, int in_stream, int out);
 ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
-- 
1.6.2.103.gb3eac.dirty
