From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [BUG] [PATCH] infinite loop due to broken symlink
Date: Wed, 25 Mar 2015 23:53:23 +0100
Message-ID: <55133C63.2010805@alum.mit.edu>
References: <5510399D.4020007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Petr Stodulka <pstodulk@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 23:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YauB2-0004vS-QW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 23:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbbCYWx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 18:53:29 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54963 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750807AbbCYWx1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2015 18:53:27 -0400
X-AuditID: 1207440e-f79bc6d000000c43-ca-55133c654c5b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 95.3A.03139.56C33155; Wed, 25 Mar 2015 18:53:25 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1AEE.dip0.t-ipconnect.de [93.219.26.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2PMrNAC031235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 25 Mar 2015 18:53:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <5510399D.4020007@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqJtqIxxq8OGCgUXXlW4mi7uzbByY
	PN7vu8rm8XmTXABTFLdNUmJJWXBmep6+XQJ3RnP7NOaCBvmKvmX7WRsYW8W6GDk5JARMJA4d
	n88GYYtJXLi3Hsjm4hASuMwocaRjIStIQkjgPJPE11NKIDavgLbEhjU9YHEWAVWJrQufMYPY
	bAK6Eot6mplAbFGBIImXt/4yQtQLSpyc+YQFxBYRsJFYOOsLWFxYwE6i7eBORoj5mhIrJ74A
	m8MpoCXxYc0OsPnMAjoSbZ8XMkHY8hLNW2czT2Dkn4Vk7CwkZbOQlC1gZF7FKJeYU5qrm5uY
	mVOcmqxbnJyYl5dapGusl5tZopeaUrqJERKOfDsY29fLHGIU4GBU4uH9ISEUKsSaWFZcmXuI
	UZKDSUmUd6KWcKgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV5WPaAcb0piZVVqUT5MSpqDRUmc
	V22Jup+QQHpiSWp2ampBahFMVoaDQ0mC95UVUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpq
	UWJpSUY8KCLji4ExCZLiAdpraQ2yt7ggMRcoCtF6ilFRSpxXByQhAJLIKM2DGwtLMq8YxYG+
	FOYNAKniASYouO5XQIOZgAafy+cDGVySiJCSamDsFDt/a47lhl0ZwV3ml6oWf9/Hw7Lq+o33
	4jfsYg1OTp+8s7ZOtCfWrJzT+MHadU/VpOezxq/Nuh8i9qNn5UmniIiEFXWM/YvFnzur8Guw
	PtGvmfBq0yT1nMNHjI3vGd7VCIg9xOXQwKD94Mh55eCLcg2Rl/ctdL+p/nKe/crV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266308>

On 03/23/2015 05:04 PM, Petr Stodulka wrote:
> git goes into an infinite loop due to broken symlink (minimal reproducer
> [0]).  Affected code is in function
> "resolve_ref_unsafe" in file refs.c - notice 'stat_ref'. There is comment
> about problem with race condition, hovewer in that case it's regular broken
> symlink which cause infinite loop.

Thanks for the bug report. I can confirm the problem. In fact, I noticed
the same problem when I was working on a refactoring in the area, but I
still haven't submitted those patches. Luckily, modern Git doesn't use
symlinks in the loose reference hierarchy, so most users will never
encounter this problem.

In fact I think it is only the open() call that can lead to the infinite
loop. Meanwhile, there is another problem caused by falling through the
symlink-handling code, namely that st reflects the lstat() of the
symlink rather than the stat() of the file that it points to.

My approach was to run stat() on the path if the symlink-handling code
falls through. You can see my work in progress in my GitHub repo [1].

> Possible patch could be something
> like this:
> 
> -------------------------------------------------------
> diff --git a/refs.c b/refs.c
> index e23542b..9efe8d2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1356,6 +1356,7 @@ static struct ref_dir *get_loose_refs(struct
> ref_cache *refs)
>  /* We allow "recursive" symbolic refs. Only within reason, though */
>  #define MAXDEPTH 5
>  #define MAXREFLEN (1024)
> +#define MAXLOOP 1024
> 
>  /*
>   * Called by resolve_gitlink_ref_recursive() after it failed to read
> @@ -1482,6 +1483,7 @@ const char *resolve_ref_unsafe(const char
> *refname, int resolve_flags, unsigned
>         char buffer[256];
>         static char refname_buffer[256];
>         int bad_name = 0;
> +    int loop_counter = 0;
> 
>         if (flags)
>                 *flags = 0;
> @@ -1546,7 +1548,8 @@ const char *resolve_ref_unsafe(const char
> *refname, int resolve_flags, unsigned
>                 if (S_ISLNK(st.st_mode)) {
>                         len = readlink(path, buffer, sizeof(buffer)-1);
>                         if (len < 0) {
> -                               if (errno == ENOENT || errno == EINVAL)
> +                               if (loop_counter++ < MAXLOOP &&
> +                    (errno == ENOENT || errno == EINVAL))
>                                         /* inconsistent with lstat;
> retry */
>                                         goto stat_ref;
>                                 else
> @@ -1579,7 +1582,7 @@ const char *resolve_ref_unsafe(const char
> *refname, int resolve_flags, unsigned
>                  */
>                 fd = open(path, O_RDONLY);
>                 if (fd < 0) {
> -                       if (errno == ENOENT)
> +                       if (loop_counter++ < MAXLOOP && errno == ENOENT)
>                                 /* inconsistent with lstat; retry */
>                                 goto stat_ref;
>                         else
> -------------------------------------------------------
> 
> If I understand well that simple check of broken symlink is not possible
> due to race conditions.

This change also prevents the infinite loop, in fact in a more failproof
way that doesn't depend on errno values being interpreted correctly. I
would suggest a few stylistic changes, like for example here [2]. On the
other hand, this change doesn't solve the lstat()/stat() problem.

Nevertheless, I wouldn't object to a fix like this being accepted in
addition to the stat() fix when it's ready. It doesn't hurt to wear both
a belt *and* suspenders.

Michael

[1] https://github.com/mhagger/git, branch "wip/refactor-resolve-ref".
    See especially commit d2425d8ac8cf73494b318078b92f5b1c510a68fb.
[2] https://github.com/mhagger/git, branch "ref-broken-symlinks"

-- 
Michael Haggerty
mhagger@alum.mit.edu
