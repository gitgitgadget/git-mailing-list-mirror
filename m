From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [WIP/PATCH v4 1/8] for-each-ref: extract helper functions out of grab_single_ref()
Date: Sat, 30 May 2015 22:58:27 -0400
Message-ID: <CAPig+cSBaKwRqEEBB62LX0OyYGNddLHNU-zMEx2478kV8=+pDQ@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 04:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YytSL-00042U-3V
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 04:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077AbbEaC63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 22:58:29 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38593 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbbEaC62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 22:58:28 -0400
Received: by igbjd9 with SMTP id jd9so39821168igb.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 19:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TvEVY1mSIsBfdAnPMz/ZZZ03qq8lWF71kFKLe12Yc58=;
        b=gGVETWUVVhAMUoRL3stuT+2Z1YxjPVJuUN+Ei/d+LEczlzkYo/sHIh6iLZUFITDctR
         4FIbisq6012qoTKrM9UaR1YleJyapyMPh2c26N1eQ4CCkoIFz0HkHP5kC5+2rEbt2Xa1
         OKEsiiT93heos22hQTaSCkEmOQcotmx7z0PTF++syueF9cU6uOrrmTywTmXn1HJ3p0Or
         KYkhhXD6CBuFZnyRg1Tr9Glih1W+Vz2EMlgBtQpZwWThCNyP3ZqZ+AA/YZz1noV/1+Sh
         KS6KC656wcIWl9ruppNY1LQb18sEnWBZCM3QGHqAFpzGcxFhMsS1h+1fsG7sVCsUFzjN
         hUmw==
X-Received: by 10.50.61.200 with SMTP id s8mr5661930igr.7.1433041107751; Sat,
 30 May 2015 19:58:27 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 30 May 2015 19:58:27 -0700 (PDT)
In-Reply-To: <1433008411-8550-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: tcPmTdkOH0F4nTYkWtHXl7WfIRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270311>

On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Extract two helper functions out of grab_single_ref(). Firstly,
> new_refinfo() which is used to allocate memory for a new refinfo
> structure and copy the objectname, refname and flag to it.
> Secondly, match_name_as_path() which when given an array of patterns
> and the refname checks if the refname matches any of the patterns
> given while the pattern is a pathname, also while supporting wild
> characters.
>
> This is a preperatory patch for restructuring 'for-each-ref' and
> eventually moving most of it to 'ref-filter' to provide the
> functionality to similar commands via public API's.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 83f9cf9..b33e2de 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -837,6 +837,43 @@ struct grab_ref_cbdata {
>  };
>
>  /*
> + * Given a refname, return 1 if the refname matches with one of the patterns
> + * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
> + * and so on, else return 0. Supports use of wild characters.
> + */
> +static int match_name_as_path(const char **pattern, const char *refname)
> +{
> +       int namelen = strlen(refname);
> +       for (; *pattern; pattern++) {
> +               const char *p = *pattern;
> +               int plen = strlen(p);
> +
> +               if ((plen <= namelen) &&
> +                   !strncmp(refname, p, plen) &&
> +                   (refname[plen] == '\0' ||
> +                    refname[plen] == '/' ||
> +                    p[plen-1] == '/'))
> +                       return 1;
> +               if (!wildmatch(p, refname, WM_PATHNAME, NULL))
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
> +/* Allocate space for a new refinfo and copy the objectname and flag to it */
> +static struct refinfo *new_refinfo(const char *refname,
> +                                  const unsigned char *objectname,
> +                                  int flag)
> +{
> +       struct refinfo *ref = xcalloc(1, sizeof(struct refinfo));
> +       ref->refname = xstrdup(refname);
> +       hashcpy(ref->objectname, objectname);
> +       ref->flag = flag;
> +
> +       return ref;
> +}
> +
> +/*
>   * A call-back given to for_each_ref().  Filter refs and keep them for
>   * later object processing.
>   */
> @@ -851,40 +888,16 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
>                   return 0;
>         }
>
> -       if (*cb->grab_pattern) {
> -               const char **pattern;
> -               int namelen = strlen(refname);
> -               for (pattern = cb->grab_pattern; *pattern; pattern++) {
> -                       const char *p = *pattern;
> -                       int plen = strlen(p);
> -
> -                       if ((plen <= namelen) &&
> -                           !strncmp(refname, p, plen) &&
> -                           (refname[plen] == '\0' ||
> -                            refname[plen] == '/' ||
> -                            p[plen-1] == '/'))
> -                               break;
> -                       if (!wildmatch(p, refname, WM_PATHNAME, NULL))
> -                               break;
> -               }
> -               if (!*pattern)
> -                       return 0;
> -       }
> +       if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
> +               return 0;
>
> -       /*
> -        * We do not open the object yet; sort may only need refname
> -        * to do its job and the resulting list may yet to be pruned
> -        * by maxcount logic.
> -        */

Why did this comment get removed? Isn't it still meaningful to the
overall logic of this function?

> -       ref = xcalloc(1, sizeof(*ref));
> -       ref->refname = xstrdup(refname);
> -       hashcpy(ref->objectname, sha1);
> -       ref->flag = flag;
> +       ref = new_refinfo(refname, sha1, flag);
>
>         cnt = cb->grab_cnt;
>         REALLOC_ARRAY(cb->grab_array, cnt + 1);
>         cb->grab_array[cnt++] = ref;
>         cb->grab_cnt = cnt;
> +

Sneaking in whitespace change?

>         return 0;
>  }
