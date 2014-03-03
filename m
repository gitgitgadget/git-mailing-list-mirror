From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Replace memcpy with hashcpy when dealing hash copy globally
Date: Mon, 3 Mar 2014 02:49:45 -0500
Message-ID: <CAPig+cTiC9-wmeXANFMZO-1MtLQ+u40aQi1jr0JPfK4KS+DS-w@mail.gmail.com>
References: <1393753044-6232-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:50:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNdh-0002C8-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbaCCHts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:49:48 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:57294 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbaCCHtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:49:45 -0500
Received: by mail-yh0-f46.google.com with SMTP id v1so3225022yhn.5
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 23:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YtJi/lw1IZuO+qteQfWUzuM+cScRI0re9T2ik06hwU4=;
        b=GDPERVu0lvbBPzQhUos1X6hYxFJ4Kolozl3/ucZqFRcdGzVbHylK9/jWp7NnH6xtko
         67zF2uQaexmWLNTQq5rL6LjMYsdas9hMjhYn1GLDN01iR4f3LZavuaCW6vhTsHGws98Y
         k6zZxAGoBnMtEWNmrncB1gdaPI8oKMzTzFkxa/AgxFPB/CTQdqzEKR9c8tD1TXgjZOPs
         /pZg213+casuPelJPhCrh0q4Xh1tC6fw0evKGxo1C7UCav1kuFp4iduZPlbnTRIYx1eb
         yqkHcAj8Kqf+FaV/CaNVL2u8XBlLpCCMzxVMFTP2Ca96qRlGLqxWRkI19cTyz6rs64AM
         Lqkw==
X-Received: by 10.236.83.194 with SMTP id q42mr18934282yhe.56.1393832985263;
 Sun, 02 Mar 2014 23:49:45 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 23:49:45 -0800 (PST)
In-Reply-To: <1393753044-6232-1-git-send-email-sunheehnus@gmail.com>
X-Google-Sender-Auth: xMWzbQt2R8StFXk_71WsCSc7ImY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243195>

On Sun, Mar 2, 2014 at 4:37 AM, Sun He <sunheehnus@gmail.com> wrote:
>  Replacing memcpy with hashcpy is more directly and elegant.

A better explanation is that the change takes advantage of the
abstraction provided by hashcpy() rather than hardcoding knowledge
about a particular hash representation.

>  Leave ppc/sha1.c alone, as it is an isolated component.
>  Pull cache.h(actually ../cache.h) in just for one memcpy
>  there is not proper.

Strange one-space indentation on all lines of commit message.

Other than that, the patch looks reasonable.

> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>
>  PATCH v2 leave ppc/sha1.c alone.
>
>  The general rule is if cache.h or git-compat-util.h is included,
>  it is the first #include, and system includes will be always in
>  git-compat-tuil.h.
>                                         via Duy Nguyen
>
>  The change in PATCH v1 is not proper because I placed cache.h
>  in the end.
>  And adding it to the head is not a good way to achieve the goal,
>  as is said above "---".
>
>  Thanks to Duy Nguyen.
>
>  Find the potential places with memcpy by the bash command:
>   $ find . | xargs grep "memcpy.*\(.*20.*\)"
>
>
>  ppc/sha1.c doesn't include cache.h and it cannot use
>  So just leave memcpy(in ppc/sha1.c) alone
>
>  bundle.c            | 2 +-
>  grep.c              | 2 +-
>  pack-bitmap-write.c | 2 +-
>  reflog-walk.c       | 4 ++--
>  refs.c              | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index e99065c..7809fbb 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -19,7 +19,7 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
>                 list->list = xrealloc(list->list,
>                                 list->alloc * sizeof(list->list[0]));
>         }
> -       memcpy(list->list[list->nr].sha1, sha1, 20);
> +       hashcpy(list->list[list->nr].sha1, sha1);
>         list->list[list->nr].name = xstrdup(name);
>         list->nr++;
>  }
> diff --git a/grep.c b/grep.c
> index c668034..f5101f7 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1650,7 +1650,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
>                 break;
>         case GREP_SOURCE_SHA1:
>                 gs->identifier = xmalloc(20);
> -               memcpy(gs->identifier, identifier, 20);
> +               hashcpy(gs->identifier, identifier);
>                 break;
>         case GREP_SOURCE_BUF:
>                 gs->identifier = NULL;
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 1218bef..5f1791a 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -530,7 +530,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
>         header.version = htons(default_version);
>         header.options = htons(flags | options);
>         header.entry_count = htonl(writer.selected_nr);
> -       memcpy(header.checksum, writer.pack_checksum, 20);
> +       hashcpy(header.checksum, writer.pack_checksum);
>
>         sha1write(f, &header, sizeof(header));
>         dump_bitmap(f, writer.commits);
> diff --git a/reflog-walk.c b/reflog-walk.c
> index b2fbdb2..d490f7d 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -32,8 +32,8 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
>                         sizeof(struct reflog_info));
>         }
>         item = array->items + array->nr;
> -       memcpy(item->osha1, osha1, 20);
> -       memcpy(item->nsha1, nsha1, 20);
> +       hashcpy(item->osha1, osha1);
> +       hashcpy(item->nsha1, nsha1);
>         item->email = xstrdup(email);
>         item->timestamp = timestamp;
>         item->tz = tz;
> diff --git a/refs.c b/refs.c
> index 89228e2..f90b7ea 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1222,7 +1222,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
>         if (ref == NULL)
>                 return -1;
>
> -       memcpy(sha1, ref->u.value.sha1, 20);
> +       hashcpy(sha1, ref->u.value.sha1);
>         return 0;
>  }
>
> --
> 1.9.0.138.g2de3478.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
