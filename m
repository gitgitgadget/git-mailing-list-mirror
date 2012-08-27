From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] t/lib-httpd: recognize */smart/* repos as smart-http
Date: Mon, 27 Aug 2012 09:25:21 -0400
Message-ID: <20120827132521.GD17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:25:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zJq-0001jp-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446Ab2H0NZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:25:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39697 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab2H0NZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:25:24 -0400
Received: (qmail 12848 invoked by uid 107); 27 Aug 2012 13:25:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:25:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:25:21 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204337>

We do not currently test authentication for smart-http repos
at all. Part of the infrastructure to do this is recognizing
that auth/smart is indeed a smart-http repo.

The current apache config recognizes only "^/smart/*" as
smart-http. Let's instead treat anything with /smart/ in the
URL as smart-http. This is obviously a stupid thing to do
for a real production site, but for our test suite we know
that our repositories will not have this magic string in the
name.

Note that we will route /foo/smart/bar.git directly to
git-http-backend/bar.git; in other words, everything before
the "/smart/" is irrelevant to finding the repo on disk (but
may impact apache config, for example by triggering auth
checks).

Signed-off-by: Jeff King <peff@peff.net>
---
Another backporting gotcha: the smart_custom_env bits did not exist back
in the v1.7.8 era.

 t/lib-httpd/apache.conf | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index d13fe64..c6a1a87 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -48,22 +48,20 @@ PassEnv GIT_VALGRIND_OPTIONS
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
 
-<Location /smart/>
+<LocationMatch /smart/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
-</Location>
-<Location /smart_noexport/>
+</LocationMatch>
+<LocationMatch /smart_noexport/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
-</Location>
-<Location /smart_custom_env/>
+</LocationMatch>
+<LocationMatch /smart_custom_env/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 	SetEnv GIT_COMMITTER_NAME "Custom User"
 	SetEnv GIT_COMMITTER_EMAIL custom@example.com
-</Location>
-ScriptAlias /smart/ ${GIT_EXEC_PATH}/git-http-backend/
-ScriptAlias /smart_noexport/ ${GIT_EXEC_PATH}/git-http-backend/
-ScriptAlias /smart_custom_env/ ${GIT_EXEC_PATH}/git-http-backend/
+</LocationMatch>
+ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
-- 
1.7.11.5.10.g3c8125b
