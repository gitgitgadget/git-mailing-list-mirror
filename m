From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: GIT server over HTTP
Date: Fri, 19 Sep 2008 15:31:47 +0200
Message-ID: <48D3A9C3.8080909@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 15:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KggHc-0002XQ-VB
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 15:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbYISNmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 09:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYISNmh
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 09:42:37 -0400
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:55124 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYISNmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 09:42:35 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Sep 2008 09:42:34 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 68C0D19F9AF
	for <git@vger.kernel.org>; Fri, 19 Sep 2008 15:32:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.248
X-Spam-Level: 
X-Spam-Status: No, score=-4.248 tagged_above=-10 required=5
	tests=[ALL_TRUSTED=-1.8, AWL=0.151, BAYES_00=-2.599]
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Fpvmi6Mz-9d for <git@vger.kernel.org>;
	Fri, 19 Sep 2008 15:32:37 +0200 (CEST)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 0F43319F99E
	for <git@vger.kernel.org>; Fri, 19 Sep 2008 15:32:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96285>

Hi,

I'm trying to migrate from SVN to GIT and are facing some problems with=
 setting up public GIT repository accessible via HTTP for pull and push=
=2E I'm runnig 2.6.26 kernel on Gentoo Linux with apache 2 and git 1.5.=
6.4. Following the http://www.kernel.org/pub/software/scm/git/docs/howt=
o/setup-git-server-over-http.txt I managed to get following done:

1. create GIT repo in /home/hinkok/public_html:
$ mkdir ~/public_html/gitrepo.git
$ cd ~/public_html/gitrepo.git
$ git --bare init
$ sudo chown -R apache:apache .

2. Create DAV entry for apache web server
$ cat /etc/apache2/modules.d/48_mod_dav_git.conf=20
<Location /~hinkok/gitrepo.git>
	DAV on
#	AuthType None
	AuthType Basic
	AuthName "Git"
	AuthUserFile /home/hinkok/passwd.git
	Require valid-user
</Location>

$ htpasswd -c ~/passwd.git hinkok
$ cat ~/passwd.git
hinkok:t9871siBkRbaU
$ cat ~/.netrc=20
machine localhost
login hinkok
password hinkok

3. Test GIT location
$ curl --netrc --location http://hinkok@localhost/~hinkok/gitrepo.git/H=
EAD
ref: refs/heads/master

=46irefox also requests user auth for http://hinkok@localhost/~hinkok/g=
itrepo.git

4. Pushing some changes to the remote repo
$ cd /tmp
$ mkdir gt
$ cd gt/
$ git init
$ git-config remote.upload.url http://hinkok@localhost/~hinkok/gitrepo.=
git/   =20
$ git push upload master
error: Cannot access URL http://hinkok@localhost/~hinkok/gitrepo.git/, =
return code 22
error: failed to push some refs to 'http://hinkok@localhost/~hinkok/git=
repo.git/'

$ cat .git/config
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[remote "upload"]
	url =3D http://hinkok@localhost/~hinkok/gitrepo.git/

 $ sudo tail /var/log/apache2/error_log
[Fri Sep 19 15:29:20 2008] [notice] Apache/2.2.9 (Unix) DAV/2 mod_ssl/2=
=2E2.9 OpenSSL/0.9.8g SVN/1.5.1 PHP/5.2.6-pl6-gentoo configured -- resu=
ming normal operations
[Fri Sep 19 15:31:03 2008] [error] [client 127.0.0.1] client denied by =
server configuration: /home/hinkok/public_html/gitrepo.git/

What am I missing here?

Thank you,
Hinko

--=20
=C8ETRTA POT, d.o.o., Kranj
Planina 3
4000 Kranj
Slovenia, Europe
Tel. +386 (0) 4 280 66 03
E-mail: hinko.kocevar@cetrtapot.si
Http: www.cetrtapot.si
