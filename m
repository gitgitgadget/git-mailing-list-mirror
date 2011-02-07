From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 7 Feb 2011 16:57:13 +0700
Message-ID: <20110207095713.GA19653@do>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <20110207091740.GA5391@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 10:58:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmNrq-0000zI-TA
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 10:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab1BGJ6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 04:58:42 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:34062 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1BGJ6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 04:58:41 -0500
Received: by pxi15 with SMTP id 15so847808pxi.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l5jXV6mbutp3qtm1dhtgVb9fbh3x7E71oFSDzc8Z8Bk=;
        b=UwtqfxE9ZuHANd5LidewI9Bq/FmUMROmvvuXlNBmljRsnVt6bkdzygDr47FUIQf3+t
         Q5W/XHdaGu1QryHrAKppdCpUfF2lvgUP8PXjIvkHWTFHK3uHhkoU5fi70SVYpNj9So5g
         gR33jDnMbMppsbABXVB4kH5h75Iz3A2Yn3hZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EwGBowsgh1qc0ECpLNZugzeO6NfBEGwa8KtRLDv4ZYXhxrTHUpOHU015ya9Xk+Z0qp
         +MxxIU84M8Ee9YoTVWSpzq7ci04vHOEZvNtpk3tEH8cGoJXslQoc04P3hqFGzuFMaMi1
         CNuMVp9JtpCym9sPxsRKsP85grPaqjWr0mEs4=
Received: by 10.142.47.2 with SMTP id u2mr15160511wfu.63.1297072721099;
        Mon, 07 Feb 2011 01:58:41 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id x18sm5717336wfa.23.2011.02.07.01.58.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 01:58:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 Feb 2011 16:57:13 +0700
Content-Disposition: inline
In-Reply-To: <20110207091740.GA5391@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166247>

On Mon, Feb 07, 2011 at 03:17:40AM -0600, Jonathan Nieder wrote:
> While this violates some seeming invariants, like
> 
> 1.
> 	git reset --hard
> 	git commit --allow-empty
> 	git rev-parse HEAD^^{tree} >expect
> 	git rev-parse HEAD^{tree} >actual
> 	test_cmp expect actual
> 
> 2.
> 	git reset --hard
> 	git revert HEAD
> 	if git rev-parse HEAD~2
> 	then
> 		git rev-parse HEAD~2^{tree} >expect
> 		git rev-parse HEAD^{tree} >actual
> 		test_cmp expect actual
> 	fi
> 
> , I think it's a good change.  Malformed modes in trees already break
> those false invariants iiuc.

Perhaps it's not a good approach after all. What I wanted was to make
pre-1.8.0 tolerate empty trees created by 1.8.0. Perhaps it's better
to just let pre-1.8.0 refuse to work with empty trees, forcing users
to upgrade to 1.8.0?

The (untested) patch below would make git refuse to create an index
from a tree that contains empty trees. Hmm?

diff --git a/cache-tree.c b/cache-tree.c
index f755590..e33998a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -619,6 +619,8 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 		else {
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(entry.sha1);
+			if (!hashcmp(entry.sha1, EMPTY_TREE_SHA1_BIN))
+				die("empty tree .../%s detected!", entry.path);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
diff --git a/unpack-trees.c b/unpack-trees.c
index 1ca41b1..0e6738e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -434,6 +434,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long
 	void *buf[MAX_UNPACK_TREES];
 	struct traverse_info newinfo;
 	struct name_entry *p;
+	struct unpack_trees_options *o = info->data;
 
 	p = names;
 	while (!p->mode)
@@ -447,8 +448,11 @@ static int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long
 
 	for (i = 0; i < n; i++, dirmask >>= 1) {
 		const unsigned char *sha1 = NULL;
-		if (dirmask & 1)
+		if (dirmask & 1) {
 			sha1 = names[i].sha1;
+			if (o->merge && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
+				return error("empty tree .../%s detected!", p->path);
+		}
 		buf[i] = fill_tree_descriptor(t+i, sha1);
 	}
 

-- 
Duy
