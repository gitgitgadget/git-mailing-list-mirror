From: Etienne Buira <etienne.buira@gmail.com>
Subject: Re: [PATCH 2/2] Remove spurious 'no threads support' warnings
Date: Tue, 14 Oct 2014 16:46:47 +0200
Message-ID: <CAMcFKVyGKnGmmzDwKuSn3cQmG-jNiRRW-2rExL2+dBG7eaX_bA@mail.gmail.com>
References: <d2df2f619967ea7ba9625868b9c77d79a1190665.1413038338.git.etienne.buira@gmail.com>
	<8d057560e40fb5edaa3a32f204718c5e561a207a.1413038338.git.etienne.buira@gmail.com>
	<xmqqbnpf3fub.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 16:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe3NF-0001Eh-3t
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 16:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbaJNOqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 10:46:49 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:38986 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbaJNOqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 10:46:48 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so6908747qcv.10
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z5mMIOFGISwi1ZVs1G19xtEOZlyPxjHBkV9XCMcHBvk=;
        b=a7xbL3ZEAfLYZ7x812V7pA5PXtXGQpOdrU9JxsF3Tqssnc+lMaA5SlPZpe2J7AbCNu
         /p5VbGt86PsRxDYTZQYz4qJJsArUKx7YIbxFGLbzTBKcZr05IFI0f51a/HD/EIyia3q5
         5vJOk0nPQE83VPC2Pjn3mt+cg7tEKll9xVbQWMgJbmLiU9eDzEfey9VLKWLMamHXDsrY
         rrqpOkEABIxvQOP0csgs0nu9kRrFLiEuEdtXq1mQvA+uqmmEl4zI6owIE/ZnvP0Kwh2b
         vUPW5ybdLaJknFOLAwFt6uD2wyqzsEdbcKHI+o2s2AR/sYm3oBhrK9kLxz18A/j0oIXD
         8kMQ==
X-Received: by 10.224.163.20 with SMTP id y20mr1297880qax.91.1413298007729;
 Tue, 14 Oct 2014 07:46:47 -0700 (PDT)
Received: by 10.140.35.116 with HTTP; Tue, 14 Oct 2014 07:46:47 -0700 (PDT)
In-Reply-To: <xmqqbnpf3fub.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Etienne Buira <etienne.buira@gmail.com> writes:
>
>> Threads count being defaulted to 0 (autodetect), and --disable-pthreads
>> build checking that thread count==1, there were spurious warnings about
>> threads being ignored, despite not specified on command line/conf.
>>
>> Fixes tests 5521 and 5526 that were broken in --disable-pthreads builds
>> because of those warnings.
>>
>> Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
>> ---
>
> I am not sure if this is the right fix.
>
> Shouldn't a --threads=0 from the command line (when there is a
> pack.threads configuration hardcoding some number to override it)
> give a chance to the auto detection codepath to ask online_cpus()
> and receive 1 on NO_PTHREADS build to avoid triggering the same
> warning you are squelching with this patch?
>
> That is, something like this instead, perhaps?

Indeed, your patch is better.

> -- >8 --
> Subject: [PATCH] pack-objects: set number of threads before checking and warning
>
> Under NO_PTHREADS build, we warn when delta_search_threads is not
> set to 1, because that is the only sensible value on a single
> threaded build.
>
> However, the auto detection that kicks in when that variable is set
> to 0 (e.g. there is no configuration variable or command line option,
> or an explicit --threads=0 is given from the command line to override
> the pack.threads configuration to force auto-detection) was not done
> before the condition to issue this warning was tested.
>
> Move the auto-detection code and place it at an appropriate spot.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/pack-objects.c | 6 ++++--
>  thread-utils.h         | 4 ++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d391934..a715237 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1972,8 +1972,6 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
>
>         init_threaded_search();
>
> -       if (!delta_search_threads)      /* --threads=0 means autodetect */
> -               delta_search_threads = online_cpus();
>         if (delta_search_threads <= 1) {
>                 find_deltas(list, &list_size, window, depth, processed);
>                 cleanup_threaded_search();
> @@ -2685,6 +2683,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>                 pack_compression_level = Z_DEFAULT_COMPRESSION;
>         else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
>                 die("bad pack compression level %d", pack_compression_level);
> +
> +       if (!delta_search_threads)      /* --threads=0 means autodetect */
> +               delta_search_threads = online_cpus();
> +
>  #ifdef NO_PTHREADS
>         if (delta_search_threads != 1)
>                 warning("no threads support, ignoring --threads");
> diff --git a/thread-utils.h b/thread-utils.h
> index 6fb98c3..d9a769d 100644
> --- a/thread-utils.h
> +++ b/thread-utils.h
> @@ -7,5 +7,9 @@
>  extern int online_cpus(void);
>  extern int init_recursive_mutex(pthread_mutex_t*);
>
> +#else
> +
> +#define online_cpus() 1
> +
>  #endif
>  #endif /* THREAD_COMPAT_H */
> --
> 2.1.2-468-g1a77c5b
>
