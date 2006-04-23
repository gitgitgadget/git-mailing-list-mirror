From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make update-index --chmod work with multiple files and --stdin
Date: Sun, 23 Apr 2006 09:08:43 +0200
Message-ID: <20060423070843.GB5802@steel.home>
References: <20060422204642.GA7676@steel.home> <7v1wvpi010.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 23 09:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXYiE-00068r-46
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 09:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWDWHIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 03:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDWHIq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 03:08:46 -0400
Received: from devrace.com ([198.63.210.113]:11524 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751361AbWDWHIp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Apr 2006 03:08:45 -0400
Received: from tigra.home (p54A074BC.dip.t-dialin.net [84.160.116.188])
	by devrace.com (Postfix) with ESMTP id A3E0E357;
	Sun, 23 Apr 2006 02:08:47 -0500 (CDT)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FXYi3-0006wF-00; Sun, 23 Apr 2006 09:08:43 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FXYi3-0003RC-EE; Sun, 23 Apr 2006 09:08:43 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wvpi010.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19067>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Junio C Hamano, Sun, Apr 23, 2006 02:54:51 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > I had a project where lots of files were "accidentally" marked +x, and
> > doing plain "git-update-index --chmod=-x" for each file was too slow.
> > Besides, it's somewhat inconsistent, that --chmod does work only for
> > one subsequent file.
> 
> If you are doing that on the command line, people may want to
> have a way to mean "from here on do not do chmod, just do normal
> update-index and nothing else" by resetting the chmod_mode thing
> back to zero.  Nothing major, and we do not do that to allow_add
> and allow_remove either, but just a thought.

I am unsure about this. I'm even attaching instead of inlining the
patches, to make it clear how unsure I am :)

I have a feeling that it's more understandable to just use two
separate commands. Besides, the reset switch makes it impossible to
use pathname disambiguation ("--"). Unsure...


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-git-update-index-no-chmod.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Sun Apr 23 08:38:04 2006 +0200
Subject: git-update-index --no-chmod

Message-ID: <7v1wvpi010.fsf@assigned-by-dhcp.cox.net>

Alex Riesen <raa.lkml@gmail.com> writes:

> I had a project where lots of files were "accidentally" marked +x, and
> doing plain "git-update-index --chmod=-x" for each file was too slow.
> Besides, it's somewhat inconsistent, that --chmod does work only for
> one subsequent file.

If you are doing that on the command line, people may want to
have a way to mean "from here on do not do chmod, just do normal
update-index and nothing else" by resetting the chmod_mode thing
back to zero.  Nothing major, and we do not do that to allow_add
and allow_remove either, but just a thought.

---

 update-index.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

2972ef33fa4b04f07d4f4dbb9e13d5b9b2d593b4
diff --git a/update-index.c b/update-index.c
index a8582ea..1ed36fa 100644
--- a/update-index.c
+++ b/update-index.c
@@ -551,6 +551,10 @@ int main(int argc, const char **argv)
 				set_executable_bit = path[8];
 				continue;
 			}
+			if (!strcmp(path, "--no-chmod")) {
+				set_executable_bit = 0;
+				continue;
+			}
 			if (!strcmp(path, "--assume-unchanged")) {
 				mark_valid_only = MARK_VALID;
 				continue;
-- 
1.3.0.gc2941


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0003-git-update-index-add-no-add-and-no-remove.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Sun Apr 23 08:43:42 2006 +0200
Subject: git-update-index: add --no-add and --no-remove

Message-ID: <7v1wvpi010.fsf@assigned-by-dhcp.cox.net>

Alex Riesen <raa.lkml@gmail.com> writes:

> I had a project where lots of files were "accidentally" marked +x, and
> doing plain "git-update-index --chmod=-x" for each file was too slow.
> Besides, it's somewhat inconsistent, that --chmod does work only for
> one subsequent file.

If you are doing that on the command line, people may want to
have a way to mean "from here on do not do chmod, just do normal
update-index and nothing else" by resetting the chmod_mode thing
back to zero.  Nothing major, and we do not do that to allow_add
and allow_remove either, but just a thought.

---

 update-index.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

89bceee48996f366a779b0c95ba230ec24fea340
diff --git a/update-index.c b/update-index.c
index 1ed36fa..cbee859 100644
--- a/update-index.c
+++ b/update-index.c
@@ -509,6 +509,10 @@ int main(int argc, const char **argv)
 				allow_add = 1;
 				continue;
 			}
+			if (!strcmp(path, "--no-add")) {
+				allow_add = 0;
+				continue;
+			}
 			if (!strcmp(path, "--replace")) {
 				allow_replace = 1;
 				continue;
@@ -517,6 +521,10 @@ int main(int argc, const char **argv)
 				allow_remove = 1;
 				continue;
 			}
+			if (!strcmp(path, "--no-remove")) {
+				allow_remove = 0;
+				continue;
+			}
 			if (!strcmp(path, "--unmerged")) {
 				allow_unmerged = 1;
 				continue;
-- 
1.3.0.gc2941


--wRRV7LY7NUeQGEoC--
