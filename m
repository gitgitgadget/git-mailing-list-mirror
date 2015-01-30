From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: [PATCH] Makefile: Handle broken curl version number in version check
Date: Fri, 30 Jan 2015 10:52:34 +0100
Message-ID: <1422611554-15393-1-git-send-email-tgc@statsbiblioteket.dk>
References: <54CA2E84.6090604@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 10:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YH8Fo-0004VH-60
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 10:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759898AbbA3Jwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 04:52:39 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:15654 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759885AbbA3Jwh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2015 04:52:37 -0500
Received: from throll.localdomain (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.348.2; Fri, 30 Jan 2015 10:52:34 +0100
Received: by throll.localdomain (Postfix, from userid 3000)	id 71B0740381E;
 Fri, 30 Jan 2015 10:52:34 +0100 (CET)
X-Mailer: git-send-email 2.2.2
In-Reply-To: <54CA2E84.6090604@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263173>

curl 7.11.0 through 7.12.2 when built from their official release
archives will present a 5 digit version number instead of the documented
6 digits which breaks the version check in the Makefile.
Correct these broken version numbers on the fly when extracting them to
ensure the comparison works correctly.

Signed-off-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
---

This was discoved while building on RHEL4 which has curl 7.12.1.
The makefile check for curl >= 7.34.0 failed and enabled
USE_CURL_FOR_IMAP_SEND.

# curl-config --vernum
70C01
# { echo 072200; curl-config --vernum 2>/dev/null ; } | sort -r | sed -ne 2p
072200
#

I checked the curl release tarballs and this problem seems to exist for
curl 7.11.0 (0x70B00) through 7.12.2 (0x70C02). In both 7.10.7 (0x070a07)
and 7.12.3 (0x070c03) the version is correctly set using 6 hex digits as
documented.
I tried to verify this using the official curl repo on github but it does
not seem to record this discrepancy and shows the correct 6 digit version
numbers for the affected releases.

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c44eb3a..69a2ce3 100644
--- a/Makefile
+++ b/Makefile
@@ -1035,13 +1035,13 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
+	curl_check := $(shell (echo 070908; curl-config --vernum | sed -e '/^70[B-C]/ s/^7/07/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
 			PROGRAM_OBJS += http-push.o
 		endif
 	endif
-	curl_check := $(shell (echo 072200; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
+	curl_check := $(shell (echo 072200; curl-config --vernum | sed -e '/^70[B-C]/ s/^7/07/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "072200"
 		USE_CURL_FOR_IMAP_SEND = YesPlease
 	endif
-- 
2.2.2
