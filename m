From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] object: make add_object_array_with_mode a static function
Date: Sun, 19 Oct 2014 11:21:30 +0100
Message-ID: <544390AA.5000406@ramsay1.demon.co.uk>
References: <5442F56B.8020205@ramsay1.demon.co.uk> <20141019020319.GB17908@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 12:21:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfncK-0008H7-Pe
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 12:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbaJSKVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 06:21:37 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:57704 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751479AbaJSKVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 06:21:36 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 522D240110A;
	Sun, 19 Oct 2014 11:21:41 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 0807E4010FE;
	Sun, 19 Oct 2014 11:21:41 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sun, 19 Oct 2014 11:21:38 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141019020319.GB17908@peff.net>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/10/14 03:03, Jeff King wrote:
> On Sun, Oct 19, 2014 at 12:19:07AM +0100, Ramsay Jones wrote:
> 

[snip]

> I actually wondered while writing this series whether anyone actually
> _uses_ the mode in object_array (the new code I added sets it to the
> appropriate value to be on the safe side, but traverse_commit_list does
> not actually care about it).
> 
> Digging in the history, it looks like it is used for blob-to-blob diffs
> (see 01618a3, "use mode of the tree in git-diff, if <tree>:<file> syntax
> is used", 2007-04-22). And that still seems to be the case today. It's a
> shame we have to keep such complication around for one single case
> (especially because getting it wrong in other cases is likely to go
> unnoticed for years), but I think it would probably require major
> surgery to extract it.
> 
> I think we can take your patch a step further, though, like:

Yes, I'm always in favour of removing unused code!  :-D

> 
> -- >8 --
> Subject: [PATCH] drop add_object_array_with_mode
> 
> This is a thin compatibility wrapper around
> add_pending_object_with_path. But the only caller is
> add_object_array, which is itself just a thin compatibility
> wrapper. There are no external callers, so we can just
> remove this middle wrapper.
> 
> Noticed-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I also wondered if add_pending_object_with_mode could get the same
> treatment. But we _do_ use it in setup_revisions and friends when we
> parse something like "HEAD:foo". It would be trivial here to call
> add_pending_object_with_path instead, and actually feed "foo". That
> would mean that "git rev-list --objects HEAD:foo" reported the pathname
> "foo" alongside the object. Or if "foo" is a tree, all of its sub-parts
> would be "foo/whatever" instead of just "whatever". That seems somewhat
> sensible to me, but I would be unsurprised if it broke some weird corner
> case that is expecting paths to be relative to the given tree.
> 
>  object.c | 7 +------
>  object.h | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/object.c b/object.c
> index df86bdd..23d6c96 100644
> --- a/object.c
> +++ b/object.c
> @@ -341,12 +341,7 @@ void add_object_array_with_path(struct object *obj, const char *name,
>  
>  void add_object_array(struct object *obj, const char *name, struct object_array *array)
>  {
> -	add_object_array_with_mode(obj, name, array, S_IFINVALID);
> -}
> -
> -void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
> -{
> -	add_object_array_with_path(obj, name, array, mode, NULL);
> +	add_object_array_with_path(obj, name, array, S_IFINVALID, NULL);
>  }
>  
>  /*
> diff --git a/object.h b/object.h
> index e5178a5..6416247 100644
> --- a/object.h
> +++ b/object.h
> @@ -114,7 +114,6 @@ int object_list_contains(struct object_list *list, struct object *obj);
>  
>  /* Object array handling .. */
>  void add_object_array(struct object *obj, const char *name, struct object_array *array);
> -void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
>  void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
>  
>  typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
> 

Yep, this is a better patch.

Thanks!

ATB,
Ramsay Jones
