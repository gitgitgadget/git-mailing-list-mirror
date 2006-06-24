From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 02/12] Git.pm: Implement Git::exec_path()
Date: Sat, 24 Jun 2006 04:34:31 +0200
Message-ID: <20060624023431.32751.75101.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftxz8-0006e9-Pl
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933189AbWFXCe4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933191AbWFXCe4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:34:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59799 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933189AbWFXCez (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:34:55 -0400
Received: (qmail 300 invoked from network); 24 Jun 2006 04:34:31 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:31 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22467>

This patch implements Git::exec_path() (as a direct XS call).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |   15 ++++++++++++++-
 perl/Git.xs |   12 ++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 8fff785..5c5ae12 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -48,7 +48,7 @@ require Exporter;
 
 # Methods which can be called as standalone functions as well:
 @EXPORT_OK = qw(command command_oneline command_pipe command_noisy
-                hash_object);
+                exec_path hash_object);
 
 
 =head1 DESCRIPTION
@@ -288,6 +288,19 @@ sub command_noisy {
 }
 
 
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
index 9885e2c..b6f6d13 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -6,6 +6,7 @@ #include <ctype.h>
 
 /* libgit interface */
 #include "../cache.h"
+#include "../exec_cmd.h"
 
 /* XS and Perl interface */
 #include "EXTERN.h"
@@ -21,6 +22,17 @@ PROTOTYPES: DISABLE
 
 # /* TODO: xs_call_gate(). See Git.pm. */
 
+
+const char *
+xs_exec_path()
+CODE:
+{
+	RETVAL = git_exec_path();
+}
+OUTPUT:
+	RETVAL
+
+
 char *
 xs_hash_object(file, type = "blob")
 	SV *file;
