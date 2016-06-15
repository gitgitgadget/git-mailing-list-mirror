From: Rutger Nijlunsing <rutger@nospam.com>
Subject: [PATCH] Add Documentation/howto/setup-git-server-over-http.txt
Date: Thu, 10 Aug 2006 22:00:26 +0200
Organization: M38c
Message-ID: <20060810200026.GA20120@nospam.com>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 10 22:02:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBGj5-0006eU-71
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 22:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWHJUBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 16:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWHJUBD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 16:01:03 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:58062 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S932105AbWHJUAg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 16:00:36 -0400
Received: from wingding.demon.nl ([82.161.27.36]:56385)
	by post-25.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GBGhk-0003ER-6h
	for git@vger.kernel.org; Thu, 10 Aug 2006 20:00:32 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GBGhe-0006oJ-NZ
	for git@vger.kernel.org; Thu, 10 Aug 2006 22:00:26 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25207>

A small howto on how to setup GIT over HTTP transport protocol by
setting up WebDAV access on apache2.

Signed-off-by: Rutger Nijlunsing <git@tux.tmfweb.nl>
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---
 Documentation/howto/setup-git-server-over-http.txt |  255 ++++++++++++++++++++
 1 files changed, 255 insertions(+), 0 deletions(-)

diff --git a/Documentation/howto/setup-git-server-over-http.txt b/Documentation/howto/setup-git-server-over-http.txt
new file mode 100644
index 0000000..7279674
--- /dev/null
+++ b/Documentation/howto/setup-git-server-over-http.txt
@@ -0,0 +1,255 @@
+HOWTO: Setting up a git repository which can be pushed into and pulled
+from over HTTP.
+
+Since Apache is one of those packages people like to compile
+themselves while others prefer the bureaucrat's dream Debian, it is
+impossible to give guideliness which will work for everyone. Just send
+some feedback to the mailinglist at git@vger.kernel.org to get this
+document tailored to your favorit distro.
+
+
+What's needed:
+
+- Have an Apache webserver
+
+  On Debian:
+    $ apt-get install apache2
+    To get apache2 by default started,
+    edit /etc/default/apache2 and set NO_START=0
+
+- can edit the configuration of it.
+
+  This could be found under /etc/httpd, or refer to your Apache documentation.
+
+  On Debian: this means being able to edit files under /etc/apache2
+
+- can restart it.
+
+  'apachectl --graceful' might do. If it doesn't, just stop and
+  restart apache. Be warning that active connections to your server
+  might be aborted by this.
+
+  On Debian:
+    $ /etc/init.d/apache2 restart
+  or
+    $ /etc/init.d/apache2 force-reload
+    (which seems to do the same)
+  This adds symlinks from the /etc/apache2/mods-enabled to
+  /etc/apache2/mods-available.
+
+- have permissions to chown a directory
+
+- have git installed at the server _and_ client
+
+In effect, this probably means you're going to be root.
+
+
+Step 1: setup a bare GIT repository
+-----------------------------------
+
+At the time of writing, git-http-push cannot remotely create a GIT
+repository. So we have to do that at the server side with git. Another
+option would be to generate an empty repository at the client and copy
+it to the server with WebDAV. But then you're probably the first to
+try that out :)
+
+Create the directory under the DocumentRoot of the direcories served
+by Apache. As an example we take /usr/local/apache2, but try "grep
+DocumentRoot /where/ever/httpd.conf" to find your root:
+
+    $ cd /usr/local/apache/htdocs
+    $ mkdir my-new-repo.git
+
+  On Debian:
+
+    $ cd /var/www
+    $ mkdir my-new-repo.git
+
+
+Initialize a bare repository
+ 
+    $ cd my-new-repo.git
+    $ git --bare init-db
+
+
+Change the ownership to your webserver's credentials. Use "grep ^User
+httpd.conf" and "grep ^Group httpd.conf" to find out:
+ 
+    $ chown -R www.www .
+
+  On Debian:
+
+    $ chown -R www-data.www-data .
+
+
+If you do not know which user Apache runs as, you can alternatively do
+a "chmod -R a+w .", inspect the files which are created later on, and
+set the permissions appropriately.
+
+Restart apache2, and check whether http://server/my-new-repo.git gives
+a directory listing. If not, check whether apache started up
+succesfully.
+
+
+Step 2: enable DAV on this repository
+-------------------------------------
+
+First make sure the dav module is loaded. For this, insert in httpd.conf:
+
+    LoadModule dav_module libexec/httpd/libdav.so
+    AddModule mod_dav.c
+
+Also make sure that this line exists which is the file used for
+locking DAV operations:
+
+  DAVLockDB "/usr/local/apache2/temp/DAV.lock"
+
+  On Debian these steps can be performed with:
+
+    Enable the dav and dav_fs modules of apache:
+    $ a2enmod dav_fs
+    (just to be sure. dav_fs might be unneeded, I don't know)
+    $ a2enmod dav
+    The DAV lock is located in /etc/apache2/mods-available/dav_fs.conf:
+      DAVLockDB /var/lock/apache2/DAVLock
+
+Of course, it can point somewhere else, but the string is actually just a 
+prefix in some Apache configurations, and therefore the _directory_ has to 
+be writable by the user Apache runs as.
+
+Then, add something like this to your httpd.conf
+
+  <Location /my-new-repo.git>
+     DAV on
+     AuthType Basic
+     AuthName "Git"
+     AuthUserFile /usr/local/apache2/conf/passwd.git
+     Require valid-user
+  </Location>
+
+  On Debian:
+    Create (or add to) /etc/apache2/conf.d/git.conf :
+
+    <Location /my-new-repo.git>
+       DAV on
+       AuthType Basic
+       AuthName "Git"
+       AuthUserFile /etc/apache2/passwd.git
+       Require valid-user
+    </Location>
+
+    Debian automatically reads all files under /etc/apach2/conf.d.
+
+The password file can be somewhere else, but it has to be readable by
+Apache and preferably not readable by the world.
+
+Create this file by
+    $ htpasswd -c /usr/local/apache2/conf/passwd.git <user>
+
+    On Debian:
+      $ htpasswd -c /etc/apache2/passwd.git <user>
+
+You will be asked a password, and the file is created. Subsequent calls
+to htpasswd should omit the '-c' option, since you want to append to the
+existing file.
+
+You need to restart Apache.
+
+Now go to http://<username>@<servername>/my-new-repo.git in your
+browser to check whether it asks for a password and accepts the right
+password.
+
+On Debian:
+
+   To test the WebDAV part, do:
+
+   $ apt-get install litmus
+   $ litmus http://<servername>/my-new-repo.git <username> <password>
+
+   Mosts tests should pass.
+
+A command line tool to test WebDAV is cadaver.
+
+If you're into Windows, from XP onwards Internet Explorer supports
+WebDAV. For this, do Internet Explorer -> Open Location ->
+http://<servername>/my-new-repo.git [x] Open as webfolder -> login .
+
+
+Step 3: setup the client
+------------------------
+ 
+Make sure that you have HTTP support, i.e. your git was built with curl.
+The easiest way to check is to look for the executable 'git-http-push'.
+
+Then, add the following to your $HOME/.netrc (you can do without, but will be
+asked to input your password a _lot_ of times):
+
+    machine <servername>
+    login <username>
+    password <password>
+
+...and set permissions:
+     chmod 600 ~/.netrc
+
+If you want to access the webserver by its IP, you have to type that in,
+instead of the server name.
+
+To check whether all is OK, do:
+
+   curl --netrc --location -v http://<username>@<servername>/my-new-repo.git/
+
+...this should give a directory listing in HTML of /var/www/my-new-repo.git .
+
+
+Now, add the remote in your existing repository which contains the project
+you want to export:
+ 
+   $ git-repo-config remote.upload.url \
+       http://<username>@<servername>/my-new-repo.git/
+
+It is important to put the last '/'; Without it, the server will send
+a redirect which git-http-push does not (yet) understand, and git-http-push
+will repeat the request inifinitely.
+
+
+Step 4: make the initial push
+-----------------------------
+
+From your client repository, do
+
+   $ git push upload master
+
+This pushes branch 'master' (which is assumed to be the branch you
+want to export) to repository called 'upload', which we previously
+defined with git-repo-config.
+
+
+Troubleshooting:
+----------------
+
+If git-http-push says
+
+   Error: no DAV locking support on remote repo http://...
+
+then it means the webserver did not accept your authentication. Make sure
+that the user name and password matches in httpd.conf, .netrc and the URL
+you are uploading to.
+
+If git-http-push shows you an error (22/502) when trying to MOVE a blob,
+it means that your webserver somehow does not recognize its name in the
+request; This can happen when you start Apache, but then disable the
+network interface. A simple restart of Apache helps.
+
+Errors like (22/502) are of format (curl error code/http error
+code). So (22/404) means something like 'not found' at the server.
+
+Reading /usr/local/apache2/logs/error_log is often helpful.
+
+  On Debian: Read /var/log/apache2/error.log instead.
+
+
+Debian References: http://www.debian-administration.org/articles/285
+
+Authors
+  Johannes Schindelin <Johannes.Schindelin@gmx.de>
+  Rutger Nijlunsing <git@wingding.demon.nl>
-- 
1.4.2.rc2.g7cb1

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
