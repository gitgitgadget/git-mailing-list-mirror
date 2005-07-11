From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Dereference tag repeatedly until we get a non-tag.
Date: Tue, 12 Jul 2005 01:14:53 +1000
Message-ID: <2cfc40320507110814256bef25@mail.gmail.com>
References: <7v7jg0wb77.fsf@assigned-by-dhcp.cox.net>
	 <7v8y0dx24j.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 20:29:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds32B-0001g2-2y
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 20:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVGKPTC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 11:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVGKPQp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 11:16:45 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:41294 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261961AbVGKPOz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 11:14:55 -0400
Received: by rproxy.gmail.com with SMTP id c51so814972rne
        for <git@vger.kernel.org>; Mon, 11 Jul 2005 08:14:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MZrgBidsbNiJqgYjCm/7eJtj7/tSF14ioe9kCF4GpcVgbMO46kXziJnU26odtAlBgIqdK/CaGjyFd+iCx6uysVMPeKeoeut1RuDnCuMUD9LZCH2/ucjyycK8MbiiiZ7fJXce2YS1LhVMqgCG6oI20hW6DwhGesGKt++zUVhrieI=
Received: by 10.38.104.15 with SMTP id b15mr2177646rnc;
        Mon, 11 Jul 2005 08:14:53 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Mon, 11 Jul 2005 08:14:53 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y0dx24j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This seems reasonable to me. I have thought this would be useful on
several occasions and haven't yet conceived of a counterexample where
it would break something.

On 7/11/05, Junio C Hamano <junkio@cox.net> wrote:
> When we allow a tag object in place of a commit object, we only
> dereferenced the given tag once, which causes a tag that points
> at a tag that points at a commit to be rejected.  Instead,
> dereference tag repeatedly until we get a non-tag.
> 
> This patch makes change to two functions:
> 
>  - commit.c::lookup_commit_reference() is used by merge-base,
>    rev-tree and rev-parse to convert user supplied SHA1 to that of
>    a commit.
>  - rev-list uses its own get_commit_reference() to do the same.
> 
> Dereferencing tags this way helps both of these uses.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
> *** Whether having a tag pointing at another tag is a separate
> *** issue, but I do not see a reason to forbid it.  Maybe it
> *** is used to represent a chain of trust.
> 
>  commit.c   |    5 +++--
>  rev-list.c |    4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> 0dc9377363ee73c5e3f3711d6f82e49886ce8c6a
> diff --git a/commit.c b/commit.c
> --- a/commit.c
> +++ b/commit.c
> @@ -52,8 +52,9 @@ struct commit *lookup_commit_reference(c
> 
>         if (!obj)
>                 return NULL;
> -       if (obj->type == tag_type)
> -               obj = ((struct tag *)obj)->tagged;
> +       while (obj->type == tag_type)
> +               obj = parse_object(((struct tag *)obj)->tagged->sha1);
> +
>         return check_commit(obj, sha1);
>  }
> 
> diff --git a/rev-list.c b/rev-list.c
> --- a/rev-list.c
> +++ b/rev-list.c
> @@ -367,12 +367,12 @@ static struct commit *get_commit_referen
>         /*
>          * Tag object? Look what it points to..
>          */
> -       if (object->type == tag_type) {
> +       while (object->type == tag_type) {
>                 struct tag *tag = (struct tag *) object;
>                 object->flags |= flags;
>                 if (tag_objects && !(object->flags & UNINTERESTING))
>                         add_pending_object(object, tag->tag);
> -               object = tag->tagged;
> +               object = parse_object(tag->tagged->sha1);
>         }
> 
>         /*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
