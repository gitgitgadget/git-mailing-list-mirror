From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] blame: avoid -lm by not using log().
Date: Sun, 05 Mar 2006 14:46:36 -0800
Message-ID: <7vhd6cechf.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060305110351.GA23448@c165.ib.student.liu.se>
	<7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
	<20060305123800.GD23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 05 23:46:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG1zt-0004Sr-ND
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 23:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWCEWqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWCEWqj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 17:46:39 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27778 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932179AbWCEWqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 17:46:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305224504.SWXP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 17:45:04 -0500
To: git@vger.kernel.org
In-Reply-To: <20060305123800.GD23448@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 5 Mar 2006 13:38:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17247>


... as suggested on the list.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile |    4 ----
 blame.c  |    6 ++++--
 2 files changed, 4 insertions(+), 6 deletions(-)

e0539773df17e5f8410850b8ffcfe8d2fa14ab7a
diff --git a/Makefile b/Makefile
index eb1887d..b6d8804 100644
--- a/Makefile
+++ b/Makefile
@@ -534,10 +534,6 @@ git-rev-list$X: rev-list.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LIBSSL)
 
-git-blame$X: blame.o $(LIB_FILE)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) -lm
-
 init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
 		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c
diff --git a/blame.c b/blame.c
index 168b1f5..59146fa 100644
--- a/blame.c
+++ b/blame.c
@@ -589,7 +589,7 @@ int main(int argc, const char **argv)
 				usage(blame_usage);
 			else if(!strcmp(argv[i], "-l") ||
 				!strcmp(argv[i], "--long")) {
-				sha1_len = 20;
+				sha1_len = 40;
 				continue;
 			} else if(!strcmp(argv[i], "-c") ||
 				  !strcmp(argv[i], "--compability")) {
@@ -651,7 +651,9 @@ int main(int argc, const char **argv)
 	process_commits(&rev, filename, &initial);
 
 	buf = blame_contents;
-	max_digits = 1 + log(num_blame_lines+1)/log(10);
+	for (max_digits = 1, i = 10; i <= num_blame_lines; max_digits++)
+		i *= 10;
+
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
 		if (!c)
-- 
1.2.4.gee5c7
