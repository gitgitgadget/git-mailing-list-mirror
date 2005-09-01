From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Reworked read-tree.
Date: Thu, 1 Sep 2005 11:55:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509011143350.23242@iabervon.org>
References: <Pine.LNX.4.63.0509010009350.23242@iabervon.org>
 <7vll2h4bc8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509010138370.23242@iabervon.org>
 <7vvf1l1env.fsf@assigned-by-dhcp.cox.net> <7vpsrt1cwc.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 17:55:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EArMF-0000p4-3B
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 17:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVIAPwD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 11:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVIAPwD
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 11:52:03 -0400
Received: from iabervon.org ([66.92.72.58]:22023 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030215AbVIAPwB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2005 11:52:01 -0400
Received: (qmail 12738 invoked by uid 1000); 1 Sep 2005 11:55:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Sep 2005 11:55:48 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrt1cwc.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7997>

On Thu, 1 Sep 2005, Junio C Hamano wrote:

> Daniel, I do not know what your current status is, but I think
> you need something like this.

Yup, I forgot to actually test that functionality.

> ---
> diff --git a/tree.c b/tree.c
> --- a/tree.c
> +++ b/tree.c
> @@ -224,10 +224,12 @@ struct tree *parse_tree_indirect(const u
>  		if (obj->type == tree_type)
>  			return (struct tree *) obj;
>  		else if (obj->type == commit_type)
> -			return ((struct commit *) obj)->tree;
> +			obj = (struct object *)(((struct commit *) obj)->tree);

obj = &((struct commit *) obj)->tree->object;

Multiple sequential casts always bother me, and we do actually have a 
field for this.

>  		else if (obj->type == tag_type)
> -			obj = ((struct tag *) obj)->tagged;
> +			obj = deref_tag(obj);

Shouldn't be necessary (once you've got the parse_object below); we're 
already in a loop dereferencing things.

>  		else
>  			return NULL;
> +		if (!obj->parsed)
> +			parse_object(obj->sha1);
>  	} while (1);
>  }
> 
> 
