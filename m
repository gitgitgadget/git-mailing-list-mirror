From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] revert: plug memory leak in "cherry-pick root commit"
 codepath
Date: Tue, 16 Aug 2011 13:27:39 -0500
Message-ID: <20110816182739.GC10336@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com>
 <20110814131303.GF18466@elie.gateway.2wire.net>
 <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
 <20110814152204.GJ18466@elie.gateway.2wire.net>
 <7v39h1i6rr.fsf@alter.siamese.dyndns.org>
 <20110816181633.GB10336@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 20:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtOMf-0004Gh-2W
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 20:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab1HPS1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 14:27:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34026 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab1HPS1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 14:27:43 -0400
Received: by gya6 with SMTP id 6so147052gya.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cWwmZ3J3EDeXXwqpj2yRGhcNP5vzggcxMCUHzbcMNZE=;
        b=o2HRR/wP8h+w0IWEaGdFYG8L2aVr5EswNgo0tuLvlZvZ5NY/BFzzoKZWIm2MS91M0J
         dmQn+zVOxGt3ATSyyeFrjCWDltVZjSPojPZVfuLBHpVsEUtKulPUVeHy3DDjd/qfuZUg
         00XNM7zlWxwIFBmlr5JJDPqStJ+BX1WUFjV9Q=
Received: by 10.91.50.12 with SMTP id c12mr30904agk.124.1313519263090;
        Tue, 16 Aug 2011 11:27:43 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-67-175.dsl.chcgil.sbcglobal.net [69.209.67.175])
        by mx.google.com with ESMTPS id k20sm228854and.31.2011.08.16.11.27.41
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 11:27:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110816181633.GB10336@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179466>

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> Thanks for noticing, but shouldn't we be just using
>>
>> 	lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN)
>>
>> or something, instead of hand-crafting a fake tree object?
>
> Yes.

And here's another patch in the same spirit (no test this time,
though).

-- >8 --
Subject: merge-recursive: take advantage of hardcoded empty tree

When this code was first written (v1.4.3-rc1~174^2~4, merge-recur: if
there is no common ancestor, fake empty one, 2006-08-09), everyone
needing a fake empty tree had to make her own, but ever since
v1.5.5-rc0~180^2~1 (2008-02-13), the object lookup machinery provides
a ready-made one.  Use it.

This is just a simplification, though it also fixes a small leak
(since the tree in the virtual common ancestor commit is never freed).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 merge-recursive.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 206c1036..7695fe89 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1309,12 +1309,10 @@ int merge_recursive(struct merge_options *o,
 
 	merged_common_ancestors = pop_commit(&ca);
 	if (merged_common_ancestors == NULL) {
-		/* if there is no common ancestor, make an empty tree */
-		struct tree *tree = xcalloc(1, sizeof(struct tree));
+		/* if there is no common ancestor, use an empty tree */
+		struct tree *tree;
 
-		tree->object.parsed = 1;
-		tree->object.type = OBJ_TREE;
-		pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
+		tree = lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
-- 
1.7.6
