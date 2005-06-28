From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] git-cat-file: '-s' to find out object size.
Date: Mon, 27 Jun 2005 23:59:18 -0700
Message-ID: <7v8y0vx8zd.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
	<7vzmtdq7wy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506261206170.19755@ppc970.osdl.org>
	<7vll4wq4va.fsf@assigned-by-dhcp.cox.net>
	<7v1x6om6o5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506271227160.19755@ppc970.osdl.org>
	<7v64vzyqyw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpsu7x94t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 08:56:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnA19-00037j-3w
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 08:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVF1HDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 03:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVF1HCS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 03:02:18 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:6603 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261578AbVF1G7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 02:59:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628065916.KQQF23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 02:59:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vpsu7x94t.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 27 Jun 2005 23:56:02 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We use sha1_object_info() now, and getting size is also trivial.

I admit that this is more of "because we can" not "because I see
immediate need for it", though.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-cat-file.txt |   12 +++++++++---
 cat-file.c                     |   13 ++++++++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

dcf2fc7609509985d4411fb13c6956bcf3c8560f
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,12 +9,13 @@ git-cat-file - Provide content or type i
 
 SYNOPSIS
 --------
-'git-cat-file' (-t | <type>) <object>
+'git-cat-file' (-t | -s | <type>) <object>
 
 DESCRIPTION
 -----------
 Provides content or type of objects in the repository. The type
-is required if '-t' is not being used to find the object type.
+is required unless '-t' is used to find the object type,
+or '-s' is used to find the object size.
 
 OPTIONS
 -------
@@ -25,6 +26,10 @@ OPTIONS
 	Instead of the content, show the object type identified by
 	<object>.
 
+-s::
+	Instead of the content, show the object size identified by
+	<object>.
+
 <type>::
 	Typically this matches the real type of <object> but asking
 	for a type that can trivially dereferenced from the given
@@ -35,7 +40,8 @@ OPTIONS
 
 OUTPUT
 ------
-If '-t' is specified, one of the <type>.
+If '-t' is specified, one of the <type>.  If '-s' is specified,
+the size of the <object> in bytes.
 
 Otherwise the raw (though uncompressed) contents of the <object> will
 be returned.
diff --git a/cat-file.c b/cat-file.c
--- a/cat-file.c
+++ b/cat-file.c
@@ -13,11 +13,18 @@ int main(int argc, char **argv)
 	unsigned long size;
 
 	if (argc != 3 || get_sha1(argv[2], sha1))
-		usage("git-cat-file [-t | tagname] <sha1>");
+		usage("git-cat-file [-t | -s | tagname] <sha1>");
 
-	if (!strcmp("-t", argv[1])) {
+	if (!strcmp("-t", argv[1]) || !strcmp("-s", argv[1])) {
 		if (!sha1_object_info(sha1, type, &size)) {
-			printf("%s\n", type);
+			switch (argv[1][1]) {
+			case 't':
+				printf("%s\n", type);
+				break;
+			case 's':
+				printf("%lu\n", size);
+				break;
+			}
 			return 0;
 		}
 		buf = NULL;
------------
