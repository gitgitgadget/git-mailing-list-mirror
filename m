From: Andreas Gal <gal@uci.edu>
Subject: [PATCH] New option (-H) for rpush/rpull to update HEAD
Date: Sun, 24 Apr 2005 21:39:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504242132280.5064@sam.ics.uci.edu>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>      
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>      
 <426A4669.7080500@ppp0.net>       <1114266083.3419.40.camel@localhost.localdomain>
       <426A5BFC.1020507@ppp0.net>       <1114266907.3419.43.camel@localhost.localdomain>
       <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>      
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>      
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org>
 <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <426C5F43.8010705@dwheeler.com>
 <Pine.LNX.4.62.0504250413200.14200@sheen.jakma.org>
 <Pine.LNX.4.62.0504250435050.14200@sheen.jakma.org>
 <Pine.LNX.4.62.0504250443380.14200@sheen.j
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Apr 25 06:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPvIb-0002Fh-5w
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 06:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVDYEjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 00:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDYEjJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 00:39:09 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:14253 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262531AbVDYEjD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 00:39:03 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3P4d22h005078
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 21:39:02 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3P4d2Of005074
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 21:39:02 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504250443380.14200@sheen.jakma.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch adds a new option -H to rpush/rpull to update the
HEAD pointer when pushing a new release to a remote repository. 

Signed-off-by: Andreas Gal <gal@uci.edu>

--- c27af2c2464de28732b8ad1fff3ed8a0804250d6/rpull.c
+++ rpull.c
@@ -11,6 +11,7 @@
 static int tree = 0;
 static int commits = 0;
 static int all = 0;
+static int update_head = 0;
 
 static int fd_in;
 static int fd_out;
@@ -104,11 +105,13 @@
 			all = 1;
 			tree = 1;
 			commits = 1;
+		} else if (argv[arg][1] == 'H') {
+			update_head = 1;
 		}
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("rpull [-c] [-t] [-a] commit-id url");
+		usage("rpull [-c] [-t] [-a] [-H] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
@@ -123,6 +126,11 @@
 		return 1;
 	if (process_commit(sha1))
 		return 1;
+	if (update_head) {
+		FILE* fp = fopen("HEAD", "w+");
+		fprintf(fp, "%s\n", commit_id);
+		fclose(fp);
+	}
 
 	return 0;
 }
--- 0293a1a46311d7e20b13177143741ab9d6d0d201/rpush.c
+++ rpush.c
@@ -56,7 +56,7 @@
                 arg++;
         }
         if (argc < arg + 2) {
-                usage("rpush [-c] [-t] [-a] commit-id url");
+                usage("rpush [-c] [-t] [-a] [-H] commit-id url");
                 return 1;
         }
 	commit_id = argv[arg];
