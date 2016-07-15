Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3534E203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 20:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbcGOU6q (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 16:58:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751991AbcGOU6p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 16:58:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 047702C4D1;
	Fri, 15 Jul 2016 16:58:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JHirAcaqWORWRzWcVvwIm4b9uiQ=; b=RnpDOQ
	rdbYwoMVzS1tV+J1PWYUu4IjE+r+Nfs8nMA/PzfIDq4gZHRkqdh3AxKfHhlbyjfI
	vhxwr9rR/8osN7q0TSDkn8N0ouQljbTb5jShKWRwb+k6IJK6JBkz/QVBh5vts1eF
	eH3/8OVk2zsrcyAQvxNzNn0kBIwTptF/zhTBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KAfAnSLIQeTZ8naqa/5Ld9P1pOVZ7Rge
	3nnouQGYHQkS/Pw+HaEfxE+ZdquF83z5r0cr+M5LY+bW4zLXsfx7iKwmo9xC3OZV
	W8kvXIqzqIR3OJXsMkA2AaB7XF9gVqU4vxVhIAJlSvG4KycSTycj/Iahkk1H8Vft
	VTKi+5OS5Mo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF8302C4D0;
	Fri, 15 Jul 2016 16:58:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B09A2C4CE;
	Fri, 15 Jul 2016 16:58:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Mike Hommey <mh@glandium.org>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] blame: Allow to blame paths freshly added to the index
References: <20160715024254.29186-1-mh@glandium.org>
Date:	Fri, 15 Jul 2016 13:58:41 -0700
In-Reply-To: <20160715024254.29186-1-mh@glandium.org> (Mike Hommey's message
	of "Fri, 15 Jul 2016 11:42:54 +0900")
Message-ID: <xmqqvb06lita.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA3FEDAA-4ACE-11E6-BBE5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> When blaming files, changes in the work tree are taken into account
> and displayed as being "Not Committed Yet".
>
> However, when blaming a file that is not known to the current HEAD,
> git blame fails with `no such path 'foo' in HEAD`, even when the file
> was git add'ed.
>
> This would seem uninteresting with the plain `git blame` case, which
> it is, but it becomes useful when using copy detection, and the new file
> was created from pieces already in HEAD, moved or copied from other
> files.

I suspect that this would be useful without copy detection.  If you
"git mv fileA fileB" (optionally followed by "edit fileB"), fileB
would not be in HEAD but you should be able to trace the lineage of
the lines in it back through the renaming event, and this change
also allows that use case, no?

> ---

Missing sign-off?

>  builtin/blame.c               |  4 +++-
>  t/t8003-blame-corner-cases.sh | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 1e214bd..0858b18 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2240,7 +2240,9 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
>  		    sha1_object_info(blob_sha1, NULL) == OBJ_BLOB)
>  			return;
>  	}
> -	die("no such path '%s' in HEAD", path);
> +
> +	if (cache_name_pos(path, strlen(path)) < 0)
> +		die("no such path '%s' in HEAD", path);
>  }

This is a surprisingly small change to bring a big difference at the
usage level.  I am sort-of surprised that the "fake working tree
commit" mechanism was already prepared to handle this, even though I
am responsible for the introduction of it at 1cfe7733 (git-blame: no
rev means start from the working tree file., 2007-01-30).

Having said that, do we act differently when the index is unmerged
at path in any way?  When path exists but is unmerged, you get
negative index from cache_name_pos(), and IIUC, "blaming of working
tree file" does not care if the index is unmerged.  It creates the
fake working tree file commit, pretends HEAD is its parent, and digs
the lineage from there.

I suspect that the above change needs to be updated further if the
user wants to run "blame path" during a conflicted renaming merge,
i.e.

 0. Before two histories diverged, there was old_path.
 1. Our side updated contents of that file and kept it at old_path.
 2. Their side updated contents of that file and moved it to path.
 3. "git merge" notcied the rename, created three stages at "path",
    with the result of conflicted content-level merge in the working
    tree at "path".
 4. The user edits "path" and resolves the conflict, but wants to
    double check before running "git add path".
 5. "git blame path"

Perhaps something like this should suffice:

    pos = cache_name_pos(path, strlen(path));
    if (0 <= pos)
    	; /* ok */
    else if (!strcmp(active_cache[-1 - pos]->name), path)
        ; /* ok -- just unmerged */
    else
    	die("no such path in HEAD");

