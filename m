From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 6/6] sparse: Fix some "using sizeof on a function" warnings
Date: Sun, 06 Oct 2013 21:52:21 +0100
Message-ID: <5251CD85.9030307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 22:52:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvJa-0007Yk-9s
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 22:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab3JFUwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 16:52:25 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:38375 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754745Ab3JFUwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 16:52:23 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 142076FB5A5;
	Sun,  6 Oct 2013 21:52:23 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id D88AC6FB3C1;
	Sun,  6 Oct 2013 21:52:22 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun,  6 Oct 2013 21:52:22 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235750>


Sparse issues an "using sizeof on a function" warning for each
call to curl_easy_setopt() which sets an option that takes a
function pointer parameter. (currently 12 such warnings over 4
files.)

The warnings relate to the use of the "typecheck-gcc.h" header
file which adds a layer of type-checking macros to the curl
function invocations (for gcc >= 4.3 and !__cplusplus). As part
of the type-checking layer, 'sizeof' is applied to the function
parameter of curl_easy_setopt(). Note that, in the context of
sizeof, the function to function pointer conversion is not
performed and that sizeof(f) != sizeof(&f).

A simple solution, therefore, would be to replace the function
name in each such call to curl_easy_setopt() with an explicit
function pointer expression (i.e. replace f with &f).

However, the "typecheck-gcc.h" header file is only conditionally
included, in addition to the gcc and C++ checks mentioned above,
depending on the CURL_DISABLE_TYPECHECK preprocessor variable.

In order to suppress the warnings, we use target-specific variable
assignments to add -DCURL_DISABLE_TYPECHECK to SPARSE_FLAGS for
each file affected (http-push.c, http.c, http-walker.c and
remote-curl.c).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index de3d72c..4fde227 100644
--- a/Makefile
+++ b/Makefile
@@ -2018,6 +2018,9 @@ gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
 
+http-push.sp http.sp http-walker.sp remote-curl.sp: SPARSE_FLAGS += \
+	-DCURL_DISABLE_TYPECHECK
+
 ifdef NO_EXPAT
 http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
 endif
-- 
1.8.4
