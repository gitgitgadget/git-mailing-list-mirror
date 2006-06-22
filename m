From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Implement Git::exec_path()
Date: Fri, 23 Jun 2006 00:31:50 +0200
Message-ID: <20060622223150.21622.22126.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 00:31:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtXiO-0008P1-Ki
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 00:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWFVWby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 18:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWFVWby
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 18:31:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43936 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030422AbWFVWbx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 18:31:53 -0400
Received: (qmail 21632 invoked from network); 23 Jun 2006 00:31:50 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 23 Jun 2006 00:31:50 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22380>

This patch implements Git::exec_path() (as a direct XS call).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   20 +++++++++++++++++++-
 perl/Git.xs |   10 ++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 4bb7c50..516c065 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -47,7 +47,8 @@ require Exporter;
 @EXPORT = qw();
 
 # Methods which can be called as standalone functions as well:
-@EXPORT_OK = qw(command command_oneline command_pipe command_noisy);
+@EXPORT_OK = qw(command command_oneline command_pipe command_noisy
+                exec_path hash_object);
 
 
 =head1 DESCRIPTION
@@ -213,6 +214,7 @@ sub command {
 	}
 }
 
+
 =item command_oneline ( COMMAND [, ARGUMENTS... ] )
 
 Execute the given C<COMMAND> in the same way as command()
@@ -231,6 +233,7 @@ sub command_oneline {
 	return $line;
 }
 
+
 =item command_pipe ( COMMAND [, ARGUMENTS... ] )
 
 Execute the given C<COMMAND> in the same way as command()
@@ -253,6 +256,7 @@ sub command_pipe {
 	return $fh;
 }
 
+
 =item command_noisy ( COMMAND [, ARGUMENTS... ] )
 
 Execute the given C<COMMAND> in the same way as command() does but do not
@@ -283,6 +287,20 @@ sub command_noisy {
 	}
 }
 
+
+=item exec_path ()
+
+Return path to the git sub-command executables (the same as
+C<git --exec-path>). Useful mostly only internally.
+
+Implementation of this function is very fast; no external command calls
+are involved.
+
+=cut
+
+# Implemented in Git.xs.
+
+
 =item hash_object ( FILENAME [, TYPE ] )
 
 =item hash_object ( FILEHANDLE [, TYPE ] )
diff --git a/perl/Git.xs b/perl/Git.xs
index 33bb3ca..d1f94a4 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -6,6 +6,7 @@ #include <ctype.h>
 
 /* libgit interface */
 #include "../cache.h"
+#include "../exec_cmd.h"
 
 /* XS and Perl interface */
 #include "EXTERN.h"
@@ -19,6 +20,15 @@ MODULE = Git		PACKAGE = Git		
 
 # /* TODO: xs_call_gate(). See Git.pm. */
 
+
+const char *
+xs_exec_path()
+CODE:
+	RETVAL = git_exec_path();
+OUTPUT:
+	RETVAL
+
+
 char *
 xs_hash_object(file, type = "blob")
 	SV *file;
