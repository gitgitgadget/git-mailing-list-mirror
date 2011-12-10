From: Mathieu Peltier <mathieu.peltier@gmail.com>
Subject: Access to git repository through squid proxy: The remote end hung up unexpectedly
Date: Sat, 10 Dec 2011 09:56:07 +0100
Message-ID: <CACjeFCA4h_w2UmYywMBV_P+YZcWAE=zRUz-z5eTfAO+oxWKPjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 09:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZIjA-0006N5-Fe
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 09:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab1LJI4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 03:56:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35139 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1LJI4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 03:56:08 -0500
Received: by iakc1 with SMTP id c1so5522201iak.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 00:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sO9sduT7xY50zk2pXo8TFmnZROX2d1ooLFYzngGVE94=;
        b=uoKC6mDhhq+zQRKoKESSB/uSqcOhIKY+y8j+HuNqxbcWb/ZHkXZ2kCxNg6G5bBUq6o
         IkPpavO9BCFEgMB2mVz46iBn184Oebv44Kb1tgKpNzuPUZMIKkuh6QiXNbB83Om4X7Or
         8jOVvxP+fBWEVdY8ZGvSJNBDhTEDvLq+3BEuY=
Received: by 10.50.220.231 with SMTP id pz7mr6412665igc.94.1323507367576; Sat,
 10 Dec 2011 00:56:07 -0800 (PST)
Received: by 10.231.33.11 with HTTP; Sat, 10 Dec 2011 00:56:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186729>

Hi,
I am trying to access a git repository (git:// URL) through a squid proxy.

squid allows CONNECT for port 9418:
$ more /etc/squid/squid.conf
...
acl password proxy_auth REQUIRED
acl git_port port 9418
...
http_access allow CONNECT git_port password
http_access deny CONNECT !SSL_ports

The proxy server can connect to git server :
$ telnet git.server.org 9418
Trying w.x.y.z...
Connected to git.server.org.
Escape character is '^]'.

Here is the error I get on the client side:
$ git config --list
core.gitproxy=gitproxy.sh

$ more ~/bin/gitproxy.sh
#!/bin/sh
PROXY=x.domain.org
PROXYPORT=8080
PROXYAUTH=user:pass
DEBUG="-d -d -d -d"
exec socat $DEBUG - PROXY:$PROXY:$1:$2,proxyport=$PROXYPORT,proxyauth=$PROXYAUTH

$ git clone git://git.server.org/gitroot/repo/repo
Initialized empty Git repository in /tmp/GIT/repo/.git/
...
2011/12/09 12:22:44 socat[21428] D socat version 1.7.1.3 on Aug 23 2010 23:26:54
2011/12/09 12:22:44 socat[21428] D setenv("SOCAT_VERSION", "1.7.1.3", 1)
...
2011/12/09 12:22:44 socat[21428] D running on Linux version #1 SMP Tue
Mar 23 09:47:08 UTC 2010, release x.y
2011/12/09 12:22:44 socat[21428] D argv[0]: "socat"
2011/12/09 12:22:44 socat[21428] D argv[1]: "-d"
2011/12/09 12:22:44 socat[21428] D argv[2]: "-d"
2011/12/09 12:22:44 socat[21428] D argv[3]: "-d"
2011/12/09 12:22:44 socat[21428] D argv[4]: "-d"
2011/12/09 12:22:44 socat[21428] D argv[5]: "-"
2011/12/09 12:22:44 socat[21428] D argv[6]:
"PROXY:x.domain.org:git.server.org:9418,proxyport=8080,proxyauth=user:pass"
...
2011/12/09 12:22:44 socat[21428] I setting option "proxyport" to "8080"
2011/12/09 12:22:44 socat[21428] I setting option
"proxy-authorization" to "user:pass"
...
2011/12/09 12:22:44 socat[21428] I sending "CONNECT
git.server.org:9418 HTTP/1.0\r\n"
...
2011/12/09 12:22:44 socat[21428] I proxy_connect: received answer
"HTTP/1.1 403 OK\r\n"
2011/12/09 12:22:44 socat[21428] E CONNECT git.server.org:9418: OK
2011/12/09 12:22:44 socat[21428] N exit(1)
2011/12/09 12:22:44 socat[21428] I shutdown(3, 2)
2011/12/09 12:22:44 socat[21428] D shutdown()  -> 0
fatal: The remote end hung up unexpectedly

I tried to use also nc but I get the same error.
Any advice?
Thanks in advance,
Mathieu
