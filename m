From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas
 XPG6
Date: Sat, 23 May 2009 12:24:56 -0700
Message-ID: <1243106697-6424-2-git-send-email-gitster@pobox.com>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wqp-0002Cd-FB
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545AbZEWTZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756386AbZEWTZD
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:25:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756091AbZEWTY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A6D2AB56C0
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:25:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 131DAB56BE for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106697-6424-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 689B4024-47CF-11DE-BAA1-F6BA321C86B1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119798>

In git-compat-util.h, we do

    #define _XOPEN_SOURCE 600
    #define _XOPEN_SOURCE_EXTENDED 1

unless we are on BSD or SCO.

On OpenSolaris (200811), /usr/include/sys/feature_tests.h has this nice
table:

    Feature Test Macro				     Specification
    ------------------------------------------------  -------------
    _XOPEN_SOURCE                                         XPG3
    _XOPEN_SOURCE && _XOPEN_VERSION = 4                   XPG4
    _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED = 1           XPG4v2
    _XOPEN_SOURCE = 500                                   XPG5
    _XOPEN_SOURCE = 600  (or POSIX_C_SOURCE=200112L)      XPG6

Later in the same header, compilation with -c99 is made to fail if _XPG6 is
not set, like this:

    #if defined(_STDC_C99) && (defined(__XOPEN_OR_POSIX) && !defined(_XPG6))
    #error "Compiler or options invalid for pre-UNIX 03 X/Open applications \
            and pre-2001 POSIX applications"
    #elif ...

The problem is that they check things in an order that is inconvenient for
us.  When they see _XOPEN_SOURCE_EXTENDED, they declare that we are XPG4v2,
regardless of the value of _XOPEN_SOURCE.

To work around this problem, do not define _XOPEN_SOURCE_EXTENDED on
Sun's.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index c7cf2d5..4236647 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -41,8 +41,10 @@
 
 #if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#ifndef __sun__
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
+#endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
-- 
1.6.3.1.145.gb74d77
