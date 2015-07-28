From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 13:47:26 -0700
Message-ID: <xmqqsi88c8m9.fsf@gitster.dls.corp.google.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:47:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBmi-0004ww-26
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbG1Urb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:47:31 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35428 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbbG1Urb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:47:31 -0400
Received: by pdrg1 with SMTP id g1so76476738pdr.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SG9QJswVdiUAjpnBhDBB5Br0MIRyAYWW7O0hUlXBZMw=;
        b=uKxbyfpJtd63Nbhi+Lm38qsee+MfJgJewoD1K557cOawA6aBOLY3djU6FZJRJtNWvo
         7QIup9VcgjKeRfAVMVp5wtxQtb+ALMx2oQCrZPSnwBNxJXhiRJPGVyJDA7Jdi76o5dKs
         DIYduK2VEpLCSbVnIgjpBYJJN3LI4PxGD2ybqJDG2i/KiDGoIDRrb4xZ1zkmTaocKm3e
         vhq3izYKuFiqZDwv6CqcBdUPkegOou9HhfoG73pM8UJOK1fEiF29jlyPkGDsl+/7So2s
         qr3kKU004xpDjoIO6DAynbhvdmVJmZ8eiTXoTFzh545M9k3I0Jqo3U9jeHjXzbnpnx3c
         c6qw==
X-Received: by 10.70.64.162 with SMTP id p2mr85814682pds.54.1438116450688;
        Tue, 28 Jul 2015 13:47:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id oj15sm36796365pdb.20.2015.07.28.13.47.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 13:47:27 -0700 (PDT)
In-Reply-To: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 28 Jul 2015 15:30:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274843>

David Turner <dturner@twopensource.com> writes:

> When we unpack trees into an existing index, we discard the old index
> and replace it with the new, merged index.  Ensure that this index has
> its cache-tree populated.  This will make subsequent git status and
> commit commands faster.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Brian Degenhardt <bmd@bmdhacks.com>
> ---
>
> This patch is by my colleague, Brian Degenhardt (as part of his work
> on git at Twitter).  I'm sending it with his and Twitter's approval.

I'd need to tweak the From:/Author: line then, and flip the order of
the sign-off, as Brian wrote and signed off then David relayed (as
attached).

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 2927660..befc247 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1156,6 +1156,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	o->src_index = NULL;
>  	ret = check_updates(o) ? (-2) : 0;
>  	if (o->dst_index) {
> +		if (!o->result.cache_tree)
> +			o->result.cache_tree = cache_tree();
> +
> +		if (!cache_tree_fully_valid(o->result.cache_tree)) {
> +			cache_tree_update(&o->result, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
> +		}

This does the cache-tree thing unconditionally, not "on successful
merge".  cache_tree_update() would refuse when it sees an unmerged
entry, but somehow the discrepancy between the title and the code
bothers me.

By the way, I wonder if we can lose/revert aecf567c (cache-tree:
create/update cache-tree on checkout, 2014-07-05), now the
underlying unpack_trees() does the necessary cache_tree_update()
when a branch is checked out.

Thanks.

-- >8 --
From: Brian Degenhardt <bmd@bmdhacks.com>
Date: Tue, 28 Jul 2015 15:30:40 -0400
Subject: [PATCH] unpack-trees: populate cache-tree on successful merge

When we unpack trees into an existing index, we discard the old
index and replace it with the new, merged index.  Ensure that this
index has its cache-tree populated.  This will make subsequent git
status and commit commands faster.

Signed-off-by: Brian Degenhardt <bmd@bmdhacks.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0090-cache-tree.sh | 24 ++++++++++++++++++++++++
 unpack-trees.c        |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 601d02d..055cc19 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -199,6 +199,30 @@ test_expect_success 'checkout -B gives cache-tree' '
 	test_cache_tree
 '
 
+test_expect_success 'merge --ff-only maintains cache-tree' '
+	git checkout current &&
+	git checkout -b changes &&
+	test_commit llamas &&
+	test_commit pachyderm &&
+	test_cache_tree &&
+	git checkout current &&
+	test_cache_tree &&
+	git merge --ff-only changes &&
+	test_cache_tree
+'
+
+test_expect_success 'merge maintains cache-tree' '
+	git checkout current &&
+	git checkout -b changes2 &&
+	test_commit alpacas &&
+	test_cache_tree &&
+	git checkout current &&
+	test_commit struthio &&
+	test_cache_tree &&
+	git merge changes2 &&
+	test_cache_tree
+'
+
 test_expect_success 'partial commit gives cache-tree' '
 	git checkout -b partial no-children &&
 	test_commit one &&
diff --git a/unpack-trees.c b/unpack-trees.c
index be84ba2..d92f903 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1155,6 +1155,14 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->src_index = NULL;
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
+		if (!ret) {
+			if (!o->result.cache_tree)
+				o->result.cache_tree = cache_tree();
+			if (!cache_tree_fully_valid(o->result.cache_tree))
+				cache_tree_update(&o->result,
+						  WRITE_TREE_SILENT |
+						  WRITE_TREE_REPAIR);
+		}
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.5.0-370-gf964943
