From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/1] configure.ac: detect ssl need with libcurl
Date: Thu, 24 Sep 2015 21:14:00 +0200
Message-ID: <1443122040-14189-1-git-send-email-repk@triplefau.lt>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bdwalton@gmail.com>, <jnareb@gmail.com>,
	Remi Pommarel <repk@triplefau.lt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 21:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfByM-0005qG-31
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 21:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbbIXTOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 15:14:09 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47248 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbIXTOF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 15:14:05 -0400
Received: from mfilter27-d.gandi.net (mfilter27-d.gandi.net [217.70.178.155])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 15B04FB89F;
	Thu, 24 Sep 2015 21:14:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter27-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter27-d.gandi.net (mfilter27-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id vScuMh_qaPDU; Thu, 24 Sep 2015 21:14:02 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4F296FB886;
	Thu, 24 Sep 2015 21:14:02 +0200 (CEST)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278554>

When libcurl has been statically compiled with openssl support they both
need to be linked in everytime libcurl is used.

During configuration this can be detected by looking for Curl_ssl_init
function symbol in libcurl, which will only be present if libcurl has been
compiled statically built with openssl.

configure.ac checks for Curl_ssl_init function in libcurl and if such function
exists; it sets NEEDS_SSL_WITH_CURL that is used by the Makefile to include
-lssl alongside with -lcurl.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 configure.ac | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index 14012fa..39837c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -521,6 +521,16 @@ AC_CHECK_LIB([curl], [curl_global_init],
 [NO_CURL=],
 [NO_CURL=YesPlease])
 
+if test -z "${NO_CURL}" && test -z "${NO_OPENSSL}"; then
+
+AC_CHECK_LIB([curl], [Curl_ssl_init],
+[NEEDS_SSL_WITH_CURL=YesPlease],
+[NEEDS_SSL_WITH_CURL=])
+
+GIT_CONF_SUBST([NEEDS_SSL_WITH_CURL])
+
+fi
+
 GIT_UNSTASH_FLAGS($CURLDIR)
 
 GIT_CONF_SUBST([NO_CURL])
-- 
2.0.1
