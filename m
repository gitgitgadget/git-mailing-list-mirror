From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rev-{list,parse}: allow -n<n> as shorthand for --max-count=<n>
Date: Sun, 29 Jan 2006 16:26:40 -0800
Message-ID: <20060130002640.GC15482@Muzzle>
References: <20060124072946.GA9468@Muzzle> <7vd5iicauh.fsf@assigned-by-dhcp.cox.net> <20060125063325.GA7953@mail.yhbt.net> <20060129134056.GA3428@Muzzle> <7vbqxukcyo.fsf@assigned-by-dhcp.cox.net> <20060130002501.GB15482@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 01:26:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3MsX-0005jA-CJ
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 01:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWA3A0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 19:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWA3A0m
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 19:26:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35284 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751209AbWA3A0m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 19:26:42 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id C1AE72DC035;
	Sun, 29 Jan 2006 16:26:40 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sun, 29 Jan 2006 16:26:40 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060130002501.GB15482@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15253>

Both -n<n> and -n <n> are supported.  POSIX versions of head(1) and
tail(1) allow their line limits to be parsed this way.  I find
--max-count to be a commonly used option, and also similar in spirit to
head/tail, so I decided to make life easier on my worn out (and lazy :)
fingers with this patch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 rev-list.c  |   10 ++++++++++
 rev-parse.c |   15 +++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

a7f5327966f8ccdf887f3c63db3147135ff20983
diff --git a/rev-list.c b/rev-list.c
index 0b142c1..4565755 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -749,6 +749,16 @@ int main(int argc, const char **argv)
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
index d2f0864..3c99a79 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -165,6 +165,21 @@ int main(int argc, char **argv)
 			show_file(arg);
 			continue;
 		}
+		if (!strcmp(arg,"-n")) {
+			if (++i >= argc)
+				die("-n requires an argument");
+			if ((filter & DO_FLAGS) && (filter & DO_REVS)) {
+				show(arg);
+				show(argv[i]);
+			}
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
1.1.5.ga7f5-dirty
