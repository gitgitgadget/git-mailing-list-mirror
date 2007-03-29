From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 12:34:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
 <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
 <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 21:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX0Os-0003CC-RP
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 21:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934325AbXC2TfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 15:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934333AbXC2TfF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 15:35:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37212 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934325AbXC2TfD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 15:35:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2TJYoU2028193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Mar 2007 12:34:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2TJYnnF010362;
	Thu, 29 Mar 2007 12:34:49 -0700
In-Reply-To: <20070329183237.GB2809@steel.home>
X-Spam-Status: No, hits=-0.462 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43463>



On Thu, 29 Mar 2007, Alex Riesen wrote:
> 
> tree == 0x0? Strange, I don't get why it is NULL, the initial commit
> definitely hase a tree (git cat-file -p initial-commit shows a tree
> name and there is a tree with that object name).

It's not the initial commit. It's a criss-cross merge, and it's a virtual 
commit created by a previous level of merging.

Apply this patch to see it blow up much earlier, when that bogus commit 
with a NULL tree is created.

(I didn't debug *why* that happens, but maybe this gets somebody further)

		Linus

---
 merge-recursive.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c96e1a7..28f0c30 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -34,6 +34,7 @@ static struct commit *make_virtual_commit(struct tree *tree, const char *comment
 {
 	struct commit *commit = xcalloc(1, sizeof(struct commit));
 	static unsigned virtual_id = 1;
+	assert(tree);
 	commit->tree = tree;
 	commit->util = (void*)comment;
 	*(int*)commit->object.sha1 = virtual_id++;
