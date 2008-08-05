From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Optimize sha1_object_info for loose objects, not concurrent repacks
Date: Tue, 5 Aug 2008 13:08:41 -0700
Message-ID: <20080805200841.GA23121@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 22:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQSxM-0003sR-TL
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 22:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763633AbYHEUPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 16:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763643AbYHEUPY
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 16:15:24 -0400
Received: from tater.midwinter.com ([216.32.86.90]:44595 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763949AbYHEUPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 16:15:23 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Aug 2008 16:15:22 EDT
Received: (qmail 23279 invoked by uid 1001); 5 Aug 2008 20:08:41 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91459>

When dealing with a repository with lots of loose objects, sha1_object_info
would rescan the packs directory every time an unpacked object was referenced
before finally giving up and looking for the loose object. This caused a lot
of extra unnecessary system calls during git pack-objects; the code was
rereading the entire pack directory once for each loose object file.

This patch looks for a loose object before falling back to rescanning the
pack directory, rather than the other way around.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	I discovered this by running strace on a pack-objects that was
	taking especially long to run; it was making more system calls
	to scan the pack directory than to do stuff with the loose
	objects, which didn't seem right.

 sha1_file.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e281c14..32e4664 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1929,11 +1929,18 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
 	struct pack_entry e;
+	int status;
 
 	if (!find_pack_entry(sha1, &e, NULL)) {
+		/* Most likely it's a loose object. */
+		status = sha1_loose_object_info(sha1, sizep);
+		if (status >= 0)
+			return status;
+
+		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
 		if (!find_pack_entry(sha1, &e, NULL))
-			return sha1_loose_object_info(sha1, sizep);
+			return status;
 	}
 	return packed_object_info(e.p, e.offset, sizep);
 }
-- 
1.6.0.rc1.66.gc78d7
