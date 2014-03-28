From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] pack-objects: reuse deltas for thin "have" objects
Date: Fri, 28 Mar 2014 00:23:29 -0400
Message-ID: <CAPig+cSRVSBU-RsWTYgRqvRp76Ot9FjjXVyS476vA+CNOSozuA@mail.gmail.com>
References: <20140326072215.GA31739@sigill.intra.peff.net>
	<20140326072338.GF32193@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 05:23:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTOKN-0005JS-87
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 05:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbaC1EXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 00:23:30 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:46675 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaC1EX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 00:23:29 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so3203427ykq.21
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 21:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=41QFPW2mGaUlBmXrYm98kxVlh2arcdeapklLlDCzhao=;
        b=i5F2jD1cs6wUeRC+sZbdVEmzWisXwTv4RzzbbLF7YQcr7FFg54wRQB0+/iXSEdi1sj
         h4Z+cAS5UBTnLMnUO4L1/pgN41uSRUzrLiK87lBFFpx6ULeUXn8DbXp6TMT0cZxNtHxj
         AlaoAfr2A8Mt2kBeUdr+WZF3nwKXu9LpozwQ9Gp48kdCvM983wnKFXSSD4T8LdWn9AAN
         NiT6ixbkaIAStsRFIqy7AVrxqPoDysHnQDeglxuRtv29hWfOuBtEanBcj35DhpAm7kfR
         uC5+vIkprsAwZj7nHkRDVibRHPBE5oqBm27kFwRY4qhSEJa/mUpdiX9u1w4zg2FJ2sxr
         OYCA==
X-Received: by 10.236.123.38 with SMTP id u26mr7969137yhh.93.1395980609175;
 Thu, 27 Mar 2014 21:23:29 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 21:23:29 -0700 (PDT)
In-Reply-To: <20140326072338.GF32193@sigill.intra.peff.net>
X-Google-Sender-Auth: JyT67B4PJcp6tnUKScKQcvlK2Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245363>

On Wed, Mar 26, 2014 at 3:23 AM, Jeff King <peff@peff.net> wrote:
> When we calculate the "wants" and "haves" for a pack, we
> only add the objects in the boundary commits as preferred
> bases. However, we know that every object reachable from the
> "haves" could be a preferred base.
>
> We probably don't want to add these to our preferred base
> list, because they would clog the delta-search window.
> However, there is no reason we cannot reuse an on-disk delta
> against such a deep "have" base, avoiding the delta search
> for that object altogether.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/pack-objects.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 7950c43..92bd682 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -53,6 +53,7 @@ static unsigned long pack_size_limit;
>  static int depth = 50;
>  static int delta_search_threads;
>  static int pack_to_stdout;
> +static int thin = 0;
>  static int num_preferred_base;
>  static struct progress *progress_state;
>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
> @@ -1419,6 +1420,20 @@ static void check_object(struct object_entry *entry)
>                         base_entry->delta_child = entry;
>                         unuse_pack(&w_curs);
>                         return;
> +               } else if(thin && base_ref && bitmap_have(base_ref)) {

Missing space after 'if'.

> +                       entry->type = entry->in_pack_type;
> +                       entry->delta_size = entry->size;
> +                       /*
> +                        * XXX we'll leak this, but it's probably OK
> +                        * since we'll exit immediately after the packing
> +                        * is done
> +                        */
> +                       entry->delta = xcalloc(1, sizeof(*entry->delta));
> +                       hashcpy(entry->delta->idx.sha1, base_ref);
> +                       entry->delta->preferred_base = 1;
> +                       entry->delta->filled = 1;
> +                       unuse_pack(&w_curs);
> +                       return;
>                 }
>
>                 if (entry->type) {
> @@ -2559,7 +2574,6 @@ static int option_parse_ulong(const struct option *opt,
>  int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  {
>         int use_internal_rev_list = 0;
> -       int thin = 0;
>         int all_progress_implied = 0;
>         const char *rp_av[6];
>         int rp_ac = 0;
> --
> 1.9.1.601.g7ec968e
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
