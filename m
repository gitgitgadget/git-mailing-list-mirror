From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] cache-tree: Write index with updated cache-tree after commit
Date: Tue, 01 Jul 2014 15:45:35 -0700
Message-ID: <xmqqlhscvgts.fsf@gitster.dls.corp.google.com>
References: <1404242075-7068-1-git-send-email-dturner@twitter.com>
	<1404242075-7068-3-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 00:45:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X26o7-00037n-H1
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 00:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbaGAWpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 18:45:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62552 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbaGAWpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 18:45:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B02425886;
	Tue,  1 Jul 2014 18:45:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wrwa+sHVgV5EexrPfHiKvllXj9o=; b=uRQ9Qd
	TLxGhFROIWwPbbXl9LengdvrJ7w+2Q6+wsQH/KMPb5g4+l5woOpvrHj+Jvhzlpld
	iABhDh6LKVlhH5FH5NeULiUAVA8C55aK783WTI9SBNzf08ZCjWeGVmO206bd9UOd
	WzTiAOzu34RM/yuSN62YJVeIS4u1RlCcPsZrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yVgpjFLI13lq9ybf20+UuNPZWEffDf5P
	IHEV2/MmzIUbhddoSM5VQXTwCZLqNh2ePYt4cV32/hu3MuSDvJlLxhKss9ehMkKw
	PWq4A/ndAQByTvKG+ML9ma487qLtCWer83lKDTFVIRz0vIEjqvA52VSHCtSpnI1M
	w1XZYH4BP3Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 324E925885;
	Tue,  1 Jul 2014 18:45:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4037A25880;
	Tue,  1 Jul 2014 18:45:26 -0400 (EDT)
In-Reply-To: <1404242075-7068-3-git-send-email-dturner@twitter.com> (David
	Turner's message of "Tue, 1 Jul 2014 12:14:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 64D7BC22-0171-11E4-B750-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252747>

David Turner <dturner@twopensource.com> writes:

> During the commit process, the cache-tree is updated. We need to write
> this updated cache-tree so that it's ready for subsequent commands.
>
> Add test code which demonstrates that git commit now writes the cache
> tree.  Also demonstrate that cache-tree invalidation is correct.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/commit.c      | 15 ++++++------
>  t/t0090-cache-tree.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 67 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9cfef6c..dbd4f4b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -342,6 +342,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  
>  		discard_cache();
>  		read_cache_from(index_lock.filename);
> +		if (update_main_cache_tree(WRITE_TREE_SILENT) >= 0)
> +			write_cache(fd, active_cache, active_nr);

OK, interactive-add may leave the cache-tree not quite populated;
we are going to write out a tree from the cache so we need to update
the in-core cache tree anyway, so calling update-main-cache-tree
here would not hurt (it will speed up the write-cache-as-tree we
will eventually call).

We might want to see if we are really changing anything, though.
What happens if the interactive-add gave us an index with fully
valid cache-tree?  Is that rare enough not to matter (not a
rhetorical question)?

> @@ -383,14 +385,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
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


How about doing this part like the following instead, so that we can
avoid the overhead of uselessly rewriting the index file when we do
not have to?

diff --git a/builtin/commit.c b/builtin/commit.c
index 5e2221c..7d730a5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -383,8 +383,11 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	if (!only && !pathspec.nr) {
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
-		if (active_cache_changed) {
+		if (active_cache_changed || !cache_tree_fully_valid(active_cache_tree)) {
 			update_main_cache_tree(WRITE_TREE_SILENT);
+			active_cache_changed = 1;
+		}
+		if (active_cache_changed) {
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));

It makes me wonder if we should teach update_main_cache_tree() to
somehow smudge active_cache_changed bit as necessary.  Then we do
not have to make the call to update-main-cache-tree conditional.

> @@ -435,6 +433,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  	fd = hold_locked_index(&index_lock, 1);
>  	add_remove_files(&partial);
>  	refresh_cache(REFRESH_QUIET);
> +	update_main_cache_tree(WRITE_TREE_SILENT);
>  	if (write_cache(fd, active_cache, active_nr) ||
>  	    close_lock_file(&index_lock))
>  		die(_("unable to write new_index file"));

This is the index that will be used after we create the commit
(which will be created from a temporary index that will be discarded
immediately after we create the commit).  As we _know_ we are
changing something in this code path by calling add_remote_files(),
it is fine to call update-main-cache-tree here unconditionally.

I didn't notice it when I gave the previous review comment but while
reviewing this round, we already do the cache-tree population for
"commit -a" in this function, which suggests me that it is the right
place to do these changes.  Modulo minor niggles, I like this
iteration much better than the previous one.

Thanks for working on this.
