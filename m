From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Sat, 12 Jul 2014 15:44:06 +0100
Message-ID: <53C149B6.7010705@ramsay1.demon.co.uk>
References: <20140711084141.GA5521@sigill.intra.peff.net> <20140711084611.GB5625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 16:44:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5yXA-0004w6-Gm
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 16:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbaGLOoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 10:44:11 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:40413 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751142AbaGLOoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 10:44:10 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 424836F9032;
	Sat, 12 Jul 2014 14:08:41 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 0F33B6F9028;
	Sat, 12 Jul 2014 14:08:41 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sat, 12 Jul 2014 14:08:40 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140711084611.GB5625@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253391>

On 11/07/14 09:46, Jeff King wrote:
> The "struct object" type implements basic object
> polymorphism.  Individual instances are allocated as
> concrete types (or as a union type that can store any
> object), and a "struct object *" can be cast into its real
> type after examining its "type" enum.  This means it is
> dangerous to have a type field that does not match the
> allocation (e.g., setting the type field of a "struct blob"
> to "OBJ_COMMIT" would mean that a reader might read past the
> allocated memory).
> 
> In most of the current code this is not a problem; the first
> thing we do after allocating an object is usually to set its
> type field by passing it to create_object. However, the
> virtual commits we create in merge-recursive.c do not ever
> get their type set. This does not seem to have caused
> problems in practice, though (presumably because we always
> pass around a "struct commit" pointer and never even look at
> the type).
> 
> We can fix this oversight and also make it harder for future
> code to get it wrong by setting the type directly in the
> object allocation functions.
> 
> This will also make it easier to fix problems with commit
> index allocation, as we know that any object allocated by
> alloc_commit_node will meet the invariant that an object
> with an OBJ_COMMIT type field will have a unique index
> number.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  alloc.c         | 18 ++++++++++--------
>  blob.c          |  2 +-
>  builtin/blame.c |  1 -
>  commit.c        |  2 +-
>  object.c        |  5 ++---
>  object.h        |  2 +-
>  tag.c           |  2 +-
>  tree.c          |  2 +-
>  8 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/alloc.c b/alloc.c
> index d7c3605..fd5fcb7 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -18,11 +18,11 @@
>  
>  #define BLOCKING 1024
>  
> -#define DEFINE_ALLOCATOR(name, type)				\
> +#define DEFINE_ALLOCATOR(name, flag, type)			\
>  static struct alloc_state name##_state;				\
>  void *alloc_##name##_node(void)					\
>  {								\
> -	return alloc_node(&name##_state, sizeof(type));		\
> +	return alloc_node(&name##_state, flag, sizeof(type));	\
>  }

I don't particularly like 'flag' here. (not a massive dislike, mind you:)

Perhaps: flag->object_type, type->node_type?
Or, if that's too verbose, maybe just: flag->type, type->node?

ATB,
Ramsay Jones
