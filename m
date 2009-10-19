From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Use faster byte swapping when compiling with MSVC
Date: Mon, 19 Oct 2009 18:37:05 +0200
Message-ID: <hbi4mt$tjt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 18:39:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzvGa-0001bG-CT
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 18:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694AbZJSQjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 12:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbZJSQjS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 12:39:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:55750 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbZJSQjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 12:39:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MzvGR-0001Wz-AC
	for git@vger.kernel.org; Mon, 19 Oct 2009 18:39:19 +0200
Received: from 91-64-214-160-dynip.superkabel.de ([91.64.214.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 18:39:19 +0200
Received: from sschuberth by 91-64-214-160-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 18:39:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-64-214-160-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130716>

When compiling with MSVC on x86-compatible, use an intrinsic for byte swapping.
In contrast to the GCC path, we do not prefer inline assembly here as it is not
supported for the x64 platform.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/bswap.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 5cc4acb..279e0b4 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -28,6 +28,16 @@ static inline uint32_t default_swab32(uint32_t val)
 	} \
 	__res; })
 
+#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
+
+#include <stdlib.h>
+
+#define bswap32(x) _byteswap_ulong(x)
+
+#endif
+
+#ifdef bswap32
+
 #undef ntohl
 #undef htonl
 #define ntohl(x) bswap32(x)
-- 
1.6.5.rc2.13.g1be2
