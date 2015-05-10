From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] tree-walk: learn get_tree_entry_follow_symlinks
Date: Sun, 10 May 2015 10:42:41 -0700
Message-ID: <xmqqd228gwha.fsf@gitster.dls.corp.google.com>
References: <1431203769-11855-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sun May 10 19:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrVFz-0007pX-DJ
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbbEJRmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 13:42:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751514AbbEJRmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 13:42:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A1864EB09;
	Sun, 10 May 2015 13:42:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ArfUFf4z2eV+aQ/jeiH1qJD4mr8=; b=BVD1EE
	1jaoTMtCS5BGYki0uKAIk66t82JSAruDinxi+dvUpLCJhtxyx6z6MZjBUiW6diKu
	QIXGgDMmudqu1xoxmPL9rMqaqbNeJoXw8vrJm7SWyQJ+s3bJj8vL4+iGQvY04EhJ
	QKdN1FNEU/AMtO5UiJv0ruwVayi5E3oH8CgDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DyFR/akQPK9BFT4zJuyvjFhL0mYjz0qc
	LAOcP0QmfLD+hkhiNKHbCaVGpz91+Yn2cjjuSeDYNqx0D7UIMFnjG2NF8ctpMAu4
	crru2o7xV7JSLa3U2YTkEz2w28M8ye5Ma7u6J5+Sbug7ocItaDsp6t3VK65mJw9H
	nv1aOf9mqQ0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 938A84EB07;
	Sun, 10 May 2015 13:42:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12AD44EB06;
	Sun, 10 May 2015 13:42:43 -0400 (EDT)
In-Reply-To: <1431203769-11855-1-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Sat, 9 May 2015 16:36:07
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F609DCFA-F73B-11E4-A9F0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268733>

dturner@twopensource.com writes:

> From: David Turner <dturner@twitter.com>
>
> Add a new function, get_tree_entry_follow_symlinks, to tree-walk.[ch].
> The function is not yet used.  It will be used to implement git
> cat-file --batch --follow-symlinks.
>
> The function locates an object by path, following symlinks in the
> repository.  If the symlinks lead outside the repository, the function
> reports this to the caller.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

Thanks.

>  cache.h     |   5 ++
>  tree-walk.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tree-walk.h |   2 +
>  3 files changed, 202 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 3d3244b..679faa9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -922,6 +922,11 @@ struct object_context {
>  	unsigned char tree[20];
>  	char path[PATH_MAX];
>  	unsigned mode;
> +	/*
> +	 * symlink_path is only used by get_tree_entry_follow_symlinks,
> +	 * and only for symlinks that point outside the repository.
> +	 */
> +	struct strbuf symlink_path;
>  };

The new low-level helper introduced here does not fill this field,
it seems, and it would make it clear to move the above hunk to
[2/3] where it becomes necessary.

I haven't checked carefully enough to say there isn't any missing
corner cases in the follow-symlinks codepath with confidence, but
the logic there seems very sound.  Other than the above suggestion
and removal of "int already_have_tree" variable that is not used, I
have only minor style nits (attached to be squashable) [*1*] on this
patch.

Thanks.

[Footnote]

 *1* Style nits:

  a. Multi-line comment format.

  b. ALLOC_GROW() followed by filling parents_nr slot is concluded
     by incrementing parents_nr itself; that single logical unit is
     easier to see without a blank line in the middle.

  c. In C, we prefer post-increment i++ over pre-increment when its
     value is discarded.

  d. We tend to omit {} around a single-statement block.


 tree-walk.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index f93492d..b7ee665 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -484,7 +484,8 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 	return retval;
 }
 
-/* This is Linux's built-in max for the number of symlinks to follow.
+/*
+ * This is Linux's built-in max for the number of symlinks to follow.
  * That limit, of course, does not affect git, but it's a reasonable
  * choice.
  */
@@ -514,7 +515,6 @@ int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, u
 	unsigned char current_tree_sha1[20];
 	struct strbuf namebuf = STRBUF_INIT;
 	enum object_type type;
-	int already_have_tree = 0;
 	struct tree_desc t = {0};
 	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
 	int i;
@@ -541,7 +541,6 @@ int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, u
 			parents[parents_nr].tree = tree;
 			parents[parents_nr].size = size;
 			hashcpy(parents[parents_nr].sha1, root);
-
 			parents_nr++;
 
 			if (namebuf.buf[0] == '\0') {
@@ -562,8 +561,7 @@ int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, u
 			strbuf_remove(&namebuf, 0, 1);
 		}
 
-		/* Split namebuf into a first component and a
-		 * remainder */
+		/* Split namebuf into a first component and a remainder */
 		if ((first_slash = strchr(namebuf.buf, '/'))) {
 			*first_slash = 0;
 			remainder = first_slash + 1;
@@ -571,8 +569,10 @@ int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, u
 
 		if (!strcmp(namebuf.buf, "..")) {
 			struct dir_state *parent;
-			/* We could end up with .. in the namebuf if
-			 * it appears in a symlink. */
+			/*
+			 * We could end up with .. in the namebuf if it
+			 * appears in a symlink.
+			 */
 
 			if (parents_nr == 1) {
 				if (remainder)
@@ -599,8 +599,7 @@ int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, u
 			goto done;
 		}
 
-		/* Look up the first (or only) path component
-		 * in the tree. */
+		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(&t, namebuf.buf,
 					      current_tree_sha1, mode);
 		if (find_result) {
@@ -664,9 +663,8 @@ int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, u
 		}
 	}
 done:
-	for (i = 0; i < parents_nr; ++i) {
+	for (i = 0; i < parents_nr; i++)
 		free(parents[i].tree);
-	}
 	free(parents);
 
 	strbuf_release(&namebuf);
