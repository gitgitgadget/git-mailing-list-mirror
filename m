From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] fmt-merge-msg.c: Fix an "dubious one-bit signed bitfield"
 sparse error
Date: Sat, 15 Oct 2011 18:46:59 +0100
Message-ID: <4E99C713.4090802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 19:51:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF8OU-0000hn-OJ
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 19:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab1JORva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 13:51:30 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:48082 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753841Ab1JORv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 13:51:29 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1RF8ON-0006Rg-id; Sat, 15 Oct 2011 17:51:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183670>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This was originally part of the patch I sent last week (applied to next
as commit 273c7032 - environment.c: Fix an sparse "symbol not declared" warning,
09-10-2011), since they both blame to commit 898eacd8 (fmt-merge-msg: use 
branch.$name.description, 06-10-2011).

However, sparse only issued this particular error on Linux, and not cygwin
or MinGW, so I decided to remove this part of the patch until I could
investigate further.

So, I had a look this afternoon and, *literally*, after no more than a
minute I realized why that is ... *blush*. Well, it may already be obvious,
that the Makefile has -Wno-one-bit-signed-bitfield set in the SPARSE_FLAGS
for cygwin and MinGW! *ahem* :-P  (now, who could have done that!)

This was mainly for the benefit of MinGW, since it otherwise issues 558 errors
(2 * 279 compilations); cygwin only results in 2 errors as follows:

        SP compat/cygwin.c
    /usr/include/w32api/winuser.h:3083:28: error: dubious one-bit signed bitfield
    /usr/include/w32api/winuser.h:3084:25: error: dubious one-bit signed bitfield

since only compat/cygwin.c, indirectly, includes that win32 header file.

Unfortunately, you can't tell sparse not to issue errors/warnings for system
header files. I could have lived with just the two errors on cygwin, but I wanted
at least one platform to be free of sparse errors/warnings. I remember thinking
that it would be OK to turn the messages off because I would notice them on
Linux anyway! Ha! :-P

BTW, t7800-difftool.sh fails for me on the next branch; I haven't investigated yet.

ATB,
Ramsay Jones

 builtin/fmt-merge-msg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 255a50f..7da6ff6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -37,7 +37,7 @@ struct src_data {
 
 struct origin_data {
 	unsigned char sha1[20];
-	int is_local_branch:1;
+	unsigned int is_local_branch:1;
 };
 
 static void init_src_data(struct src_data *data)
-- 
1.7.7
