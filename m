From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] makefile: hide stderr of curl-config test
Date: Wed, 21 Nov 2012 22:19:57 -0500
Message-ID: <1353554397-27162-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 22:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbeTZ-0005qc-7v
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 22:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372Ab2KVViG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 16:38:06 -0500
Received: from mail.windriver.com ([147.11.1.11]:50779 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab2KVViD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 16:38:03 -0500
Received: from yow-pgortmak-d1.corp.ad.wrs.com (yow-pgortmak-d1.wrs.com [128.224.146.65])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id qAM3K4kh027029;
	Wed, 21 Nov 2012 19:20:04 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210213>

Currently, if you don't have curl installed, you will get

    $ make distclean 2>&1 | grep curl
    /bin/sh: curl-config: not found
    /bin/sh: curl-config: not found
    /bin/sh: curl-config: not found
    /bin/sh: curl-config: not found
    /bin/sh: curl-config: not found
    $

The intent is not to alarm the user, but just to test if there is
a new enough curl installed.  However, if you look at search engine
suggested completions, the above "error" messages are confusing
people into thinking curl is a hard requirement.

This test dates back 7+ years to:

 ---------------------
  commit 0890098780f295f2a58658d1f6b6627e40426c72
  Author: Nick Hengeveld <nickh@reactrix.com>
  Date:   Fri Nov 18 17:08:36 2005 -0800

    Decide whether to build http-push in the Makefile
 ---------------------

It wants to ensure curl is newer than 070908.  The oldest
machine I could find (RHEL 4.6) is 2007 vintage according
to /proc/version data, and it has curl 070C01.

The failure here is to mask stderr in the test.  However, since
the chance of curl being installed, but too old is essentially
nil, lets just check for existence and drop the ancient version
threshold check, if for no other reason, than to simplifly the
parsing of what the makefile is trying to do by humans.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/Makefile b/Makefile
index 9bc5e40..56f55f6 100644
--- a/Makefile
+++ b/Makefile
@@ -1573,8 +1573,8 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "070908"
+	curl_check := $(shell curl-config --vernum 2>/dev/null)
+	ifneq "$(curl_check)" ""
 		ifndef NO_EXPAT
 			PROGRAM_OBJS += http-push.o
 		endif
-- 
1.8.0
