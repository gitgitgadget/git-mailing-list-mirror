From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] [PATCH] git grep: be careful to use mutices only when
 they are initialized
Date: Wed, 26 Oct 2011 10:19:09 +0100
Message-ID: <CABNJ2GL7khag3uD=kX+Ui9aqn5A-bkM5wfK=of0-=3fRrjmJ4w@mail.gmail.com>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 26 11:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIzdk-0007J3-8a
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 11:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543Ab1JZJTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Oct 2011 05:19:11 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35084 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932375Ab1JZJTK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2011 05:19:10 -0400
Received: by ggnb1 with SMTP id b1so1358635ggn.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pzzsA61A6Uvo7pkVGZQuRN2un6H4ZQdUijXohR6D3GE=;
        b=bUpk03ejDEP2Ur6Rpu4EjIl3ow8BCmvECYFPLhvR4oneIgjewkuQT/Go6R99phU6pz
         OJJXuUdsnQ0lcoxmz1nFA9Jr0v1pXYB95w+tOO7/3raTX7QPrzJbDHV+DQzg3CzQNj3b
         yaUlifJUzjowcf0ezBMXkPYn/4uHQGft6CjWk=
Received: by 10.42.147.196 with SMTP id o4mr49770489icv.33.1319620749938; Wed,
 26 Oct 2011 02:19:09 -0700 (PDT)
Received: by 10.231.206.199 with HTTP; Wed, 26 Oct 2011 02:19:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184251>

On 25 October 2011 18:25, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Rather nasty things happen when a mutex is not initialized but locked
> nevertheless. Now, when we're not running in a threaded manner, the m=
utex
> is not initialized, which is correct. But then we went and used the m=
utex
> anyway, which -- at least on Windows -- leads to a hard crash (ordina=
rily
> it would be called a segmentation fault, but in Windows speak it is a=
n
> access violation).
>
> This problem was identified by our faithful tests when run in the msy=
sGit
> environment.

I did not see this failure when running the tests on my machine. But
then threaded issues are often intermittent depending on load, number
of cores, phase of the moon, etc. You never said _which_ test either
although there are only 3 to try - most likey t7810-grep.sh

I was going to point out that it should be "mutexes" but I see it is
committed already :)

> To avoid having to wrap the line due to the 80 column limit, we use

So last century!

> the name "WHEN_THREADED" instead of "IF_USE_THREADS" because it is on=
e
> character shorter. Which is all we need in this case.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I looked around a bit but ran out of time =
to identify the reason why
> =C2=A0 =C2=A0 =C2=A0 =C2=A0this was not caught earlier.
>
> =C2=A0builtin/grep.c | =C2=A0 =C2=A09 +++++----
> =C2=A01 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 92eeada..e94c5fe 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -78,10 +78,11 @@ static pthread_mutex_t grep_mutex;
> =C2=A0/* Used to serialize calls to read_sha1_file. */
> =C2=A0static pthread_mutex_t read_sha1_mutex;
>
> -#define grep_lock() pthread_mutex_lock(&grep_mutex)
> -#define grep_unlock() pthread_mutex_unlock(&grep_mutex)
> -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
> -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
> +#define WHEN_THREADED(x) do { if (use_threads) (x); } while (0)
> +#define grep_lock() WHEN_THREADED(pthread_mutex_lock(&grep_mutex))
> +#define grep_unlock() WHEN_THREADED(pthread_mutex_unlock(&grep_mutex=
))
> +#define read_sha1_lock() WHEN_THREADED(pthread_mutex_lock(&read_sha1=
_mutex))
> +#define read_sha1_unlock() WHEN_THREADED(pthread_mutex_unlock(&read_=
sha1_mutex))
>
> =C2=A0/* Signalled when a new work_item is added to todo. */
> =C2=A0static pthread_cond_t cond_add;
> --
> 1.7.5.3.4540.g15f89

Works for me.

Pat.
