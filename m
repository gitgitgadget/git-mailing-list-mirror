From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Mon, 26 Feb 2007 07:15:57 -0500
Message-ID: <20070226121557.GA18114@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 13:16:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLelx-0005ZP-FF
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 13:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbXBZMQC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 07:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbXBZMQB
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 07:16:01 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2877 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751222AbXBZMQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 07:16:00 -0500
Received: (qmail 28528 invoked from network); 26 Feb 2007 07:16:12 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 26 Feb 2007 07:16:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Feb 2007 07:15:57 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40620>

This limit doesn't seem to come into effect anywhere else; it's simply
an arbitrary limit to make memory allocation easier. It's used to
declare a single static array of 20-byte hashes, so this increase wastes
about 2K.
---
This limit is arbitrary; should it be ridiculously high (I think 128 is
already ridiculous, but we could go to 1024 and waste 20K). Or
should it simply allocate dynamically?

I ran into this while trying to make an octopus with 25 heads. I have a
set of 25 small repositories imported from CVS. They no longer see
active development, but I want to keep them around for historical
purposes. Checking out 25 repos is a pain, so I wanted to put them all
in one repo. However, I didn't just want the histories on separate
branches; I wanted everything checked out at once. So I did:

  rm -f .git/MERGE_HEAD
  for i in $repos; do
    git fetch ../$i $i
    git read-tree --prefix=$i/ $i
    git checkout -- $i
    git rev-parse $i >>.git/MERGE_HEAD
  done
  git commit

Which of course barfed on the giant octopus. Bumping up the limit
allowed it to happen with no visible problems (the history browsing code
works fine). Yes, I obviously could have done a series of 25 pair-wise
merges (or even 2 16-way octopus merges), but I think this more closely
represents what I'm trying to accomplish.

 builtin-commit-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 2a818a0..48dbf1d 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -60,7 +60,7 @@ static void check_valid(unsigned char *sha1, const char *expect)
  * Having more than two parents is not strange at all, and this is
  * how multi-way merges are represented.
  */
-#define MAXPARENT (16)
+#define MAXPARENT (128)
 static unsigned char parent_sha1[MAXPARENT][20];
 
 static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
-- 
1.5.0.1.793.gedfd5-dirty
