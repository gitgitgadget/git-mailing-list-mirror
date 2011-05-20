From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 06/11] streaming: a new API to read from the object
 store
Date: Sat, 21 May 2011 01:05:36 +0200
Message-ID: <4DD6F3C0.4060107@lsrfire.ath.cx>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com> <1305840826-7783-1-git-send-email-gitster@pobox.com> <1305840826-7783-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 01:06:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNYlg-0001KC-EO
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 01:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab1ETXF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 19:05:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:45832 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab1ETXF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 19:05:56 -0400
Received: from [192.168.2.106] (p4FFDA965.dip.t-dialin.net [79.253.169.101])
	by india601.server4you.de (Postfix) with ESMTPSA id CCA012F8086;
	Sat, 21 May 2011 01:05:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1305840826-7783-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174084>

Am 19.05.2011 23:33, schrieb Junio C Hamano:
> Given an object name, use open_istream() to get a git_istream handle
> that you can read_istream() from as if you are using read(2) to read
> the contents of the object, and close it with close_istream() when
> you are done.
> 
> Currently, we do not do anything fancy--it just calls read_sha1_file()
> and keeps the contents in memory as a whole, and carve it out as you
> request with read_istream().
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile    |    2 +
>  streaming.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  streaming.h |   15 +++++
>  3 files changed, 216 insertions(+), 0 deletions(-)
>  create mode 100644 streaming.c
>  create mode 100644 streaming.h
> 
> diff --git a/Makefile b/Makefile
> index 320ccc7..83bd539 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -552,6 +552,7 @@ LIB_H += sha1-lookup.h
>  LIB_H += sideband.h
>  LIB_H += sigchain.h
>  LIB_H += strbuf.h
> +LIB_H += streaming.h
>  LIB_H += string-list.h
>  LIB_H += submodule.h
>  LIB_H += tag.h
> @@ -657,6 +658,7 @@ LIB_OBJS += shallow.o
>  LIB_OBJS += sideband.o
>  LIB_OBJS += sigchain.o
>  LIB_OBJS += strbuf.o
> +LIB_OBJS += streaming.o
>  LIB_OBJS += string-list.o
>  LIB_OBJS += submodule.o
>  LIB_OBJS += symlinks.o
> diff --git a/streaming.c b/streaming.c
> new file mode 100644
> index 0000000..84330b4
> --- /dev/null
> +++ b/streaming.c
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright (c) 2011, Google Inc.
> + */
> +#include "cache.h"
> +#include "streaming.h"
> +
> +enum input_source {
> +	stream_error = -1,
> +	incore = 0,
> +	loose = 1,
> +	pack_non_delta = 2
> +};
> +
> +typedef int (*open_istream_fn)(struct git_istream *,
> +			       struct object_info *,
> +			       const unsigned char *,
> +			       enum object_type *);
> +typedef int (*close_istream_fn)(struct git_istream *);
> +typedef ssize_t (*read_istream_fn)(struct git_istream *, char *, size_t);
> +
> +struct stream_vtbl {
> +	close_istream_fn close;
> +	read_istream_fn read;
> +};
> +
> +#define open_method_decl(name) \
> +	int open_istream_ ##name \
> +	(struct git_istream *st, struct object_info *oi, \
> +	 const unsigned char *sha1, \
> +	 enum object_type *type)
> +
> +#define close_method_decl(name) \
> +	int close_istream_ ##name \
> +	(struct git_istream *st)
> +
> +#define read_method_decl(name) \
> +	ssize_t read_istream_ ##name \
> +	(struct git_istream *st, char *buf, size_t sz)

It would be nice if those macros could be got rid of once the interface
stabilizes.

> +
> +/* forward declaration */
> +static open_method_decl(incore);
> +static open_method_decl(loose);
> +static open_method_decl(pack_non_delta);
> +
> +static open_istream_fn open_istream_tbl[] = {
> +	open_istream_incore,
> +	open_istream_loose,
> +	open_istream_pack_non_delta,
> +};

These three uses of the macro can be avoided by moving open_istream_tbl
and open_istream() to the end of the file.  It would be just as clear
and clean, albeit not as close to literal programming style.

> +
> +struct git_istream {
> +	enum input_source source;

source seems to be write-only.

> +	const struct stream_vtbl *vtbl;
> +	unsigned long size; /* inflated size of full object */
> +
> +	union {
> +		struct {
> +			char *buf; /* from read_object() */
> +			unsigned long read_ptr;
> +		} incore;
> +
> +		struct {
> +			int fd; /* open for reading */
> +			/* NEEDSWORK: what else? */
> +		} loose;
> +
> +		struct {
> +			int fd; /* open for reading */
> +			/* NEEDSWORK: what else? */
> +		} in_pack;
> +	} u;
> +};
> +
> +int close_istream(struct git_istream *st)
> +{
> +	return st->vtbl->close(st);
> +}
> +
> +ssize_t read_istream(struct git_istream *st, char *buf, size_t sz)
> +{
> +	return st->vtbl->read(st, buf, sz);
> +}
> +
> +static enum input_source istream_source(const unsigned char *sha1,
> +					enum object_type *type,
> +					struct object_info *oi)
> +{
> +	unsigned long size;
> +	int status;
> +
> +	oi->sizep = &size;
> +	status = sha1_object_info_extended(sha1, oi);
> +	if (status < 0)
> +		return stream_error;
> +	*type = status;
> +
> +	switch (oi->whence) {
> +	case OI_LOOSE:
> +		return loose;
> +	case OI_PACKED:
> +		if (!oi->u.packed.is_delta && big_file_threshold <= size)
> +			return pack_non_delta;
> +		/* fallthru */
> +	default:
> +		return incore;
> +	}
> +}
> +
> +struct git_istream *open_istream(const unsigned char *sha1,
> +				 enum object_type *type,
> +				 unsigned long *size)
> +{
> +	struct git_istream *st;
> +	struct object_info oi;
> +	const unsigned char *real = lookup_replace_object(sha1);
> +	enum input_source src = istream_source(real, type, &oi);
> +
> +	if (src < 0)
> +		return NULL;
> +
> +	st = xmalloc(sizeof(*st));
> +	st->source = src;
> +	if (open_istream_tbl[src](st, &oi, real, type)) {
> +		if (open_istream_incore(st, &oi, real, type)) {
> +			free(st);
> +			st = NULL;

			return NULL;
			// Otherwise we get a problem three lines down.

> +		}
> +	}
> +	*size = st->size;
> +	return st;
> +}
> +
> +/*****************************************************************
> + *
> + * Loose object stream
> + *
> + *****************************************************************/
> +
> +static open_method_decl(loose)
> +{
> +	return -1; /* for now */
> +}
> +
> +
> +/*****************************************************************
> + *
> + * Non-delta packed object stream
> + *
> + *****************************************************************/
> +
> +static open_method_decl(pack_non_delta)
> +{
> +	return -1; /* for now */
> +}
> +
> +
> +/*****************************************************************
> + *
> + * In-core stream
> + *
> + *****************************************************************/
> +
> +static close_method_decl(incore)
> +{
> +	free(st->u.incore.buf);
> +	return 0;
> +}
> +
> +static read_method_decl(incore)
> +{
> +	size_t read_size = sz;
> +	size_t remainder = st->size - st->u.incore.read_ptr;
> +
> +	if (remainder <= read_size)
> +		read_size = remainder;
> +	if (read_size) {
> +		memcpy(buf, st->u.incore.buf + st->u.incore.read_ptr, read_size);
> +		st->u.incore.read_ptr += read_size;
> +	}
> +	return read_size;
> +}
> +
> +static struct stream_vtbl incore_vtbl = {
> +	close_istream_incore,
> +	read_istream_incore,
> +};
> +
> +static open_method_decl(incore)
> +{
> +	st->u.incore.buf = read_sha1_file_extended(sha1, type, &st->size, 0);
> +	st->u.incore.read_ptr = 0;
> +	st->vtbl = &incore_vtbl;
> +
> +	if (!st->u.incore.buf) {
> +		free(st->u.incore.buf);

free(NULL) is a noop.

> +		return -1;
> +	}
> +	return 0;
> +}
> diff --git a/streaming.h b/streaming.h
> new file mode 100644
> index 0000000..18cbe68
> --- /dev/null
> +++ b/streaming.h
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (c) 2011, Google Inc.
> + */
> +#ifndef STREAMING_H
> +#define STREAMING_H 1
> +#include "cache.h"
> +
> +/* opaque */
> +struct git_istream;
> +
> +extern struct git_istream *open_istream(const unsigned char *, enum object_type *, unsigned long *);
> +extern int close_istream(struct git_istream *);
> +extern ssize_t read_istream(struct git_istream *, char *, size_t);
> +
> +#endif /* STREAMING_H */
