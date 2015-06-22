From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 03/19] ref-filter: implement '--points-at' option
Date: Mon, 22 Jun 2015 18:36:27 -0400
Message-ID: <CAPig+cRGWG=L0JmSEtnxAyV=NTsq281Ot7E85HB4buDnMPHc1Q@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7AKW-0001lz-LW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbbFVWge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:36:34 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:35148 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbbFVWg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:36:28 -0400
Received: by yhak3 with SMTP id k3so108031731yha.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lMtsK+wCxN3+g5hD1aWmdbR43CQTQOL+Z84vvJc4KKw=;
        b=fmtms06/RNuouqh7hZQESKGWyl3Ryu3b0lpbMSqBMZOyTUeaZtywAfc1topkLALS2Y
         PUIZDLCYmNOiNg9MTg8jnYyiBuZ5C8/XJzohyaAlKaWLBPMx62rPYIG5Swd0mjS5O//w
         nSgt4VZTRyVv/XKuXLtsBXr1VwhGlqOsvr864Ec9NAwcRvfgoUeIAy6ovYh0pfRDj71s
         FXxzxP/EbCAH4cPQOrQ6/Of5anHiavavn+XXVyFCadd7Hkmx5do3ByGw7Yk6VLO43dsv
         rME+Mk7LDbehwJO2pn8AttLbqym7Z9wp4ehut3b187mSeI9ybw6YRknmQc49rROSSqkB
         49wQ==
X-Received: by 10.13.205.71 with SMTP id p68mr19897377ywd.48.1435012587452;
 Mon, 22 Jun 2015 15:36:27 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Mon, 22 Jun 2015 15:36:27 -0700 (PDT)
In-Reply-To: <1434919705-4884-3-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: faBM9HR_VWkgQ3CpDV7ngnqnSvc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272429>

On Sun, Jun 21, 2015 at 4:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> In 'tag -l' we have '--points-at' option which lets users
> list only tags which point to a particular commit. Implement
> this option in 'ref-filter.{c,h}' so that other commands can
> benefit from this.
>
> This is duplicated from tag.c, we will eventually remove that
> when we port tag.c to use ref-filter APIs.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/tag.c b/builtin/tag.c
> index e36c43e..280981f 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -56,6 +56,10 @@ static int match_pattern(const char **patterns, const char *ref)
>         return 0;
>  }
>
> +/*
> + * This is currently duplicated in ref-filter.c, and will eventually be
> + * removed as we port tag.c to use the ref-filter APIs.
> + */
>  static const unsigned char *match_points_at(const char *refname,
>                                             const unsigned char *sha1)
>  {
> diff --git a/ref-filter.c b/ref-filter.c
> index 43502a4..591e281 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -842,6 +842,29 @@ static int match_name_as_path(const char **pattern, const char *refname)
>         return 0;
>  }
>
> +/*
> + * Given a ref (sha1, refname) see if it points to a one of the sha1s

s/a one/one/

> + * in a sha1_array.
> + */
> +static int match_points_at(struct sha1_array *points_at, const unsigned char *sha1,
> +                          const char *refname)
> +{
> +       struct object *obj;
> +
> +       if (!points_at || !points_at->nr)
> +               return 1;
> +
> +       if (sha1_array_lookup(points_at, sha1) >= 0)
> +               return 1;
> +
> +       obj = parse_object_or_die(sha1, refname);
> +       if (obj->type == OBJ_TAG &&
> +           sha1_array_lookup(points_at, ((struct tag *)obj)->tagged->sha1) >= 0)
> +               return 1;
> +
> +       return 0;
> +}
