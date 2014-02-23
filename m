From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 7/8] name-hash: allow dir hashing even when !ignore_case
Date: Sun, 23 Feb 2014 04:19:16 -0500
Message-ID: <CAPig+cRRvEUDivU=ySx7wY9qYsCYSvn68aY8s_jfX=Z=jh=Ptg@mail.gmail.com>
References: <cover.1393059605.git.tr@thomasrast.ch>
	<38527c9f6ae31ad39d8f3dddfe5252a3527629ed.1393059605.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Feb 23 10:19:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHVE1-0004F2-7A
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 10:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbaBWJTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 04:19:20 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:60862 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaBWJTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 04:19:17 -0500
Received: by mail-yh0-f51.google.com with SMTP id t59so4102749yho.10
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tWdtgXwWKw5JPKmsER1GEu4LHT5grkLg9wCikqYKR+s=;
        b=lK7k1je8ku2jT0VXcMsatKPJr+cnP03SxPwU2ClEHrmx01MA9X6pQbA3kjq9c+SEET
         0NQGRIdOgUmPTklIy7gI85wcN8E0mdRbReAlgrTx2X00+9K+vJxYnhrk0Z4SYkrLmwvc
         mXUdNcfunM7zO1kVMyw0lcc/8v4JuyqswixAma+NEvvl+PRSIhgnHL9s97jJofQ4xBIx
         1y1JgibnqNCCLM2yNzoKbuaHdupxHz/iuZByv9jqB+ficCqDaz8L+CvjUSetMW2ry5iB
         AJzUpc2NWb5AiKCa0YaTmSSb8H92U84gXvP3wHC4xgNAV5kKbfqPVuXMCwHBSM7gV+gM
         PZ0A==
X-Received: by 10.236.120.17 with SMTP id o17mr22202191yhh.121.1393147156669;
 Sun, 23 Feb 2014 01:19:16 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 23 Feb 2014 01:19:16 -0800 (PST)
In-Reply-To: <38527c9f6ae31ad39d8f3dddfe5252a3527629ed.1393059605.git.tr@thomasrast.ch>
X-Google-Sender-Auth: YSm_HBPowr29FEZKRvU6Q3G784M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242539>

On Sat, Feb 22, 2014 at 4:17 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> The directory hash (for fast checks if the index already has a
> directory) was only used in ignore_case mode and so depended on that
> flag.
>
> Make it generally available on request.
>
> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
> ---
> diff --git a/name-hash.c b/name-hash.c
> index e5b6e1a..c8953be 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -141,16 +141,19 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
>                 *pos = ce;
>         }
>
> -       if (ignore_case && !(ce->ce_flags & CE_UNHASHED))
> +       if (istate->has_dir_hash && !(ce->ce_flags & CE_UNHASHED))
>                 add_dir_entry(istate, ce);
>  }
>
> -static void lazy_init_name_hash(struct index_state *istate)
> +void init_name_hash(struct index_state *istate, int force_dir_hash)
>  {
>         int nr;
>
>         if (istate->name_hash_initialized)
>                 return;
> +
> +       istate->has_dir_hash = force_dir_hash || ignore_case;

This is getting a bit convoluted. Refactoring lazy_init_name_hash()
into two functions would eliminate the complexity. For instance:

  void init_name_hash(struct index_state *istate)
  {
  ...pure initialization code...
  }

  static void init_name_hash_if_needed(struct index_state *istate)
  {
    if (ignore_case && !istate->name_hash_initialized)
      init_name_hash(istate);
  }

The two existing callers of lazy_init_name_hash() in name-hash.c,
which rely upon the lazy/ignore-case logic, would invoke the static
init_name_hash_if_needed().

The new caller in patch 8/8, which knows explicitly if and when it
wants the hash initialized can invoke the public init_name_hash().

>         if (istate->cache_nr)
>                 preallocate_hash(&istate->name_hash, istate->cache_nr);
>         for (nr = 0; nr < istate->cache_nr; nr++)
> @@ -161,7 +164,7 @@ static void lazy_init_name_hash(struct index_state *istate)
>  void add_name_hash(struct index_state *istate, struct cache_entry *ce)
>  {
>         /* if already hashed, add reference to directory entries */
> -       if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_STATE_MASK)
> +       if (istate->has_dir_hash && (ce->ce_flags & CE_STATE_MASK) == CE_STATE_MASK)
>                 add_dir_entry(istate, ce);
>
>         ce->ce_flags &= ~CE_UNHASHED;
> @@ -181,7 +184,7 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce)
>  void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
>  {
>         /* if already hashed, release reference to directory entries */
> -       if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_HASHED)
> +       if (istate->has_dir_hash && (ce->ce_flags & CE_STATE_MASK) == CE_HASHED)
>                 remove_dir_entry(istate, ce);
>
>         ce->ce_flags |= CE_UNHASHED;
> @@ -228,7 +231,7 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
>         struct cache_entry *ce;
>         struct dir_entry *dir;
>
> -       lazy_init_name_hash(istate);
> +       init_name_hash(istate, 0);
>         dir = find_dir_entry(istate, name, namelen);
>         if (dir && dir->nr)
>                 return dir->ce;
> @@ -250,7 +253,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
>         unsigned int hash = hash_name(name, namelen);
>         struct cache_entry *ce;
>
> -       lazy_init_name_hash(istate);
> +       init_name_hash(istate, 0);
>         ce = lookup_hash(hash, &istate->name_hash);
>
>         while (ce) {
> @@ -286,9 +289,11 @@ void free_name_hash(struct index_state *istate)
>         if (!istate->name_hash_initialized)
>                 return;
>         istate->name_hash_initialized = 0;
> -       if (ignore_case)
> +       if (istate->has_dir_hash) {
>                 /* free directory entries */
>                 for_each_hash(&istate->dir_hash, free_dir_entry, NULL);
> +               istate->has_dir_hash = 0;
> +       }
>
>         free_hash(&istate->name_hash);
>         free_hash(&istate->dir_hash);
> --
> 1.9.0.313.g3d0a325
