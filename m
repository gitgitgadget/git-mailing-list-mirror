From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT cannot import properly from stdin
Date: Thu, 22 Sep 2005 16:48:28 +0100
Message-ID: <tnxmzm514tv.fsf@arm.com>
References: <433107C7.60901@drzeus.cx>
	<b0943d9e05092101033dd5d366@mail.gmail.com>
	<433290A5.5070008@drzeus.cx> <tnxhdcd2tfn.fsf@arm.com>
	<4332BA3E.2080607@drzeus.cx> <tnxr7bh188q.fsf@arm.com>
	<4332C880.1060906@drzeus.cx>
	<b0943d9e050922084232f704d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 17:53:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EITKc-0003mZ-Rr
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 17:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVIVPtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 11:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbVIVPtv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 11:49:51 -0400
Received: from incsun1.losgatos.arm.com ([63.80.46.197]:50979 "EHLO
	incsun1.losgatos.arm.com") by vger.kernel.org with ESMTP
	id S1030413AbVIVPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 11:49:51 -0400
Received: from ASHWA.Asiapac.Arm.com (localhost [127.0.0.1])
	by incsun1.losgatos.arm.com (8.12.6/8.12.6) with ESMTP id j8MFnVd1009045;
	Thu, 22 Sep 2005 08:49:38 -0700 (PDT)
Received: from ZIPPY.Emea.Arm.com ([10.1.255.57]) by ASHWA.Asiapac.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 22 Sep 2005 21:19:26 +0530
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 22 Sep 2005 16:48:44 +0100
To: Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <b0943d9e050922084232f704d@mail.gmail.com> (Catalin Marinas's
 message of "Thu, 22 Sep 2005 16:42:28 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Sep 2005 15:48:44.0679 (UTC) FILETIME=[1CF13170:01C5BF8D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9130>

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> It works, thanks for this. I attached a patch if you want to try.

Oops, gmail attached it as a binary. It is inserted below (as
text/plain):

======================================================
Fix importing from stdin

The current stdin patch importing expects two EOFs since the 'for' loop
doesn't start before one EOF is received. As suggested, this patch changes
the 'for' loop with a 'while True' loop.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/imprt.py |    6 +++++-
 stgit/git.py            |    5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -134,7 +134,11 @@ def __parse_patch(filename = None):
     authname = authemail = authdate = None
 
     descr = ''
-    for line in f:
+    while True:
+        line = f.readline()
+        if not line:
+            break
+
         # the first 'Signed-of-by:' is the author
         if not authname and re.match('signed-off-by:\s+', line, re.I):
             auth = re.findall('^.*?:\s+(.*)$', line)[0]
diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -113,7 +113,10 @@ def get_conflicts():
 
 def _input(cmd, file_desc):
     p = popen2.Popen3(cmd)
-    for line in file_desc:
+    while True:
+        line = file_desc.readline()
+        if not line:
+            break
         p.tochild.write(line)
     p.tochild.close()
     if p.wait():
