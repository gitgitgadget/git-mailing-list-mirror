From: Ryan Phillips <ryan@trolocsis.com>
Subject: git-http-backend and Authenticated Pushes
Date: Tue, 9 Mar 2010 11:08:48 -0600
Message-ID: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 18:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np2vv-00036g-DE
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 18:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab0CIRJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 12:09:21 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:45206 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab0CIRJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 12:09:17 -0500
Received: by gxk9 with SMTP id 9so4131432gxk.8
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 09:09:16 -0800 (PST)
Received: by 10.90.217.14 with SMTP id p14mr221811agg.35.1268154531646; Tue, 
	09 Mar 2010 09:08:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141833>

Hi All,

I'm trying to follow the git-http-backend man page on setting up
authenticated pushes to my apache server. Pulls work fine, and fully
authenticated pushes work fine. However, when I try and setup
anonymous pulls and authenticated pushes the push fails.

I believe the culprit is this 403 error:

192.168.1.1 - - [09/Mar/2010:09:01:43 -0800] "GET
/git/test.git/info/refs?service=git-receive-pack HTTP/1.1" 403 - "-"
"git/1.7.0.2.dirty"

Anybody know what I missed?

Regards,
Ryan

My vhost replaced with example.com:

<VirtualHost *:80>
        SetEnv GIT_PROJECT_ROOT /home/httpd/domains/example.com/repo
        SetEnv GIT_HTTP_EXPORT_ALL
        SetEnv GITWEB_CONFIG /home/httpd/domains/example.com/gitweb.conf

        RewriteEngine on
        RewriteRule ^/$     /git/ [PT]

        <Directory /usr/local/git>
           Options Indexes FollowSymLinks MultiViews Includes ExecCGI
           AllowOverride None
           Order allow,deny
           Allow from all
        </Directory>

        <LocationMatch "^/git/.*/git-receive-pack$">
            AuthType Basic
            AuthName "Git Access"
            AuthUserFile /home/httpd/domains/example.com/.htpasswd
            Require valid-user
        </LocationMatch>
        ScriptAliasMatch \
                "(?x)^/git/(.*/(HEAD | \
                                info/refs | \
                                objects/(info/[^/]+ | \
                                         [0-9a-f]{2}/[0-9a-f]{38} | \
                                         pack/pack-[0-9a-f]{40}\.(pack|idx)) | \
                                git-(upload|receive)-pack))$" \
                /usr/local/git/current/libexec/git-core/git-http-backend/$1

        ScriptAlias /git/ /usr/local/git/current/gitweb/gitweb.cgi/

        Alias       /gitweb.css       /usr/local/git/current/gitweb/gitweb.css
        Alias       /git-logo.png     /usr/local/git/current/gitweb/git-logo.png
        Alias       /git-favicon.png
/usr/local/git/current/gitweb/git-favicon.png

        ServerName example.com
        ServerAlias *.example.com
        ErrorLog /home/httpd/domains/example.com/logs/error_log
        CustomLog /home/httpd/domains/example.com/logs/access_log combined
</VirtualHost>
