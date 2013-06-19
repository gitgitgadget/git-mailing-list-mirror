From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2] http.c: don't rewrite the user:passwd string multiple times
Date: Tue, 18 Jun 2013 19:43:49 -0700
Message-ID: <1371609829-31813-1-git-send-email-bcasey@nvidia.com>
References: <CA+sFfMcsOx14UdzLF_JsgkpUQU6yG7DE+00eA3d+Lo-qncDgew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gitster@pobox.com>, <peff@peff.net>, <daniel@haxx.se>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 04:44:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8Na-0008H8-8o
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934083Ab3FSCoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:44:09 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:6031 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933861Ab3FSCoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:44:08 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B51c11c940000>; Tue, 18 Jun 2013 19:51:00 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2013 19:42:17 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Tue, 18 Jun 2013 19:42:17 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.298.1; Tue, 18 Jun 2013
 19:43:51 -0700
X-Mailer: git-send-email 1.8.3.1.440.gc2bf105
In-Reply-To: <CA+sFfMcsOx14UdzLF_JsgkpUQU6yG7DE+00eA3d+Lo-qncDgew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228330>

From: Brandon Casey <drafnel@gmail.com>

Curl older than 7.17 (RHEL 4.X provides 7.12 and RHEL 5.X provides
7.15) requires that we manage any strings that we pass to it as
pointers.  So, we really shouldn't be modifying this strbuf after we
have passed it to curl.

Our interaction with curl is currently safe (before or after this
patch) since the pointer that is passed to curl is never invalidated;
it is repeatedly rewritten with the same sequence of characters but
the strbuf functions never need to allocate a larger string, so the
same memory buffer is reused.

This "guarantee" of safety is somewhat subtle and could be overlooked
by someone who may want to add a more complex handling of the username
and password.  So, let's stop modifying this strbuf after we have
passed it to curl, but also leave a note to describe the assumptions
that have been made about username/password lifetime and to draw
attention to the code.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 http.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 92aba59..2d086ae 100644
--- a/http.c
+++ b/http.c
@@ -228,9 +228,15 @@ static void init_curl_http_auth(CURL *result)
 #else
 	{
 		static struct strbuf up = STRBUF_INIT;
-		strbuf_reset(&up);
-		strbuf_addf(&up, "%s:%s",
-			    http_auth.username, http_auth.password);
+		/*
+		 * Note that we assume we only ever have a single set of
+		 * credentials in a given program run, so we do not have
+		 * to worry about updating this buffer, only setting its
+		 * initial value.
+		 */
+		if (!up.len)
+			strbuf_addf(&up, "%s:%s",
+				http_auth.username, http_auth.password);
 		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
 	}
 #endif
-- 
1.8.3.1.440.gc2bf105
