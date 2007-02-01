From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/3] provide a nice @{...} syntax to always mean the current
 branch reflog
Date: Thu, 01 Feb 2007 17:29:33 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702011725150.3021@xanadu.home>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <45C25BA6.1000301@fs.ei.tum.de> <Pine.LNX.4.64.0702011710120.3021@xanadu.home>
 <20070201221758.GA15213@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 23:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCkR2-0004Q4-3j
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXBAW3f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbXBAW3e
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:29:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493AbXBAW3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 17:29:34 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCT00H2G2H9JU61@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 17:29:33 -0500 (EST)
In-reply-to: <20070201221758.GA15213@moooo.ath.cx>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38420>

This is shorter than HEAD@{...} and being nameless it has no semantic 
issues.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Thu, 1 Feb 2007, Matthias Lederhofer wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > I really like "@{...}" to mean whatever branch I'm on.  Given that it 
> > has no real name it can happily change meaning with branch switches.
> Ack.

Here it is, on top of my previous patches.

diff --git a/sha1_name.c b/sha1_name.c
index 70c6e42..de8caf8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -279,7 +279,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	/* basic@{time or number} format to query ref-log */
 	reflog_len = at = 0;
 	if (str[len-1] == '}') {
-		for (at = 1; at < len - 1; at++) {
+		for (at = 0; at < len - 1; at++) {
 			if (str[at] == '@' && str[at+1] == '{') {
 				reflog_len = (len-1) - (at+2);
 				len = at;
@@ -289,10 +289,14 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	}
 
 	/* Accept only unambiguous ref paths. */
-	if (ambiguous_path(str, len))
+	if (len && ambiguous_path(str, len))
 		return -1;
 
-	refs_found = dwim_ref(str, len, sha1, &real_ref);
+	if (!len && reflog_len) {
+		/* allow "@{...}" to mean the current branch reflog */
+		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
+	} else
+		refs_found = dwim_ref(str, len, sha1, &real_ref);
 
 	if (!refs_found)
 		return -1;
@@ -312,11 +316,12 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		 * In the mean time prevent people from getting used to
 		 * such a synonym until the work is completed.
 		 */
-		if (!strncmp("HEAD", str, len) &&
+		if (len && !strncmp("HEAD", str, len) &&
 		    !strncmp(real_ref, "refs/", 5)) {
 			error("reflog for HEAD has not been implemented yet\n"
-			      "Maybe you could try %s%s instead.",
-			      strchr(real_ref+5, '/')+1, str + len);
+			      "Maybe you could try %s%s instead, "
+			      "or just %s for current branch..",
+			      strchr(real_ref+5, '/')+1, str+len, str+len);
 			exit(-1);
 		}
 
