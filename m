From: Davide Baldini <baldiniebaldini@gmail.com>
Subject: Fail to push over HTTP with MySQL authentication (Apache2)
Date: Sat, 29 Dec 2012 20:54:32 +0100
Message-ID: <50DF4A78.5000206@gmail.com>
Reply-To: Davide Baldini <baldiniebaldini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 29 21:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp2eJ-0003zp-Jr
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 21:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab2L2UC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 15:02:57 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:51226 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2L2UCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 15:02:55 -0500
Received: by mail-ee0-f47.google.com with SMTP id e51so5593358eek.20
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 12:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=hNWrdtwnhEBYOXY5U677xA7srnDKFPXuIsMSCUuU0bk=;
        b=Br1bGR9sLNBSk8isMNvmhabxl017Pa3va2BumbnTe8Jc1iIb/4F+XiNvq5/QFXOI/9
         bgxcnXQCRYPr9sqIgH9JSFGkJ1iajlkE5TxOdFqZjjQYnzHPlkJ4jgpjpMpYO5H4OfaK
         7SHPXHS2oPueiWxrBSOqS40t9pfRj6jMOq6G1fgbyM0wCI0LN/4/E81neYfFvidXGpjI
         b0d40B5W44FkPfjMrBLvQ/3qN6L/qBxSz+HyXgRnTEJqKymO1ywnHfRKa6Qfav3dSWqO
         gcSTxoj/EmEW+gEs7X5JFYfQ58iDP67tcvtTQWHX8oFbIjkORjLy5YZRyc0U7t5tiKi9
         8B8Q==
X-Received: by 10.14.1.195 with SMTP id 43mr97368451eed.31.1356810936635;
        Sat, 29 Dec 2012 11:55:36 -0800 (PST)
Received: from [192.168.1.11] ([87.19.240.177])
        by mx.google.com with ESMTPS id b2sm74170504eep.9.2012.12.29.11.55.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Dec 2012 11:55:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20120507 Icedove/3.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212315>

Hi,

I'm not able to setup a public Git repository over plain HTTP with
MySQL authentication.
Both HTTP and authentication are provided by Apache2.

SETUP:
-----

This setup is performed on Debian 6.0.4.

Apache2 (v. 2.2), with modules:
    auth_mysql
    WebDAV

Git (v. 1.7.8.3)
Git repository location:
    local, for webserver: /var/www/public/GT_rulesets/GT00.git
    public, for Git:      http://greatturn.org:8081/GT00.git

Git repository has been configured as:
    cd /var/www/public/GT_rulesets/GT00.git
    git init --bare
    mv hooks/post-update.sample hooks/post-update
    git update server-info
    chmode 777 /var/www/public/GT_rulesets/GT00.git  # for testing.


FACTS:
-----

The Apache side of my setup seems to work:
_   HTTP, MySQL authentication:
        I point Iceweasel to http://greatturn.org:8081/ .
        It asks for authentication; I authenticate with a username/
        password pair taken from MySQL database (which doesn't exist as
        a system user); It works, and I can see all the content of
        the git repository "GT00.git".
_   WebDAV:
        I point Konqueror to webdav://greatturn.org:8081/ .
        Works exactly as previous point.
_   Git:
        Git can fetch the repository without problems:
        git clone http://username:password@greatturn.org:8081/GT00.git

Pushing the locally fetched repository back to the remote one doesn't
work:
    "git push http://greatturn.org:8081/GT00.git master"
    asks for username and password:
        > Username for 'greatturn.org:8081':
        > Password for 'greatturn.org:8081':

    I enter my credentials, then git outputs the following and exits:
        > error: Cannot access URL http://greatturn.org:8081/GT00.git/,
return code 22
        > fatal: git-http-push failed

    On Apache's access.log, git produces all and no more than the
    following:
        > 87.19.240.177 - - [29/Dec/2012:16:43:22 +0100] "GET /GT00.git
/info/refs?service=git-receive-pack HTTP/1.1" 401 767 "-"
"git/1.7.8.3"
        > 87.19.240.177 - - [29/Dec/2012:16:43:26 +0100] "GET
/GT00.git/info/refs?service=git-receive-pack HTTP/1.1" 401 767 "-"
"git/1.7.8.3"
        > 87.19.240.177 - davide [29/Dec/2012:16:43:26 +0100] "GET
/GT00.git/info/refs?service=git-receive-pack HTTP/1.1" 200 233 "-"
"git/1.7.8.3"
        > 87.19.240.177 - davide [29/Dec/2012:16:43:26 +0100] "GET
/GT00.git/HEAD HTTP/1.1" 200 258 "-" "git/1.7.8.3"
        > 87.19.240.177 - - [29/Dec/2012:16:43:26 +0100] "PROPFIND
/GT00.git/ HTTP/1.1" 401 767 "-" "git/1.7.8.3"
