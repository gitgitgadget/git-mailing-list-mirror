From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] gc: notice gc processes run by other users
Date: Tue, 31 Dec 2013 20:46:14 +0700
Message-ID: <CACsJy8AABkF8tq5sU+HxtNPuWTTAVwau-vUJq8SjhiDxawQ4jw@mail.gmail.com>
References: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 14:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxzek-0000i3-FI
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 14:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab3LaNqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 08:46:46 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:61356 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab3LaNqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 08:46:45 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so12292478qeb.22
        for <git@vger.kernel.org>; Tue, 31 Dec 2013 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8lFMBxLi9lpUemYaSuF/YsfrGHRs9SlmUp128JlLARA=;
        b=Kx+/ZzJ9l5pQ0/wl2WjNh3gEDX2GgIWyUQn6GnZnYqsWHTrFr9+xdnBSFoOICdZDDc
         J8kVx2FHNXLq4EF2JbbFaEggwD1DXtqCZ1rUUdKrLzDo1ooKmBfuGJIfzwKX9Q0aPIAi
         n0ipsy6Xds8+bh7ReeyvPXuPI/E4Mvxsa5frkNVdjZXQmBYcTE8C0vKXIbURfoa79ENE
         pB6sa02HQk1x16JpcWGIg+eApmqs2YlLK6Zdw77VVByy9Zu4SMuKOV0+oZeQGRa9XIac
         xvo5OYuSyyF1pmAbIuNQN6SyHhHg26NkO1QYBbVjgoDzgovS/rUotulxXBwYwuL6k44J
         v/dA==
X-Received: by 10.224.71.143 with SMTP id h15mr19800336qaj.88.1388497605049;
 Tue, 31 Dec 2013 05:46:45 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Tue, 31 Dec 2013 05:46:14 -0800 (PST)
In-Reply-To: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239839>

On Tue, Dec 31, 2013 at 7:07 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
> Since 64a99eb4 git gc refuses to run without the --force option if
> another gc process on the same repository is already running.
>
> However, if the repository is shared and user A runs git gc on the
> repository and while that gc is still running user B runs git gc on
> the same repository the gc process run by user A will not be noticed
> and the gc run by user B will go ahead and run.
>
> The problem is that the kill(pid, 0) test fails with an EPERM error
> since user B is not allowed to signal processes owned by user A
> (unless user B is root).
>
> Update the test to recognize an EPERM error as meaning the process
> exists and another gc should not be run (unless --force is given).

Ack. Looking at kill(2) the other errors are EINVAL and ESRCH, which
are fine to ignore.

> ---
>
> I suggest this be included in maint as others may also have expected the
> shared repository, different user gc scenario to be caught by the new
> code when in fact it's not without this patch.
>
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c14190f8..25f2237c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -222,7 +222,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>                         time(NULL) - st.st_mtime <= 12 * 3600 &&
>                         fscanf(fp, "%"PRIuMAX" %127c", &pid, locking_host) == 2 &&
>                         /* be gentle to concurrent "gc" on remote hosts */
> -                       (strcmp(locking_host, my_host) || !kill(pid, 0));
> +                       (strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
>                 if (fp != NULL)
>                         fclose(fp);
>                 if (should_exit) {
> --
> 1.8.5.2
>



-- 
Duy
