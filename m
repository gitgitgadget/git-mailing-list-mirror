From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUGFIX PATCH 1/4] git-instaweb: Fix issue with static files for 'plackup' server
Date: Wed, 29 Dec 2010 17:47:00 +0100
Message-ID: <201012291747.01288.jnareb@gmail.com>
References: <201012291743.41213.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tadeusz Sosnierz <tadzikes@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 17:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXzEX-0004pD-AG
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 17:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0L2Quf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 11:50:35 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab0L2Quc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 11:50:32 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so11085534bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IdtMM4oL9Fm1ywr44f3eBoggL7YHhzwWcbLfPH6ZXTI=;
        b=iRm773jS6V0zi3EtM4WLwKr4KBEVsGWgmQR21L/LD8Yhr4rPVqtrGIznm49S/wk3+Q
         tyaEg87ZdU8bDtNoqH7MkOfvqHgceswj/F5/ofj65Y0nUVHh4xRZrbS0c+WhV6YNAWwc
         0fa8P+BCIO55qMJYPxenMMSJDQr/heDoER+w0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rvSBdxuJZgLGGjHB4Ha2/5WnRdjqs+grjgWUTuN3bKmvTyFZU0rW8TyMQpexTWZqYe
         Vlm42t9/bpUpPw1HtaHI/wAhS7GuZ+wemWJ93PWZ0BLomNkmDQ/CFdQFuEkqofo1miob
         6cKMte0Bnm4S4M+uyxZY1CaV44De1ZxU3mk5M=
Received: by 10.204.126.138 with SMTP id c10mr12369286bks.156.1293641431495;
        Wed, 29 Dec 2010 08:50:31 -0800 (PST)
Received: from [192.168.1.13] (abvs18.neoplus.adsl.tpnet.pl [83.8.216.18])
        by mx.google.com with ESMTPS id x38sm7505600bkj.13.2010.12.29.08.50.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 08:50:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012291743.41213.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164316>

The default (in gitweb/Makefile) is to use relative paths for gitweb
static files, e.g. "static/gitweb.css" for GITWEB_CSS.  But the
configuration for Plack::Middleware::Static in plackup_conf assumed
that static files must be absolute paths starting with "/gitweb/"
prefix which had to be stripped, e.g. "/gitweb/static/gitweb.css".
This in turn caused web server run by "git instaweb --httpd=3Dplackup"
to not access static files (e.g. CSS) correctly.

This is a minimal fixup, making 'plackup' web server in git-instaweb
work with default gitweb build configuration.

Reported-by: Tadeusz So=C5=9Bnierz <tadzikes@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The regexp is probably too strict: qr{^/static/} should be enough,
but I didn't want to change too much at once.

This bug was not noticed because we don't have any test for
git-instaweb, not mentioning tests for all web servers supported.  And
the fact that I was checking "git instaweb -httpd=3Dplackup" against
gitweb.cgi built with custom configuration (including the fact that
GITWEB_CSS=3D"/gitweb/static/gitweb.css").

tadzik, does that fix the issue you noticed?

Junio, could you apply this before 1.7.4?  Thanks in advance.

 git-instaweb.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 10fcebb..bb57d81 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -549,7 +549,7 @@ my \$app =3D builder {
 	};
 	# serve static files, i.e. stylesheet, images, script
 	enable 'Static',
-		path =3D> sub { m!\.(js|css|png)\$! && s!^/gitweb/!! },
+		path =3D> qr{^/static/.*(?:js|css|png)\$},
 		root =3D> "$root/",
 		encoding =3D> 'utf-8'; # encoding for 'text/plain' files
 	# convert CGI application to PSGI app
--=20
1.7.3
