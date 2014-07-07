From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 07 Jul 2014 13:03:28 -0700
Message-ID: <xmqq61j9c4xb.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-4-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 22:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4F8Z-000393-PL
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 22:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbaGGUDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 16:03:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54171 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbaGGUDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 16:03:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94CEE2749C;
	Mon,  7 Jul 2014 16:03:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=seCZPMlbxSdVFmaa2TE+zTIOxGI=; b=RH59FE
	HK+cXXQKLzAVxqbxT+QcIuhZWPwDKaIm5drNuC2F8q85wURD5XKjUlH44RsCOG9l
	jBisqqLqm1mM9ER3kHh76hCK0yUMk8inqklgaOv3UnuVu8vStSiT6Lx5wr6nl7nj
	ekC3Ikeijf+v2bRSrz2v8AfdxbH2J6c7M0McI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VW5ooXER/IHtmZaRaKtorLovN9O8jo9D
	37yi4WJTO4pkZquSGFMefpCLeDnSZOHEsrqE1/5MSlhyWX0VVEODABOhR+O7QXSL
	P382mcUrhrsjxjdYFVH6Yt1+SSsHjXmIhut9CgJFb6d3+JeNzp0yUuhQ53JV0AeK
	1H1kpCNLfTA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A6C02749B;
	Mon,  7 Jul 2014 16:03:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1215927490;
	Mon,  7 Jul 2014 16:03:19 -0400 (EDT)
In-Reply-To: <1404619619-4774-4-git-send-email-dturner@twitter.com> (David
	Turner's message of "Sat, 5 Jul 2014 21:06:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE0FB908-0611-11E4-85FC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252985>

David Turner <dturner@twopensource.com> writes:

> During the commit process, update the cache-tree. Write this updated
> cache-tree so that it's ready for subsequent commands.
>
> Add test code which demonstrates that git commit now writes the cache
> tree.  Make all tests test the entire cache-tree, not just the root
> level.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/commit.c      | 31 +++++++++++-------
>  t/t0090-cache-tree.sh | 87 ++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 91 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9cfef6c..5981755 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -342,6 +342,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  
>  		discard_cache();
>  		read_cache_from(index_lock.filename);
> +		if (update_main_cache_tree(WRITE_TREE_SILENT) >= 0)
> +			write_cache(fd, active_cache, active_nr);
>  
>  		commit_style = COMMIT_NORMAL;
>  		return index_lock.filename;
> @@ -363,10 +365,18 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  		fd = hold_locked_index(&index_lock, 1);
>  		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
>  		refresh_cache_or_die(refresh_flags);
> -		update_main_cache_tree(WRITE_TREE_SILENT);
> -		if (write_cache(fd, active_cache, active_nr) ||
> -		    close_lock_file(&index_lock))
> -			die(_("unable to write new_index file"));
> +		if (active_cache_changed
> +		    || !cache_tree_fully_valid(active_cache_tree)) {
> +			update_main_cache_tree(WRITE_TREE_SILENT);
> +			active_cache_changed = 1;
> +		}
> +		if (active_cache_changed) {
> +			if (write_cache(fd, active_cache, active_nr) ||
> +			    close_lock_file(&index_lock))
> +				die(_("unable to write new_index file"));
> +		} else {
> +			rollback_lock_file(&index_lock);
> +		}
>  		commit_style = COMMIT_NORMAL;
>  		return index_lock.filename;
>  	}
> @@ -383,14 +393,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  	if (!only && !pathspec.nr) {
>  		fd = hold_locked_index(&index_lock, 1);
>  		refresh_cache_or_die(refresh_flags);
> -		if (active_cache_changed) {
> -			update_main_cache_tree(WRITE_TREE_SILENT);
> -			if (write_cache(fd, active_cache, active_nr) ||
> -			    commit_locked_index(&index_lock))
> -				die(_("unable to write new_index file"));
> -		} else {
> -			rollback_lock_file(&index_lock);
> -		}
> +		update_main_cache_tree(WRITE_TREE_SILENT);
> +		if (write_cache(fd, active_cache, active_nr) ||
> +		    commit_locked_index(&index_lock))
> +			die(_("unable to write new_index file"));
>  		commit_style = COMMIT_AS_IS;
>  		return get_index_file();
>  	}

Hmph.  The above two hunks somehow feel the other way around.  When
doing a non-partial, non as-is commit, i.e. "git commit $paths", the
original used to call 'write-cache' unconditionally, because it is
very unlikely for us to see !active_cache_changed after calling the
add-files-to-cache with user-supplied pathspec (if there is nothing
to change, the user is being silly to say "git commit $paths" in the
first place).  I would have expected that the patch would have left
that code path alone (it seems to be doing the right thing already).

On the other hand, "git commit" to commit the contents of the index
as-is is being cautious not to write things out unnecessarily, but
as you found out, it would be a good idea to fully populate the
cache-tree in this code path and write the otherwise already-good
index file out, even if we see !active_cache_changed after we called
refresh_cache_or_die().  So I would have expected that the patch
would have kept the "write only necessary" carefulness instead of
calling write-cache unconditionally.

That is, something like:

	fd = hold_locked_index();
        refresh_cache_or_die();
+	if (!cache_tree_fully_valid())
+               active_cache_changed = 1;
	if (active_cache_changed) {
		update_main_cache_tree();

> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 8437c5f..15f1484 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -7,8 +7,14 @@ cache-tree extension.
>  "
>   . ./test-lib.sh
>  
> +grep_nonmatch_ok () {
> +    grep $@

dq around it, i.e. "$@".

> +    test "$?" = "2" && return 1

POSIX.1 only specifies >1 not necessarily 2 as an error status.  

> +    return 0
> +}

Having said all that I do not think the helper is unnecessary.  Just
use something like

	sed -e '/#(ref)/d'

>  cmp_cache_tree () {
> -	test-dump-cache-tree >actual &&
> +	test-dump-cache-tree | grep_nonmatch_ok -v \#\(ref\) >actual &&
