Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F0C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0F461053
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhHRKOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:14:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:44001 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232421AbhHRKOt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:14:49 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mGIaG-0009Kv-8g; Wed, 18 Aug 2021 11:14:12 +0100
Subject: Re: [PATCH v3 08/25] Provide zlib's uncompress2 from
 compat/zlib-compat.c
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <d92338467d66fcfedd57f209c97a798e9920d1e5.1629207607.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e1959ed9-beed-f110-c9a8-da8ed352dcda@iee.email>
Date:   Wed, 18 Aug 2021 11:14:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d92338467d66fcfedd57f209c97a798e9920d1e5.1629207607.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2021 14:39, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This will be needed for reading reflog blocks in reftable.

How large might the reftable become? In particular will it exceed the
32bit Long limit on Windows?

I ask as the Zlib library is one of (among many) the constraints on
beating the 4GB [backward compatibility] size limit from 32 bit Windows.

>
> Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  Makefile                  |  7 +++
>  ci/lib.sh                 |  1 +
>  compat/.gitattributes     |  1 +
>  compat/zlib-uncompress2.c | 92 +++++++++++++++++++++++++++++++++++++++
>  config.mak.uname          |  1 +
>  configure.ac              | 13 ++++++
>  6 files changed, 115 insertions(+)
>  create mode 100644 compat/.gitattributes
>  create mode 100644 compat/zlib-uncompress2.c
>
> diff --git a/Makefile b/Makefile
> index e98d8ed17cf..16c883978d4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -256,6 +256,8 @@ all::
>  #
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
> +# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
> +#
>  # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
>  # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
>  #
> @@ -1738,6 +1740,11 @@ ifdef NO_DEFLATE_BOUND
>  	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
>  endif
>  
> +ifdef NO_UNCOMPRESS2
> +	BASIC_CFLAGS += -DNO_UNCOMPRESS2
> +	REFTABLE_OBJS += compat/zlib-uncompress2.o
> +endif
> +
>  ifdef NO_POSIX_GOODIES
>  	BASIC_CFLAGS += -DNO_POSIX_GOODIES
>  endif
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 476c3f369f5..5711c63979d 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -224,6 +224,7 @@ linux-gcc-default)
>  	;;
>  Linux32)
>  	CC=gcc
> +	MAKEFLAGS="$MAKEFLAGS NO_UNCOMPRESS2=1"
>  	;;
>  linux-musl)
>  	CC=gcc
> diff --git a/compat/.gitattributes b/compat/.gitattributes
> new file mode 100644
> index 00000000000..40dbfb170da
> --- /dev/null
> +++ b/compat/.gitattributes
> @@ -0,0 +1 @@
> +/zlib-uncompress2.c	whitespace=-indent-with-non-tab,-trailing-space
> diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
> new file mode 100644
> index 00000000000..6893bb469ce
> --- /dev/null
> +++ b/compat/zlib-uncompress2.c
> @@ -0,0 +1,92 @@
> +/* taken from zlib's uncompr.c
> +
> +   commit cacf7f1d4e3d44d871b605da3b647f07d718623f
> +   Author: Mark Adler <madler@alumni.caltech.edu>
> +   Date:   Sun Jan 15 09:18:46 2017 -0800
> +
> +       zlib 1.2.11
> +
> +*/
> +
> +/*
> + * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
> + * For conditions of distribution and use, see copyright notice in zlib.h
> + */
> +
> +#include <zlib.h>
> +
> +/* clang-format off */
> +
> +/* ===========================================================================
> +     Decompresses the source buffer into the destination buffer.  *sourceLen is
> +   the byte length of the source buffer. Upon entry, *destLen is the total size
> +   of the destination buffer, which must be large enough to hold the entire
> +   uncompressed data. (The size of the uncompressed data must have been saved
> +   previously by the compressor and transmitted to the decompressor by some
> +   mechanism outside the scope of this compression library.) Upon exit,
> +   *destLen is the size of the decompressed data and *sourceLen is the number
> +   of source bytes consumed. Upon return, source + *sourceLen points to the
> +   first unused input byte.
> +
> +     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not enough
> +   memory, Z_BUF_ERROR if there was not enough room in the output buffer, or
> +   Z_DATA_ERROR if the input data was corrupted, including if the input data is
> +   an incomplete zlib stream.
> +*/
> +int ZEXPORT uncompress2 (
> +    Bytef *dest,
> +    uLongf *destLen,
> +    const Bytef *source,
> +    uLong *sourceLen) {

Length is limited to 4GB on Windows (the pointer itself will be
implicitly size_t, but ...)

> +    z_stream stream;
> +    int err;
> +    const uInt max = (uInt)-1;
> +    uLong len, left;
> +    Byte buf[1];    /* for detection of incomplete stream when *destLen == 0 */
> +
> +    len = *sourceLen;
> +    if (*destLen) {
> +        left = *destLen;
> +        *destLen = 0;
> +    }
> +    else {
> +        left = 1;
> +        dest = buf;
> +    }
> +
> +    stream.next_in = (z_const Bytef *)source;
> +    stream.avail_in = 0;
> +    stream.zalloc = (alloc_func)0;
> +    stream.zfree = (free_func)0;
> +    stream.opaque = (voidpf)0;
> +
> +    err = inflateInit(&stream);
> +    if (err != Z_OK) return err;
> +
> +    stream.next_out = dest;
> +    stream.avail_out = 0;
> +
> +    do {
> +        if (stream.avail_out == 0) {
> +            stream.avail_out = left > (uLong)max ? max : (uInt)left;
> +            left -= stream.avail_out;
> +        }
> +        if (stream.avail_in == 0) {
> +            stream.avail_in = len > (uLong)max ? max : (uInt)len;
> +            len -= stream.avail_in;
> +        }
> +        err = inflate(&stream, Z_NO_FLUSH);
> +    } while (err == Z_OK);
> +
> +    *sourceLen -= len + stream.avail_in;
> +    if (dest != buf)
> +        *destLen = stream.total_out;
> +    else if (stream.total_out && err == Z_BUF_ERROR)
> +        left = 1;
> +
> +    inflateEnd(&stream);
> +    return err == Z_STREAM_END ? Z_OK :
> +           err == Z_NEED_DICT ? Z_DATA_ERROR  :
> +           err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
> +           err;
> +}
> diff --git a/config.mak.uname b/config.mak.uname
> index 69413fb3dc0..61e11550b1f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -256,6 +256,7 @@ ifeq ($(uname_S),FreeBSD)
>  	FILENO_IS_A_MACRO = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),OpenBSD)
> +	NO_UNCOMPRESS2 = YesPlease
>  	NO_STRCASESTR = YesPlease
>  	NO_MEMMEM = YesPlease
>  	USE_ST_TIMESPEC = YesPlease
> diff --git a/configure.ac b/configure.ac
> index 031e8d3fee8..c3a913103d0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -672,9 +672,22 @@ AC_LINK_IFELSE([ZLIBTEST_SRC],
>  	NO_DEFLATE_BOUND=yes])
>  LIBS="$old_LIBS"
>  
> +AC_DEFUN([ZLIBTEST_UNCOMPRESS2_SRC], [
> +AC_LANG_PROGRAM([#include <zlib.h>],
> + [uncompress2(NULL,NULL,NULL,NULL);])])
> +AC_MSG_CHECKING([for uncompress2 in -lz])
> +old_LIBS="$LIBS"
> +LIBS="$LIBS -lz"
> +AC_LINK_IFELSE([ZLIBTEST_UNCOMPRESS2_SRC],
> +	[AC_MSG_RESULT([yes])],
> +	[AC_MSG_RESULT([no])
> +	NO_UNCOMPRESS2=yes])
> +LIBS="$old_LIBS"
> +
>  GIT_UNSTASH_FLAGS($ZLIB_PATH)
>  
>  GIT_CONF_SUBST([NO_DEFLATE_BOUND])
> +GIT_CONF_SUBST([NO_UNCOMPRESS2])
>  
>  #
>  # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
--
Philip
