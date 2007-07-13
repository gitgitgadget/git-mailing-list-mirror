From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Fri, 13 Jul 2007 14:56:00 +0200
Message-ID: <46977660.7070207@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Hausmann <simon@lst.de>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 13 14:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Kga-0002N7-VV
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 14:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997AbXGMMzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 08:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758674AbXGMMzp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 08:55:45 -0400
Received: from esparsett.troll.no ([62.70.27.18]:44916 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbXGMMzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 08:55:44 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 7B7AC741D8; Fri, 13 Jul 2007 14:55:42 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 6E68C741D2; Fri, 13 Jul 2007 14:55:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.4) Gecko/20070604 Thunderbird/2.0.0.4 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.2
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52389>

 From 255ec32feb7525db8eef582eeed2b6e60be35ed8 Mon Sep 17 00:00:00 2001
From: Marius Storm-Olsen <marius@trolltech.com>
Date: Fri, 13 Jul 2007 14:39:05 +0200
Subject: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf 
function.

Add condition for Windows, since it doesn't support the os.sysconf module.
We hardcode the commandline limit to 2K, as that should work on most 
Windows platforms.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
  contrib/fast-import/git-p4 |    6 +++++-
  1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 54a05eb..746e0ca 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -717,7 +717,11 @@ class P4Sync(Command):
          # POSIX says it's 4096 bytes, default for Linux seems to be 
130 K.
          # and all OS from the table below seems to be higher than POSIX.
          # See http://www.in-ulm.de/~mascheck/various/argmax/
-        argmax = min(4000, os.sysconf('SC_ARG_MAX'))
+        if (self.isWindows):
+            argmax = 2000
+        else:
+            argmax = min(4000, os.sysconf('SC_ARG_MAX'))
+
          chunk = ''
          filedata = []
          for i in xrange(len(files)):
-- 
1.5.2-GUB
