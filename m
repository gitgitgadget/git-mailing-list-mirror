From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Wed, 26 Mar 2014 09:35:22 +0100
Message-ID: <5332914A.7030407@viscovery.net>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: szager@chromium.org
X-From: git-owner@vger.kernel.org Wed Mar 26 09:35:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSjJC-0002cM-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 09:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbaCZIfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 04:35:33 -0400
Received: from so.liwest.at ([212.33.55.23]:60105 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbaCZIf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 04:35:29 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WSjIy-0003EQ-5f; Wed, 26 Mar 2014 09:35:24 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C641916613;
	Wed, 26 Mar 2014 09:35:23 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245170>

Am 3/19/2014 1:46, schrieb szager@chromium.org:
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
> .... which gives each index-pack thread its own file descriptor.
> ---
>  builtin/index-pack.c | 21 ++++++++++++++++-----
>  compat/mingw.c       | 31 ++++++++++++++++++++++++++++++-
>  compat/mingw.h       |  3 +++
>  config.mak.uname     |  1 -
>  4 files changed, 49 insertions(+), 7 deletions(-)

t5302 does not pass with this patch (sz/mingw-index-pack-threaded).
It fails like this:

+ eval 'git index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
     git prune-packed &&
     git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
     cmp "test-1-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
++ git index-pack --index-version=1 --stdin
pack	1c54d893dd9bf6645ecee2886ea72f2c2030bea1
++ git prune-packed
error: packfile .git/objects/pack/pack-1c54d893dd9bf6645ecee2886ea72f2c2030bea1.pack does not match index
warning: packfile .git/objects/pack/pack-1c54d893dd9bf6645ecee2886ea72f2c2030bea1.pack cannot be accessed
[... these 2 messages repeat ~250 times ...]
++ git count-objects
++ read nr rest
++ test 303 -eq 1

I haven't tested Duy's latest patch (index-pack: work around
thread-unsafe pread() yesterday), yet.

-- Hannes

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
> 
