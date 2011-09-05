From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH git] http: avoid empty error messages for some curl errors
Date: Mon, 5 Sep 2011 17:22:02 -0500
Message-ID: <20110905222202.GA32071@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 00:22:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0hYq-0005zf-GI
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 00:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab1IEWW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 18:22:29 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47820 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1IEWW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 18:22:28 -0400
Received: by gxk21 with SMTP id 21so3589018gxk.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=fY20WN/pqxFULBOzlHbNsPWwKIqRwOexTYe4PPBdPfU=;
        b=YyWva6NTj2lbMtBZ2KJXV9ArALAYnNy4ePfBpMJNszZkH9M9h/hRJ/8SydowwwBc5n
         +aYogV5jyPsIyeHYdGuhnDKhzyX/sBwqt3yXy64ctu+TaQrT4N1gdWxIjT2Opw0l7wMP
         nhO7FZK8csjDEOaXP/P/qMPRZ8Z3JJV6ovOoo=
Received: by 10.150.206.18 with SMTP id d18mr3159861ybg.352.1315261347624;
        Mon, 05 Sep 2011 15:22:27 -0700 (PDT)
Received: from elie (c-24-1-57-115.hsd1.il.comcast.net [24.1.57.115])
        by mx.google.com with ESMTPS id c1sm14591ybo.13.2011.09.05.15.22.25
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Sep 2011 15:22:26 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180764>

When asked to fetch over SSL without a valid
/etc/ssl/certs/ca-certificates.crt file, "git fetch" writes

	error:  while accessing https://github.com/torvalds/linux.git/info/refs

which is a little disconcerting.  Better to fall back to
curl_easy_strerror(result) when the error string is empty, like the
curl utility does:

	error: Problem with the SSL CA cert (path? access rights?) while
	accessing https://github.com/torvalds/linux.git/info/refs

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

I ran into this error today because this machine has no certs enabled.
I'm not thrilled with the following patch because the error string
buffer is not cleared very often so it seems possible for it to be
not empty but stale at the relevant moment.  I would be happier if we
could rely on libcurl always filling the error buffer on errors.

What do you think?
Jonathan

 http.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index a59cac45..dec3c60a 100644
--- a/http.c
+++ b/http.c
@@ -851,8 +851,13 @@ static int http_request(const char *url, void *result, int target, int options)
 				init_curl_http_auth(slot->curl);
 				ret = HTTP_REAUTH;
 			}
-		} else
+		} else {
+			if (!curl_errorstr[0])
+				strlcpy(curl_errorstr,
+					curl_easy_strerror(results.curl_result),
+					sizeof(curl_errorstr));
 			ret = HTTP_ERROR;
+		}
 	} else {
 		error("Unable to start HTTP request for %s", url);
 		ret = HTTP_START_FAILED;
-- 
1.7.6
