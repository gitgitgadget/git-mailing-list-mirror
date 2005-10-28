From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fix multi_ack, was Re: [PATCH 8/8] git-fetch-pack: Support
 multi_ack extension
Date: Fri, 28 Oct 2005 05:56:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280555070.5054@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510280449240.20516@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0510280535480.1460@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 05:58:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVLMQ-0007Dj-6N
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 05:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVJ1D4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 23:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVJ1D4n
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 23:56:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45011 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965083AbVJ1D4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 23:56:42 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9570B13F30D; Fri, 28 Oct 2005 05:56:41 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 768EF9EFCF; Fri, 28 Oct 2005 05:56:41 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61D8385CB1; Fri, 28 Oct 2005 05:56:41 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4186C13F321; Fri, 28 Oct 2005 05:56:41 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0510280535480.1460@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10754>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I was already half asleep when I realized that

		printf("%s", "\0multi_ack");

	could not work. All the more astounding, that my tests
	said that the server has multi_ack capability. But that
	was my mixing up arguments to strstr().

	Aargh.

	On Fri, 28 Oct 2005, Johannes Schindelin wrote:

	> never mind patch 7 and 8. I succeeded in fscking up again.
	> Will patch tomorrow.

	Well, I could not sleep with such silly a bug.

 connect.c     |    5 +++--
 upload-pack.c |   10 +++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

applies-to: c45879487343238adc4e926abf0e6280a3f4291c
2c3e9bb8ab663976132315c970c0feea5176fb81
diff --git a/connect.c b/connect.c
index b8aea35..c2badc7 100644
--- a/connect.c
+++ b/connect.c
@@ -8,7 +8,7 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 
-static char *server_capabilities = "";
+static char *server_capabilities = NULL;
 
 /*
  * Read all the refs from the other end
@@ -58,7 +58,8 @@ struct ref **get_remote_heads(int in, st
 
 int server_supports(const char *feature)
 {
-	return strstr(feature, server_capabilities) != NULL;
+	return server_capabilities &&
+		strstr(server_capabilities, feature) != NULL;
 }
 
 int get_ack(int fd, unsigned char *result_sha1)
diff --git a/upload-pack.c b/upload-pack.c
index 686445e..c5eff21 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -212,11 +212,15 @@ static int receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
-	static char *capabilities = "\0multi_ack";
+	static char *capabilities = "multi_ack";
 	struct object *o = parse_object(sha1);
 
-	packet_write(1, "%s %s%s\n", sha1_to_hex(sha1), refname, capabilities);
-	capabilities = "";
+	if (capabilities)
+		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
+			0, capabilities);
+	else
+		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
+	capabilities = NULL;
 	if (!(o->flags & OUR_REF)) {
 		o->flags |= OUR_REF;
 		nr_our_refs++;
---
0.99.8.GIT
