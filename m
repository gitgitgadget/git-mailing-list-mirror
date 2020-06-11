Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41440C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6702078D
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S3960wPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFKBLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:11:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61236 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKBLB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 21:11:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A654DC68D;
        Wed, 10 Jun 2020 21:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rukPymp9ABvmcJ9IhZZV9xOc3yc=; b=S3960w
        Pv48fc9iGr81V56jLI+y55V7TIJC9ViEligqM7fA4BfKjJwwVtNyIPRidyPc9fip
        RgGhBgC4DKV4SKcAYd8IRrC98QldqrOl4Xb9ISAoWUswg+1JoLWo2aPe3fz4bd9L
        BR3X5Hz80eqNB3yH7YtDRoWYQSEGu3wr+0MmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wblx7dTRhxo3vvSYva6oCZk9OBUs0Vdh
        raefCKIegeIlhjIOxyif7mVNLo16Z0HvKqu32wTnVVt8IGVQLKmESYDAT+73iIMY
        Zdn6dVobjONCW9dGxSYji0eQUSFkckjpTazplSn6kMeuoWtx8kitYkLkMUF14Ohu
        aLJQoEQnrkQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03188DC68C;
        Wed, 10 Jun 2020 21:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 481DADC68B;
        Wed, 10 Jun 2020 21:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/9] http: use --stdin when indexing dumb HTTP pack
References: <cover.1590789428.git.jonathantanmy@google.com>
        <cover.1591821067.git.jonathantanmy@google.com>
        <d3b27394cad951a9f1412a04572439513d7e9f4d.1591821067.git.jonathantanmy@google.com>
Date:   Wed, 10 Jun 2020 18:10:55 -0700
In-Reply-To: <d3b27394cad951a9f1412a04572439513d7e9f4d.1591821067.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 10 Jun 2020 13:57:15 -0700")
Message-ID: <xmqqsgf2csps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67C17BFC-AB80-11EA-A1B5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/http.c b/http.c
> index 62aa995245..39cbd56702 100644
> --- a/http.c
> +++ b/http.c
> @@ -2270,9 +2270,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  {
>  	struct packed_git **lst;
>  	struct packed_git *p = preq->target;
> -	char *tmp_idx;
> -	size_t len;
>  	struct child_process ip = CHILD_PROCESS_INIT;
> +	int tmpfile_fd;
> +	int ret = 0;
>  
>  	close_pack_index(p);
>  
> @@ -2284,35 +2284,24 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  		lst = &((*lst)->next);
>  	*lst = (*lst)->next;
>  
> -	if (!strip_suffix(preq->tmpfile.buf, ".pack.temp", &len))
> -		BUG("pack tmpfile does not end in .pack.temp?");
> -	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile.buf);
> +	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);

Shouldn't we catch the case where we cannot open the file for
reading and return -1 to have the caller handle the error, just like
the case where other errors are detected in this function?

>  	argv_array_push(&ip.args, "index-pack");
> -	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
> -	argv_array_push(&ip.args, preq->tmpfile.buf);
> +	argv_array_push(&ip.args, "--stdin");
>  	ip.git_cmd = 1;
> -	ip.no_stdin = 1;
> +	ip.in = tmpfile_fd;
>  	ip.no_stdout = 1;
>  
>  	if (run_command(&ip)) {
> -		unlink(preq->tmpfile.buf);
> -		unlink(tmp_idx);
> -		free(tmp_idx);
> -		return -1;
> -	}
> -
> -	unlink(sha1_pack_index_name(p->hash));
> -
> -	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->hash))
> -	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->hash))) {
> -		free(tmp_idx);
> -		return -1;
> +		ret = -1;
> +		goto cleanup;
>  	}
>  
>  	install_packed_git(the_repository, p);
> -	free(tmp_idx);
> -	return 0;
> +cleanup:
> +	close(tmpfile_fd);
> +	unlink(preq->tmpfile.buf);
> +	return ret;
>  }
>  
>  struct http_pack_request *new_http_pack_request(
