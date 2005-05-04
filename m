From: Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH] control/limit output of git-rev-list
Date: Wed, 4 May 2005 13:58:14 +0200
Message-ID: <20050504115814.GA18946@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 04 13:52:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTIQ7-0003t8-Og
	for gcvg-git@gmane.org; Wed, 04 May 2005 13:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVEDL6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 07:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEDL6Z
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 07:58:25 -0400
Received: from soundwarez.org ([217.160.171.123]:4234 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261673AbVEDL6R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 07:58:17 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 0308E2CC57; Wed,  4 May 2005 13:58:14 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

gitweb.cgi's default view is the log of the last day and git-rev-list
can stop crawling the whole repo if we have all our data to display in the
browser. Also the rss-feed query needs only the last 20 items. This
will speeds up these queries dramatically.

  usage: rev-list [OPTION] commit-id
    --max-count=nr
    --max-age=epoch
    --min-age=epoch

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

Pasky, kernel.org uses the cogito binaries. It would be nice, if you can
include this into the next release, so we can safe these boxes a whole lot
of useless work.

Thanks,
Kay

--- a/rev-list.c
+++ b/rev-list.c
@@ -6,9 +6,31 @@ int main(int argc, char **argv)
 	unsigned char sha1[20];
 	struct commit_list *list = NULL;
 	struct commit *commit;
+	char *commit_arg = NULL;
+	int i;
+	unsigned long max_age = -1;
+	unsigned long min_age = -1;
+	int max_count = -1;
 
-	if (argc != 2 || get_sha1(argv[1], sha1))
-		usage("rev-list <commit-id>");
+	for (i = 1 ; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (!strncmp(arg, "--max-count=", 12)) {
+			max_count = atoi(arg + 12);
+		} else if (!strncmp(arg, "--max-age=", 10)) {
+			max_age = atoi(arg + 10);
+		} else if (!strncmp(arg, "--min-age=", 10)) {
+			min_age = atoi(arg + 10);
+		} else {
+			commit_arg = arg;
+		}
+	}
+
+	if (!commit_arg || get_sha1(commit_arg, sha1))
+		usage("usage: rev-list [OPTION] commit-id\n"
+		      "  --max-count=nr\n"
+		      "  --max-age=epoch\n"
+		      "  --min-age=epoch\n");
 
 	commit = lookup_commit(sha1);
 	if (!commit || parse_commit(commit) < 0)
@@ -17,6 +39,13 @@ int main(int argc, char **argv)
 	commit_list_insert(commit, &list);
 	do {
 		struct commit *commit = pop_most_recent_commit(&list, 0x1);
+
+		if (min_age != -1 && (commit->date > min_age))
+			continue;
+		if (max_age != -1 && (commit->date < max_age))
+			break;
+		if (max_count != -1 && !max_count--)
+			break;
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
 	} while (list);
 	return 0;

