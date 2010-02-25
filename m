From: Filippo Negroni <fnegroni@flexerasoftware.com>
Subject: compat/mkdtemp.c: patch for gitmkdtemp() compatibility implementation
Date: Thu, 25 Feb 2010 09:01:12 +0000
Message-ID: <4B863C58.7010105@flexerasoftware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------060302010905080000050204"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 10:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkZpe-0007rG-Eq
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 10:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab0BYJQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 04:16:25 -0500
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:18691 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab0BYJQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 04:16:24 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2010 04:16:24 EST
Received: from mail121-tx2-R.bigfish.com (10.9.14.236) by
 TX2EHSOBE002.bigfish.com (10.9.40.22) with Microsoft SMTP Server id
 8.1.240.5; Thu, 25 Feb 2010 09:01:17 +0000
Received: from mail121-tx2 (localhost [127.0.0.1])	by
 mail121-tx2-R.bigfish.com (Postfix) with ESMTP id AC5774684FC;	Thu, 25 Feb
 2010 09:01:17 +0000 (UTC)
X-SpamScore: 4
X-BigFish: VPS4(zba6lzzz1202hzzz2dh6bh43h61h)
X-Spam-TCS-SCL: 0:0
Received: from mail121-tx2 (localhost.localdomain [127.0.0.1]) by mail121-tx2
 (MessageSwitch) id 1267088477144379_26849; Thu, 25 Feb 2010 09:01:17 +0000
 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.236])	by
 mail121-tx2.bigfish.com (Postfix) with ESMTP id 1FA251090050;	Thu, 25 Feb
 2010 09:01:17 +0000 (UTC)
Received: from schexch.acresso.com (64.244.204.10) by TX2EHSMHS005.bigfish.com
 (10.9.99.105) with Microsoft SMTP Server id 14.0.482.39; Thu, 25 Feb 2010
 09:01:14 +0000
Received: from mhexch.acresso.com ([10.41.0.8]) by schexch.acresso.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 25 Feb 2010 03:01:14 -0600
Received: from [10.41.10.67] ([10.41.10.67]) by mhexch.acresso.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Thu, 25 Feb 2010 09:01:12 +0000
User-Agent: Thunderbird 2.0.0.23 (X11/20090820)
X-OriginalArrivalTime: 25 Feb 2010 09:01:12.0431 (UTC) FILETIME=[1439FFF0:01CAB5F9]
X-Reverse-DNS: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141037>

--------------060302010905080000050204
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

I noticed that the current implementation of mkdtemp() in the compat/ directory does not seem to be correct.

gitmkdtemp() is needed for platforms such as Solaris 9 and 10 which do not implement mkdtemp().

The current implementation (compat/mkdtemp.c):

----
char *gitmkdtemp(char *template)
{
        if (!mktemp(template) || mkdir(template, 0700))
                return NULL;
        return template;
}
----

seems to be testing the return value of mktemp incorrectly.

mktemp() always returns the argument 'template', even on failure.

This is an extract from Solaris's mktemp(2) manual page:

RETURN VALUES
     The mktemp() function will  assign  to  template  the  empty
     string if it  cannot create a unique name.

Upon failure, 'template' is set to an empty string, i.e., it's first character is '\0'.

The fixed implementation should read:

----
char *gitmkdtemp(char *template)
{
        if (!*mktemp(template) || mkdir(template, 0700))
                return NULL;
        return template;
}
----

I.e., simply add the pointer dereference operator when calling mktemp().

I have attached a patch against the most current git repo, branch master.

Please let me know if you need the patch in any other way.

--------------060302010905080000050204
Content-Type: text/plain;
	name="0001-Fixed-return-value-check-for-mkdtemp-implementation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-Fixed-return-value-check-for-mkdtemp-implementation.pat";
	filename*1="ch"

>From 00b2a96d93d801d06eb710bc03b3e4804d3583ec Mon Sep 17 00:00:00 2001
From: Filippo Negroni <fnegroni@flexerasoftware.com>
Date: Thu, 25 Feb 2010 08:39:35 +0000
Subject: [PATCH] Fixed return value check for mkdtemp implementation.

mktemp() returns an 'empty' string, not a NULL pointer.
---
 compat/mkdtemp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
index 34d4b49..1136119 100644
--- a/compat/mkdtemp.c
+++ b/compat/mkdtemp.c
@@ -2,7 +2,7 @@
 
 char *gitmkdtemp(char *template)
 {
-	if (!mktemp(template) || mkdir(template, 0700))
+	if (!*mktemp(template) || mkdir(template, 0700))
 		return NULL;
 	return template;
 }
-- 
1.6.4


--------------060302010905080000050204--
