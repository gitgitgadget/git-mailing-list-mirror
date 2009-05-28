From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 2/2] http.c: add http.sslCertNoPass option
Date: Wed, 27 May 2009 23:16:03 -0400
Message-ID: <1243480563-5954-2-git-send-email-lodatom@gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 05:17:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9W7N-0005s0-T0
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 05:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386AbZE1DQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 23:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbZE1DQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 23:16:58 -0400
Received: from mail-qy0-f190.google.com ([209.85.221.190]:48947 "EHLO
	mail-qy0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbZE1DQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 23:16:57 -0400
Received: by mail-qy0-f190.google.com with SMTP id 28so5128155qyk.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 20:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2zbJDNNoZCCZ4pROQPiPYjbHSHgpaHtB0BhrpuBWWIk=;
        b=YKgwBwq+ws6dJnmhGB//gPCaIVfiV3aNjc7irG0lBgGyOdwGM8GLZZBxjUeY9PIcQ1
         gm9fACOYFAVCGmYeJPGMMvBN2zGY3DZXVjINbIxAAWaop/5hgUjOUbqur+kYjiW/fqT4
         rh/v30uUfB/p0nJ+8Op4S8Ypl3hlWl55oW0mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QlKP9sXyCqGE+VEI08u8SUfrkXAPYntlqE1Ax5O2xFkthxIIU37nsAXiXSpw+3ezj4
         siAjcKIDuDJyGO465Cn4CtQMQtsYwaJuVZ28iDSRibP63mp0Qmc4dwmiGp+QOWmAGTiv
         41S40RYeH6m+ng5pjYxUsk0HfgrQzW2h/I6Rc=
Received: by 10.224.32.145 with SMTP id c17mr977257qad.12.1243480619484;
        Wed, 27 May 2009 20:16:59 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 5sm680953qwg.29.2009.05.27.20.16.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 20:16:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120141>

Add a configuration option, http.sslCertNoPass, and associated
environment variable, GIT_SSL_CERT_NO_PASS, to allow disabling of the
SSL client certificate password prompt from within git.  If this option
is set to true, or if the environment variable exists, git falls back to
OpenSSL's prompts (as in earlier versions of git).

This option is useful in (at least) two cases:
1. The certificate is not encrypted and the user does not want to be
   prompted needlessly.
2. The user does not wish to leave the password in the clear in git's
   (and libcurl's) memory, in case the program crashes and core dumps.

The environment variable may only be used to disable, not to re-enable,
git's password prompt.  This behavior mimics GIT_NO_VERIFY; the mere
existence of the variable is all that is checked.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/config.txt |    9 +++++++++
 http.c                   |    9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2c03162..65c3ac5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1038,6 +1038,15 @@ http.sslKey::
 	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
 	variable.
 
+http.sslCertNoPass::
+	Disable git's password prompt for the SSL certificate.  OpenSSL
+	will still prompt the user, possibly many times, if the
+	certificate or private key is encrypted.  Useful if the
+	certificate is not encrypted (to disable the password prompt) or
+	if you do not wish to store the certificate password in git's
+	memory.  Can be overridden by the 'GIT_SSL_CERT_NO_PASS'
+	environment variable.
+
 http.sslCAInfo::
 	File containing the certificates to verify the peer with when
 	fetching or pushing over HTTPS. Can be overridden by the
diff --git a/http.c b/http.c
index 1fc3444..6ae59b6 100644
--- a/http.c
+++ b/http.c
@@ -131,6 +131,11 @@ static int http_options(const char *var, const char *value, void *cb)
 #endif
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_string(&ssl_cainfo, var, value);
+	if (!strcmp("http.sslcertnopass", var)) {
+		if (git_config_bool(var, value))
+			ssl_cert_password_required = -1;
+		return 0;
+	}
 #ifdef USE_CURL_MULTI
 	if (!strcmp("http.maxrequests", var)) {
 		max_requests = git_config_int(var, value);
@@ -359,7 +364,9 @@ void http_init(struct remote *remote)
 
 	if (remote && remote->url && remote->url[0]) {
 		http_auth_init(remote->url[0]);
-		if (!prefixcmp(remote->url[0], "https://"))
+		if (ssl_cert_password_required == 0 &&
+		    !getenv("GIT_SSL_CERT_NO_PASS") &&
+		    !prefixcmp(remote->url[0], "https://"))
 			ssl_cert_password_required = 1;
 	}
 
-- 
1.6.3.1
