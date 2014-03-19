From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Wed, 19 Mar 2014 15:23:33 -0700
Message-ID: <xmqqha6t25ga.fsf@gitster.dls.corp.google.com>
References: <20140319213556.2FC3D4062B@wince.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: szager@chromium.org (Stefan Zager)
X-From: git-owner@vger.kernel.org Wed Mar 19 23:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQOtj-0003jX-59
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 23:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833AbaCSWXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 18:23:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438AbaCSWXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 18:23:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 215BF75E05;
	Wed, 19 Mar 2014 18:23:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jUVmX/BPZnAt0KosGWhr8/Z69BU=; b=oqdJ5G
	A/SkeLKBJReVmL2oav3UJlOKubMPGDtnnQ7dat+gh7PBeeaJK9qkA9DLWCqcCMLA
	9oPVsNgE0Vcj16NGhv+NBA81vKYWv4/NNAYjfKZzYYNoyVcMS1bg84Qn81JMOKuZ
	/iYqqj24ay7LdFUMZd13gZ1+yLjBFZ76CN59I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uxrzWNhJKdhYJkKKfEldZNNX/j3IG45c
	OsFUCS35jD+5/JeKkz3OmwCkhEMJkHJvqbwRfMXRtXVk0fsi+BkXv7MwgYIWRT/W
	zsLDUh0kBMNV3JG4iuz4w/bzck9RlM3oNl1et7bxHNbs/N8Wc/6d4zLJeWjiAsKK
	QGiQcnM11Ns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ADBE75E04;
	Wed, 19 Mar 2014 18:23:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43EF975E03;
	Wed, 19 Mar 2014 18:23:36 -0400 (EDT)
In-Reply-To: <20140319213556.2FC3D4062B@wince.sfo.corp.google.com> (Stefan
	Zager's message of "Wed, 19 Mar 2014 14:35:56 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D120E5A-AFB5-11E3-9C2C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244502>

szager@chromium.org (Stefan Zager) writes:

> This adds a Windows implementation of pread.  Note that it is NOT
> safe to intersperse calls to read() and pread() on a file
> descriptor.  According to the ReadFile spec, using the 'overlapped'
> argument should not affect the implicit position pointer of the
> descriptor.  Experiments have shown that this is, in fact, a lie.
>
> To accomodate that fact, this change also incorporates:
>
> http://article.gmane.org/gmane.comp.version-control.git/196042
>
> ... which gives each index-pack thread its own file descriptor.
>
> Signed-off-by: Stefan Zager <szager@chromium.org>
> ---

I'll queue it on 'pu' until I hear from Windows folks.
There were a few things I tweaked while queuing, tho.

 - the indentation of the new comment inside struct thread_local
   declaration looked strange;

 - there was one new if () statement whose block was opened on the
   next line, not on the same line as if () itself.

Thanks.

>  builtin/index-pack.c | 30 ++++++++++++++++++++----------
>  compat/mingw.c       | 37 ++++++++++++++++++++++++++++++++++++-
>  compat/mingw.h       |  3 +++
>  config.mak.uname     |  1 -
>  4 files changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 2f37a38..63b8b0e 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -40,17 +40,17 @@ struct base_data {
>  	int ofs_first, ofs_last;
>  };
>  
> -#if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
> -/* pread() emulation is not thread-safe. Disable threading. */
> -#define NO_PTHREADS
> -#endif
> -
>  struct thread_local {
>  #ifndef NO_PTHREADS
>  	pthread_t thread;
>  #endif
>  	struct base_data *base_cache;
>  	size_t base_cache_used;
> +    /*
> +     * To accomodate platforms that have pthreads, but don't have a
> +     * thread-safe pread, give each thread its own file descriptor.
> +     */
> +	int pack_fd;
>  };
>  
>  /*
> @@ -91,7 +91,8 @@ static off_t consumed_bytes;
>  static unsigned deepest_delta;
>  static git_SHA_CTX input_ctx;
>  static uint32_t input_crc32;
> -static int input_fd, output_fd, pack_fd;
> +static const char *curr_pack;
> +static int input_fd, output_fd;
>  
>  #ifndef NO_PTHREADS
>  
> @@ -134,6 +135,7 @@ static inline void unlock_mutex(pthread_mutex_t *mutex)
>   */
>  static void init_thread(void)
>  {
> +	int i;
>  	init_recursive_mutex(&read_mutex);
>  	pthread_mutex_init(&counter_mutex, NULL);
>  	pthread_mutex_init(&work_mutex, NULL);
> @@ -141,11 +143,17 @@ static void init_thread(void)
>  		pthread_mutex_init(&deepest_delta_mutex, NULL);
>  	pthread_key_create(&key, NULL);
>  	thread_data = xcalloc(nr_threads, sizeof(*thread_data));
> +	for (i = 0; i < nr_threads; i++) {
> +		thread_data[i].pack_fd = open(curr_pack, O_RDONLY);
> +		if (thread_data[i].pack_fd == -1)
> +			die_errno("unable to open %s", curr_pack);
> +	}
>  	threads_active = 1;
>  }
>  
>  static void cleanup_thread(void)
>  {
> +	int i;
>  	if (!threads_active)
>  		return;
>  	threads_active = 0;
> @@ -155,6 +163,8 @@ static void cleanup_thread(void)
>  	if (show_stat)
>  		pthread_mutex_destroy(&deepest_delta_mutex);
>  	pthread_key_delete(key);
> +	for (i = 0; i < nr_threads; i++)
> +		close(thread_data[i].pack_fd);
>  	free(thread_data);
>  }
>  
> @@ -288,13 +298,13 @@ static const char *open_pack_file(const char *pack_name)
>  			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
>  		if (output_fd < 0)
>  			die_errno(_("unable to create '%s'"), pack_name);
> -		pack_fd = output_fd;
> +		nothread_data.pack_fd = output_fd;
>  	} else {
>  		input_fd = open(pack_name, O_RDONLY);
>  		if (input_fd < 0)
>  			die_errno(_("cannot open packfile '%s'"), pack_name);
>  		output_fd = -1;
> -		pack_fd = input_fd;
> +		nothread_data.pack_fd = input_fd;
>  	}
>  	git_SHA1_Init(&input_ctx);
>  	return pack_name;
> @@ -542,7 +552,7 @@ static void *unpack_data(struct object_entry *obj,
>  
>  	do {
>  		ssize_t n = (len < 64*1024) ? len : 64*1024;
> -		n = pread(pack_fd, inbuf, n, from);
> +		n = pread(get_thread_data()->pack_fd, inbuf, n, from);
>  		if (n < 0)
>  			die_errno(_("cannot pread pack file"));
>  		if (!n)
> @@ -1490,7 +1500,7 @@ static void show_pack_info(int stat_only)
>  int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  {
>  	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
> -	const char *curr_pack, *curr_index;
> +	const char *curr_index;
>  	const char *index_name = NULL, *pack_name = NULL;
>  	const char *keep_name = NULL, *keep_msg = NULL;
>  	char *index_name_buf = NULL, *keep_name_buf = NULL;
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 383cafe..0efc570 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -329,7 +329,42 @@ int mingw_mkdir(const char *path, int mode)
>  	return ret;
>  }
>  
> -int mingw_open (const char *filename, int oflags, ...)
> +
> +/*
> + * Warning: contrary to the specificiation, when ReadFile() is called
> + * with an 'overlapped' argument, it *will* modify the implict position
> + * pointer for the file descriptor.  As a result, it is *not* safe to
> + * intersperse calls to read() and pread() on a single file descriptor.
> + */
> +ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset)
> +{
> +	HANDLE hand = (HANDLE)_get_osfhandle(fd);
> +	if (hand == INVALID_HANDLE_VALUE) {
> +		errno = EBADF;
> +		return -1;
> +	}
> +
> +	LARGE_INTEGER offset_value;
> +	offset_value.QuadPart = offset;
> +
> +	DWORD bytes_read = 0;
> +	OVERLAPPED overlapped = {0};
> +	overlapped.Offset = offset_value.LowPart;
> +	overlapped.OffsetHigh = offset_value.HighPart;
> +	BOOL result = ReadFile(hand, buf, count, &bytes_read, &overlapped);
> +
> +	ssize_t ret = bytes_read;
> +
> +	if (!result && GetLastError() != ERROR_HANDLE_EOF)
> +	{
> +		errno = err_win_to_posix(GetLastError());
> +		ret = -1;
> +	}
> +
> +	return ret;
> +}
> +
> +int mingw_open(const char *filename, int oflags, ...)
>  {
>  	va_list args;
>  	unsigned mode;
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 08b83fe..377ba50 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -174,6 +174,9 @@ int mingw_unlink(const char *pathname);
>  int mingw_rmdir(const char *path);
>  #define rmdir mingw_rmdir
>  
> +ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset);
> +#define pread mingw_pread
> +
>  int mingw_open (const char *filename, int oflags, ...);
>  #define open mingw_open
>  
> diff --git a/config.mak.uname b/config.mak.uname
> index e8acc39..b405524 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -474,7 +474,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
>  	pathsep = ;
> -	NO_PREAD = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
>  	NO_POLL = YesPlease
