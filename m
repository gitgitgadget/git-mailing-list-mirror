From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: How to setup a public reposistory?
Date: Fri, 21 Nov 2008 12:04:02 -0800 (PST)
Message-ID: <354563.49837.qm@web37901.mail.mud.yahoo.com>
References: <4926853A.6080009@op5.se>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 21 21:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3cFo-0004IY-HK
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 21:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbYKUUEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 15:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752955AbYKUUEG
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 15:04:06 -0500
Received: from web37901.mail.mud.yahoo.com ([209.191.91.163]:43652 "HELO
	web37901.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752580AbYKUUEE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2008 15:04:04 -0500
Received: (qmail 49991 invoked by uid 60001); 21 Nov 2008 20:04:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=zjqO6TxTBoKd/hkoiFEFjg1x2HcBKoKNqwQR55lutt04n5zMQMahQMIu1MPzq+ePkwYRLbH4QTLzB9iOjo+RO2nC/O/YUXb12E9IN7TUDxmxo41DyoMDm+QZolErtFKkSQ7ixAZJYlENQOBQO0r3bG9/ffyHhqvwqiwR6cqvVJc=;
X-YMail-OSG: uvUsp_IVM1mhuyQpFL_7R1iRJGmnpUeoz4mjUh0yj5k104EPdUZtFJt63NqasPJlEuQMGZzS2IhTiW96kHQKHivFuGB7kfIjyUYkXaIXgSf2FY.3sqV5WPx7tWxYYwIq0DOnVGLbuorhNRSkMvxpVMIctrxn0kdBXz6tcwHlZHNHrt0-
Received: from [76.195.33.70] by web37901.mail.mud.yahoo.com via HTTP; Fri, 21 Nov 2008 12:04:02 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <4926853A.6080009@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101538>


I followed the steps outlined by the links below. But, I am still not able to setup the public repository. I got, fatal: unable to connect a socket (Connection refused). What I did wrong? Please help.

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#setting-up-a-public-repository
http://dtcsupport.gplhost.com/Git/Public-Repo-Howto

0. Prepare your name and email address
cat ~gyang/.gitconfig
[user]
        email = gyang@mycompany.com
        name = Gary Yang


1. Create an archive to send to the server

/home/gyang% git clone http://git.gplhost.com/dtc-xen.git

/home/gyang% git clone --bare dtc-xen dtc-xen.git

/home/gyang% touch dtc-xen.git/git-daemon-export-ok

/home/gyang% tar -cvzf dtc-xen.git.tar.gz dtc-xen.git


2. Install the archive on the web server

/pub/git% tar -xvzf /home/gyang/dtc-xen.git.tar.gz

/pub/git/dtc-xen.git% git --bare update-server-info

/pub/git/dtc-xen.git% mv hooks/post-update.sample hooks/post-update

/pub/git/dtc-xen.git% chmod +x hooks/post-update

/pub/git/dtc-xen.git% cat hooks/post-update
#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, rename this file to "post-update".

exec git-update-server-info


3. Configure and start git daemon at the web server

/pub/git/dtc-xen.git% grep 9418 /etc/services
git             9418/tcp                        # Git Version Control System


/pub/git/dtc-xen.git% sudo git daemon --verbose --inetd --export-all /pub/git &


4. At my local machine. I did

/home/gyang% git clone git://git.mycompany.com/pub/git/dtc-xen.git test-git

Initialized empty Git repository in //home/gyang/test-git/.git/
git.mycompany.com[0: 10.66.4.168]: errno=Connection refused
fatal: unable to connect a socket (Connection refused)


ps -efww | grep git
root      9626 22321  0 11:31 pts/1    00:00:00 git-daemon --verbose --inetd --export-all /pub/git





--- On Fri, 11/21/08, Andreas Ericsson <ae@op5.se> wrote:

> From: Andreas Ericsson <ae@op5.se>
> Subject: Re: Cannot git pull using http from my git.mycompany.com
> To: garyyang6@yahoo.com
> Cc: git@vger.kernel.org
> Date: Friday, November 21, 2008, 1:54 AM
> Gary Yang wrote:
> > git pull http://git.mycompany.com/pub/git/u-boot.git
> HEAD
> > fatal:
> http://git.mycompany.com/pub/git/u-boot.git/info/refs not
> found: did you run git update-server-info on the server?
> > 
> > Below are related gitweb configs. What did I do wrong?
> > 
> > 
> > httpd.confg
> > 
> > <VirtualHost 10.66.4.168>
> >     ServerName svdcgit01
> >      DocumentRoot /pub/git
> >      <Directory /var/www/cgi-bin>
> >           Allow from all
> >           AllowOverride all
> >           Order allow,deny
> >           Options ExecCGI
> >           <Files gitweb.cgi>
> >                SetHandler cgi-script
> >           </Files>
> >      </Directory>
> >      DirectoryIndex /cgi-bin/gitweb.cgi
> >      SetEnv  GITWEB_CONFIG  /etc/gitweb.conf
> > #       RewriteEngine on
> > #       RewriteRule
> ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$
> /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
> > 
> > 
> > cat /etc/gitweb.conf
> 
> 
> You seem slightly confused. gitweb is not used for cloning
> over http.
> The following documents would almost certainly be
> beneficial for you
> to read. Please don't ask any questions that are
> already answered in
> those documents. If, by following the steps outlined in
> those docs,
> you still cannot get things to work, please let us know
> what you fail
> to understand so the texts can be amended.
> 
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#setting-up-a-public-repository
> http://dtcsupport.gplhost.com/Git/Public-Repo-Howto
> 
> -- Andreas Ericsson                  
> andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
