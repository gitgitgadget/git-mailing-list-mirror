From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/8] Support receiving server capabilities
Date: Fri, 28 Oct 2005 04:48:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280448330.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 04:49:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKIc-0000wl-Nw
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVJ1Cs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVJ1Cs4
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:48:56 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46287 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965068AbVJ1Csz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:48:55 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BC08313EFF3; Fri, 28 Oct 2005 04:48:54 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 99DE39EFCF; Fri, 28 Oct 2005 04:48:54 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7F4A99EFC3; Fri, 28 Oct 2005 04:48:54 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 777CC13EFF3; Fri, 28 Oct 2005 04:48:54 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10747>


On Thu, 27 Oct 2005, Sergey Vlasov wrote:

> Actually, there is another way to pass some data from the server
> which would be ignored by older clients - at the first stage,
> when upload-pack sends the list of refs to the client:
>
>       packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname, '\0',
>                    server_capabilities);

This patch implements the client side of it. server_capabilities is supposed
to be a string containing space separated features of the server.

After get_remote_heads(), check if the server supports the feature like

	if (server_supports("multi_ack"))
		do_something();

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 cache.h   |    1 +
 connect.c |   16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

applies-to: 755b5d7a6bb3861a284381a8adb26c2241217355
883ea2e2bf664c78a7bee5b29ad9584339085310
diff --git a/cache.h b/cache.h
index 2e36cc5..677c6ac 100644
--- a/cache.h
+++ b/cache.h
@@ -340,6 +340,7 @@ extern int match_refs(struct ref *src, s
 		      int nr_refspec, char **refspec, int all);
 extern int get_ack(int fd, unsigned char *result_sha1);
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, int ignore_funny);
+extern int server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
 extern struct packed_git *parse_pack_index_file(const unsigned char *sha1,
diff --git a/connect.c b/connect.c
index b171c5d..5cc49f9 100644
--- a/connect.c
+++ b/connect.c
@@ -8,6 +8,8 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 
+static char *server_capabilities = "";
+
 /*
  * Read all the refs from the other end
  */
@@ -20,7 +22,7 @@ struct ref **get_remote_heads(int in, st
 		unsigned char old_sha1[20];
 		static char buffer[1000];
 		char *name;
-		int len;
+		int len, name_len;
 
 		len = packet_read_line(in, buffer, sizeof(buffer));
 		if (!len)
@@ -36,6 +38,13 @@ struct ref **get_remote_heads(int in, st
 		    check_ref_format(name + 5))
 			continue;
 
+		name_len = strlen(name);
+		if (len != name_len + 41) {
+			if (server_capabilities)
+				free(server_capabilities);
+			server_capabilities = strdup(name + name_len + 1);
+		}
+
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
 		ref = xcalloc(1, sizeof(*ref) + len - 40);
@@ -47,6 +56,11 @@ struct ref **get_remote_heads(int in, st
 	return list;
 }
 
+int server_supports(const char *feature)
+{
+	return strstr(feature, server_capabilities) != NULL;
+}
+
 int get_ack(int fd, unsigned char *result_sha1)
 {
 	static char line[1000];
---
0.99.8.GIT
