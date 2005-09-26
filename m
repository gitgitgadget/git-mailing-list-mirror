From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add "git-update-ref" to update the HEAD (or other) ref
Date: Sun, 25 Sep 2005 18:07:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509251753460.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
 <7vhdc8n2xb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 03:08:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJhTF-0001qS-Gm
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 03:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbVIZBHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 21:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbVIZBHq
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 21:07:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751587AbVIZBHp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 21:07:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8Q17f4s026287
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Sep 2005 18:07:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8Q17boB003219;
	Sun, 25 Sep 2005 18:07:39 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdc8n2xb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9298>



On Sun, 25 Sep 2005, Junio C Hamano wrote:
> 
> Is something like the one at the end acceptable?

Looking at the patch closer, no, that's incorrect.

"oldsha" doesn't necessarily exist, since there has to be some way to 
force the new one. So if "oldval" is NULL, we shouldn't re-verify 
anything.

Also, independently of that your patch is buggy because calling
"resolve_ref()" again will overwrite the lockpath, since it's re-used by
the static buffer in git_path(). That's why the "strdup()" is there.

Yeah, yeah, static buffers are evil, but they are also simple and 
efficient. 

But something like this (on top of my original one) might work.

		Linus
----
diff --git a/update-ref.c b/update-ref.c
--- a/update-ref.c
+++ b/update-ref.c
@@ -63,6 +63,19 @@ const char *resolve_ref(const char *path
 	return path;
 }
 
+static int re_verify(const char *path, unsigned char *oldsha1, unsigned char *currsha1)
+{
+	char buf[40];
+	int fd = open(path, O_RDONLY), nr;
+	if (fd < 0)
+		return -1;
+	nr = read(fd, buf, 40);
+	close(fd);
+	if (nr != 40 || get_sha1_hex(buf, currsha1) < 0)
+		return -1;
+	return memcmp(oldsha1, currsha1, 20) ? -1 : 0;
+}
+
 int main(int argc, char **argv)
 {
 	char *hex;
@@ -108,14 +121,18 @@ int main(int argc, char **argv)
 		unlink(lockpath);
 		die("Unable to write to %s", lockpath);
 	}
-		
+
 	/*
-	 * FIXME!
-	 *
-	 * We should re-read the old ref here, and re-verify that it
-	 * matches "oldsha1". Otherwise there's a small race.
+	 * Re-read the ref after getting the lock to verify
 	 */
+	if (oldval && re_verify(path, oldsha1, currsha1) < 0) {
+		unlink(lockpath);
+		die("Ref lock failed");
+	}
 
+	/*
+	 * Finally, replace the old ref with the new one
+	 */
 	if (rename(lockpath, path) < 0) {
 		unlink(lockpath);
 		die("Unable to create %s", path);
