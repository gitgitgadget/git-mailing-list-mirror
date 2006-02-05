From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix git-rev-parse over-eager errors
Date: Sun, 5 Feb 2006 11:58:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602051155460.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
 <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
 <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org> <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602051141020.3854@g5.osdl.org> <Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 20:58:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5q24-0001t3-02
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 20:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWBET6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 14:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWBET6j
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 14:58:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750705AbWBET6j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 14:58:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k15JwZDZ001573
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Feb 2006 11:58:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k15JwYOw012041;
	Sun, 5 Feb 2006 11:58:34 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15635>


Using "--verify" together with "--no-flags" makes perfect sense, but 
git-rev-parse would complain about it when it saw a flag, even though it 
would never actually use/output that flag.

This fixes it.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is independent of the "git show" patches, although the problem was 
triggered by the "git show" usage of git-rev-parse. It's a bug whether git 
show is merged or not, though.

diff --git a/rev-parse.c b/rev-parse.c
index 6bf205a..9cec33b 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -107,12 +107,15 @@ static void show_rev(int type, const uns
 }
 
 /* Output a flag, only if filter allows it. */
-static void show_flag(char *arg)
+static int show_flag(char *arg)
 {
 	if (!(filter & DO_FLAGS))
-		return;
-	if (filter & (is_rev_argument(arg) ? DO_REVS : DO_NOREV))
+		return 0;
+	if (filter & (is_rev_argument(arg) ? DO_REVS : DO_NOREV)) {
 		show(arg);
+		return 1;
+	}
+	return 0;
 }
 
 static void show_default(void)
@@ -296,9 +299,8 @@ int main(int argc, char **argv)
 				show_datestring("--min-age=", arg+8);
 				continue;
 			}
-			if (verify)
+			if (show_flag(arg) && verify)
 				die("Needed a single revision");
-			show_flag(arg);
 			continue;
 		}
 
