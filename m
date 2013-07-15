From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v5 2/5] http.c: fix parsing of GIT_SSL_CERT_PASSWORD_PROTECTED variable
Date: Mon, 15 Jul 2013 02:50:59 -0700
Message-ID: <41e6c55e7d5ad8bcae6db7d53c846f3@f74d39fa044aa309eaea14b9f57fe79>
References: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfRH-0006b8-Of
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab3GOJvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:51:19 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37463 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3GOJvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:51:16 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so10960518pab.36
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v6PiLl4aiSy73y7tQu8dOpGhBydl9tcK0EnC3nJPh9c=;
        b=qlTKWZU5KJnHNdWB6A1mTqVbYFN+KYfwhTMrGHIvQN0CVxcFqN/4G+jAo0c3KiEPVY
         F+41oQwJ2SLNy9tYozFrwLZKoedVAUm4vYCUQnIUwbu+cyqdFDIUjLepuxEgVxzmiGuQ
         85ViNWnd40WTPxResqgjyeDOY6SNqrmjoXeinLdsXKopQwJTwkv6ZwYD1fWVvx+PpKaf
         Dydh9tT3bnIsjN1iJLkMa43gatX/9+ihvp5XJ/WK65m3cA7Z4ilAOWbzXKsjA7rRuIZr
         1l6OEkIuvH9TLQDXUPU1MwCELitQ/uLwgJl8basgjn8QleT1hS+ab5EkcKA0OvgDAbCg
         CDYw==
X-Received: by 10.67.10.163 with SMTP id eb3mr38381637pad.70.1373881875672;
        Mon, 15 Jul 2013 02:51:15 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wr9sm60041274pbc.7.2013.07.15.02.51.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:51:15 -0700 (PDT)
In-Reply-To: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230451>

The existing code triggers whenever GIT_SSL_CERT_PASSWORD_PROTECTED
is defined.  Setting GIT_SSL_CERT_PASSWORD_PROTECTED to a false
value could not be used to override the http.sslCertPasswordProtected
setting once it had been turned on.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 http.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index e65661e..9542a59 100644
--- a/http.c
+++ b/http.c
@@ -403,11 +403,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ftp_no_epsv = 1;
 
 	if (url) {
+		int pwdreq = git_env_bool("GIT_SSL_CERT_PASSWORD_PROTECTED", -1);
 		credential_from_url(&http_auth, url);
-		if (!ssl_cert_password_required &&
-		    getenv("GIT_SSL_CERT_PASSWORD_PROTECTED") &&
-		    !prefixcmp(url, "https://"))
-			ssl_cert_password_required = 1;
+		if (pwdreq != -1 && !prefixcmp(url, "https://"))
+			ssl_cert_password_required = pwdreq;
 	}
 
 #ifndef NO_CURL_EASY_DUPHANDLE
-- 
1.8.3
