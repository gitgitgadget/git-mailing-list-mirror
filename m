From: Sam Vilain <sam@vilain.net>
Subject: [stgit] [PATCH] common: parse 'email (name)' correctly
Date: Thu, 09 Mar 2006 18:29:58 +1300
Message-ID: <440FBD56.1040007@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 09 06:30:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHDj7-0008IA-FA
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 06:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWCIF37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 00:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWCIF37
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 00:29:59 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:39341 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750787AbWCIF36 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 00:29:58 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id B9DB269CC; Thu,  9 Mar 2006 18:29:55 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id D9AAA133E;
	Thu,  9 Mar 2006 18:29:49 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17398>

Currently only e-mails of the form "Name <email>" are accepted by
stgit import etc, however some people use "email (Name)".  Accept this
alternate form.
---
Note: the function just below it might need consideration, too.

 stgit/commands/common.py |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 2985379..4bfa4dd 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -175,12 +175,15 @@ def push_patches(patches, check_merged =
 
 def name_email(address):
     """Return a tuple consisting of the name and email parsed from a
-    standard 'name <email>' string
+    standard 'name <email>' or 'email (name)' string
     """
     address = re.sub('[\\\\"]', '\\\\\g<0>', address)
     str_list = re.findall('^(.*)\s*<(.*)>\s*$', address)
     if not str_list:
-        raise CmdException, 'Incorrect "name <email>" string: %s' % address
+        str_list = re.findall('^(.*)\s*\((.*)\)\s*$', address)
+        if not str_list:
+            raise CmdException, 'Incorrect "name <email>"/"email
(name)" string: %s' % address
+        return ( str_list[0][1], str_list[0][0] )
 
     return str_list[0]
