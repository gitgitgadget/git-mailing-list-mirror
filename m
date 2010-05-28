From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] git-instaweb: Wait for server to start before running web browser
Date: Fri, 28 May 2010 21:11:24 +0200
Message-ID: <1275073885-26537-3-git-send-email-jnareb@gmail.com>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 21:09:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI4wN-0000eN-Ug
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 21:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab0E1TJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 15:09:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0E1TJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 15:09:40 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1005565fxm.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Gy+Zvee9Q9tO8Jvd3o71XAXOewKCWvOK97crVpbDc0I=;
        b=XiobFoC1TdrzkN2qe4LCPxqJH6zo1l4TXBShaqLI/v0tUoquXWtvuvCSUhwaI+hhWT
         6f2QFuPUpfLWZwLeMIvkyYUWgfxLkHaIs8yysUo3VoUggwPb1Y2Whnh0FfheO5zM13Zj
         YXM/hOnHNNpJBgzaa2d9g2gzFVzfpF3LlLEFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f04ZMiVwlDTQx/QjyUzBzM4UYl71A8gU+A4UFe1EBWtCBbpS7G1WYQ3QFqQ1L+M21d
         K1F6bWYJa4aMBFaDwyvS2kDN2+jxKHDx03ja1/HUngKNexgZNm/t0citpIykmxprddlO
         eQD6zWgBQDSLxjXIwZbF0duz6hDfBtssbUZZM=
Received: by 10.223.45.200 with SMTP id g8mr800621faf.67.1275073778936;
        Fri, 28 May 2010 12:09:38 -0700 (PDT)
Received: from localhost.localdomain (abwk209.neoplus.adsl.tpnet.pl [83.8.234.209])
        by mx.google.com with ESMTPS id 13sm13023723fad.7.2010.05.28.12.09.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 12:09:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147933>

Add generic httpd_is_ready subroutine, which busy-waits for web server to
be started, by checking if $port is opened on localhost.  This is used to
avoid situation where web browser is started before web server is ready to
accept connection, and fails.

It uses IO::Socket::INET module, which is core Perl module since v5.6.0.


Alternate solution, possible for those web servers that can run arbitrary
code hooks after they bind the listen socket (after they start accepting
connections), would be to use some kind of blocking mechanism: FIFO or
lockfile, see
  http://thread.gmane.org/gmane.comp.version-control.git/147337/focus=147566

This can be always added later, as a web server specific branch in
httpd_is_ready function.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was required to test support for 'plackup' web server in git-instaweb
(the next patch in this series), because default pure-Perl web server used
by Plack, namely HTTP::Server::PSGI, can take a while to start.

 git-instaweb.sh |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index a8c5dc0..dc8478f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -117,6 +117,19 @@ stop_httpd () {
 	rm -f "$fqgitdir/pid"
 }
 
+httpd_is_ready () {
+	"$PERL" -MIO::Socket::INET -e "
+local \$| = 1; # turn on autoflush
+exit if (IO::Socket::INET->new('127.0.0.1:$port'));
+print 'Waiting for \'$httpd\' to start ..';
+do {
+	print '.';
+	sleep(1);
+} until (IO::Socket::INET->new('127.0.0.1:$port'));
+print qq! (done)\n!;
+"
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -414,7 +427,7 @@ start_httpd
 url=http://127.0.0.1:$port
 
 if test -n "$browser"; then
-	git web--browse -b "$browser" $url || echo $url
+	httpd_is_ready && git web--browse -b "$browser" $url || echo $url
 else
-	git web--browse -c "instaweb.browser" $url || echo $url
+	httpd_is_ready && git web--browse -c "instaweb.browser" $url || echo $url
 fi
-- 
1.7.0.1
