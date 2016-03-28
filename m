From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] refs: add a new function set_worktree_head_symref
Date: Mon, 28 Mar 2016 10:48:50 -0700
Message-ID: <xmqq4mbqze65.fsf@gitster.mtv.corp.google.com>
References: <cover.1459087958.git.k@rhe.jp>
	<39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kazuki Yamaguchi <k@rhe.jp>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:50:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akbHe-0001Uy-TR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 19:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbcC1Rsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 13:48:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753067AbcC1Rsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 13:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 618864D36E;
	Mon, 28 Mar 2016 13:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AXZJ/daHCWmwyxC7UjAoXpLZ0XU=; b=G6VMov
	Oe2SHGO8SxAhS0VJJBWmd0GOv04o4ZpV0QmQ7pQaDgGGGK8ar+/wwHVyiXMaXyKT
	JrC/K4w85OdVjsPqJCgCrBnOFHLobhaHpc6Cn8BjqMRdIsGaTIWb3WNO005dnLBU
	FHEjVOd7GoMrx8ZtUgErWHBa9ugLJ89R3cl3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0enCggp6xM0ckmNStFeuZUKC1OOZd3F
	eEkkvRo1xD1J+KUmJUWKg0TQYFANSoX0h+w3eDtzRbh6hEM9zTD2qyY73g/9paiI
	dkmbu/KdUGrVZuojnsYydgEOTSFdikm2w9wbUpe9AVI6V/GW1Z64wMT40F6//6Ps
	kFYP+ZX1bxw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57A674D36D;
	Mon, 28 Mar 2016 13:48:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC87C4D36C;
	Mon, 28 Mar 2016 13:48:51 -0400 (EDT)
In-Reply-To: <39bc3c1da6daf31f2a10e592dbb5d3daadc96199.1459087958.git.k@rhe.jp>
	(Kazuki Yamaguchi's message of "Sun, 27 Mar 2016 23:37:13 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 554364E6-F50D-11E5-B6CA-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290051>

Kazuki Yamaguchi <k@rhe.jp> writes:

> Add a new function set_worktree_head_symref, to update HEAD symref for
> the specified worktree.
>
> To update HEAD of a linked working tree,
> create_symref("worktrees/$work_tree/HEAD", "refs/heads/$branch", msg)
> could be used. However when it comes to updating HEAD of the main
> working tree, it is unusable because it uses $GIT_DIR for
> worktree-specific symrefs (HEAD).
>
> The new function takes git_dir (real directory) as an argument, and
> updates HEAD of the working tree. This function will be used when
> renaming a branch.
>
> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---

I suspect that this helper function should be in the common layer
(refs.c) to be redirected to specific backend(s).

David & Michael, what do you think?

>  refs.h               |  8 ++++++++
>  refs/files-backend.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/refs.h b/refs.h
> index 2f3decb432cf..f11154cf5faf 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -306,6 +306,14 @@ extern int rename_ref(const char *oldref, const char *newref, const char *logmsg
>  
>  extern int create_symref(const char *refname, const char *target, const char *logmsg);
>  
> +/*
> + * Update HEAD of the specified gitdir.
> + * Similar to create_symref("relative-git-dir/HEAD", target, NULL), but this is
> + * able to update the main working tree's HEAD wherever $GIT_DIR points to.
> + * Return 0 if successful, non-zero otherwise.
> + * */
> +extern int set_worktree_head_symref(const char *gitdir, const char *target);
> +
>  enum action_on_err {
>  	UPDATE_REFS_MSG_ON_ERR,
>  	UPDATE_REFS_DIE_ON_ERR,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 81f68f846b69..ec237efec35d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2894,6 +2894,41 @@ int create_symref(const char *refname, const char *target, const char *logmsg)
>  	return ret;
>  }
>  
> +int set_worktree_head_symref(const char *gitdir, const char *target)
> +{
> +	static struct lock_file head_lock;
> +	struct ref_lock *lock;
> +	struct strbuf err = STRBUF_INIT;
> +	struct strbuf head_path = STRBUF_INIT;
> +	const char *head_rel;
> +	int ret;
> +
> +	strbuf_addf(&head_path, "%s/HEAD", absolute_path(gitdir));
> +	if (hold_lock_file_for_update(&head_lock, head_path.buf,
> +				      LOCK_NO_DEREF) < 0) {
> +		error("%s", err.buf);
> +		strbuf_release(&err);
> +		strbuf_release(&head_path);
> +		return -1;
> +	}
> +
> +	/* head_rel will be "HEAD" for the main tree, "worktrees/wt/HEAD" for
> +	   linked trees */
> +	head_rel = remove_leading_path(head_path.buf,
> +				       absolute_path(get_git_common_dir()));
> +	/* to make use of create_symref_locked(), initialize ref_lock */
> +	lock = xcalloc(1, sizeof(struct ref_lock));
> +	lock->lk = &head_lock;
> +	lock->ref_name = xstrdup(head_rel);
> +	lock->orig_ref_name = xstrdup(head_rel);
> +
> +	ret = create_symref_locked(lock, head_rel, target, NULL);
> +
> +	unlock_ref(lock); /* will free lock */
> +	strbuf_release(&head_path);
> +	return ret;
> +}
> +
>  int reflog_exists(const char *refname)
>  {
>  	struct stat st;
