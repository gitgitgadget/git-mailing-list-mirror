From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] http.c: don't rewrite the user:passwd string multiple times
Date: Mon, 17 Jun 2013 19:00:40 -0700
Message-ID: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <peff@peff.net>, <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 04:13:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolQ2-0004E1-AA
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab3FRCM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 22:12:56 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:16719 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab3FRCMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:12:55 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B51bfc0fb0000>; Mon, 17 Jun 2013 19:07:55 -0700
Received: from hqemhub03.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2013 19:00:48 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 17 Jun 2013 19:00:48 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.298.1; Mon, 17 Jun 2013
 19:00:47 -0700
X-Mailer: git-send-email 1.8.3.1.440.gc2bf105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228129>

From: Brandon Casey <drafnel@gmail.com>

Curl requires that we manage any strings that we pass to it as pointers.
So, we should not be overwriting this strbuf after we've passed it to
curl.

Additionally, it is unnecessary since we only prompt for the user name
and password once, so we end up overwriting the strbuf with the same
sequence of characters each time.  This is why in practice it has not
caused any problems for git's use of curl; the internal strbuf char
pointer does not change, and get's overwritten with the same string
each time.

But it's unnecessary and potentially dangerous, so let's avoid it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 92aba59..6828269 100644
--- a/http.c
+++ b/http.c
@@ -228,8 +228,8 @@ static void init_curl_http_auth(CURL *result)
 #else
 	{
 		static struct strbuf up = STRBUF_INIT;
-		strbuf_reset(&up);
-		strbuf_addf(&up, "%s:%s",
+		if (!up.len)
+			strbuf_addf(&up, "%s:%s",
 			    http_auth.username, http_auth.password);
 		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
 	}
-- 
1.8.3.1.440.gc2bf105
