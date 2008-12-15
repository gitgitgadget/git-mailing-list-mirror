From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
	file
Date: Mon, 15 Dec 2008 01:46:51 +0100
Message-ID: <20081215004651.GA16205@localhost>
References: <20081210201259.GA12928@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 01:48:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC1cw-0002GE-5D
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 01:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbYLOAqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 19:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbYLOAqo
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 19:46:44 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:31182 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbYLOAqo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 19:46:44 -0500
Received: from darc.dyndns.org ([84.154.114.217]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Dec 2008 01:46:40 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LC1bn-0001Tq-QQ; Mon, 15 Dec 2008 01:46:51 +0100
Content-Disposition: inline
In-Reply-To: <20081210201259.GA12928@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 15 Dec 2008 00:46:41.0319 (UTC) FILETIME=[9858DB70:01C95E4E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103118>

On Wed, Dec 10, 2008 at 09:12:59PM +0100, Clemens Buchacher wrote:
> If a file was removed in HEAD, but modified in MERGE_HEAD, recursive merge
> will result in a "CONFLICT (delete/modify)". If the (now untracked) file
> already exists and was not added to the index, it is overwritten with the
> conflict resolution contents.

The following patch fixes the problem described above, but it also breaks
t6023-merge-rename-nocruft.sh, which tries to merge "A" renamed to "B" in
HEAD and "A" modified in MERGE_HEAD, while ignoring an untracked file "A" in
the working tree. If we want to be able to do this, we have to handle the
other case after rename detection.

---
 unpack-trees.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 54f301d..de5b616 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -859,6 +859,9 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 	if (index) {
 		if (verify_uptodate(index, o))
 			return -1;
+	} else if (remote && !remote_match) {
+		if (verify_absent(remote, "overwritten", o))
+			return -1;
 	}
 
 	o->nontrivial_merge = 1;
-- 
1.6.1.rc2
