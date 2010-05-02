From: Jakub Narebski <jnareb@gmail.com>
Subject: Adding support for "plackup" and similar web server tools to git-instaweb
Date: Sun, 2 May 2010 03:17:40 +0200
Message-ID: <201005020317.42112.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 03:18:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Nom-0002VJ-Rw
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 03:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0EBBRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 21:17:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:36820 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab0EBBRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 21:17:49 -0400
Received: by fg-out-1718.google.com with SMTP id d23so605190fga.1
        for <git@vger.kernel.org>; Sat, 01 May 2010 18:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=cJ6ZeNzOkzhvSyzEwhuss9Wft9pewNljA+HeZWbO1iU=;
        b=BD8ITt6rFmeQk3rafwDC2Iy/yh9bnkuyt5KeNF2hm/ctANOoIzYhzimpbKH3grxeno
         Gzjr6c8G2u6dGwWnoHl6FwRB1CpaatQjZdqICjFHEXf6Ia2pADkRp7/W7FxMNrNFzTdq
         /SizaioJk6LOPp98bscGNq1yhmkNPQ+93WBAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=kVp0ZnBYYj6bT3b5pNmHIZn9clqXNoUl8WmmbUdC/DAmh+wu5oYE8UowM027710sCC
         zCnJhFX8wdOAWnolw1edYCw9okJKsSfA+nkCgiERxo13+ZoeEuC0bmlsqbH6/tKnaCum
         dplExDllc1ey8ihrzCeZD1HDF0Q4yDV4kHdCE=
Received: by 10.87.1.13 with SMTP id d13mr7319675fgi.29.1272763067271;
        Sat, 01 May 2010 18:17:47 -0700 (PDT)
Received: from [192.168.1.13] (abvd245.neoplus.adsl.tpnet.pl [83.8.201.245])
        by mx.google.com with ESMTPS id e11sm3458427fga.28.2010.05.01.18.17.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 18:17:46 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146124>

I would like to add support for --httpd / instaweb.httpd = plackup
to git-instaweb.  'plackup'[1] is a command line utility to run 
PSGI[2][3] application (CGI application can be wrapped as such[4][5])
from the command line.  

Among others 'plackup' can use standalone HTTP::Server::PSGI server
(in Perl).  This means that one could use git-instaweb with 
--httpd=plackup even without permissions to install CGI scripts;
without admin rights (CPAN modules can be installed localy in one's
home directory using local::lib).


The problem is that contrary to other web servers that can be used by
git-instaweb, (namely apache2, lighttpd, mongoose and webrick), the
'plackup' utility is configured using command line options, and not
via configuration file (well, one can use configuration file, but it
depends on the web server run from plackup).

How should one go with adding support for such httpd?  My first attempt
was putting full command line into 'httpd' in resolve_full_httpd():

+       *plackup*)
+               # plackup is configured via command-line options
+               bind=
+               test x"$local" = xtrue && bind="--host=127.0.0.1"
+               httpd="$httpd --port=$port $bind --app=$fqgitdir/gitweb/app.psgi"
+               ;;

The default standalone web server used by plackup (HTTP::Server::PSGI)
does not have daemon mode, so we would have to do the same as for moongose
web server: set to background and save pid in pidfile in git-instaweb.

OTOH plackup prints information / logs to STDERR, so it would have to be
silenced or redirected to error_log.  Also plackup does not need to have
"$fqgitdir/gitweb/httpd.conf" passed as last argument, but it needs to
be passed PSGI wrapper for CGI (I'd rather not use httpd.conf, but rather
app.psgi or gitweb.psgi for that).


So how should one go with adding support for new web server to git-instaweb,
that is configured via command line options (--port, --host) and not via
config file?

[1] http://p3rl.org/plackup
[2] http://plackperl.org
[3] http://p3rl.org/PSGI
[4] http://p3rl.org/Plack::App::WrapCGI
[5] http://p3rl.org/CGI::Emulate::PSGI
[6] http://p3rl.org/Plack
-- 
Jakub Narebski
Poland
