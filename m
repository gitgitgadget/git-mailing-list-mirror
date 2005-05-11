From: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 19:24:16 +0000
Organization: linutronix
Message-ID: <1115839456.22180.79.camel@tglx>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 11 21:17:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVwhO-00007h-Uz
	for gcvg-git@gmane.org; Wed, 11 May 2005 21:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVEKTXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 15:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVEKTXi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 15:23:38 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27265
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262026AbVEKTX0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 15:23:26 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id D794565C003
	for <git@vger.kernel.org>; Wed, 11 May 2005 21:23:24 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 156A928204
	for <git@vger.kernel.org>; Wed, 11 May 2005 21:23:26 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The patch adds an option to stop the output of git-rev-list
on a sha1 match. 

Signed-Off: Thomas Gleixner <tglx@linutronix.de>

--- a/rev-list.c
+++ b/rev-list.c
@@ -7,6 +7,8 @@ int main(int argc, char **argv)
 	struct commit_list *list = NULL;
 	struct commit *commit;
 	char *commit_arg = NULL;
+	char *sha1hex;
+	char *to_sha1 = NULL;
 	int i;
 	unsigned long max_age = -1;
 	unsigned long min_age = -1;
@@ -21,6 +23,8 @@ int main(int argc, char **argv)
 			max_age = atoi(arg + 10);
 		} else if (!strncmp(arg, "--min-age=", 10)) {
 			min_age = atoi(arg + 10);
+		} else if (!strncmp(arg, "--to_sha1=", 10)) {
+			to_sha1 = arg + 10;
 		} else {
 			commit_arg = arg;
 		}
@@ -30,7 +34,8 @@ int main(int argc, char **argv)
 		usage("usage: rev-list [OPTION] commit-id\n"
 		      "  --max-count=nr\n"
 		      "  --max-age=epoch\n"
-		      "  --min-age=epoch\n");
+		      "  --min-age=epoch\n"
+		      "  --to-sha1=sha1\n");
 
 	commit = lookup_commit(sha1);
 	if (!commit || parse_commit(commit) < 0)
@@ -46,7 +51,10 @@ int main(int argc, char **argv)
 			break;
 		if (max_count != -1 && !max_count--)
 			break;
-		printf("%s\n", sha1_to_hex(commit->object.sha1));
+		sha1hex = sha1_to_hex(commit->object.sha1);
+		if (to_sha1 != NULL && strcmp(to_sha1, sha1hex) == 0)
+			break;
+		printf("%s\n", sha1hex);
 	} while (list);
 	return 0;
 }


