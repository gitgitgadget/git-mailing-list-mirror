From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] git-cat-file: use sha1_object_info() on '-t'.
Date: Mon, 27 Jun 2005 23:58:45 -0700
Message-ID: <7vfyv3x90a.fsf_-_@assigned-by-dhcp.cox.net>
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
X-From: git-owner@vger.kernel.org Tue Jun 28 08:55:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn9zN-0002g4-Jw
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 08:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVF1HA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 03:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVF1G7s
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 02:59:48 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58039 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261172AbVF1G6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 02:58:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628065846.LQBH17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 02:58:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vpsu7x94t.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 27 Jun 2005 23:56:02 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When trying to find out the type of the object, there is no need
to uncompress the whole object.  Just use sha1_object_info().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cat-file.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

fcfdd3d74d359af32dd30aa9f4fe373cebb3e232
diff --git a/cat-file.c b/cat-file.c
--- a/cat-file.c
+++ b/cat-file.c
@@ -16,13 +16,11 @@ int main(int argc, char **argv)
 		usage("git-cat-file [-t | tagname] <sha1>");
 
 	if (!strcmp("-t", argv[1])) {
-		buf = read_sha1_file(sha1, type, &size);
-		if (buf) {
-			buf = type;
-			size = strlen(type);
-			type[size] = '\n';
-			size++;
+		if (!sha1_object_info(sha1, type, &size)) {
+			printf("%s\n", type);
+			return 0;
 		}
+		buf = NULL;
 	} else {
 		buf = read_object_with_reference(sha1, argv[1], &size, NULL);
 	}
------------
