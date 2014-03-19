From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Wed, 19 Mar 2014 13:57:45 -0700
Message-ID: <xmqqbnx13nzq.fsf@gitster.dls.corp.google.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: szager@chromium.org
X-From: git-owner@vger.kernel.org Wed Mar 19 21:58:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNYk-0007SP-JM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 21:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbaCSU5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 16:57:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbaCSU5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 16:57:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2128475436;
	Wed, 19 Mar 2014 16:57:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tNtVsz2rWbH1GaR9Gwv1LRG6ylg=; b=WX0eeW
	pYn0gHeQaU3Tq20SmaaTTDC8F6Hds9W7HIUYMdTOLl7i6sBNDb4PYT1FH4uG2qnx
	7KCPOkgITRHPhscDJlT5T6z7Z26AHJ8V5n2Nbk7CDmBxie2A8oX3fSABEnBT6IgD
	G6jUzA+rltZo2E7fW5yQDepHWEKCBT5DZooTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ko0atbWMPj/IRx8Yhw5oi8zgeth0mzT+
	DzuAL/BzQZ2LCZXNMy5mHwx+jNSTrdXRNpUT6DW7pz5GhMW70kyPe/L+HStrvMaA
	DcNKhKkfYsU4+qUTmmjDd/iUwo3aC0lxSc75PmFQNvJx7bVnnab/JM/Xrlk57y9n
	l21ZV2BG9vw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D75675434;
	Wed, 19 Mar 2014 16:57:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31D3475432;
	Wed, 19 Mar 2014 16:57:49 -0400 (EDT)
In-Reply-To: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
	(szager@chromium.org's message of "Tue, 18 Mar 2014 17:46:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 212C7478-AFA9-11E3-A6D7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244489>

szager@chromium.org writes:

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
> ---

Sign-off?

The new "per-thread file descriptors to the same thing" in a generic
codepath is a bit of eyesore.  For index-pack, keeping as many file
descritors open to the current pack as the worker threads are should
not be too bad, but could we have some comment next to the field
definition please (e.g. "Windows emulation of pread() needs separate
fd per thread; see $URL for details" or something)?

>  builtin/index-pack.c | 21 ++++++++++++++++-----
>  compat/mingw.c       | 31 ++++++++++++++++++++++++++++++-
>  compat/mingw.h       |  3 +++
>  config.mak.uname     |  1 -
>  4 files changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 2f37a38..c02dd4c 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -51,6 +51,7 @@ struct thread_local {
>  #endif
>  	struct base_data *base_cache;
>  	size_t base_cache_used;
> +	int pack_fd;
>  };
>  
>  /*
> @@ -91,7 +92,8 @@ static off_t consumed_bytes;
>  static unsigned deepest_delta;
>  static git_SHA_CTX input_ctx;
>  static uint32_t input_crc32;
> -static int input_fd, output_fd, pack_fd;
> +static const char *curr_pack;
> +static int input_fd, output_fd;
>  
>  #ifndef NO_PTHREADS
>  
> @@ -134,6 +136,7 @@ static inline void unlock_mutex(pthread_mutex_t *mutex)
>   */
>  static void init_thread(void)
>  {
> +	int i;
>  	init_recursive_mutex(&read_mutex);
>  	pthread_mutex_init(&counter_mutex, NULL);
>  	pthread_mutex_init(&work_mutex, NULL);
> @@ -141,11 +144,17 @@ static void init_thread(void)
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
> @@ -155,6 +164,8 @@ static void cleanup_thread(void)
>  	if (show_stat)
>  		pthread_mutex_destroy(&deepest_delta_mutex);
>  	pthread_key_delete(key);
> +	for (i = 0; i < nr_threads; i++)
> +		close(thread_data[i].pack_fd);
>  	free(thread_data);
>  }
>  
> @@ -288,13 +299,13 @@ static const char *open_pack_file(const char *pack_name)
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
> @@ -542,7 +553,7 @@ static void *unpack_data(struct object_entry *obj,
>  
>  	do {
>  		ssize_t n = (len < 64*1024) ? len : 64*1024;
> -		n = pread(pack_fd, inbuf, n, from);
> +		n = pread(get_thread_data()->pack_fd, inbuf, n, from);
>  		if (n < 0)
>  			die_errno(_("cannot pread pack file"));
>  		if (!n)
> @@ -1490,7 +1501,7 @@ static void show_pack_info(int stat_only)
>  int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  {
>  	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
> -	const char *curr_pack, *curr_index;
> +	const char *curr_index;
>  	const char *index_name = NULL, *pack_name = NULL;
>  	const char *keep_name = NULL, *keep_msg = NULL;
>  	char *index_name_buf = NULL, *keep_name_buf = NULL;
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 383cafe..6cc85d6 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -329,7 +329,36 @@ int mingw_mkdir(const char *path, int mode)
>  	return ret;
>  }
>  
> -int mingw_open (const char *filename, int oflags, ...)
> +
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
