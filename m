From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add threaded versions of functions in symlinks.c.
Date: Fri, 02 Mar 2012 23:55:25 -0800
Message-ID: <7vwr726rv6.fsf@alter.siamese.dyndns.org>
References: <cover.1330740964.git.jaredhance@gmail.com>
 <1dcc783012d179f91c606204bffea9ff8cf2c803.1330740964.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 08:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3joX-0003AA-QH
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 08:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab2CCHz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 02:55:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961Ab2CCHz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 02:55:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDF293644;
	Sat,  3 Mar 2012 02:55:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JbAvecVaLIfNrbcqblfsOacxMKU=; b=S7QqP+
	N1HFTq1Sl6G/MBO9SCkmtDhLTk0h1JgUMBRqtnD5F1PTcFGRMV5Q3RE6xYdDv2YS
	6xePs2HJqgEXgUuhq0ilmAVapHw8oKZoPotGg4P29He9Tu3jVlmW21jCOehGNhhi
	OS2PIqK5jRDSKBX7C05uwZhDhyqyiC6dmC8ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fsvPb+wMZCv1yylFleF6DMlslzdQ6E4G
	sW2EFEkhlqsVAlSkAKGXEkY+q6wzdSkOD/KDrFDeLY6y5nymEiOg7wNlFY57a4Fg
	SK3239ZDKTTa/kizpNFv37IpKIushZerrJZBm0AoH7vhXBMzecxJrE6WmInb8Ypj
	pvAfUblsDHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B579B3643;
	Sat,  3 Mar 2012 02:55:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEBF63642; Sat,  3 Mar 2012
 02:55:26 -0500 (EST)
In-Reply-To: <1dcc783012d179f91c606204bffea9ff8cf2c803.1330740964.git.jaredhance@gmail.com> (Jared Hance's message of "Fri, 2 Mar 2012 21:31:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D39C7FA-6506-11E1-9CBD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192098>

Jared Hance <jaredhance@gmail.com> writes:

> check_leading_patch and has_dirs_only_path both always use the default

s/patch/path/;

> cache, which could be a caveat for adding parallelism (which is a
> concern and even a GSoC proposal). This patch implements
> threaded_check_leading_path and threading threaded_has_dirs_only_path
> and then implements the nonthreaded functions in terms of their threaded
> equivalents. No functional should be changed.
>
> Signed-off-by: Jared Hance <jaredhance@gmail.com>
> ---

Ok, so these FIXME's started at 867f72b (Prepare symlink caching for
thread-safety, 2009-07-09) and some of them were taken care of at b9fd284
(Export thread-safe version of 'has_symlink_leading_path()', 2009-07-09),
that follows it.  The latter left these two FIXMEs behind.

I wonder why. I suspect that it is merely because it wasn't necessary to
call these two functions from threaded context at all.

The patch changes no behaviour and should be safe, I would think.

>  cache.h    |    2 ++
>  symlinks.c |   28 ++++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index baa8852..1113296 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -950,7 +950,9 @@ struct cache_def {
>  extern int has_symlink_leading_path(const char *name, int len);
>  extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
>  extern int check_leading_path(const char *name, int len);
> +extern int threaded_check_leading_path(struct cache_def *cache, const char *name, int len);
>  extern int has_dirs_only_path(const char *name, int len, int prefix_len);
> +extern int threaded_has_dirs_only_path(struct cache_def *cache, const char *name, int len, int prefix_len);
>  extern void schedule_dir_for_removal(const char *name, int len);
>  extern void remove_scheduled_dirs(void);
>  
> diff --git a/symlinks.c b/symlinks.c
> index 034943b..2900367 100644
> --- a/symlinks.c
> +++ b/symlinks.c
> @@ -219,7 +219,20 @@ int has_symlink_leading_path(const char *name, int len)
>   */
>  int check_leading_path(const char *name, int len)
>  {
> -	struct cache_def *cache = &default_cache;	/* FIXME */
> +    return threaded_check_leading_path(&default_cache, name, len);
> +}
> +
> +/*
> + * Return zero if path 'name' has a leading symlink component or
> + * if some leading path component does not exists.
> + *
> + * Return -1 if leading path exists and is a directory.
> + *
> + * Return path length if leading path exists and is neither a
> + * directory nor a symlink.
> + */
> +int threaded_check_leading_path(struct cache_def *cache, const char *name, int len)
> +{
>  	int flags;
>  	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
>  			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
> @@ -240,7 +253,18 @@ int check_leading_path(const char *name, int len)
>   */
>  int has_dirs_only_path(const char *name, int len, int prefix_len)
>  {
> -	struct cache_def *cache = &default_cache;	/* FIXME */
> +	return threaded_has_dirs_only_path(&default_cache, name, len, prefix_len);
> +}
> +
> +/*
> + * Return non-zero if all path components of 'name' exists as a
> + * directory.  If prefix_len > 0, we will test with the stat()
> + * function instead of the lstat() function for a prefix length of
> + * 'prefix_len', thus we then allow for symlinks in the prefix part as
> + * long as those points to real existing directories.
> + */
> +int threaded_has_dirs_only_path(struct cache_def *cache, const char *name, int len, int prefix_len)
> +{
>  	return lstat_cache(cache, name, len,
>  			   FL_DIR|FL_FULLPATH, prefix_len) &
>  		FL_DIR;
