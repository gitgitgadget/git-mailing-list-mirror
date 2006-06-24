From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 04/12] Git.pm: Implement Git::version()
Date: Sat, 24 Jun 2006 04:34:36 +0200
Message-ID: <20060624023436.32751.67240.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtxzS-0006hJ-KY
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbWFXCfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933192AbWFXCfK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61079 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933193AbWFXCfH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:07 -0400
Received: (qmail 317 invoked from network); 24 Jun 2006 04:34:36 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:36 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22470>

Git::version() returns the Git version string.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile    |    5 ++++-
 perl/Git.pm |   14 +++++++++++++-
 perl/Git.xs |   10 ++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4d20b22..7842195 100644
--- a/Makefile
+++ b/Makefile
@@ -596,7 +596,10 @@ XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare
 
 
 perl/Makefile:	perl/Git.pm perl/Makefile.PL
-	(cd perl && $(PERL_PATH) Makefile.PL PREFIX="$(prefix)" DEFINE="$(ALL_CFLAGS)" LIBS="$(LIBS)")
+	(cd perl && $(PERL_PATH) Makefile.PL \
+		PREFIX="$(prefix)" \
+		DEFINE="$(ALL_CFLAGS) -DGIT_VERSION=\\\"$(GIT_VERSION)\\\"" \
+		LIBS="$(LIBS)")
 
 doc:
 	$(MAKE) -C Documentation all
diff --git a/perl/Git.pm b/perl/Git.pm
index 212337e..dcd769b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -48,7 +48,7 @@ require Exporter;
 
 # Methods which can be called as standalone functions as well:
 @EXPORT_OK = qw(command command_oneline command_pipe command_noisy
-                exec_path hash_object);
+                version exec_path hash_object);
 
 
 =head1 DESCRIPTION
@@ -285,6 +285,18 @@ sub command_noisy {
 }
 
 
+=item version ()
+
+Return the Git version in use.
+
+Implementation of this function is very fast; no external command calls
+are involved.
+
+=cut
+
+# Implemented in Git.xs.
+
+
 =item exec_path ()
 
 Return path to the git sub-command executables (the same as
diff --git a/perl/Git.xs b/perl/Git.xs
index c8220e2..9623fdd 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -24,6 +24,16 @@ # /* TODO: xs_call_gate(). See Git.pm. *
 
 
 const char *
+xs_version()
+CODE:
+{
+	RETVAL = GIT_VERSION;
+}
+OUTPUT:
+	RETVAL
+
+
+const char *
 xs_exec_path()
 CODE:
 {
