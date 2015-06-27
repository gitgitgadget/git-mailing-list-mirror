From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Sat, 27 Jun 2015 22:02:14 +0200
Message-ID: <CAP8UFD1gT_2RKYc1vvBO9goGwPzFxhu9uMan5+cLO7eWxwwB_w@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
	<1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 22:06:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8wMh-0005p2-Sq
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 22:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbbF0UCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 16:02:17 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34434 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbF0UCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 16:02:15 -0400
Received: by wicnd19 with SMTP id nd19so69475361wic.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YhagRwR9PTz3Y79nLkWb62MZFuyNNfs2jaDjO0skuWg=;
        b=qRKeEfe2F2HMQFcYP4TSlFO3+LSRr/+6f5P6r8HRwG8NbHu2Xv2PQjQieE0/OngBKf
         Y7UbarIb9V+T8Lkt35OdRd8sb5kOJLOObxc7XKxKJ021+vhR98wdIVHu9wUlmAKP+9hz
         gfydoeWqz8yaRcs9qZll6m34bk13+RpW1AKAKdZnByfz6FRGcbWEt1ttdlxa+SB9QW4j
         df1L6UH0Z8nt72/cm2wrfne5jccY6VPvJ6cruwFdDfe1LJQ8ezjRdrzPRY7JkxX1ACZ0
         zDaJlx4dj3Q7TzM4W4U2VdnrzwM8pV+uyXsE6Nr+Zu6zRT1iq76aK7ho0ncFd2RidQhe
         ynrw==
X-Received: by 10.194.2.68 with SMTP id 4mr14866270wjs.82.1435435334171; Sat,
 27 Jun 2015 13:02:14 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Sat, 27 Jun 2015 13:02:14 -0700 (PDT)
In-Reply-To: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272862>

On Thu, Jun 25, 2015 at 1:43 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support for %(refname:lalignX) where X is a number.
> This will print a shortened refname aligned to the left
> followed by spaces for a total length of X characters.
> If X is less than the shortened refname size, the entire
> shortened refname is printed.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 00d06bf..299b048 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -695,7 +695,22 @@ static void populate_value(struct ref_array_item *ref)
>                         int num_ours, num_theirs;
>
>                         formatp++;
> -                       if (!strcmp(formatp, "short"))
> +                       if (starts_with(formatp, "lalign")) {
> +                               const char *valp;
> +                               int val;
> +
> +                               skip_prefix(formatp, "lalign", &valp);
> +                               val = atoi(valp);

After thinking about such code, I wonder if it would be better to
support %(refname:lalign=X) instead of %(refname:lalignX).

The reason why it might be interesting to require an = sign between
"align" and the number X is that if we later want to introduce another
option with a name that starts with "lalign", for example
%(refname:lalignall=X) that would truncate the refname if it is bigger
than X), we might be more backward compatible with old git versions
that implement %(refname:lalign=X) but not %(refname:lalignall=X).

We will be more backward compatible because the above call to
starts_with() would probably be something like:

                       if (starts_with(formatp, "lalign=")) {

which means that old git versions would ignore something like "lalignall=X".

> +                               refname = shorten_unambiguous_ref(refname,
> +                                                                 warn_ambiguous_refs);
> +                               if (val > strlen(refname)) {
> +                                       struct strbuf buf = STRBUF_INIT;
> +                                       strbuf_addstr(&buf, refname);
> +                                       strbuf_addchars(&buf, ' ', val - strlen(refname));
> +                                       free((char *)refname);
> +                                       refname = strbuf_detach(&buf, NULL);
> +                               }

Thanks,
Christian.
