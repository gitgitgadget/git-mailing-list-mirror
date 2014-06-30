From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] cache-tree: Write index with updated cache-tree after commit
Date: Mon, 30 Jun 2014 11:10:19 -0700
Message-ID: <xmqqegy6z2t0.fsf@gitster.dls.corp.google.com>
References: <1403914856-3546-1-git-send-email-dturner@twitter.com>
	<1403914856-3546-3-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 20:10:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1g2D-0004L7-QK
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 20:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbaF3SKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 14:10:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57032 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486AbaF3SK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 14:10:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46047234A3;
	Mon, 30 Jun 2014 14:10:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9oqiShQ8Nkai09iIOc6EpibgVwY=; b=GKIJDi
	lx2P4ZmkUdpgfDQmAg832ElexG6Z81Qt3EvMHxxvSVXQMafuetDlmQqq4pPU3iQV
	ASg2inwn4R+JvOrJ0e0KSBTfG65tkGO+D3Vf628lqMly2wbxaN+VTr0FBykY73Mh
	sc4xs2uJaDbcrv5033wyN+duQ0Ss/F/eDX54M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAFRa+huIjfhMvLHz4z/mWhmwRBcLUFH
	U7vzxx3H0gGu/PLpeq66NXLyyS3bLVGAE+2DrL1urgWe5lb05ceOqiojmqC9l38d
	DbtrCNpB/wfefbOkFie//UGuv5HNCIvOo50D/Oiu7J3uursXekpyhXIgDuuQTaSf
	Yepd/dE4HtQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4D5E234A1;
	Mon, 30 Jun 2014 14:10:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E8BC2348E;
	Mon, 30 Jun 2014 14:10:12 -0400 (EDT)
In-Reply-To: <1403914856-3546-3-git-send-email-dturner@twitter.com> (David
	Turner's message of "Fri, 27 Jun 2014 17:20:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C76EB08E-0081-11E4-ACFA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252697>

David Turner <dturner@twopensource.com> writes:

> During the commit process, the cache-tree is updated. We need to write
> this updated cache-tree so that it's ready for subsequent commands.
>
> Add test code which demonstrates that git commit now writes the cache
> tree.  Also demonstrate that  cache-tree invalidation is correct.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/commit.c      |  6 ++++++
>  t/t0090-cache-tree.sh | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9cfef6c..6814e87 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -607,6 +607,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	const char *hook_arg2 = NULL;
>  	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
>  	int old_display_comment_prefix;
> +	static struct lock_file index_lock;
> +	int index_fd;
>  
>  	/* This checks and barfs if author is badly specified */
>  	determine_author_info(author_ident);
> @@ -872,6 +874,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		error(_("Error building trees"));
>  		return 0;
>  	}
> +	/* After updating the cache-tree, rewrite the index */
> +	index_fd = hold_locked_index(&index_lock, 0);
> +	if (index_fd >= 0 && write_index(&the_index, index_fd) >= 0)
> +		commit_locked_index(&index_lock);

Is this run unconditionally even when we are making a partial commit
out of a temporary index file (which will be discarded after we
create this commit)?

I have a feeling that a better place to populate the cache-tree may
be prepare-index which knows the distinction between various modes
of commit, but I haven't looked at the code path for a while...
