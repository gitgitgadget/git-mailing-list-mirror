From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rev-{list,parse}: allow -n<n> as shorthand for --max-count=<n>
Date: Sun, 29 Jan 2006 05:40:56 -0800
Message-ID: <20060129134056.GA3428@Muzzle>
References: <20060124072946.GA9468@Muzzle> <7vd5iicauh.fsf@assigned-by-dhcp.cox.net> <20060125063325.GA7953@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 14:41:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Cnd-0004YF-FC
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 14:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWA2Nk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 08:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWA2Nk6
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 08:40:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:14803 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1750994AbWA2Nk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 08:40:58 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 7962B2DC033;
	Sun, 29 Jan 2006 05:40:56 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sun, 29 Jan 2006 05:40:56 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060125063325.GA7953@mail.yhbt.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15217>

Both -n<n> and -n <n> are supported.  POSIX versions of head(1) and
tail(1) allow their line limits to be parsed this way.  I find
--max-count to be a commonly used option, and also similar in spirit to
head/tail, so I decided to make life easier on my worn out (and lazy :)
fingers with this patch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 rev-list.c  |   10 ++++++++++
 rev-parse.c |   19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

a598ce380cfcf01b27be92bca92a3c451d3b41e3
diff --git a/rev-list.c b/rev-list.c
index e00e6fc..33541cc 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -732,6 +732,16 @@ int main(int argc, const char **argv)
 		struct commit *commit;
 		unsigned char sha1[20];
 
+		if (!strcmp(arg, "-n")) {
+			if (++i >= argc)
+				die("-n requires an argument");
+			max_count = atoi(argv[i]);
+			continue;
+		}
+		if (!strncmp(arg,"-n",2)) {
+			max_count = atoi(arg + 2);
+			continue;
+		}
 		if (!strncmp(arg, "--max-count=", 12)) {
 			max_count = atoi(arg + 12);
 			continue;
diff --git a/rev-parse.c b/rev-parse.c
index 7abad35..3790463 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -21,6 +21,7 @@ static char *def = NULL;
 static int show_type = NORMAL;
 static int symbolic = 0;
 static int output_sq = 0;
+static int next_arg_is_rev = 0;
 
 static int revs_count = 0;
 
@@ -162,6 +163,24 @@ int main(int argc, char **argv)
 			show_file(arg);
 			continue;
 		}
+		if (next_arg_is_rev) {
+			if ((filter & DO_FLAGS) && (filter & DO_REVS))
+				show(arg);
+			next_arg_is_rev = 0;
+			continue;
+		}
+		if (!strcmp(arg,"-n")) {
+			next_arg_is_rev = 1;
+			if ((filter & DO_FLAGS) && (filter & DO_REVS))
+				show(arg);
+			continue;
+		}
+		if (!strncmp(arg,"-n",2)) {
+			if ((filter & DO_FLAGS) && (filter & DO_REVS))
+				show(arg);
+			continue;
+		}
+
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
 				as_is = 1;
-- 
1.1.4.g3b65
