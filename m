Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D3219FF
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 05:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737315; cv=none; b=jsWbUzXXfvmgDZ4lewfj1qajAtf6XHmjc6CoE2bpTtoBMNw7ZZG+LdIoImkg22gU8xgOg11D4bv88+GurPPdvFUOiw6jARfDEhkZq/b4Z4eA3CUyp4CSN2PwwAE9hbpF2QeQJ3dLg7GJjiI+OJSKXPDRR4WySWNA2mxQFq/kh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737315; c=relaxed/simple;
	bh=eWngbrjXpJpcuTXhQKQQbKGUx0bTP6vEvyxK/r/qYXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLdc+mZ0A6Cu+hbktJ/G8GHZRyhRdKoRiJU2AZEiEb0DQAMeml63SkZwf/oQYONl/00tWyDHgjEJHEg0NVHL47Y3dOKP14hneD2Z4VOVDiitKghDhLMMb8aQM1OY5jW0GN38CRH5LP/glKg5m/38gBvf5/xodY18qXogigXws6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GcdAi5xh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GcdAi5xh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 172F82C243;
	Tue, 27 Aug 2024 01:41:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eWngbrjXpJpcuTXhQKQQbKGUx0bTP6vEvyxK/r
	/qYXI=; b=GcdAi5xhE7nTt7/K0VJvUoL5xjxOh1fUILFIVcMwzOfJfIaeBddY8V
	jYFaNTObrol/w6yL0+1HaICyka62RsHKX+SQoKXQrJIJ80xRrnlDDb3yOoENC/+G
	/Hk80hsHUgS9NP7q7PXunxfBItNyCnbYWCCj8VPoMvf1u4/77JgQw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EA0F2C242;
	Tue, 27 Aug 2024 01:41:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D5CC2C241;
	Tue, 27 Aug 2024 01:41:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 10/10] cat-file: use writev(2) if available
In-Reply-To: <20240823224630.1180772-11-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:30 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-11-e@80x24.org>
Date: Mon, 26 Aug 2024 22:41:47 -0700
Message-ID: <xmqq1q2acyjo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E3C1FB4-6437-11EF-92BF-BF444491E1BC-77302942!pb-smtp20.pobox.com

Eric Wong <e@80x24.org> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index bf81054662..016b7d26a7 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -280,7 +280,7 @@ struct expand_data {
>  	off_t disk_size;
>  	const char *rest;
>  	struct object_id delta_base_oid;
> -	void *content;
> +	struct git_iovec iov[3];


The earlier content pointer hinted that the caller that obtained
data into this structure from the object layer can use it for any
purpose that suits it, but using git_iovec structure screams that
"we are going to write this thing out!".  As "expand_data" is about
what we are going to write out from cat-file anyway, is probably OK.

Having said that ...

> -static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
> +static void batch_writev(struct batch_options *opt, struct expand_data *data,
> +			const struct strbuf *hdr, size_t size)
> +{
> +	data->iov[0].iov_base = hdr->buf;
> +	data->iov[0].iov_len = hdr->len;
> +	data->iov[1].iov_len = size;
> +
> +	/*
> +	 * Copying a (8|16)-byte iovec for a single byte is gross, but my
> +	 * attempt to stuff output_delim into the trailing NUL byte of
> +	 * iov[1].iov_base (and restoring it after writev(2) for the
> +	 * OI_DBCACHED case) to drop iovcnt from 3->2 wasn't faster.
> +	 */
> +	data->iov[2].iov_base = &opt->output_delim;
> +	data->iov[2].iov_len = 1;
> +	if (opt->buffer_output)
> +		fwritev_or_die(stdout, data->iov, 3);
> +	else
> +		writev_or_die(1, data->iov, 3);
> +
> +	/* writev_or_die may move iov[1].iov_base, so it's invalid */
> +	data->iov[1].iov_base = NULL;
> +}

... the above made me read it twice, wondering "where does
iov[1].iov_base comes from???"  The location of the git_iovec
structure in the expand_data forces this rather unnatural calling
convention where the iovec is passed by address (as part of the
expand_data structure), with only one of six slots filled, and the
other five slots are filled by this function from the parameters
passed to it.

I wonder if we can rework the data structure to

 - Not embed git_iovec iov[] in expand_data;

 - Keep "void *content" instead there;

 - Define an on-stack "struct git_iovec iov[3]" local to this function;

 - Pass "void *content" from the caller to this function;

 - Populate iov[] fully from hdr->{buf,len}, content, size, and
   opt->output_delim and consume it in this function by either
   calling fwritev_or_die() or writev_or_die().

That way, the caller does not have to use data->iov[1].iov_base in
place of data->content, which is the source of "Huh?  Why is the 2nd
element of the 3-element array so special?" puzzlement readers would
feel while reading the caller---after all, the fact that we are
using writev with three chunks is an implementation detail that the
caller does not have to know to correctly use this helper function.

Or am I missing something?

> +static void print_object_or_die(struct batch_options *opt,
> +				struct expand_data *data, struct strbuf *hdr)
>  {
>  	const struct object_id *oid = &data->oid;
>  
>  	assert(data->info.typep);
>  
> -	if (data->content) {
> -		void *content = data->content;
> +	if (data->iov[1].iov_base) {
> +		void *content = data->iov[1].iov_base;
>  		unsigned long size = data->size;
>  
> -		data->content = NULL;
>  		if (use_mailmap && (data->type == OBJ_COMMIT ||
>  					data->type == OBJ_TAG)) {
>  			size_t s = size;
> @@ -399,10 +424,10 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  			}
>  
>  			content = replace_idents_using_mailmap(content, &s);
> +			data->iov[1].iov_base = content;
>  			size = cast_size_t_to_ulong(s);
>  		}
> -
> -		batch_write(opt, content, size);
> +		batch_writev(opt, data, hdr, size);
>  		switch (data->info.whence) {
>  		case OI_CACHED:
>  			/*

And with the "let's make iov[3] a local implementation detail of
batch_writev()" approach, the above two hunks would shrink and
essentialy we'd replace batch_write() with batch_writev() (with
adjusted parameters).

> @@ -419,8 +444,6 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  		}
>  	} else {
>  		assert(data->type == OBJ_BLOB);
> -		if (opt->buffer_output)
> -			fflush(stdout);

We used to fflush whatever we have written before entering this
"else" clause.  We no longer do so

>  		if (opt->transform_mode) {
>  			char *contents;
>  			unsigned long size;
> @@ -447,10 +470,15 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  					    oid_to_hex(oid), data->rest);
>  			} else
>  				BUG("invalid transform_mode: %c", opt->transform_mode);
> -			batch_write(opt, contents, size);
> +			data->iov[1].iov_base = contents;
> +			batch_writev(opt, data, hdr, size);

And in the buffer_output mode, batch_writev() ends up calling
fwritev_or_die(), which is merely a series of fwrite() calls.  And
the removed fflush() earlier is perfectly fine, as it was solely
because we wanted to make sure fflush() before going down to direct
file descriptor access with write(2) and we are now still going
through stdio layer.

>  			free(contents);
>  		} else {
> +			batch_write(opt, hdr->buf, hdr->len);
> +			if (opt->buffer_output)
> +				fflush(stdout);

The bigger else clause is entered with potentially unflushed bytes
in the stdio buffer, as that was why we first fflush().  Then we do
batch_write() here, which uses fwrite() in the buffer_output mode,
without having to fflush().  But before doing stream_blob() below,
we do need to fflush().  Makes sense.

>  static void batch_one_object(const char *obj_name,
> @@ -666,7 +692,7 @@ static void parse_cmd_contents(struct batch_options *opt,
>  			     struct expand_data *data)
>  {
>  	opt->batch_mode = BATCH_MODE_CONTENTS;
> -	data->info.contentp = &data->content;
> +	data->info.contentp = &data->iov[1].iov_base;
>  	batch_one_object(line, output, opt, data);
>  }
>  
> @@ -823,7 +849,7 @@ static int batch_objects(struct batch_options *opt)
>  		data.info.typep = &data.type;
>  		if (!opt->transform_mode) {
>  			data.info.sizep = &data.size;
> -			data.info.contentp = &data.content;
> +			data.info.contentp = &data.iov[1].iov_base;
>  			data.info.content_limit = big_file_threshold;
>  			data.info.direct_cache = 1;
>  		}

If we do the "let's not leak the iov[3] implementation detail from
batch_writev()" update, the above two hunks can be eliminated.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index ca7678a379..afde8abc99 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -388,6 +388,16 @@ static inline int git_setitimer(int which UNUSED,
>  #define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
>  #endif
>  
> +#ifdef HAVE_WRITEV
> +#include <sys/uio.h>
> +#define git_iovec iovec
> +#else /* !HAVE_WRITEV */
> +struct git_iovec {
> +	void *iov_base;
> +	size_t iov_len;
> +};
> +#endif /* !HAVE_WRITEV */

OK.

> diff --git a/write-or-die.c b/write-or-die.c
> index 01a9a51fa2..227b051165 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -107,3 +107,69 @@ void fflush_or_die(FILE *f)
>  	if (fflush(f))
>  		die_errno("fflush error");
>  }
> +
> +void fwritev_or_die(FILE *fp, const struct git_iovec *iov, int iovcnt)
> +{
> +	int i;
> +
> +	for (i = 0; i < iovcnt; i++) {
> +		size_t n = iov[i].iov_len;
> +
> +		if (fwrite(iov[i].iov_base, 1, n, fp) != n)
> +			die_errno("unable to write to FD=%d", fileno(fp));
> +	}
> +}

OK.

