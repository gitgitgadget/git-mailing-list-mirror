Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576981FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 03:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbdJLD6r (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 23:58:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57813 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753308AbdJLD6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 23:58:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93613B787A;
        Wed, 11 Oct 2017 23:58:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6DzT7WLCcDiQdcO7OxKD8jwmpbM=; b=QdiN1j
        DtLJfrFrZ1gzYHi+fWmYnLmnv45WsZzsc7RJvZkrg0/TbEi42suOiVOeN4NCfxLf
        1fMMQcqIaf7ZAWvP3e5G4qQEwg3FDRQWFvriamrXHqZbzztjMozz8RVNqsFA6/De
        J2AsK7K1K8PhBBsbH71q7vLSnYDHJF229wQgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hht1WALOKCzWXYprKnfQ6U3NDUkn91vZ
        9V5jVrWgqNn+ZWArT1VPzTovv3s4KXjTUVp0N1aw8J27dT3fsAicx8sT6E15tRx6
        QKECc9YFmhHHAErhPSnhMZr5J6JSD9zs/GXzpIwng5dB9JrO9aOxWnoXJ/veO8Sf
        VDgZGTDU/6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8836CB7879;
        Wed, 11 Oct 2017 23:58:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E667FB7878;
        Wed, 11 Oct 2017 23:58:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v2 4/5] Expand support for ignored arguments on status
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171011133504.15049-1-jamill@microsoft.com>
        <20171011133504.15049-5-jamill@microsoft.com>
Date:   Thu, 12 Oct 2017 12:58:43 +0900
In-Reply-To: <20171011133504.15049-5-jamill@microsoft.com> (Jameson Miller's
        message of "Wed, 11 Oct 2017 09:35:03 -0400")
Message-ID: <xmqqinfl10gc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A49C6D30-AF01-11E7-A56A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> Teach status command to handle matching ignored mode when showing
> untracked files with the normal option.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  dir.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index b9af87eca9..8636d080b2 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1585,6 +1585,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>  {
>  	int exclude;
>  	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
> +	enum path_treatment path_treatment;
>  
>  	if (dtype == DT_UNKNOWN)
>  		dtype = get_dtype(de, istate, path->buf, path->len);
> @@ -1631,8 +1632,23 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>  		return path_none;
>  	case DT_DIR:
>  		strbuf_addch(path, '/');
> -		return treat_directory(dir, istate, untracked, path->buf, path->len,
> -				       baselen, exclude, pathspec);
> +		path_treatment = treat_directory(dir, istate, untracked,
> +						 path->buf, path->len,
> +						 baselen, exclude, pathspec);
> +		/*
> +		 * If we are only want to return directories that
> +		 * match an exclude pattern, and this directories does

s/are //; s/directories/directory/

> +		 * not match an exclude pattern but all contents are
> +		 * excluded, then indicate that we should recurse into
> +		 * this directory (instead of marking the directory
> +		 * itself as an ignored path)
> +		 */
> +		if (!exclude &&
> +		    path_treatment == path_excluded &&
> +		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
> +		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
> +			return path_recurse;
> +		return path_treatment;

The required change to the code is surprisingly small ;-) and it is
well explained in the comment.  Good job.


>  	case DT_REG:
>  	case DT_LNK:
>  		return exclude ? path_excluded : path_untracked;
