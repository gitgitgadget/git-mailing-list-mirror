From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/19] read-cache: add index reading api
Date: Sun, 14 Jul 2013 10:21:50 +0700
Message-ID: <CACsJy8A7T8KRuTRoC9-2RXR21gWsgPt1uA6xa6BhjK2k3gF2CA@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-7-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 05:22:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyCte-0002qn-Fd
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 05:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427Ab3GNDWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 23:22:36 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:47263 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab3GNDWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 23:22:21 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so14669352oag.14
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 20:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t5maAGxvtJ1DsKfRJVieJc5h3E8nLkwWP4/FnCt9TtI=;
        b=TlE/f3+8c0E1gdPT1eEt2yT6s/79/DJVPPGtx4izl29wMQknz2qgj4iUQCJX7wNgRF
         Ov0N4eNhzrwqdsh255+fEmo6Bta2tlovnv6EroFLB1NJbcYPJr5VslgbQREPWMPWrVJO
         I7Z78REw6BXKZvdvYh9inXoFYDwnCG4NjEAG7kTOQEq5ndEmJFSItaDmvij/lnj5Ub0g
         /TDJFwWXWpFxBCyhWwmxxowWTHvGhNk3t/E0RPIPIaNvArvYJuuGDOlD5opMDLXx4LK4
         kT4yRBpxAnxILf0FAGkO0+8A93Pppby1VlTVfdO43dXBgPa3fmGgyCtmtXS7D50juHGB
         /qlw==
X-Received: by 10.60.136.161 with SMTP id qb1mr39807731oeb.32.1373772140613;
 Sat, 13 Jul 2013 20:22:20 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 20:21:50 -0700 (PDT)
In-Reply-To: <1373650024-3001-7-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230302>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -238,7 +245,6 @@ static int read_index_v2(struct index_state *istate, void *mmap,
>                 disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
>                 ce = create_from_disk(disk_ce, &consumed, previous_name);
>                 set_index_entry(istate, i, ce);
> -
>                 src_offset += consumed;
>         }
>         strbuf_release(&previous_name_buf);

Nit pick. This is unnecessary.

> +int for_each_index_entry_v2(struct index_state *istate, each_cache_entry_fn fn, void *cb_data)
> +{
> +       int i, ret = 0;
> +       struct filter_opts *opts= istate->filter_opts;

Nitpick. space before "=".

> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -996,6 +996,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>                 memmove(istate->cache + pos + 1,
>                         istate->cache + pos,
>                         (istate->cache_nr - pos - 1) * sizeof(ce));
> +
>         set_index_entry(istate, pos, ce);
>         istate->cache_changed = 1;
>         return 0;

NP: unnecessary change.

> +int set_internal_ops(struct index_state *istate)
> +{
> +       if (!istate->internal_ops && istate->cache)
> +               istate->internal_ops = &v2_internal_ops;
> +       if (!istate->internal_ops)
> +               return 0;
> +       return 1;
> +}
> +
> +/*
> + * Execute fn for each index entry which is currently in istate.  Data
> + * can be given to the function using the cb_data parameter.
> + */
> +int for_each_index_entry(struct index_state *istate, each_cache_entry_fn fn, void *cb_data)
> +{
> +       if (!set_internal_ops(istate))
> +               return 0;
> +       return istate->internal_ops->for_each_index_entry(istate, fn, cb_data);
>  }

set_internal_ops should have been called in read_index and initialize_index.

> @@ -1374,6 +1409,7 @@ int discard_index(struct index_state *istate)
>         free(istate->cache);
>         istate->cache = NULL;
>         istate->cache_alloc = 0;
> +       istate->filter_opts = NULL;
>         return 0;
>  }

Why is internal_ops not reset here?

> --- a/read-cache.h
> +++ b/read-cache.h
> @@ -24,11 +24,17 @@ struct cache_version_header {
>  struct index_ops {
>         int (*match_stat_basic)(const struct cache_entry *ce, struct stat *st, int changed);
>         int (*verify_hdr)(void *mmap, unsigned long size);
> -       int (*read_index)(struct index_state *istate, void *mmap, unsigned long mmap_size);
> +       int (*read_index)(struct index_state *istate, void *mmap, unsigned long mmap_size,
> +                         struct filter_opts *opts);
>         int (*write_index)(struct index_state *istate, int newfd);
>  };
>
> +struct internal_ops {
> +       int (*for_each_index_entry)(struct index_state *istate, each_cache_entry_fn fn, void *cb_data);
> +};
> +

I wonder if we do need separate internal_ops from index_ops. Why not
merge internal_ops in index_ops?
--
Duy
