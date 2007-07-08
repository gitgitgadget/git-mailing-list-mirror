From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make attributes "-diff" and "diff" work as advertized
Date: Sun, 8 Jul 2007 01:59:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080153220.4093@racer.site>
References: <Pine.LNX.4.64.0707071749220.4093@racer.site>
 <7vy7hr69ky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 03:06:46 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7LEZ-0002jf-TL
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 03:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbXGHBGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 21:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbXGHBGb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 21:06:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:52093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753774AbXGHBGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 21:06:31 -0400
Received: (qmail invoked by alias); 08 Jul 2007 01:06:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 08 Jul 2007 03:06:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KWT1OOJVKlZHXygEWB0x0DyippFofxdTPgQFBGR
	6S0fmlR61kVw/e
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7hr69ky.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51851>

Hi,

well, it was a quick fix. I had more on my wishlist for today, and wanted 
to be done with it quickly. The proper fix would be something like this, I 
guess (which should not be applied without the changes to t4020, of 
course):

 diff.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 04e7e91..e47921f 100644
--- a/diff.c
+++ b/diff.c
@@ -1113,13 +1113,13 @@ static void setup_diff_attr_check(struct git_attr_check *check)
 
 static void diff_filespec_check_attr(struct diff_filespec *one)
 {
+	int is_binary = -1;
 	struct git_attr_check attr_diff_check[2];
 
 	if (one->checked_attr)
 		return;
 
 	setup_diff_attr_check(attr_diff_check);
-	one->is_binary = 0;
 	one->hunk_header_ident = NULL;
 
 	if (!git_checkattr(one->path, ARRAY_SIZE(attr_diff_check), attr_diff_check)) {
@@ -1128,9 +1128,9 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 		/* binaryness */
 		value = attr_diff_check[0].value;
 		if (ATTR_TRUE(value))
-			;
+			is_binary = 0;
 		else if (ATTR_FALSE(value))
-			one->is_binary = 1;
+			is_binary = 1;
 
 		/* hunk header ident */
 		value = attr_diff_check[1].value;
@@ -1140,11 +1140,15 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 			one->hunk_header_ident = value;
 	}
 
-	if (!one->data && DIFF_FILE_VALID(one))
-		diff_populate_filespec(one, 0);
+	if (is_binary < 0) {
+		if (!one->data && DIFF_FILE_VALID(one))
+			diff_populate_filespec(one, 0);
 
-	if (one->data)
-		one->is_binary = buffer_is_binary(one->data, one->size);
+		if (one->data)
+			one->is_binary =
+				buffer_is_binary(one->data, one->size);
+	} else
+		one->is_binary = is_binary;
 
 }
 
