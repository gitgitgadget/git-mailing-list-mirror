Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B181F404
	for <e@80x24.org>; Thu,  4 Jan 2018 23:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeADXrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 18:47:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53892 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeADXrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 18:47:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C697FCC671;
        Thu,  4 Jan 2018 18:47:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMXspxKlf+rX3raFMpIB2Ekq8n8=; b=a0/ap1
        ffhTLjiylWPVVpa0qcPjTKZmLW1e3N7sK3eOls5XvWTaS5WD5oOOE4FEWYX62Kz5
        qBpKu+u/s2jeeRWrqx8tSCgR5oz7IVFqPC3UtA/BdZNDXnzxyo1/5a9x7nm9g3fG
        lXhizJnZHExX7LNXv0Vm0VOZKRm8NWF0oGsR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qODHVutcVoGPyUWdZtqLtZ4mWQJrcyh0
        ZBTOtfStXYXAGiBSTy9P+tZZ1FauMiUikD6pA2umy111/jZeH86u9RDnxzs+Ok7D
        nYRtYiGpTGGA/ZaOCk+dXXKli98RkHcQ20TJBWiWGLZKFRjnPhUbugLyKqSTeksW
        FGM4SSwm250=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD1DACC670;
        Thu,  4 Jan 2018 18:47:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 218BFCC66C;
        Thu,  4 Jan 2018 18:47:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] clone: factor out dir_exists() helper
References: <20180102210753.GA10430@sigill.intra.peff.net>
        <20180102211014.GC22556@sigill.intra.peff.net>
Date:   Thu, 04 Jan 2018 15:47:18 -0800
In-Reply-To: <20180102211014.GC22556@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 2 Jan 2018 16:10:14 -0500")
Message-ID: <xmqqbmi9dw55.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A7A2546-F1A9-11E7-A1D4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Two parts of git-clone's setup logic check whether a
> directory exists, and they both call stat directly with the
> same scratch "struct stat" buffer. Let's pull that into a
> helper, which has a few advantages:
>
>   - it makes the purpose of the stat calls more obvious
>
>   - it makes it clear that we don't care about the
>     information in "buf" remaining valid
>
>   - if we later decide to make the check more robust (e.g.,
>     complaining about non-directories), we can do it in one
>     place
>
> Note that we could just use file_exists() for this, which
> has identical code. But we specifically care about
> directories, so this future-proofs us against that function
> later getting more picky about seeing actual files.

It leaves funny taste in my mouth to see that dir_exists() does call
stat() but does not check st.st_mode to see if it is a directory,
but for this particular caller, we want dest_exists() to be true
even when the thing is a non-directory, so that !is_empty_dir(dir)
call is made on the next line to trigger "exists but not an empty
dir" error.  After all, what this caller really wants to ask is "is
something sitting there?" and the answer it expects under normal
condition is "no, there is nothing there".

If we really want to be anal, perhaps a new helper path_exists()
that cares only about existence of paths (i.e. the implementation of
these two helpers they currently have), together with update to
check the st.st_mode for file_exists() and dir_exists(), may help
making the API set more rational, but I do not think it is worth it.

Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/clone.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 2da71db107..04b0d7283f 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -863,10 +863,15 @@ static void dissociate_from_references(void)
>  	free(alternates);
>  }
>  
> +static int dir_exists(const char *path)
> +{
> +	struct stat sb;
> +	return !stat(path, &sb);
> +}
> +
>  int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
>  	int is_bundle = 0, is_local;
> -	struct stat buf;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
>  	char *path, *dir;
>  	int dest_exists;
> @@ -938,7 +943,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		dir = guess_dir_name(repo_name, is_bundle, option_bare);
>  	strip_trailing_slashes(dir);
>  
> -	dest_exists = !stat(dir, &buf);
> +	dest_exists = dir_exists(dir);
>  	if (dest_exists && !is_empty_dir(dir))
>  		die(_("destination path '%s' already exists and is not "
>  			"an empty directory."), dir);
> @@ -949,7 +954,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		work_tree = NULL;
>  	else {
>  		work_tree = getenv("GIT_WORK_TREE");
> -		if (work_tree && !stat(work_tree, &buf))
> +		if (work_tree && dir_exists(work_tree))
>  			die(_("working tree '%s' already exists."), work_tree);
>  	}
