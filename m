From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] git-instaweb: Add checks that web server can be started and is started
Date: Wed, 29 Dec 2010 17:49:14 +0100
Message-ID: <201012291749.14772.jnareb@gmail.com>
References: <201012291743.41213.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 17:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXzEY-0004pD-TC
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 17:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab0L2Quk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 11:50:40 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab0L2Quf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 11:50:35 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so11085534bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 08:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SxBhZE0nXzFjV4AGh9oV3urR2Bwqi1XECm9Bc/VTLno=;
        b=iYBzCb73Hs5ZuZ+9gtt9XsUwmTKfX0uwYvkkRHxuj9HhQEY6RyXR7ZRMgmp8snRmao
         VV69qB3DcBUZzQwHiQX1XJLKukUUORzhZHOl4L0Nl7EYkndyBfvCfuCfecxIwLNd7jth
         mXpdwUyKBbC6O1zLTU1iFWEgrTEQuRCbuCHGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fj1cc6jYCDT9HkPNNMKH0cFkDNSm5oqI7EdsyxdL0Uxbr7mOtOgBlkCh+okXldhBhY
         WsTDxeqxlyz+a9mEhemrj+ltv1mswg/oUoLwepBFZY74Mh5DXoAAm2TPVFvPAmpUxjr0
         zdTIpM1GPyfzUeCimSZdhg27CwUG9Fv2GbkOk=
Received: by 10.204.50.200 with SMTP id a8mr4915640bkg.209.1293641435071;
        Wed, 29 Dec 2010 08:50:35 -0800 (PST)
Received: from [192.168.1.13] (abvs18.neoplus.adsl.tpnet.pl [83.8.216.18])
        by mx.google.com with ESMTPS id x38sm7505600bkj.13.2010.12.29.08.50.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 08:50:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012291743.41213.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164318>

Better to check that "$root/gitweb.cgi" exists, and that web server
started, rather than have (for example) the following error message

  $ git instaweb --httpd=plackup --browser=mozilla
  Waiting for 'plackup' to start .../usr/share/gitweb/gitweb.cgi:
  No such file or directory at <somewhere>/perl5/CGI/Compile.pm line 97.
  ........

and keep waiting in httpd_is_ready for gitweb.cgi which would not start.

Note that the first check is not strictly necessary, but checking
separately that gitweb.cgi script can be found at expected place leads
to better error message.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It can be considered bugfix, or it can be considered hardening of
git-instaweb (making it more resilent).

 git-instaweb.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index da569f2..94f8b07 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -41,6 +41,9 @@ test -z "$root" && root='@@GITWEBDIR@@'
 # any untaken local port will do...
 test -z "$port" && port=1234
 
+# Sanity check
+test -e "$root/gitweb.cgi" || die "gitweb.cgi not found at '$root'"
+
 resolve_full_httpd () {
 	case "$httpd" in
 	*apache2*|*lighttpd*|*httpd*)
@@ -617,7 +620,7 @@ webrick)
 	;;
 esac
 
-start_httpd
+start_httpd || die "Could not start '$httpd'"
 url=http://127.0.0.1:$port
 
 if test -n "$browser"; then
-- 
1.7.3
