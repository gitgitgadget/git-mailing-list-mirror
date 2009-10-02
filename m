From: Nicholas Miell <nmiell@gmail.com>
Subject: [PATCH] Use the best HTTP authentication method supported by the server
Date: Fri,  2 Oct 2009 12:04:46 -0700
Message-ID: <1254510286-23155-1-git-send-email-nmiell@gmail.com>
References: <25718488.post@talk.nabble.com>
Cc: git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>
To: gsky51@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 02 21:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtnR9-0004kZ-3m
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 21:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbZJBTEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 15:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZJBTEw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 15:04:52 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:39137 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbZJBTEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 15:04:51 -0400
Received: by pxi9 with SMTP id 9so1380245pxi.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=10ZQVPuK5PQWJw9wSmDFuQ9BgjOqCLUXs88D/I9Zwh4=;
        b=J3KYF+TSyE174FILfLeGU19Oyu4pzk8icdWZzVCSGa9tbMLnn89J1jmaEDbZn1p4SZ
         iZ9sRMdLS59eBreTV0q+wHdwm0Jq2LVjdPgPPW1bAdQIvKkpWsUYzltzHq+GSy3zEZQF
         KLotm68vbMbHSpsNWoSS8sRciY+1d3SPBQh8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZdLNUjn4D1JLJWVteotEERMeyugA2yKOngSuL7kzueX7tYvI2P12Sbv4sXKxGcjKvb
         cNNNKhJx6glaRZjcMo/fEY79KEkTYl/2a6HzIJQA1JM5hjxPjp6LqDoz3H4uCqKLR0hS
         f1oANkTgR9zdnHKpQXOx0MqeDCkfaKXMxVMfc=
Received: by 10.115.102.38 with SMTP id e38mr4098309wam.207.1254510295225;
        Fri, 02 Oct 2009 12:04:55 -0700 (PDT)
Received: from localhost.localdomain (c-98-247-100-230.hsd1.wa.comcast.net [98.247.100.230])
        by mx.google.com with ESMTPS id 23sm808640pzk.8.2009.10.02.12.04.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 12:04:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <25718488.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129455>

Currently, libcurl is limited to using HTTP Basic authentication if a
username and password are specified. HTTP Basic passes the username
and password to the server as plaintext, which is obviously
suboptimal. Furthermore, some servers are configured to require a more
secure authentication method (e.g. Digest or NTLM), which means that
git can't talk to them at all.

This is easily solved by telling libcurl to use any HTTP
authentication method it pleases. I leave the decision as to whether
HTTP Basic (i.e. completely insecure) should be allowed at all to
somebody else.  This can be easily changed in the future by using
CURLAUTH_ANYSAFE instead of CURLAUTH_ANY.

Signed-off-by: Nicholas Miell <nmiell@gmail.com>
---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

This passes make test; but I haven't actually tested it on a real
HTTP server.

diff --git a/http.c b/http.c
index 23b2a19..1937b45 100644
--- a/http.c
+++ b/http.c
@@ -185,6 +185,7 @@ static void init_curl_http_auth(CURL *result)
 		if (!user_pass)
 			user_pass = xstrdup(getpass("Password: "));
 		strbuf_addf(&up, "%s:%s", user_name, user_pass);
+		curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 		curl_easy_setopt(result, CURLOPT_USERPWD,
 				 strbuf_detach(&up, NULL));
 	}
-- 
1.6.2.5
