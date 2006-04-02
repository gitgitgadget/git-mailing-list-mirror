From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] pack-objects: be incredibly anal about stdio semantics
Date: Sun, 2 Apr 2006 13:31:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021328380.3050@g5.osdl.org>
References: <824.1144007555@lotus.CS.Berkeley.EDU> <Pine.LNX.4.64.0604021312510.3050@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 22:32:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ9Ex-0005Nh-Pm
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 22:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWDBUcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDBUcA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 16:32:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932413AbWDBUb7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 16:31:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32KVsEX019301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 13:31:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32KVsKh021876;
	Sun, 2 Apr 2006 13:31:54 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604021312510.3050@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18283>


This is the "letter of the law" version of using fgets() properly in the
face of incredibly broken stdio implementations.  We can work around the
Solaris breakage with SA_RESTART, but in case anybody else is ever that
stupid, here's the "safe" (read: "insanely anal") way to use fgets.

It probably goes without saying that I'm not terribly impressed by
Solaris libc.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is the same one that I already sent out, but re-diffed, and with a 
proper commit message.

Not tested on Solaris.

Junio - I think that I forgot to Cc: you on the 1/2 patch, but you'll see 
it on the git list.

diff --git a/pack-objects.c b/pack-objects.c
index 1817b58..0ea16ad 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1110,8 +1110,18 @@ int main(int argc, char **argv)
 		setup_progress_signal();
 	}
 
-	while (fgets(line, sizeof(line), stdin) != NULL) {
+	for (;;) {
 		unsigned char sha1[20];
+
+		if (!fgets(line, sizeof(line), stdin)) {
+			if (feof(stdin))
+				break;
+			if (!ferror(stdin))
+				die("fgets returned NULL, not EOF, not error!");
+			if (errno == EINTR)
+				continue;
+			die("fgets: %s", strerror(errno));
+		}
 
 		if (line[0] == '-') {
 			if (get_sha1_hex(line+1, sha1))
