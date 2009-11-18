From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Wed, 18 Nov 2009 01:16:47 +0100
Message-ID: <7fce93be0911171616l4f41acd4v2a42d5849a139d29@mail.gmail.com>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
	 <7vhbssewm7.fsf@alter.siamese.dyndns.org>
	 <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
	 <7vd43gerak.fsf@alter.siamese.dyndns.org> <4B032AC8.4@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:16:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAYEA-0005Gg-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbZKRAQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 19:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbZKRAQm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:16:42 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:57150 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbZKRAQl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 19:16:41 -0500
Received: by ywh6 with SMTP id 6so588671ywh.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 16:16:47 -0800 (PST)
Received: by 10.101.155.38 with SMTP id h38mr3230998ano.146.1258503407219; 
	Tue, 17 Nov 2009 16:16:47 -0800 (PST)
X-Originating-IP: [82.233.66.33]
In-Reply-To: <4B032AC8.4@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133117>

> For starters I think overriding the /~<user> (specifically the ~ here=
) is
> going to be a bad idea no matter what you do and gives the wrong impr=
ession
> about what / how the request is being responded to. =A0You might want=
 to try
> and pick a different delimiter or re-work the rule so that you could =
have
> something like:
>
> =A0 =A0 =A0 =A0http://git.kernel.org/<gitweb urls>
> =A0 =A0 =A0 =A0http://git.kernel.org/user/<gitweb urls>
>
> Your also, likely, going to need to take into account things like ind=
ex.cgi
> and gitweb.cgi in the url as things like:
>
> http://git.kernel.org/?p=3Dbluetooth/bluez-gnome.git;a=3Dsummary
> http://git.kernel.org/gitweb.cgi?p=3Dbluetooth/bluez-gnome.git;a=3Dsu=
mmary
>

<VirtualHost git.abstraction.fr:80>

        ServerAdmin webmaster@abstraction.fr
        ServerName git.abstraction.fr:80
        DocumentRoot /var/www/sylvain/git.abstraction.fr/html

        # Possible values include: debug, info, notice, warn, error, cr=
it,
        # alert, emerg.
        LogLevel debug

        CustomLog /var/www/sylvain/git.abstraction.fr/log/access.log co=
mbined
        ErrorLog /var/www/sylvain/git.abstraction.fr/log/error.log
        ServerSignature On

        RewriteEngine on
        RewriteLog /var/www/sylvain/git.abstraction.fr/log/rewrite.log
        RewriteLogLevel 3
        RewriteRule ^/$
/cgi-bin/gitweb.cgi     [QSA,L,PT]
        RewriteRule ^/gitweb.cgi$
/cgi-bin/gitweb.cgi     [QSA,L,PT]
        RewriteRule ^/\~([^\/]+)/?$
/cgi-bin/gitweb.cgi
[QSA,E=3DGITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
        RewriteRule ^/\~([^\/]+)/gitweb.cgi$
/cgi-bin/gitweb.cgi
[QSA,E=3DGITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
        RewriteRule ^/users/([^\/]+)/?$
/cgi-bin/gitweb.cgi
[QSA,E=3DGITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
        RewriteRule ^/users/([^\/]+)/gitweb.cgi$
/cgi-bin/gitweb.cgi
[QSA,E=3DGITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]

        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
        <Directory "/usr/lib/cgi-bin/">
                AllowOverride None
                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
                Order allow,deny
                Allow from all
        </Directory>

        Alias /gitweb /usr/share/gitweb/
        <Directory "/usr/share/gitweb/">
                AllowOverride None
                Options +MultiViews +SymLinksIfOwnerMatch
                Order allow,deny
                Allow from all
        </Directory>

</VirtualHost>


You can test here :

http://git.abstraction.fr/
http://git.abstraction.fr/gitweb.cgi
http://git.abstraction.fr/~sylvain/
http://git.abstraction.fr/~sylvain/gitweb.cgi
http://git.abstraction.fr/users/sylvain/
http://git.abstraction.fr/users/sylvain/gitweb.cgi

The dns record is fresh. If your dns is not up to date the ip is 88.191=
=2E254.60.
