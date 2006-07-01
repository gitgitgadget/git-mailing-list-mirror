From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Remove PerlIO usage from Git.xs
Date: Sun, 02 Jul 2006 01:38:56 +0200
Message-ID: <20060701233856.2104.3557.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 02 01:39:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwp3F-0000Oi-4j
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGAXi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGAXi6
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:38:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56526 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932116AbWGAXi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 19:38:58 -0400
Received: (qmail 2114 invoked from network); 2 Jul 2006 01:38:56 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 2 Jul 2006 01:38:56 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23080>

PerlIO_*() is not portable before 5.7.3, according to ppport.h, and it's
more clear what is going on when we do it in the Perl part of the Git module
anyway.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   14 +++++++++++++-
 perl/Git.xs |   56 +++++++++++++++++++++++++-------------------------------
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 0581447..b4ee88b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -511,7 +511,19 @@ are involved.
 
 =cut
 
-# Implemented in Git.xs.
+sub hash_object {
+	my ($self, $type, $file) = _maybe_self(@_);
+
+	# hash_object_* implemented in Git.xs.
+
+	if (ref($file) eq 'GLOB') {
+		my $hash = hash_object_pipe($type, fileno($file));
+		close $file;
+		return $hash;
+	} else {
+		hash_object_file($type, $file);
+	}
+}
 
 
 
diff --git a/perl/Git.xs b/perl/Git.xs
index 3030ba9..cb23261 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -104,42 +104,36 @@ CODE:
 }
 
 char *
-xs_hash_object(type, file)
+xs_hash_object_pipe(type, fd)
 	char *type;
-	SV *file;
+	int fd;
 CODE:
 {
 	unsigned char sha1[20];
 
-	if (SvTYPE(file) == SVt_RV)
-		file = SvRV(file);
-
-	if (SvTYPE(file) == SVt_PVGV) {
-		/* Filehandle */
-		PerlIO *pio;
-
-		pio = IoIFP(sv_2io(file));
-		if (!pio)
-			croak("You passed me something weird - a dir glob?");
-		/* XXX: I just hope PerlIO didn't read anything from it yet.
-		 * --pasky */
-		if (index_pipe(sha1, PerlIO_fileno(pio), type, 0))
-			croak("Unable to hash given filehandle");
-		/* Avoid any nasty surprises. */
-		PerlIO_close(pio);
-
-	} else {
-		/* String */
-		char *path = SvPV_nolen(file);
-		int fd = open(path, O_RDONLY);
-		struct stat st;
-
-		if (fd < 0 ||
-		    fstat(fd, &st) < 0 ||
-		    index_fd(sha1, fd, &st, 0, type))
-			croak("Unable to hash %s", path);
-		close(fd);
-	}
+	if (index_pipe(sha1, fd, type, 0))
+		croak("Unable to hash given filehandle");
+	RETVAL = sha1_to_hex(sha1);
+}
+OUTPUT:
+	RETVAL
+
+char *
+xs_hash_object_file(type, path)
+	char *type;
+	char *path;
+CODE:
+{
+	unsigned char sha1[20];
+	int fd = open(path, O_RDONLY);
+	struct stat st;
+
+	if (fd < 0 ||
+	    fstat(fd, &st) < 0 ||
+	    index_fd(sha1, fd, &st, 0, type))
+		croak("Unable to hash %s", path);
+	close(fd);
+
 	RETVAL = sha1_to_hex(sha1);
 }
 OUTPUT:
