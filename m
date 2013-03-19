From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] index-pack: protect deepest_delta in multithread code
Date: Tue, 19 Mar 2013 21:07:56 +0700
Message-ID: <CACsJy8C0AYvAEm6fJFv+JLWpg3HuFG0erKXnq3NxpkYAy=qb_w@mail.gmail.com>
References: <CACsJy8DgQZFewPjLSXSkdHHWqhQDqExoVq-pBGpKr1G8w06uvQ@mail.gmail.com>
 <1363698075-12452-1-git-send-email-pclouds@gmail.com> <87d2uv7b31.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Stefan Zager <szager@google.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 15:08:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHxDj-00025r-0w
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 15:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab3CSOI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 10:08:28 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:33314 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab3CSOI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 10:08:27 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so487315oag.20
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WEl1EZDZgQijfig3RLwIkmFw/OzXgu21v6RV+6muYao=;
        b=TnATp539r9tDBl4JdykTilcjKcHst1fi7YgBUUbE4TCe5Hr6NJQuP8bi1xiVOGnpoN
         NKC4UgQNb2fmIJZY6+e9iMQ/1vR3uXETOeXTaM6n/zHoR4GOOlP1RsV0B2dFCxkbE5dd
         UChKHB9omTHNiC5WQBuM5Bam0oNCrfsBxwMcgmKObEhysRetXbh6HbxumhU5Dbwej9HZ
         X5TdrQwXzq3oL0WD3kYtOIXsp0L602TcJUQsbGTyMDgpZtR74cSEf7PL+xmXmUukkGLF
         14KbBR1ju914TxNZ+rcR0u/WDIka7L7VZzh7XfPeihxSUFznkleJqVD5RpZm8B9F+wL/
         7Z1g==
X-Received: by 10.60.6.199 with SMTP id d7mr1290300oea.137.1363702107019; Tue,
 19 Mar 2013 07:08:27 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 07:07:56 -0700 (PDT)
In-Reply-To: <87d2uv7b31.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218515>

On Tue, Mar 19, 2013 at 8:50 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> -- >8 --
> Subject: [PATCH] index-pack: guard nr_resolved_deltas reads by lock
>
> The threaded parts of index-pack increment the number of resolved
> deltas in nr_resolved_deltas guarded by counter_mutex.  However, the
> per-thread outer loop accessed nr_resolved_deltas without any locks.
>
> This is not wrong as such, since it doesn't matter all that much
> whether we get an outdated value.  However, unless someone proves that
> this one lock makes all the performance difference, it would be much
> cleaner to guard _all_ accesses to the variable with the lock.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  builtin/index-pack.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index b3fee45..6be99e2 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -968,7 +968,9 @@ static void *threaded_second_pass(void *data)
>         for (;;) {
>                 int i;
>                 work_lock();
> +               counter_lock();
>                 display_progress(progress, nr_resolved_deltas);
> +               counter_unlock();
>                 while (nr_dispatched < nr_objects &&
>                        is_delta_type(objects[nr_dispatched].type))
>                         nr_dispatched++;

I'm pretty sure futex will make this cheap. The only thing I don't
like here is the double locking (work_lock then counter_lock) is an
invitation for potential deadlocks (not now, but who now what can
change later). I think you could move work_lock(); down after
counter_unlock() so we hold one lock at a time.
-- 
Duy
