From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: [PATCH] Make creation of pack/pack-*.keep obey the umask
Date: Wed, 7 May 2008 11:25:48 -0600
Message-ID: <20080507172548.GI24525@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 19:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtnmS-0004qC-Fa
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 19:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbYEGRtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 13:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbYEGRtW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 13:49:22 -0400
Received: from quartz.orcorp.ca ([142.179.161.236]:60808 "EHLO
	quartz.edm.orcorp.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752942AbYEGRtT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 13:49:19 -0400
X-Greylist: delayed 1406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2008 13:49:19 EDT
Received: from [10.0.0.11] (helo=jggl.edm.orcorp.ca)
	by quartz.edm.orcorp.ca with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1JtnOm-0007JW-DW
	for git@vger.kernel.org; Wed, 07 May 2008 11:25:48 -0600
Received: from jgg by jggl.edm.orcorp.ca with local (Exim 4.67)
	(envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1JtnOm-000281-7r
	for git@vger.kernel.org; Wed, 07 May 2008 11:25:48 -0600
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Broken-Reverse-DNS: no host name found for IP address 10.0.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81468>

Prevents git clone from complaining on shared repositories

Initialized empty Git repository in /tmp/src/.git/
cpio: objects/pack/pack-601efa4cfe63e081c0591b463549aeba3f7c6164.keep: Cannot open: Permission denied
3376 blocks

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---

I'm uncertain if the keep files should be sticking around for so long,
commit b8077709 makes it sounds like they are shorted lived lock
files. In the case I have the keep file contains:

fetch-pack 20810 on bertha1

But, I don't see anything in fetch-pack to erase the keep file.. In
any event making the file the same permissions as everything else
can't hurt.

 index-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 9c0c278..eb19e98 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -707,7 +707,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 				 get_object_directory(), sha1_to_hex(sha1));
 			keep_name = name;
 		}
-		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0666);
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
 				die("cannot write keep file");
-- 
1.5.4.2
