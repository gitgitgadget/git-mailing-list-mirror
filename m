From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: HOWTO set up a repository which can be pushed into over HTTP
Date: Tue, 8 Aug 2006 21:02:20 +0200
Organization: M38c
Message-ID: <20060808190220.GA6001@nospam.com>
References: <Pine.LNX.4.63.0608042021300.1800@wbgn013.biozentrum.uni-wuerzburg.de> <7vac6kjoxh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0608050044000.1800@wbgn013.biozentrum.uni-wuerzburg.de> <7vd5bd6ku8.fsf@assigned-by-dhcp.cox.net>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 21:02:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAWqg-00006J-TP
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 21:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWHHTCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 15:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWHHTCX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 15:02:23 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:3287 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S964983AbWHHTCW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 15:02:22 -0400
Received: from wingding.demon.nl ([82.161.27.36]:46531)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1GAWqK-000Iqb-WC; Tue, 08 Aug 2006 19:02:21 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.62)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1GAWqK-0003pE-6g; Tue, 08 Aug 2006 21:02:20 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5bd6ku8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25082>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2006 at 12:55:43AM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Do people find it useful? Or would you like to wait until I implement an 
> > option in git-http-push to actually init an HTTP repo remotely?
> 
> I do not have need for push over http-dav at the moment myself,
> but I would imagine I would certainly look for it when I would
> need to later.
> 
> Do people find it useful?  More importantly, has somebody else
> independently tried to follow the documentation and found the
> description accurate and helpful?

Today I did try to follow it, and it made an otherwise impossible job
for me doable, although still taking too much hours and a patch. The
'impossible job' for me had to do with my zero-apache experience and
(probably) a bug in WebDAV.

Find attached updated HOWTO with specific information for Debian
users, and a patch to git to git-http-push since initially WebDAV gave
me MOVE 22/404 errors.

--
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=howto

HOWTO: Setting up a git repository which can be pushed into and pulled
from over HTTP.

What's needed:

- Have an Apache webserver

  On Debian:
    $ apt-get install apache2
    To get apache2 by default started,
    edit /etc/default/apache2 and set NO_START=0

- can edit the configuration of it

  On Debian: this means being able to edit files under /etc/apache2

- can restart it.
  'apachectl --graceful' might do.

  On Debian:
    $ /etc/init.d/apache2 restart

- have permissions to chown a directory

In effect, this probably means you're going to be root.


Step 1: setup a bare GIT repository
-----------------------------------

Create the directory (this assumes you have your Apache installed in
/usr/local/apache2):

    $ cd /usr/local/apache/htdocs
    $ mkdir my-new-repo.git

  On Debian:

    $ cd /var/www
    $ mkdir my-new-repo.git


Initialize a bare repository
 
    $ cd my-new-repo.git
    $ git --bare init-db


Change the ownership to your webserver's credentials
 
    $ chown -R www.www .

  On Debian:

    $ chown -R www-data.www-data .


If you do not know which user Apache runs as, you can alternatively do
a "chmod -R a+w .", inspect the files which are created later on, and
set the permissions appropriately.

Restart apache2, and check whether http://server/my-new-repo.git gives
a directory listing. If not, check whether apache started up
succesfully.


Step 2: enable DAV on this repository
-------------------------------------

In your httpd.conf, make sure that this line exists which is the file
used for locking DAV operations:

  DAVLockDB "/usr/local/apache2/temp/DAV.lock"

  On Debian:

    Enable the dav and dav_fs modules of apache:
    $ a2enmod dav_fs
    $ a2enmod dav
    The DAV lock is located in /etc/apache2/mods-available/dav_fs.conf:
      DAVLockDB /var/lock/apache2/DAVLock

Of course, it can point somewhere else, but the string is actually just a 
prefix in some Apache configurations, and therefore the _directory_ has to 
be writable by the user Apache runs as.

Then, add something like this to your httpd.conf

  <Location /my-new-repo.git>
     DAV on
     AuthType Basic
     AuthName "Git"
     AuthUserFile /usr/local/apache2/conf/passwd.git
     Require valid-user
  </Location>

  On Debian:
    Create (or add to) /etc/apache2/conf.d/git.conf :

    <Location /my-new-repo.git>
       DAV on
       AuthType Basic
       AuthName "Git"
       AuthUserFile /etc/apache2/passwd.git
       Require valid-user
    </Location>

The password file can be somewhere else, but it has to be readable by
Apache and preferably not readable by the world.

Create this file by
    $ htpasswd -c /usr/local/apache2/conf/passwd.git <user>

    On Debian:
      $ htpasswd -c /etc/apache2/passwd.git <user>

You will be asked a password, and the file is created. Subsequent calls
to htpasswd should omit the '-c' option, since you want to append to the
existing file.

You need to restart Apache.

Now go to http://<username>@<servername>/my-new-repo.git in your
browser to check whether it asks for a password and accepts the right
password.

On Debian:

   To test the WebDAV part, do:

   $ apt-get install litmus
   $ litmus http://<servername>/my-new-repo.git <username> <password>

   Mosts tests should pass.


Step 3: setup the client
------------------------
 
Make sure that you have HTTP support, i.e. your git was built with curl.
The easiest way to check is to look for the executable 'git-http-push'.

Then, add the following to your ~/.netrc (you can do without, but will be
asked to input your password a _lot_ of times):

    machine <servername>
    login <username>
    password <password>

...and set permissions:
     chmod 600 ~/.netrc

    On Windows, use %HOMEDRIVE%%HOMEPATH%.netrc instead.

If you want to access the webserver by its IP, you have to type that in,
instead of the server name.

To check whether all is OK, do:

   curl --netrc --location -v http://<username>@<servername>/my-new-repo.git/

...this should give a directory listing in HTML of /var/www/my-new-repo.git .


Now, add the remote in your existing repository which contains the project
you want to export:
 
   $ git-repo-config remote.upload.url \
       http://<username>@<servername>/my-new-repo.git/

It is important to put the last '/'; Without it, the server will send
a redirect which git-http-push does not (yet) understand, and git-http-push
will repeat the request inifinitely.


Step 4: make the initial push
-----------------------------

>From your client repository, do

   $ git push upload master

This pushes branch 'master' (which is assumed to be the branch you
want to export) to repository called 'upload', which we previously
defined with git-repo-config.


Troubleshooting:
----------------

If git-http-push says

   Error: no DAV locking support on remote repo http://...

then it means the webserver did not accept your authentication. Make sure
that the user name and password matches in httpd.conf, .netrc and the URL
you are uploading to.

If git-http-push shows you an error (22/502) when trying to MOVE a blob,
it means that your webserver somehow does not recognize its name in the
request; This can happen when you start Apache, but then disable the
network interface. A simple restart of Apache helps.

Errors like (22/502) are of format (curl error code/http error
code). So (22/404) means something like 'not found' at the server.

Reading /usr/local/apache2/logs/error_log is often helpful.
On Debian: Read /var/log/apache2/error.log instead.


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=commit-bd1ba73

commit bd1ba734176277034c6e4b33eb68fde170286538
Author: Rutger Nijlunsing <git@tux.tmfweb.nl>
Date:   Tue Aug 8 14:17:38 2006 +0200

    http-push: Use '_token' instead of '.token' as temporary file before renaming.
    
    WebDAV on Debian unstable cannot handle renames on WebDAV from
    file.ext to newfile (without ext) when newfile* already
    exists. Normally, git creates a file like 'objects/xx/sha1.token',
    which is renamed to 'objects/xx/sha1' when transferred completely.
    
    Just use '_' instead of '.' so WebDAV doesn't see it as an extension
    change.

diff --git a/http-push.c b/http-push.c
index 4021e7d..d45733e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -530,7 +530,7 @@ static void start_put(struct transfer_re
 	request->dest = xmalloc(strlen(request->url) + 14);
 	sprintf(request->dest, "Destination: %s", request->url);
 	posn += 38;
-	*(posn++) = '.';
+	*(posn++) = '_';
 	strcpy(posn, request->lock->token);
 
 	slot = get_active_slot();

--UugvWAfsgieZRqgk--
