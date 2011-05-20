From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] cache-tree: Teach write_cache_as_tree to
 discard_cache
Date: Fri, 20 May 2011 09:56:42 -0700
Message-ID: <7vboyx48fp.fsf@alter.siamese.dyndns.org>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
 <1305880223-7542-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 18:57:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNT0d-00010b-QC
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 18:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935260Ab1ETQ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 12:56:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272Ab1ETQ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 12:56:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1FB152CC;
	Fri, 20 May 2011 12:59:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mAesv1nxAT5ax4qrt0FVXSGA9dI=; b=MqOZuu
	SNsI2+wggG+ZVYRRZo8ARkAo0z+8EBLNBKgVuv3mhmjto9UCEmE88SxbALWLusF1
	eCTHtYdgn1gDQz5qJveLvDi/Kp1vJql4e/PwpFSOIYLa2gCoRmCyXp+pS7B/3D9P
	4evtd48UE2ROk5NIP5LLuXMR47MnIexForiLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tmh56hvY2Nna61CHmO9Nz62KfNST5vt0
	uTsJuuR9VMWi4lR/uUvZt7P9Yo60JdZV4kHc3mJD/yGI+32WiBG5eiJHZmzaefTS
	rW8ETS8SKMp+kFzYSW77NUgj+RRpzQLV5pLsXM4vspOuAO6DUSZJalzp8zEjjeP7
	QSaCHk951lk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 764B852CB;
	Fri, 20 May 2011 12:58:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB21852CA; Fri, 20 May 2011
 12:58:51 -0400 (EDT)
In-Reply-To: <1305880223-7542-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 20 May 2011 08:30:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7436D1E4-8302-11E0-B229-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174065>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> If the read_cache() call succeeds, the function must call
> discard_cache() before returning to the caller.

Does this mean the callers (current ones and also future ones) cannot
continue using the index after writing it out as a tree?

I would imagine anything that wants to write more than one tree (imagine:
reimplementation of "git stash" in C) would want to do something like:

	read_cache();
        write_cache_as_tree(index_tree_sha1[]);
        create commit to record that tree, with HEAD as the parent,
            and call that i_commit;

	for (all path in work tree different from index)
	        add_file_to_index();
        write_cache_as_tree(worktree_tree_sha1[]);
        create commit to record that tree, with HEAD as the parent;

        create commit to record the same tree, with HEAD and i_commit,
            and return it as the result of "git stash create".

Of course you _could_ force the caller to read_cache() what you wrote out
again immediately, but I do not see why you want to do so.  Especially in
the non-error codepath, I do not see why this could be a good change.

> diff --git a/cache-tree.c b/cache-tree.c
> index f755590..17c5bab 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -573,8 +573,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
>  
>  		if (cache_tree_update(active_cache_tree,
>  				      active_cache, active_nr,
> -				      missing_ok, 0) < 0)
> +				      missing_ok, 0) < 0) {
> +			discard_cache();
>  			return WRITE_TREE_UNMERGED_INDEX;

Also this may not be what the callers want, either.

If your goal is to update the existing code even more reusable by new
callers, I would understand if you introduced a "quiet" mode to
cache_tree_update() codepath (especially, verify_cache()), so that the
callers can choose to re-inspect the index in the error case and give a
better diagnostics, suggestion, or even auto-correction, depending on the
application. That would be a good way to restructure the current API to
give more control to the application.

Running discard_cache() here, however, would forever forbid any such
callers to be written, without reverting this change.

> +		}
>  		if (0 <= newfd) {
>  			if (!write_cache(newfd, active_cache, active_nr) &&
>  			    !commit_lock_file(lock_file))
> @@ -591,8 +593,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
>  	if (prefix) {
>  		struct cache_tree *subtree =
>  			cache_tree_find(active_cache_tree, prefix);
> -		if (!subtree)
> +		if (!subtree) {
> +			discard_cache();
>  			return WRITE_TREE_PREFIX_ERROR;

Same here.

> +		}
>  		hashcpy(sha1, subtree->sha1);
>  	}
>  	else
> @@ -601,6 +605,7 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
>  	if (0 <= newfd)
>  		rollback_lock_file(lock_file);
>  
> +	discard_cache();
>  	return 0;
>  }

I am afraid that I have to say that the approach this patch takes is
totally backwards from the point of view of good API design.  Perhaps
there is an (unstated) other goal you are trying to achieve, but I cannot
read it from the patch.
