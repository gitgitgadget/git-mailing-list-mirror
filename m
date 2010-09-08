From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/3] fast-import: allow cat command with empty path
Date: Tue, 7 Sep 2010 22:17:44 -0500
Message-ID: <20100908031744.GB23409@capella.cs.uchicago.edu>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino> <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 05:17:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtBAU-0002yR-B4
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 05:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab0IHDRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 23:17:46 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:41945 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab0IHDRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 23:17:45 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 9BE06B8FC;
	Tue,  7 Sep 2010 22:17:44 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 8D54F761AF; Tue,  7 Sep 2010 22:17:44 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100905031528.GA2344@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155760>

Rather than erroring out, treat an empty path as the path to
the root of a tree so frontends can be simplified a little.

While at it, fix a typo in an error message: the cat command is used
to examine paths within trees, not branches.

Cc: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Would this be helpful?  I imagine it would make tree access by
pathname a bit simpler, and I found myself tempted to try it.

The test from the next patch exercises this.

 fast-import.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 099f63e..f3c4123 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2702,9 +2702,13 @@ static void quoted_path_sha1(unsigned char sha1[20], struct tree_entry *root,
 		die("Invalid path: %s", line);
 	if (*x)
 		die("Garbage after path: %s", line);
+	if (uq.len == 0) {
+		hashcpy(sha1, root->versions[1].sha1);
+		return;
+	}
 	tree_content_get(root, uq.buf, &leaf);
 	if (!leaf.versions[1].mode)
-		die("Path %s not in branch", uq.buf);
+		die("Path %s not in tree", uq.buf);
 	hashcpy(sha1, leaf.versions[1].sha1);
 }
 
-- 
1.7.3.rc0.6.g7505a.dirty
