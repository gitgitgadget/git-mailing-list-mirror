From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] detect close failure on just-written file handles
Date: Sun, 24 Jun 2007 21:20:41 +0200
Message-ID: <873b0hyx9y.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 21:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Xdc-0001Vd-Vu
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 21:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbXFXTUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 15:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbXFXTUn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 15:20:43 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:49579 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbXFXTUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 15:20:42 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CA5995A0AF
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 21:20:41 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id AC5E126108; Sun, 24 Jun 2007 21:20:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50813>

I audited git for potential undetected write failures.
In the cases fixed below, the diagnostics I add mimic the diagnostics
used in surrounding code, even when that means not reporting
the precise strerror(errno) cause of the error.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-init-db.c |    3 ++-
 builtin-rerere.c  |    3 ++-
 index-pack.c      |    3 ++-
 refs.c            |    6 ++----
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 0be2d2e..976f47b 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -40,7 +40,8 @@ static int copy_file(const char *dst, const char *src, int mode)
 		return fdo;
 	}
 	status = copy_fd(fdi, fdo);
-	close(fdo);
+	if (close(fdo) != 0)
+		return error("%s: write error: %s", dst, strerror(errno));

 	if (!status && adjust_shared_perm(dst))
 		return -1;
diff --git a/builtin-rerere.c b/builtin-rerere.c
index f6409b9..29fb075 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -57,7 +57,8 @@ static int write_rr(struct path_list *rr, int out_fd)
 		    write_in_full(out_fd, path, length) != length)
 			die("unable to write rerere record");
 	}
-	close(out_fd);
+	if (close(out_fd) != 0)
+		die("unable to write rerere record");
 	return commit_lock_file(&write_lock);
 }

diff --git a/index-pack.c b/index-pack.c
index 82c8da3..8403c36 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -634,7 +634,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
 				write_or_die(keep_fd, "\n", 1);
 			}
-			close(keep_fd);
+			if (close(keep_fd) != 0)
+				die("cannot write keep file");
 			report = "keep";
 		}
 	}
diff --git a/refs.c b/refs.c
index 67ac97c..4dc7e8b 100644
--- a/refs.c
+++ b/refs.c
@@ -1106,8 +1106,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 		len += sprintf(logrec + len - 1, "\t%.*s\n", msglen, msg) - 1;
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
-	close(logfd);
-	if (written != len)
+	if (close(logfd) != 0 || written != len)
 		return error("Unable to append to %s", log_file);
 	return 0;
 }
@@ -1204,8 +1203,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 		goto error_free_return;
 	}
 	written = write_in_full(fd, ref, len);
-	close(fd);
-	if (written != len) {
+	if (close(fd) != 0 || written != len) {
 		error("Unable to write to %s", lockpath);
 		goto error_unlink_return;
 	}
