Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D619478
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181951; cv=none; b=dYTowtuitJN9W8DbNcIoUN9PFkZVAnPDbxf2rc9p3m/oZYaXkcEzrQUr8w1g3W4ZmiKtDe27TiPo4xb/4gVX4lIriHFFGqnuqPfP/wvqVcRv2ES0+ow5PdC+v/DM2eazVaiwpFGkw0EG9Nq01pol8gHEtq+PRIOlX23X95agquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181951; c=relaxed/simple;
	bh=hmm8RdjfFVsMYvT36GAHW9DuYlorQMjCgxw7lIipq94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dj4qyG8DeClbshTPbGtN64DWp/IlkD8T6YRubpAQpWP88F6Mp31DD5lWpKhQ+YoYSXXT8VnmyYE0zmwE8hWLG0HlOoNEcIw6TQaoOpWDQMuUCJ4bT4oLD9teJRST0h1b9kq9PgCmC0Di3Cgce3o51jEwg03je3sKDAuSXnG/MN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W09ub993; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W09ub993"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 878C7260B3;
	Tue, 20 Aug 2024 15:25:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hmm8RdjfFVsMYvT36GAHW9DuYlorQMjCgxw7lI
	ipq94=; b=W09ub993dDiOSCT4a2keGm9fedCh3xWXzgQ5JDRsxKQnaYRPrasURT
	QeDirC7JsnpEKlvwbAPey+3AcyE1AlIbTvzq8/gDzHo+mUEViI484ut6AJvBdAZN
	wgugsSaxvcxz9LF7t+4lLmQjxSzB67CkM4sp7littxlCkdBOOO+sQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8116D260B2;
	Tue, 20 Aug 2024 15:25:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E108260B1;
	Tue, 20 Aug 2024 15:25:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] mailinfo: fix leaking header data
In-Reply-To: <69e30ea5179eff6472be54ebba64ebca3e562f32.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:02 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<69e30ea5179eff6472be54ebba64ebca3e562f32.1724159575.git.ps@pks.im>
Date: Tue, 20 Aug 2024 12:25:38 -0700
Message-ID: <xmqq5xrv8099.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC2A6C2A-5F29-11EF-B990-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We populate the `mailinfo` arrays `p_hdr_data` and `s_hdr_data` with
> data parsed from the mail headers. These arrays may end up being only
> partially populated with gaps in case some of the headers do not parse
> properly. This causes memory leaks because `strbuf_list_free()` will
> stop iterating once it hits the first `NULL` pointer in the backing
> array.
>
> Fix this by open-coding a variant of `strbuf_list_free()` that knows to
> iterate through all headers.

Well spotted.  An array of strbuf is often a wrong data structure
for anything, but luckily we use it and suffer from a bug like this
only rarely.

The fix makes sense.  Will queue.



>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  mailinfo.c          | 17 +++++++++++++++--
>  t/t5100-mailinfo.sh |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index 94b9b0abf22..a4fa64994ac 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -1290,8 +1290,21 @@ void clear_mailinfo(struct mailinfo *mi)
>  	strbuf_release(&mi->inbody_header_accum);
>  	free(mi->message_id);
>  
> -	strbuf_list_free(mi->p_hdr_data);
> -	strbuf_list_free(mi->s_hdr_data);
> +	for (size_t i = 0; header[i]; i++) {
> +		if (!mi->p_hdr_data[i])
> +			continue;
> +		strbuf_release(mi->p_hdr_data[i]);
> +		free(mi->p_hdr_data[i]);
> +	}
> +	free(mi->p_hdr_data);
> +
> +	for (size_t i = 0; header[i]; i++) {
> +		if (!mi->s_hdr_data[i])
> +			continue;
> +		strbuf_release(mi->s_hdr_data[i]);
> +		free(mi->s_hdr_data[i]);
> +	}
> +	free(mi->s_hdr_data);
>  
>  	while (mi->content < mi->content_top) {
>  		free(*(mi->content_top));
> diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
> index c8d06554541..065156c1f39 100755
> --- a/t/t5100-mailinfo.sh
> +++ b/t/t5100-mailinfo.sh
> @@ -5,6 +5,7 @@
>  
>  test_description='git mailinfo and git mailsplit test'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  DATA="$TEST_DIRECTORY/t5100"
