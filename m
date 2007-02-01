From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch
 reflog
Date: Thu, 01 Feb 2007 12:33:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 18:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCfoN-00078o-Vh
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbXBARdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbXBARdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:33:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32692 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161226AbXBARdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:33:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCS00KW6ORNRUE0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 12:33:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38379>

The work in progress to enable separate reflog for HEAD will make it
independent from reflog of any branch HEAD might be pointing to. In
the mean time disallow HEAD@{...} until that work is completed. Otherwise
people might get used to the current behavior which makes HEAD@{...} an
alias for <current_branch>@{...} which won't be the case later.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_name.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9dfb3ac..70c6e42 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -301,12 +301,26 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		fprintf(stderr, warning, len, str);
 
 	if (reflog_len) {
-		/* Is it asking for N-th entry, or approxidate? */
 		int nth, i;
 		unsigned long at_time;
 		unsigned long co_time;
 		int co_tz, co_cnt;
 
+		/*
+		 * We'll have an independent reflog for "HEAD" eventually
+		 * which won't be a synonym for the current branch reflog.
+		 * In the mean time prevent people from getting used to
+		 * such a synonym until the work is completed.
+		 */
+		if (!strncmp("HEAD", str, len) &&
+		    !strncmp(real_ref, "refs/", 5)) {
+			error("reflog for HEAD has not been implemented yet\n"
+			      "Maybe you could try %s%s instead.",
+			      strchr(real_ref+5, '/')+1, str + len);
+			exit(-1);
+		}
+
+		/* Is it asking for N-th entry, or approxidate? */
 		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
 			char ch = str[at+2+i];
 			if ('0' <= ch && ch <= '9')
-- 
1.5.0.rc2.131.g4b01-dirty
