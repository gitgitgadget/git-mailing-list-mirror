From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] daemon: Skip unknown "extra arg" information
Date: Thu, 4 Jun 2009 15:08:24 -0700
Message-ID: <20090604220824.GT3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 00:08:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCL6v-0000kC-T0
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 00:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbZFDWIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 18:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754539AbZFDWIX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 18:08:23 -0400
Received: from george.spearce.org ([209.20.77.23]:44584 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbZFDWIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 18:08:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E3599381D1; Thu,  4 Jun 2009 22:08:24 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120724>

If we don't recognize an extra arg supplied hidden behind the
command, we should skip it and look at the next extra arg, in
case we recognize the next one.

For example, we currently don't recognize the "user=" extra arg,
but we should still be able to start this connection anyway:

 perl -e '
   $s="git-upload-pack /.git\0user=me\0host=localhost\0";
   printf "%4.4x%s",4+length $s,$s
 ' | ./git-daemon --inetd --base-path=`pwd` --export-all

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This should go in maint.

 daemon.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index daa4c8e..a9a4f02 100644
--- a/daemon.c
+++ b/daemon.c
@@ -411,14 +411,13 @@ static char *xstrdup_tolower(const char *str)
 static void parse_extra_args(char *extra_args, int buflen)
 {
 	char *val;
-	int vallen;
 	char *end = extra_args + buflen;
 
 	while (extra_args < end && *extra_args) {
+		int arglen = strlen(extra_args);
 		saw_extended_args = 1;
 		if (strncasecmp("host=", extra_args, 5) == 0) {
 			val = extra_args + 5;
-			vallen = strlen(val) + 1;
 			if (*val) {
 				/* Split <host>:<port> at colon. */
 				char *host = val;
@@ -432,10 +431,10 @@ static void parse_extra_args(char *extra_args, int buflen)
 				free(hostname);
 				hostname = xstrdup_tolower(host);
 			}
-
-			/* On to the next one */
-			extra_args = val + vallen;
 		}
+
+		/* On to the next one */
+		extra_args += arglen + 1;
 	}
 
 	/*
-- 
1.6.3.1.333.g3ebba7
