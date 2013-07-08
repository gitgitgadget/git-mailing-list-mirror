From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 8 Jul 2013 09:19:42 +0700
Message-ID: <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 04:20:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw148-0001Q0-C6
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 04:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab3GHCUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 22:20:14 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:52112 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab3GHCUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 22:20:13 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so5717929oag.14
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 19:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nznQMZmsd09MS12BVx1o88eBgoUPW5ddLHuQleidxmQ=;
        b=prF1eHDj14aPkVvuHJb+i6/PZl9hSEj2relb3hyVPH1ochdmrBAdQZA2jcQXCDBgSd
         iDhhNvnoHLuUMBWwRT2UUjIgBfqYZ5Fw+rhWqKdWFkEaJ0Tv9s461KZr+SEavdMF5n2V
         shzYPRQ48LM2mcE6Dmxdv4clVgp5DwE7ZI3C4J9igu1kH3xVq0VaJAeQTT/adjqMDzil
         77rSVabWyGyLMmo5uF0UIY0eWdosu3t4ZJnl9Y/UvNSmg2CN3iB1fIi6RiKKX1UILG3f
         CKfMCNeP51fCqA2dTlfdmA5Z5odFSS/LMQGTUCR/zd7eXD4a8mc4ewX63a/ti/zj/0SS
         AYDw==
X-Received: by 10.60.83.116 with SMTP id p20mr18534640oey.83.1373250012952;
 Sun, 07 Jul 2013 19:20:12 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sun, 7 Jul 2013 19:19:42 -0700 (PDT)
In-Reply-To: <1373184720-29767-6-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229821>

On Sun, Jul 7, 2013 at 3:11 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +/*
> + * Options by which the index should be filtered when read partially.
> + *
> + * pathspec: The pathspec which the index entries have to match
> + * seen: Used to return the seen parameter from match_pathspec()
> + * max_prefix, max_prefix_len: These variables are set to the longest
> + *     common prefix, the length of the longest common prefix of the
> + *     given pathspec
> + *
> + * read_staged: used to indicate if the conflicted entries (entries
> + *     with a stage) should be included
> + * read_cache_tree: used to indicate if the cache-tree should be read
> + * read_resolve_undo: used to indicate if the resolve undo data should
> + *     be read
> + */
> +struct filter_opts {
> +       const char **pathspec;
> +       char *seen;
> +       char *max_prefix;
> +       int max_prefix_len;
> +
> +       int read_staged;
> +       int read_cache_tree;
> +       int read_resolve_undo;
> +};
> +
>  struct index_state {
>         struct cache_entry **cache;
>         unsigned int version;
> @@ -270,6 +297,8 @@ struct index_state {
>         struct hash_table name_hash;
>         struct hash_table dir_hash;
>         struct index_ops *ops;
> +       struct internal_ops *internal_ops;
> +       struct filter_opts *filter_opts;
>  };

...

> -/* remember to discard_cache() before reading a different cache! */
> -int read_index_from(struct index_state *istate, const char *path)
> +
> +int read_index_filtered_from(struct index_state *istate, const char *path,
> +                            struct filter_opts *opts)
>  {
>         int fd, err, i;
>         struct stat st_old, st_new;
> @@ -1337,7 +1425,7 @@ int read_index_from(struct index_state *istate, const char *path)
>                 if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
>                         err = 1;
>
> -               if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
> +               if (istate->ops->read_index(istate, mmap, mmap_size, opts) < 0)
>                         err = 1;
>                 istate->timestamp.sec = st_old.st_mtime;
>                 istate->timestamp.nsec = ST_MTIME_NSEC(st_old);
> @@ -1345,6 +1433,7 @@ int read_index_from(struct index_state *istate, const char *path)
>                         die_errno("cannot stat the open index");
>
>                 munmap(mmap, mmap_size);
> +               istate->filter_opts = opts;
>                 if (!index_changed(&st_old, &st_new) && !err)
>                         return istate->cache_nr;
>         }

Putting filter_opts in index_state feels like a bad design. Iterator
information should be separated from the iterated object, so that two
callers can walk through the same index without stepping on each other
(I'm not talking about multithreading, a caller may walk a bit, then
the other caller starts walking, then the former caller resumes
walking again in a call chain).
--
Duy
