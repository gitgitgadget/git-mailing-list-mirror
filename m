X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb install
Date: Mon, 20 Nov 2006 02:32:29 +0100
Organization: At home
Message-ID: <ejr0gi$ea8$1@sea.gmane.org>
References: <45610199.4030502@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 01:31:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 93
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31875>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gly0X-0007a8-2n for gcvg-git@gmane.org; Mon, 20 Nov
 2006 02:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933843AbWKTBbM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 20:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933846AbWKTBbM
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 20:31:12 -0500
Received: from main.gmane.org ([80.91.229.2]:35783 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933843AbWKTBbL (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 20:31:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gly01-0007Ue-PP for git@vger.kernel.org; Mon, 20 Nov 2006 02:31:05 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 02:31:05 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 02:31:05 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

lamikr wrote:

> Hi
> 
> Following dummyuser test case (me :-) might be usefull for improving docs.
> I have read the gitweb/README but in addition of that I find out that
> there is really little documentation about installing gitweb
> except the Makefile & git-instaweb.sh itself.
> 
> I would like to install gitweb to /var/run/html/gitweb directory and
> after reading the git/INSTALL & gitweb/README
> I came to conclusion that something like following could work
> 
> 1) build git by changing some of the default gitweb configs as a user
>     make prefix=/usr all doc GITWEB_SITENAME='gitweb test' \
>          GITWEB_PROJECTROOT=/var/www/html/gitweb 
> 2) install git as a root after build
>     make prefix=/usr install install-doc
> 3) add following to apache config
>     <VirtualHost www:80>
>         ServerName my-web-page
>         DocumentRoot /gitweb
>         RewriteEngine on
>         RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
>         SetEnv    GITWEB_CONFIG    /etc/gitweb.conf
>     </VirtualHost>
> 4) move git repository (kernel for example) to /var/www/html/gitweb
It should be enough to symlink it, given appropriate setup.

> 5) restart apache
> 6) open browser to http://my-web-page/gitweb
> 
> Obviously something failed, as after step 2, I do not have either the
> /etc/gitweb.conf or gitweb scripts under directory /var/www/html/gitweb

First, "make install" does not install the gitweb, as the place where
it should be installed depends from configuration to configuration.
By the way, you may compile ony gitweb using "make gitweb/gitweb.cgi"
with appropriate params. So 2.1) step would be to manually copy
gitweb.cgi and gitweb.css at least, perhaps also git-logo.png and
git-favicon.png.

Second, you have to set up gitweb.cgi as a CGI script, or as legacy
mod_perl script. I have for example in /var/www/cgi-bin symlink named
gitweb to directory with gitweb.cgi, gitweb.css etc. and in
/var/www/perl symplink to the same place.

The CGI configuration for Apache2 is (simplest case, I'd appreciate
better solutions):

 LoadModule cgi_module modules/mod_cgi.so
 ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
 <Directory "/var/www/cgi-bin">
    Options Indexes FollowSymlinks ExecCGI
    AllowOverride None
    Order allow,deny
    Allow from all
 </Directory>

and can use for example http://localhost/cgi-bin/gitweb/gitweb.cgi

The mod_perl configuration for Apache2 is (again, I'd appreciate
pointing out better solution):

 # mod_perl configuration, c.f. CGI version
 #
 Alias /perl "/var/www/perl"
 <Directory "/var/www/perl">
    SetHandler perl-script
    PerlResponseHandler ModPerl::Registry
    PerlOptions +ParseHeaders
    Options Indexes FollowSymlinks +ExecCGI
    AllowOverride None
    Order allow,deny
    Allow from all
 </Directory>

If you don't have conf.d/perl.conf, then you have also to add to
your apache config the line

 LoadModule perl_module modules/mod_perl.so

Well, mod_perl configuration could also be in the conf.d/perl.conf file.

I can use http://localhost/perl/gitweb/gitweb.cgi for mod_perl driven
gitweb.

HTH
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

