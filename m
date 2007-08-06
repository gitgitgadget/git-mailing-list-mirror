From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] setup.c:verify_non_filename(): don't die unnecessarily while disambiguating
Date: Mon, 06 Aug 2007 00:24:12 -0700
Message-ID: <7vk5s9dt2b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 09:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHwws-0004Xm-44
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 09:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbXHFHYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 03:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbXHFHYO
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 03:24:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34547 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbXHFHYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 03:24:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070806072411.ORXS7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 03:24:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YXQC1X0061kojtg0000000; Mon, 06 Aug 2007 03:24:12 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55118>

If you have a working tree _file_ "foo", attempt to refer to a
branch "foo/bar" without -- to disambiguate, like this:

	$ git log foo/bar

tried to make sure that foo/bar cannot be naming a working tree
file "foo/bar" (in which case we would say "which one do you
want?  A rev or a working tree file?  clarify with -- please").
We run lstat("foo/bar") to check that.  If it does not succeed,
there is no ambiguity.

That is good.  But we also checked the error status for the
lstat() and expected it to fail with ENOENT.  For this
particular case, however, it fails with ENOTDIR.  That one
should be treated as "expected error" as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This was from a real-life experience Shawn had.

 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index a45ea83..2b8e8c0 100644
--- a/setup.c
+++ b/setup.c
@@ -103,7 +103,7 @@ void verify_non_filename(const char *prefix, const char *arg)
 	if (!lstat(name, &st))
 		die("ambiguous argument '%s': both revision and filename\n"
 		    "Use '--' to separate filenames from revisions", arg);
-	if (errno != ENOENT)
+	if (errno != ENOENT && errno != ENOTDIR)
 		die("'%s': %s", arg, strerror(errno));
 }
 
-- 
1.5.3.rc4.15.ga2c3d
