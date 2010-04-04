From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] Replace hard-coded path with one configurable at make time
Date: Sun, 4 Apr 2010 21:48:50 +0100
Message-ID: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 22:50:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyWmJ-0005m8-F3
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 22:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab0DDUui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 16:50:38 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:51202 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab0DDUuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 16:50:37 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NyWmB-0007We-Qt; Sun, 04 Apr 2010 21:50:36 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143947>

In exec_cmd.c and git-instaweb.sh, git hard-codes a default path of
/usr/local/bin:/usr/bin:/bin. Introduce a make variable allowing this to be
overridden by passing defpath to make.
---
I haven't worked out the capitalisation convention in the makefile, so I'm
not sure if this should be DEFPATH or defpath. (For example, prefix is
lower-case but DESTDIR is all-caps.)

 Makefile        |    6 +++++-
 exec_cmd.c      |    2 +-
 git-instaweb.sh |    4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 11ec3e2..2f4b39e 100644
--- a/Makefile
+++ b/Makefile
@@ -278,6 +278,7 @@ endif
 lib = lib
 # DESTDIR=
 pathsep = :
+defpath = /usr/local/bin:/usr/bin:/bin
 
 # JavaScript minifier invocation that can function as filter
 JSMIN =
@@ -1426,6 +1427,7 @@ gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_SQ = $(subst ','\'',$(htmldir))
 prefix_SQ = $(subst ','\'',$(prefix))
+defpath_SQ = $(subst ','\'',$(defpath))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -1588,6 +1590,7 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
 	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
 	    -e '/@@GITWEB_JS@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
+	    -e 's|@@DEFPATH@@|$(defpath_SQ)|g' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -1774,7 +1777,8 @@ endif
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
-	'-DPREFIX="$(prefix_SQ)"'
+	'-DPREFIX="$(prefix_SQ)"' \
+	'-DDEFPATH="$(defpath_SQ)"'
 
 builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
diff --git a/exec_cmd.c b/exec_cmd.c
index b2c07c7..39c6a59 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -107,7 +107,7 @@ void setup_path(void)
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
 	else
-		strbuf_addstr(&new_path, "/usr/local/bin:/usr/bin:/bin");
+		strbuf_addstr(&new_path, DEFPATH);
 
 	setenv("PATH", new_path.buf, 1);
 
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6a65f25..72d8b12 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -212,7 +212,7 @@ server.errorlog = "$fqgitdir/gitweb/error.log"
 # variable above and uncomment this
 #accesslog.filename = "$fqgitdir/gitweb/access.log"
 
-setenv.add-environment = ( "PATH" => "/usr/local/bin:/usr/bin:/bin" )
+setenv.add-environment = ( "PATH" => "@@DEFPATH@@" )
 
 cgi.assign = ( ".cgi" => "" )
 
@@ -361,7 +361,7 @@ error_log	$fqgitdir/gitweb/error.log
 access_log	$fqgitdir/gitweb/access.log
 
 #cgi setup
-cgi_env		PATH=/usr/local/bin:/usr/bin:/bin,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
+cgi_env		PATH=@@DEFPATH@@,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
 cgi_interp	$PERL
 cgi_ext		cgi,pl
 
-- 
1.7.0.3
