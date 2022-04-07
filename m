Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874DDC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 15:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiDGPWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344583AbiDGPWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 11:22:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A21FC9C8
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 08:20:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB92913454F;
        Thu,  7 Apr 2022 11:20:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L+KnUncIEURXk3h2DZuIZxscvXDxvibgA+DDw/
        fzNug=; b=sbu6vE39jAiJSyPgDxhPJ2ndJaC++RhSpFtQPUEtmPlfwpvlvGEt/H
        1ROOd0kq5mcLLzGVaginJPF8789xGqpNUhZ6VOnvV0tKhI6a9X7CMRLQEtIbHDEU
        c0GUY1MfCXhO9D4AYFd/UeBQhmuSyYfkyOVtHo2Tda5MwcpiiEvrU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B25E513454E;
        Thu,  7 Apr 2022 11:20:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D4AB13454D;
        Thu,  7 Apr 2022 11:20:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20220406232231.47714-1-chooglen@google.com>
Date:   Thu, 07 Apr 2022 08:20:37 -0700
In-Reply-To: <20220406232231.47714-1-chooglen@google.com> (Glen Choo's message
        of "Wed, 6 Apr 2022 16:22:31 -0700")
Message-ID: <xmqqzgkwudh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4765D6B0-B686-11EC-9289-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> @@ -602,6 +605,12 @@ static int fsck_tree(const struct object_id *tree_oid,
>  		has_dotdot |= !strcmp(name, "..");
>  		has_dotgit |= is_hfs_dotgit(name) || is_ntfs_dotgit(name);
>  		has_zero_pad |= *(char *)desc.buffer == '0';
> +		has_head |= !strcasecmp(name, "HEAD")
> +			&& (S_ISLNK(mode) || S_ISREG(mode));
> +		has_refs_entry |= !strcasecmp(name, "refs")
> +			&& (S_ISLNK(mode) || S_ISDIR(mode));

Sorry, I know I am to blame, but I think it is wrong to insist
"refs" (and others) to be a directory.  setup.c::is_git_directory()
only checks with access(X_OK).  Also, if I am not mistaken, we plan
to take advantage of it and may make refs a regular file, for
example, to signal that the ref-files backend is unwelcome in the
repository.  HEAD can be a symbolic link, not necessarily a regular
file.  We do not create "refs" and "objects" as symbolic links
ourselves, but it is good to see that the code protects us against
such a directory with these entries being one.

> +		has_objects_entry |= !strcasecmp(name, "objects")
> +			&& (S_ISLNK(mode) || S_ISDIR(mode));
>  
>  		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
>  			if (!S_ISLNK(mode))
> @@ -739,6 +748,16 @@ static int fsck_tree(const struct object_id *tree_oid,
>  		retval += report(options, tree_oid, OBJ_TREE,
>  				 FSCK_MSG_TREE_NOT_SORTED,
>  				 "not properly sorted");
> +	/*
> +	 * Determine if this tree looks like a bare repository according
> +	 * to the rules of setup.c. If those are changed, this should be
> +	 * changed too.
> +	 */
> +	if (has_head && has_refs_entry && has_objects_entry)
> +		retval += report(options, tree_oid, OBJ_TREE,
> +				 FSCK_MSG_EMBEDDED_BARE_REPO,
> +				 "contains bare repository");
> +
>  	return retval;
>  }
