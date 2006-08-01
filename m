From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Tue, 1 Aug 2006 21:34:08 +0200
Message-ID: <20060801193408.GF16364@admingilde.org>
References: <20060730223754.GA16364@admingilde.org> <7vzmeqa7tx.fsf@assigned-by-dhcp.cox.net> <20060731070819.GD16364@admingilde.org> <eakc16$p77$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 21:34:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G800Z-0006xL-Vi
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 21:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWHATeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWHATeM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 15:34:12 -0400
Received: from admingilde.org ([213.95.32.146]:57235 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751847AbWHATeK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 15:34:10 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G800G-0005lC-L3; Tue, 01 Aug 2006 21:34:08 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eakc16$p77$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24610>

hoi :)

On Mon, Jul 31, 2006 at 09:38:26AM +0200, Jakub Narebski wrote:
> There are currently two version variables in gitweb: the version of the
> script, and the version of git binaries used. They might be different.
> But now that gitweb is bundled with git, perhaps we could use compile-time
> git version as gitweb version

updated patch below:

+++
Generate gitweb/gitweb.cgi to reduce the need to patch gitweb.cgi by
the end user.
The GIT installation directory is already known by the Makefile, and can be
inserted directly into gitweb.
All other gitweb configuration parameters can now be specified by providing
GITWEB_* variables while building GIT.  These are described in gitweb/README.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 Makefile                         |   25 +++++++++++++++++++++++--
 gitweb/.gitignore                |    1 +
 gitweb/README                    |   17 +++++++++++++++++
 gitweb/{gitweb.cgi => gitweb.pl} |   15 +++++++--------
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 15864e2..0d66c6a 100644
--- a/Makefile
+++ b/Makefile
@@ -116,6 +116,13 @@ template_dir = $(prefix)/share/git-core/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
 
+# default configuration for gitweb
+GITWEB_SITENAME = 
+GITWEB_PROJECTROOT = /pub/git
+GITWEB_LIST = 
+GITWEB_HOMETEXT = indextext.html
+GITWEB_CSS = gitweb.css
+
 export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
 
 CC = gcc
@@ -514,7 +521,7 @@ LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk
+all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk gitweb/gitweb.cgi
 
 all:
 	$(MAKE) -C templates
@@ -572,6 +579,20 @@ git-status: git-commit
 	cp $< $@+
 	mv $@+ $@
 
+gitweb/gitweb.cgi: gitweb/gitweb.pl
+	rm -f $@ $@+
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e 's|@@GIT_VERSION@@|$(GIT_VERSION)|g' \
+	    -e 's|@@GIT_BINDIR@@|$(bindir)|g' \
+	    -e 's|@@GITWEB_SITENAME@@|$(GITWEB_SITENAME)|g' \
+	    -e 's|@@GITWEB_PROJECTROOT@@|$(GITWEB_PROJECTROOT)|g' \
+	    -e 's|@@GITWEB_LIST@@|$(GITWEB_LIST)|g' \
+	    -e 's|@@GITWEB_HOMETEXT@@|$(GITWEB_HOMETEXT)|g' \
+	    -e 's|@@GITWEB_CSS@@|$(GITWEB_CSS)|g' \
+	    $< >$@+
+	chmod +x $@+
+	mv $@+ $@
+
 git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	rm -f $@ $@+
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -582,7 +603,7 @@ git-instaweb: git-instaweb.sh gitweb/git
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
-	    $@.sh | sed "s|/usr/bin/git|$(bindir)/git|" > $@+
+	    $@.sh > $@+
 	chmod +x $@+
 	mv $@+ $@
 
diff --git a/gitweb/.gitignore b/gitweb/.gitignore
new file mode 100644
index 0000000..e83127e
--- /dev/null
+++ b/gitweb/.gitignore
@@ -0,0 +1 @@
+gitweb.cgi
diff --git a/gitweb/README b/gitweb/README
index 8d67276..ed939e2 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -5,5 +5,22 @@ The one working on:
 
 From the git version 1.4.0 gitweb is bundled with git.
 
+
+How to configure gitweb for your local system:
+
+You can specify the following configuration variables when building GIT:
+ * GITWEB_SITENAME
+   Shown in the title of all generated pages, defaults to the servers name.
+ * GITWEB_PROJECTROOT
+   The root directory for all projects shown by gitweb.
+ * GITWEB_LIST
+   points to a directory to scan for projects (defaults to project root)
+   or to a file for explicit listing of projects.
+ * GITWEB_HOMETEXT
+   points to an .html file which is included on the gitweb project
+   overview page.
+ * GITWEB_CSS
+   Points to the location where you put gitweb.css on your web server.
+
 Any comment/question/concern to:
   Kay Sievers <kay.sievers@vrfy.org>
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.pl
similarity index 100%
rename from gitweb/gitweb.cgi
rename to gitweb/gitweb.pl
index e5fca63..20dd901 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.pl
@@ -17,18 +17,18 @@ use Fcntl ':mode';
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
-our $version = "267";
+our $version = "@@GIT_VERSION@@";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 our $rss_link = "";
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
-our $GIT = "/usr/bin/git";
+our $GIT = "@@GIT_BINDIR@@/git";
 
 # absolute fs-path which will be prepended to the project path
 #our $projectroot = "/pub/scm";
-our $projectroot = "/home/kay/public_html/pub/scm";
+our $projectroot = "@@GITWEB_PROJECTROOT@@";
 
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
@@ -44,17 +44,16 @@ our $home_link = $my_uri;
 
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
-our $site_name = $ENV{'SERVER_NAME'} || "Untitled";
+our $site_name = "@@GITWEB_SITENAME@@" || $ENV{'SERVER_NAME'} || "Untitled";
 
 # html text to include at home page
-our $home_text = "indextext.html";
+our $home_text = "@@GITWEB_HOMETEXT@@";
 
 # URI of default stylesheet
-our $stylesheet = "gitweb.css";
+our $stylesheet = "@@GITWEB_CSS@@";
 
 # source of projects list
-#our $projects_list = $projectroot;
-our $projects_list = "index/index.aux";
+our $projects_list = "@@GITWEB_LIST@@" || "$projectroot";
 
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
-- 
1.4.2.rc2.gf055

-- 
Martin Waitz
