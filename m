From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3.1/4] daemon: inline fill_in_extra_table_entries()
Date: Sun, 23 Nov 2008 00:19:09 +0100
Message-ID: <4928936D.8010404@lsrfire.ath.cx>
References: <4928912A.5050307@lsrfire.ath.cx> <492891FC.6000908@lsrfire.ath.cx> <49289275.7090003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@freescale.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 00:20:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L41mA-0003Qa-ID
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 00:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbYKVXTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 18:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbYKVXTP
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 18:19:15 -0500
Received: from india601.server4you.de ([85.25.151.105]:55877 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbYKVXTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 18:19:14 -0500
Received: from [10.0.1.101] (p57B7B890.dip.t-dialin.net [87.183.184.144])
	by india601.server4you.de (Postfix) with ESMTPSA id 74D432F8057;
	Sun, 23 Nov 2008 00:19:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <49289275.7090003@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101564>

Having fill_in_extra_table_entries() as a separate function has no
advantage -- a function with no parameters and return values might as
well be an anonymous block of code.  Its name still refers to the table
of interpolate() which has been removed earlier, so it's better to
inline it at its only call site.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 daemon.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/daemon.c b/daemon.c
index 64f60c4..fbf61ca 100644
--- a/daemon.c
+++ b/daemon.c
@@ -414,6 +414,7 @@ static void parse_extra_args(char *extra_args, int buflen)
 	char *val;
 	int vallen;
 	char *end = extra_args + buflen;
+	char *hp;
 
 	while (extra_args < end && *extra_args) {
 		saw_extended_args = 1;
@@ -438,11 +439,6 @@ static void parse_extra_args(char *extra_args, int buflen)
 			extra_args = val + vallen;
 		}
 	}
-}
-
-static void fill_in_extra_table_entries(void)
-{
-	char *hp;
 
 	/*
 	 * Replace literal host with lowercase-ized hostname.
@@ -562,10 +558,8 @@ static int execute(struct sockaddr *addr)
 	free(directory);
 	hostname = canon_hostname = ip_address = tcp_port = directory = NULL;
 
-	if (len != pktlen) {
+	if (len != pktlen)
 		parse_extra_args(line + len + 1, pktlen - len - 1);
-		fill_in_extra_table_entries();
-	}
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
-- 
1.6.0.4.755.g6e139
