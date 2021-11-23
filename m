Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FDC433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhKWX1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:27:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52210 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhKWX1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:27:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1920A159CFC;
        Tue, 23 Nov 2021 18:24:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yNdmljhXw8hojVNl289DEmPBrAH02ZY2kcIkmw
        SEZsk=; b=OKvpZ0Lggj6BmFttM4WfipVWPUKcX+Ek9442ut0AgILLsYOfwMddHy
        0ZHGPdRxqt8Nmu919FACIIE2myHpY856qJiATTdcdlsqJtloYf25fI3kHS1W83/J
        ZPIIEkBgkI6f2yjzo1Z3RQ09TylmHaAI4u9UiYQocnfAjiqiNZLLA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1127E159CFA;
        Tue, 23 Nov 2021 18:24:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69B50159CF8;
        Tue, 23 Nov 2021 18:24:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/5] object-file: refactor write_loose_object() to
 read buffer from stream
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
        <20211122033220.32883-2-chiyutianyi@gmail.com>
Date:   Tue, 23 Nov 2021 15:24:04 -0800
In-Reply-To: <20211122033220.32883-2-chiyutianyi@gmail.com> (Han Xin's message
        of "Mon, 22 Nov 2021 11:32:16 +0800")
Message-ID: <xmqqczmq78x7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7355FE1C-4CB4-11EC-85E3-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> entire contents of a blob object, no matter how big it is. This
> implementation may consume all the memory and cause OOM.
>
> This can be improved by feeding data to "write_loose_object()" in a
> stream. The input stream is implemented as an interface. In the first
> step, we make a simple implementation, feeding the entire buffer in the
> "stream" to "write_loose_object()" as a refactor.

Possibly a stupid question (not a review).

How does this compare with "struct git_istream" implemented for a
few existing codepaths?  It seems that the existing users are
pack-objects, index-pack and archive and all of them use the
interface to obtain data given an object name without having to grab
everything in core at once.

If we are adding a new streaming interface to go in the opposite
direction, i.e. from the working tree data to object store, I would
understand it as a complementary interface (but then I suspect there
is a half of it already in bulk-checkin API), but I am not sure how
this new thing fits in the larger picture.



> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  object-store.h |  5 +++++
>  2 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index c3d866a287..227f53a0de 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1860,8 +1860,26 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
>  	return fd;
>  }
>  
> +struct simple_input_stream_data {
> +	const void *buf;
> +	unsigned long len;
> +};
> +
> +static const void *feed_simple_input_stream(struct input_stream *in_stream, unsigned long *len)
> +{
> +	struct simple_input_stream_data *data = in_stream->data;
> +
> +	if (data->len == 0) {
> +		*len = 0;
> +		return NULL;
> +	}
> +	*len = data->len;
> +	data->len = 0;
> +	return data->buf;
> +}
> +
>  static int write_loose_object(const struct object_id *oid, char *hdr,
> -			      int hdrlen, const void *buf, unsigned long len,
> +			      int hdrlen, struct input_stream *in_stream,
>  			      time_t mtime, unsigned flags)
>  {
>  	int fd, ret;
> @@ -1871,6 +1889,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  	struct object_id parano_oid;
>  	static struct strbuf tmp_file = STRBUF_INIT;
>  	static struct strbuf filename = STRBUF_INIT;
> +	const void *buf;
> +	unsigned long len;
>  
>  	loose_object_path(the_repository, &filename, oid);
>  
> @@ -1898,6 +1918,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  	the_hash_algo->update_fn(&c, hdr, hdrlen);
>  
>  	/* Then the data itself.. */
> +	buf = in_stream->read(in_stream, &len);
>  	stream.next_in = (void *)buf;
>  	stream.avail_in = len;
>  	do {
> @@ -1960,6 +1981,13 @@ int write_object_file_flags(const void *buf, unsigned long len,
>  {
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen = sizeof(hdr);
> +	struct input_stream in_stream = {
> +		.read = feed_simple_input_stream,
> +		.data = (void *)&(struct simple_input_stream_data) {
> +			.buf = buf,
> +			.len = len,
> +		},
> +	};
>  
>  	/* Normally if we have it in the pack then we do not bother writing
>  	 * it out into .git/objects/??/?{38} file.
> @@ -1968,7 +1996,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
>  				  &hdrlen);
>  	if (freshen_packed_object(oid) || freshen_loose_object(oid))
>  		return 0;
> -	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
> +	return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags);
>  }
>  
>  int hash_object_file_literally(const void *buf, unsigned long len,
> @@ -1977,6 +2005,13 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>  {
>  	char *header;
>  	int hdrlen, status = 0;
> +	struct input_stream in_stream = {
> +		.read = feed_simple_input_stream,
> +		.data = (void *)&(struct simple_input_stream_data) {
> +			.buf = buf,
> +			.len = len,
> +		},
> +	};
>  
>  	/* type string, SP, %lu of the length plus NUL must fit this */
>  	hdrlen = strlen(type) + MAX_HEADER_LEN;
> @@ -1988,7 +2023,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
>  		goto cleanup;
>  	if (freshen_packed_object(oid) || freshen_loose_object(oid))
>  		goto cleanup;
> -	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
> +	status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0);
>  
>  cleanup:
>  	free(header);
> @@ -2003,14 +2038,21 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen;
>  	int ret;
> +	struct simple_input_stream_data data;
> +	struct input_stream in_stream = {
> +		.read = feed_simple_input_stream,
> +		.data = &data,
> +	};
>  
>  	if (has_loose_object(oid))
>  		return 0;
>  	buf = read_object(the_repository, oid, &type, &len);
>  	if (!buf)
>  		return error(_("cannot read object for %s"), oid_to_hex(oid));
> +	data.buf = buf;
> +	data.len = len;
>  	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
> -	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
> +	ret = write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0);
>  	free(buf);
>  
>  	return ret;
> diff --git a/object-store.h b/object-store.h
> index 952efb6a4b..ccc1fc9c1a 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -34,6 +34,11 @@ struct object_directory {
>  	char *path;
>  };
>  
> +struct input_stream {
> +	const void *(*read)(struct input_stream *, unsigned long *len);
> +	void *data;
> +};
> +
>  KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
>  	struct object_directory *, 1, fspathhash, fspatheq)
