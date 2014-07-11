From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/7] add object_as_type helper for casting objects
Date: Fri, 11 Jul 2014 11:45:58 +0100
Message-ID: <53BFC066.2090102@ramsay1.demon.co.uk>
References: <20140711084141.GA5521@sigill.intra.peff.net> <20140711084823.GD5625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 12:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5YLA-0006Yb-33
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 12:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbaGKKqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 06:46:03 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:60744 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751247AbaGKKqB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 06:46:01 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 7B47B1280C4;
	Fri, 11 Jul 2014 11:45:55 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 2BE8D1280B3;
	Fri, 11 Jul 2014 11:45:55 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Fri, 11 Jul 2014 11:45:54 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140711084823.GD5625@sigill.intra.peff.net>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253271>

On 11/07/14 09:48, Jeff King wrote:

[snip]

> diff --git a/object.c b/object.c
> index 472aa8d..b2319f6 100644
> --- a/object.c
> +++ b/object.c
> @@ -158,6 +158,23 @@ void *create_object(const unsigned char *sha1, void *o)
>  	return obj;
>  }
>  
> +void *object_as_type(struct object *obj, enum object_type type, int quiet)
> +{
> +	if (obj->type == type)
> +		return obj;
> +	else if (obj->type == OBJ_NONE) {
> +		obj->type = type;
> +		return obj;
> +	}
> +	else {
> +		if (!quiet)
> +			error("object %s is a %s, not a %s",
> +			      sha1_to_hex(obj->sha1),
> +			      typename(obj->type), typename(type));
> +		return NULL;
> +	}
> +}
> +
>  struct object *lookup_unknown_object(const unsigned char *sha1)
>  {
>  	struct object *obj = lookup_object(sha1);
> diff --git a/object.h b/object.h
> index 8020ace..5e8d8ee 100644
> --- a/object.h
> +++ b/object.h
> @@ -81,6 +81,8 @@ struct object *lookup_object(const unsigned char *sha1);
>  
>  extern void *create_object(const unsigned char *sha1, void *obj);
>  
> +void *object_as_type(struct object *obj, enum object_type type, int quiet);
> +
>  /*
>   * Returns the object, having parsed it to find out what it is.
>   *
> diff --git a/refs.c b/refs.c
> index 20e2bf1..5a18e2d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1729,9 +1729,8 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
>  
>  	if (o->type == OBJ_NONE) {
>  		int type = sha1_object_info(name, NULL);
> -		if (type < 0)
> +		if (type < 0 || !object_as_type(o, type, 0))
--------------------------------------------------------^^^

It is not possible here for object_as_type() to issue an error()
report, but I had to go look at the code to check. (It would have
been a change in behaviour, otherwise). So, it doesn't really matter
what you pass to the quiet argument, but setting it to 1 _may_ help
the next reader. (No, I'm not convinced either; the only reason I
knew it had anything to do with error messages was because I had
just read the code ...) Hmm, dunno.

>  			return PEEL_INVALID;
> -		o->type = type;
>  	}
>  
>  	if (o->type != OBJ_TAG)
> diff --git a/tag.c b/tag.c
> index 79552c7..82d841b 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -41,14 +41,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj)
>  		return create_object(sha1, alloc_tag_node());
> -	if (!obj->type)
> -		obj->type = OBJ_TAG;
> -	if (obj->type != OBJ_TAG) {
> -		error("Object %s is a %s, not a tag",
> -		      sha1_to_hex(sha1), typename(obj->type));
> -		return NULL;
> -	}
> -	return (struct tag *) obj;
> +	return object_as_type(obj, OBJ_TAG, 0);
>  }
>  
>  static unsigned long parse_tag_date(const char *buf, const char *tail)
> diff --git a/tree.c b/tree.c
> index ed66575..bb02c1c 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -184,14 +184,7 @@ struct tree *lookup_tree(const unsigned char *sha1)
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj)
>  		return create_object(sha1, alloc_tree_node());
> -	if (!obj->type)
> -		obj->type = OBJ_TREE;
> -	if (obj->type != OBJ_TREE) {
> -		error("Object %s is a %s, not a tree",
> -		      sha1_to_hex(sha1), typename(obj->type));
> -		return NULL;
> -	}
> -	return (struct tree *) obj;
> +	return object_as_type(obj, OBJ_TREE, 0);
>  }
>  
>  int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
> 

ATB,
Ramsay Jones
