From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 15/86] fetch-pack: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:08 +0100
Message-ID: <20131109070720.18178.86102.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2f9-0002lM-UB
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299Ab3KIHIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:44 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65375 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933249Ab3KIHI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:27 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id D570696;
	Sat,  9 Nov 2013 08:08:25 +0100 (CET)
X-git-sha1: 8b736dc790d557bdad6ea8c6dbed5c21335a266c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237487>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a0e0350..1526ed1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -176,9 +176,9 @@ static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 		 */
 		char *line;
 		while ((line = packet_read_line(fd, NULL))) {
-			if (!prefixcmp(line, "shallow "))
+			if (has_prefix(line, "shallow "))
 				continue;
-			if (!prefixcmp(line, "unshallow "))
+			if (has_prefix(line, "unshallow "))
 				continue;
 			die("git fetch-pack: expected shallow list");
 		}
@@ -194,7 +194,7 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 		die("git fetch-pack: expected ACK/NAK, got EOF");
 	if (!strcmp(line, "NAK"))
 		return NAK;
-	if (!prefixcmp(line, "ACK ")) {
+	if (has_prefix(line, "ACK ")) {
 		if (!get_sha1_hex(line+4, result_sha1)) {
 			if (len < 45)
 				return ACK;
@@ -323,13 +323,13 @@ static int find_common(struct fetch_pack_args *args,
 
 		send_request(args, fd[1], &req_buf);
 		while ((line = packet_read_line(fd[0], NULL))) {
-			if (!prefixcmp(line, "shallow ")) {
+			if (has_prefix(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
 					die("invalid shallow line: %s", line);
 				register_shallow(sha1);
 				continue;
 			}
-			if (!prefixcmp(line, "unshallow ")) {
+			if (has_prefix(line, "unshallow ")) {
 				if (get_sha1_hex(line + 10, sha1))
 					die("invalid unshallow line: %s", line);
 				if (!lookup_object(sha1))
@@ -523,7 +523,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		}
 
 		if (!keep && args->fetch_all &&
-		    (!args->depth || prefixcmp(ref->name, "refs/tags/")))
+		    (!args->depth || !has_prefix(ref->name, "refs/tags/")))
 			keep = 1;
 
 		if (keep) {
-- 
1.8.4.1.566.geca833c
