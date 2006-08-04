From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: HOWTO set up a repository which can be pushed into over HTTP
Date: Fri, 4 Aug 2006 20:38:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608042021300.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 04 20:39:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G94Ze-0000fV-JE
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 20:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWHDSjC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 14:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWHDSjB
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 14:39:01 -0400
Received: from mail.gmx.de ([213.165.64.20]:10696 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751416AbWHDSjA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 14:39:00 -0400
Received: (qmail invoked by alias); 04 Aug 2006 18:38:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 04 Aug 2006 20:38:58 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24816>

Hi,

I set up such a repository twice now, and it is not exactly 
straight-forward. So, maybe some people find this useful:

This text assumes that you

- have an Apache webserver,
- can edit the configuration of it,
- can restart it, and
- have permissions to chown a directory

Step 1: setup a bare repository
-------------------------------

Create the directory (this assumes you have your Apache installed in
/usr/local/apache2):

	$ cd /usr/local/apache/htdocs
	$ mkdir my-new-repo.git

Initialize a bare repository

	$ cd my-new-repo.git
	$ git --bare init-db

Change the ownership to your webserver's credentials

	$ chown -R www.www .

If you do not know which user Apache runs as, you can alternatively do a 
"chmod -R a+w .", inspect the files which are created later on, and set 
the permissions appropriately.

Step 2: enable DAV on this repository
-------------------------------------

In your httpd.conf, make sure that this line exists:

	DAVLockDB "/usr/local/apache2/temp/DAV.lock"

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

The password file can be somewhere else, but it has to be readable by 
Apache.

You can create this file by

	$ htpasswd -c /usr/local/apache2/conf/passwd.git <user>

you will be asked a password, and the file is created. Subsequent calls
to htpasswd should omit the '-c' option, since you want to append to the
existing file.

You need to restart Apache; 'apachectl --graceful' is sufficient.

Step 3: setup the client
------------------------

Make sure that you have HTTP support, i.e. your git was built with curl.
The easiest way to check is to look for the executable 'git-http-push'.

Then, add the following to your .netrc (you can do without, but will be
asked to input your password a _lot_ of times):

	machine <servername>
	login <username>
	password <password>

If you want to access the webserver by its IP, you have to type that in,
instead of the server name.

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

	$ git-http-push upload master

(This assumes that the branch you want to export is called 'master' in your
client setup...)

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

In other cases, reading /usr/local/apache2/logs/error_log is often helpful.

Ciao,
Dscho
