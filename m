From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't ignore a low-probability ref-pack write failure
Date: Sun, 24 Jun 2007 21:13:11 +0200
Message-ID: <87d4zlyxmg.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 21:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2XWN-0000Ff-81
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 21:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbXFXTNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 15:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbXFXTNN
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 15:13:13 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47262 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbXFXTNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 15:13:13 -0400
X-Greylist: delayed 100767 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jun 2007 15:13:13 EDT
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CF67C5A28E
	for <git@vger.kernel.org>; Sun, 24 Jun 2007 21:13:11 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9B53726108; Sun, 24 Jun 2007 21:13:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50811>

Without this, if the size of refs_file at that point is ever an exact
multiple of BUFSIZ, then an EIO or ENOSPC error on the final write would
not be diagnosed.

It's not worth worrying about EPIPE here.
Although theoretically possible that someone kill this process
with a manual SIGPIPE, it's not at all likely.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-pack-refs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 1952950..7584992 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -105,6 +105,8 @@ static int pack_refs(unsigned int flags)
 	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");

 	for_each_ref(handle_one_ref, &cbdata);
+	if (ferror(cbdata.refs_file))
+		die("failed to write ref-pack file");
 	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
 		die("failed to write ref-pack file (%s)", strerror(errno));
 	if (commit_lock_file(&packed) < 0)
