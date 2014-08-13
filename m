From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] checkout -m: attempt merge when deletion of path was staged
Date: Tue, 12 Aug 2014 17:38:04 -0700
Message-ID: <CAPc5daV-p25_W9+3_HsOZ-nsab86JNVH0mABQJjX=HX6Kvjenw@mail.gmail.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com> <1407878107-22850-1-git-send-email-stefanbeller@gmail.com>
 <20140812235731.GD24621@google.com> <20140813000317.GG24621@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 02:38:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHMaE-00050l-9h
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 02:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaHMAi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 20:38:26 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:64736 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbaHMAi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 20:38:26 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so8594562lam.14
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 17:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xPPSVCNc1rvmzhk3xCOlx3QVXoTPCHAIwSEENZ6gwWU=;
        b=bXiRbQ8ZauWs5rymrmhn8KQa2UZUCat5TaW5mFL9eLtLdx/iWlVxlczJCRRWoeWT+B
         mpc388uHG51Aox1o+7VCyeN/lRx1uqchL7JcjuzDl4Jg+LMu2+HlZaLqtrmofqWzyJ09
         glNw00LjE0SiN3jk6ML9sA71RHJ6/oU+F76Iq6ONhw5Tbj2+mmEUYSS5adHWtN/ihbiK
         +P20O2A1oUua+ySjHXIZpCGQRfjrKJQP9s1c+69fTMWqUrUlIvPXFaru2ZxAMF1SWgKq
         uRSdo55oCHUxG6+RkpeaE63oIx8+rmR1EYS99aepgboydpkyF94oXMb/DYFfDoAk58oD
         aHEg==
X-Received: by 10.112.35.79 with SMTP id f15mr98644lbj.101.1407890304530; Tue,
 12 Aug 2014 17:38:24 -0700 (PDT)
Received: by 10.112.199.74 with HTTP; Tue, 12 Aug 2014 17:38:04 -0700 (PDT)
In-Reply-To: <20140813000317.GG24621@google.com>
X-Google-Sender-Auth: Oc7FrKrj3ip56nIGt7FcW7f7HBM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255181>

On Tue, Aug 12, 2014 at 5:03 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> twoway_merge() is missing an o->gently check in the case where a file
> that needs to be modified is missing from the index but present in the
> old and new trees.  As a result, in this case 'git checkout -m' errors
> out instead of trying to perform a merge.
>
> Fix it by checking o->gently.  While at it, inline the o->gently check
> into reject_merge to prevent future call sites from making the same
> mistake.
>
> Noticed by code inspection.  The motivating case hasn't been tested.

That sounds sloppy X-<.  I may comment more after figuring out
what _other_ reject_merge() caller that does not appear in the
patch would change its behaviour with this patch.

  side note: of course, if this were two patches, one that adds the
  same o->gently ? -1 : reject thing to places where they forget to
  do so, and the other that moves the gently thing to reject helper,
  then we can read all the necessary information to judge the change
  in the patch ;-)

Thanks.

>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This is the most iffy of the three patches, mostly because I was too
> lazy to write a test.  I believe it's safe as-is nonetheless.
>
> Thanks for reading.
>
>  unpack-trees.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 187b15b..6c45af7 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1178,7 +1178,8 @@ return_failed:
>  static int reject_merge(const struct cache_entry *ce,
>                         struct unpack_trees_options *o)
>  {
> -       return add_rejected_path(o, ERROR_WOULD_OVERWRITE, ce->name);
> +       return o->gently ? -1 :
> +               add_rejected_path(o, ERROR_WOULD_OVERWRITE, ce->name);
>  }
>
>  static int same(const struct cache_entry *a, const struct cache_entry *b)
> @@ -1633,7 +1634,7 @@ int threeway_merge(const struct cache_entry * const *stages,
>         /* #14, #14ALT, #2ALT */
>         if (remote && !df_conflict_head && head_match && !remote_match) {
>                 if (index && !same(index, remote) && !same(index, head))
> -                       return o->gently ? -1 : reject_merge(index, o);
> +                       return reject_merge(index, o);
>                 return merged_entry(remote, index, o);
>         }
>         /*
> @@ -1641,7 +1642,7 @@ int threeway_merge(const struct cache_entry * const *stages,
>          * make sure that it matches head.
>          */
>         if (index && !same(index, head))
> -               return o->gently ? -1 : reject_merge(index, o);
> +               return reject_merge(index, o);
>
>         if (head) {
>                 /* #5ALT, #15 */
> @@ -1770,7 +1771,7 @@ int twoway_merge(const struct cache_entry * const *src,
>                                 else
>                                         return merged_entry(newtree, current, o);
>                         }
> -                       return o->gently ? -1 : reject_merge(current, o);
> +                       return reject_merge(current, o);
>                 } else if ((!oldtree && !newtree) || /* 4 and 5 */
>                          (!oldtree && newtree &&
>                           same(current, newtree)) || /* 6 and 7 */
> @@ -1788,7 +1789,7 @@ int twoway_merge(const struct cache_entry * const *src,
>                         /* 20 or 21 */
>                         return merged_entry(newtree, current, o);
>                 } else
> -                       return o->gently ? -1 : reject_merge(current, o);
> +                       return reject_merge(current, o);
>         }
>         else if (newtree) {
>                 if (oldtree && !o->initial_checkout) {
> --
