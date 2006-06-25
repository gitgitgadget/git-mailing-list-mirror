From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 6/7] Git.pm: Introduce fast get_object() method
Date: Sun, 25 Jun 2006 03:54:32 +0200
Message-ID: <20060625015432.29906.31058.stgit@machine.or.cz>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJpf-0006BB-LR
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWFYByf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWFYByf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2218 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751352AbWFYBye (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:54:34 -0400
Received: (qmail 29991 invoked from network); 25 Jun 2006 03:54:32 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:54:32 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060625015421.29906.50002.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22576>

Direct .xs routine. Note that it does not work 100% correctly when
you juggle multiple repository objects, but it is not that bad either.
The trouble is that we might reuse packs information for another
Git project; that is not an issue since Git depends on uniqueness
of SHA1 ids so if we have found the object somewhere else, it is
nevertheless going to be the same object. It merely makes object
existence detection through this method unreliable; it is duly noted
in the documentation.

At least that's how I see it, I hope I didn't overlook any other
potential problem. I tested it for memory leaks and it appears to be
doing ok.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   17 +++++++++++++++++
 perl/Git.xs |   24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index c490e0c..cdae1fe 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -571,6 +571,23 @@ sub ident_person {
 }
 
 
+=item get_object ( TYPE, SHA1 )
+
+Return contents of the given object in a scalar string. If the object has
+not been found, undef is returned; however, do not rely on this! Currently,
+if you use multiple repositories at once, get_object() on one repository
+_might_ return the object even though it exists only in another repository.
+(But do not rely on this behaviour either.)
+
+The method must be called on a repository instance.
+
+Implementation of this method is very fast; no external command calls
+are involved. That's why it is broken, too. ;-)
+
+=cut
+
+# Implemented in Git.xs.
+
 
 =item hash_object ( TYPE, FILENAME )
 
diff --git a/perl/Git.xs b/perl/Git.xs
index 4e85d69..e841e4a 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -118,6 +118,30 @@ CODE:
 	free((char **) argv);
 }
 
+
+SV *
+xs_get_object(type, id)
+	char *type;
+	char *id;
+CODE:
+{
+	unsigned char sha1[20];
+	unsigned long size;
+	void *buf;
+
+	if (strlen(id) != 40 || get_sha1_hex(id, sha1) < 0)
+		XSRETURN_UNDEF;
+
+	buf = read_sha1_file(sha1, type, &size);
+	if (!buf)
+		XSRETURN_UNDEF;
+	RETVAL = newSVpvn(buf, size);
+	free(buf);
+}
+OUTPUT:
+	RETVAL
+
+
 char *
 xs_hash_object(type, file)
 	char *type;
