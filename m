From: Petr Baudis <pasky@suse.cz>
Subject: [RFC][PATCH] Rewriting revs in place in push target repository
Date: Sat, 13 Aug 2005 23:47:25 +0200
Message-ID: <20050813214725.GM5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 23:47:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E43qw-0000Ao-Jr
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 23:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVHMVr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVHMVr2
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 17:47:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61967 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932337AbVHMVr2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 17:47:28 -0400
Received: (qmail 31318 invoked by uid 2001); 13 Aug 2005 21:47:25 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rewrite refs in place in receive-pack & friends

When updating a ref, it would write a new file with the new ref and
then rename it, overwriting the original file. The problem is that
this destroys permissions and ownership of the original file, which is
troublesome especially in multiuser environment, like the one I live in.

This might be controversial, but it's a showbreaker for me wrt. pushing
now. Some alternative solution barely solving my particular situation
might be surely worked out, but this is more general. The question is:

* Does this break atomicity?

	I think it does not in real setups, since thanks to O_RDWR the
	file should be overwritten only when the write() happens.
	Can a 41-byte write() be non-atomic in any real conditions?

* Does this break with full disk/quota?

	I'm not sure - we are substituting 41 bytes by another 41
	bytes; will the system ever be evil enough to truncate the
	file, then decide the user is over his quota and not write
	the new contents?

Signed-off-by: Petr Baudis <pasky@suse.cz>

diff --git a/receive-pack.c b/receive-pack.c
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -92,13 +92,7 @@ static int run_update_hook(const char *r
 static int update(const char *name,
 		  unsigned char *old_sha1, unsigned char *new_sha1)
 {
-	char new_hex[60], *old_hex, *lock_name;
-	int newfd, namelen, written;
-
-	namelen = strlen(name);
-	lock_name = xmalloc(namelen + 10);
-	memcpy(lock_name, name, namelen);
-	memcpy(lock_name + namelen, ".lock", 6);
+	char new_hex[60], *old_hex;
 
 	strcpy(new_hex, sha1_to_hex(new_sha1));
 	old_hex = sha1_to_hex(old_sha1);
@@ -106,38 +100,38 @@ static int update(const char *name,
 		return error("unpack should have generated %s, "
 			     "but I can't find it!", new_hex);
 
-	safe_create_leading_directories(lock_name);
-
-	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0666);
-	if (newfd < 0)
-		return error("unable to create %s (%s)",
-			     lock_name, strerror(errno));
-
-	/* Write the ref with an ending '\n' */
-	new_hex[40] = '\n';
-	new_hex[41] = 0;
-	written = write(newfd, new_hex, 41);
-	/* Remove the '\n' again */
-	new_hex[40] = 0;
-
-	close(newfd);
-	if (written != 41) {
-		unlink(lock_name);
-		return error("unable to write %s", lock_name);
-	}
 	if (verify_old_ref(name, old_hex) < 0) {
-		unlink(lock_name);
 		return error("%s changed during push", name);
 	}
 	if (run_update_hook(name, old_hex, new_hex)) {
-		unlink(lock_name);
 		return error("hook declined to update %s\n", name);
 	}
-	else if (rename(lock_name, name) < 0) {
-		unlink(lock_name);
-		return error("unable to replace %s", name);
-	}
 	else {
+		char *name2;
+		int newfd, written;
+
+		name2 = strdup(name);
+		safe_create_leading_directories(name2);
+		free(name2);
+
+		newfd = open(name, O_CREAT | O_RDWR, 0666);
+		if (newfd < 0)
+			return error("unable to create %s (%s)",
+				     name, strerror(errno));
+
+		/* Write the ref with an ending '\n' */
+		new_hex[40] = '\n';
+		new_hex[41] = 0;
+		written = write(newfd, new_hex, 41);
+		/* Remove the '\n' again */
+		new_hex[40] = 0;
+
+		close(newfd);
+		if (written != 41) {
+			unlink(name);
+			return error("unable to write %s", name);
+		}
+
 		fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
 		return 0;
 	}
