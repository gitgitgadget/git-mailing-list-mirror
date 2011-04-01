From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] index-pack: Create .keep files with same permissions and
 .pack/.idx
Date: Fri, 01 Apr 2011 03:29:05 +0200
Message-ID: <201104010329.05299.johan@herland.net>
References: <201103311246.25645.johan@herland.net>
 <20110331190429.GC16981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 03:29:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5TAs-0000KL-NQ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 03:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab1DAB3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 21:29:12 -0400
Received: from smtp.getmail.no ([84.208.15.66]:36142 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab1DAB3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 21:29:11 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIY000KG9GJVV60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 01 Apr 2011 03:29:07 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3215D1EA563D_D952A63B	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 01:29:07 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 83B431EA27AD_D952A62F	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 01:29:06 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIY00GXH9GIRC20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 01 Apr 2011 03:29:06 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <20110331190429.GC16981@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170544>

While pushing to a remote repo, Git transiently adds a .keep file for the
pack being pushed, to protect it from a concurrent "git gc". However, the
permissions on this .keep file are such that if a different user attempts
a local cross-filesystem clone ("git clone --no-hardlinks") on the server
while the .keep file is present (either because of a concurrent push, or
because of a prior failed push that left a stale .keep file), the clone
will fail because the second user cannot access the .keep file created by
the first user.

There's no reason why the permission mode of a .keep file should be any
different from the permission mode of the corresponding .pack/.idx files.
Therefore, adjust the permission of .keep files from 0600 to 0444 modulo
the shared_repository setting.

In the above scenario, the .keep file is now accessible to the second user,
and will not prevent the clone.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Thursday 31 March 2011, Jeff King wrote:
> On Thu, Mar 31, 2011 at 12:46:25PM +0200, Johan Herland wrote:
> > 1. Why does the .keep file have 0600 permissions (preventing a local
> >    clone by any other user)
> 
> The relevant code is in 6e180cd (Make sure objects/pack exists before
> creating a new pack, 2009-02-24). I don't see anything particular about
> the mode, so I suspect it was simply habit to make tempfiles restricted.
> 
> There is nothing secret in the contents, so I don't see any reason to
> loosen it to the same permissions as the packfiles themselves.

This patch attempts to fix the permissions on .keep files.


...Johan


 builtin/index-pack.c |    9 ++++++---
 environment.c        |    4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5a67c81..586c9ac 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -792,10 +792,11 @@ static void final(const char *final_pack_name, const char 
*curr_pack_name,
 	if (keep_msg) {
 		int keep_fd, keep_msg_len = strlen(keep_msg);
 
-		if (!keep_name)
+		if (!keep_name) {
 			keep_fd = odb_pack_keep(name, sizeof(name), sha1);
-		else
-			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+			keep_name = name;
+		} else
+			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0444);
 
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
@@ -811,6 +812,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				    keep_name);
 			report = "keep";
 		}
+		if (adjust_shared_perm(keep_name))
+			error("unable to set permission to '%s'", keep_name);
 	}
 
 	if (final_pack_name != curr_pack_name) {
diff --git a/environment.c b/environment.c
index f4549d3..86bf8f4 100644
--- a/environment.c
+++ b/environment.c
@@ -191,13 +191,13 @@ int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
 
 	snprintf(name, namesz, "%s/pack/pack-%s.keep",
 		 get_object_directory(), sha1_to_hex(sha1));
-	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0444);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
 	safe_create_leading_directories(name);
-	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	return open(name, O_RDWR|O_CREAT|O_EXCL, 0444);
 }
 
 char *get_index_file(void)
-- 
1.7.4
