From: Jeff King <peff@peff.net>
Subject: [PATCH 02/14] http: turn off curl signals
Date: Thu, 10 Nov 2011 02:48:03 -0500
Message-ID: <20111110074803.GB27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:48:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPMq-0002ME-Uv
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab1KJHsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:48:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38909
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757403Ab1KJHsG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:48:06 -0500
Received: (qmail 22175 invoked by uid 107); 10 Nov 2011 07:48:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:48:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:48:03 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185199>

Curl sets and clears the handler for SIGALRM, which makes it
incompatible with git's progress code. However, we can ask
curl not to do this.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm a little iffy on this one. If I understand correctly, depending on
the build and configuration, curl may not be able to timeout during DNS
lookups. But I'm not sure if it does, anyway, since we don't set any
timeouts.

An alternate plan would be to give the progress code a mode where it
gets poked by curl every second or so (curl has a PROGRESSFUNCTION
option for doing this).

 http.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 95c2dfd..4f9e004 100644
--- a/http.c
+++ b/http.c
@@ -318,6 +318,8 @@ static int has_cert_password(void)
 	if (curl_http_proxy)
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 
+	curl_easy_setopt(result, CURLOPT_NOSIGNAL, 1);
+
 	return result;
 }
 
-- 
1.7.7.2.7.g9f96f
