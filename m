From: Josef Wolf <jw@raven.inka.de>
Subject: Howto setup-git-server-over-http.txt with SSL and basic authentication?
Date: Fri, 17 Oct 2008 18:06:04 +0200
Message-ID: <20081017160603.GD9707@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 18:25:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqs7v-0000qX-0J
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 18:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbYJQQXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbYJQQXV
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 12:23:21 -0400
Received: from quechua.inka.de ([193.197.184.2]:55611 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbYJQQXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 12:23:21 -0400
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Oct 2008 12:23:20 EDT
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Kqrsg-0003bH-Rh; Fri, 17 Oct 2008 18:08:50 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 8691B3AB9D; Fri, 17 Oct 2008 18:06:04 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98486>

Hello folks,

I am new to git and I am trying to set up a git repository as described in

  http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

but with SSL and basic authentication.

This is what I have done:

1. Create bare git repository on the server:

     root: mkdir -p /data/git/test
     root: ( cd /data/git/test ; git --bare init )
     root: chown -R wwwrun:www /data/git

2. Add a new DAV location to the (existing and already working) apache
   config, pointing to the newly created git repository.  I list only
   the relevant parts here:

     LoadModule dav_svn_module /usr/lib/apache2/mod_dav_svn.so
     LoadModule dav_fs_module /usr/lib/apache2/mod_dav_fs.so
     DAVLockDB "/data/dav/lock/DAV.lock"

     Alias /git/test /data/git/test
     <Location /git/test>
       DAV on
       Order           Allow,Deny
       Allow           from all
       AllowOverride   None
       AuthName        "test"
       AuthType        Basic
       AuthUserFile    /m/b/httpd/passwd
       AuthGroupFile   /m/b/httpd/group
       Require         group test test-ro
       SSLRequireSSL
       <LimitExcept GET PROPFIND OPTIONS REPORT>
         Require group test
       </LimitExcept>
     </Location>

3. Now it's time to test DAV access, so I go to the client:

     konqueror webdavs://repo.host.org/git/test

   After asking for credentials, Konqueror shows me content, and I can
   read/copy/delete files to/from the DAV directory.  So the server
   seems to work fine.
   Now I go test curl:

     $ curl --cacert /etc/cacerts/myca.pem \
            https://user@repo.host.org/git/test/HEAD

   fails with "authentication required", but

     $ curl --cacert /etc/cacerts/myca.pem --user user \
            https://user@repo.host.org/git/test/HEAD

   works fine.  So I put this information into ~/.curlrc:

     $ cat ~/.curlrc
     --cacert /etc/cacerts/myca.pem
     --user   user
     $ curl https://repo.host.org/git/test/HEAD
     Enter host password for user 'user':
     ref: refs/heads/master
     $

   this looks good now.

4. OK, now I go to the next step on the client:

     $ git-config remote.upload.url https://repo.host.org/git/test/
     error: could not lock config file .git/config
     $

   hmm, maybe I should have an empty repos here?  So:

     $ git init
     Initialized empty Git repository in /tmp/test/.git/
     $ git-config remote.upload.url https://repo.host.org/git/test/
     $ git push upload master
     error: Cannot access URL https://repo.host.org/git/test/, return code 60
     error: failed to push some refs to 'https://repo.host.org/git/test/'

   OK, from the above mentioned howto, this looks like cacert is missing.
   Looks like (unlike the howto states) ~/.curlrc is ignored by git.
   So I go searching for appropriate configuration options in git:

     $ git-config http.sslCAPath /etc/cacerts

   don't help (why?), but 

     $ git-config http.sslCAInfo /etc/cacerts/myca.pem
     $ git push upload master
     error: Cannot access URL https://repo.host.org/git/test/, return code 22
     error: failed to push some refs to 'https://repo.host.org/git/test/'

   Finally, that's a new error code.  This is probably because the server
   requires authentication.  But I can't find any hints how to specify
   credentials in git-config or git-push.

So now come my questions:

0. The howto says curl is used for transport. Why is my ~/.curlrc ignored?
1. Since .curlrc is ignored: How do I specify credentials for git?
2. Why don't sslCAPath work?
3. Is there a way to override credentials and sslCAPath on a per-remote
   basis (as can be done with http.proxy, for example)

Any hints?
