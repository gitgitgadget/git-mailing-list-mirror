From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 08:30:11 +0100
Message-ID: <49B61703.8030602@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgwRU-0008Pq-3u
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 08:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbZCJHaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 03:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbZCJHaU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 03:30:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11890 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbZCJHaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 03:30:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LgwPk-0005Xm-4h; Tue, 10 Mar 2009 08:30:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D260C4FB; Tue, 10 Mar 2009 08:30:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <49B61377.90103@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112788>

From: Johannes Sixt <j6t@kdbg.org>

This removes the last parameter of recv_sideband, by which the callers
told which channel band #2 data should be written to. Since both callers
of the function passed 2 for the parameter, we hereby remove the
parameter and send band #2 to stderr explicitly using fprintf.

This has the nice side-effect that the band #2 data (most importantly
progress reports during a fetch operation) passes through our ANSI
emulation layer on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Johannes Sixt schrieb:
> Johannes Schindelin schrieb:
>> To make use of it during a fetch, write() needs to be overridden, too.
> 
> No, that's not necessary with the patch that I'm about to send in a
> moment. To replace write() for ANSI emulation really goes too far.

Here it is. The patch is still RFC because I didn't have a chance, yet,
to test it in practice. It passes the test suite.

-- Hannes

 builtin-archive.c    |    2 +-
 builtin-fetch-pack.c |    2 +-
 sideband.c           |   20 +++++++++-----------
 sideband.h           |    2 +-
 4 files changed, 12 insertions(+), 14 deletions(-)

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
index cca3360..a706ac8 100644
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
@@ -95,12 +94,13 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
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
+					if (l > 0)
+						fprintf(stderr, "%.*s", l, b);
 					len -= l;
 				}

@@ -112,10 +112,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
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
1.6.2.987.g90c1d
