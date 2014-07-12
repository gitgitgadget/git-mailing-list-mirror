From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Sat, 12 Jul 2014 15:55:35 +0100
Message-ID: <53C14C67.60300@ramsay1.demon.co.uk>
References: <20140711084141.GA5521@sigill.intra.peff.net> <20140711084611.GB5625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 16:55:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5yiF-0000Xu-Cv
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 16:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbaGLOzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 10:55:39 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:41122 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751749AbaGLOzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 10:55:38 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 6EAD86F907B;
	Sat, 12 Jul 2014 14:20:10 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 2595B6F9079;
	Sat, 12 Jul 2014 14:20:10 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sat, 12 Jul 2014 14:20:09 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140711084611.GB5625@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253392>

On 11/07/14 09:46, Jeff King wrote:

[snip]

Sorry, hit send too early ...

> diff --git a/blob.c b/blob.c
> index ae320bd..5720a38 100644
> --- a/blob.c
> +++ b/blob.c
> @@ -7,7 +7,7 @@ struct blob *lookup_blob(const unsigned char *sha1)
>  {
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj)
> -		return create_object(sha1, OBJ_BLOB, alloc_blob_node());
> +		return create_object(sha1, alloc_blob_node());
>  	if (!obj->type)
>  		obj->type = OBJ_BLOB;
>  	if (obj->type != OBJ_BLOB) {
> diff --git a/builtin/blame.c b/builtin/blame.c
> index d3b256e..8f3e311 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2287,7 +2287,6 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  	commit = alloc_commit_node();
>  	commit->object.parsed = 1;
>  	commit->date = now;
> -	commit->object.type = OBJ_COMMIT;
>  	parent_tail = &commit->parents;
>  
>  	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
> diff --git a/commit.c b/commit.c
> index fb7897c..21ed310 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -63,7 +63,7 @@ struct commit *lookup_commit(const unsigned char *sha1)
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj) {
>  		struct commit *c = alloc_commit_node();
> -		return create_object(sha1, OBJ_COMMIT, c);
> +		return create_object(sha1, c);
>  	}

perhaps:
	if (!obj)
		return create_object(sha1, alloc_commit_node());

(increasing similarity with other calls here ...)

>  	if (!obj->type)
>  		obj->type = OBJ_COMMIT;
> diff --git a/object.c b/object.c
> index 9c31e9a..a950b85 100644
> --- a/object.c
> +++ b/object.c
> @@ -141,13 +141,12 @@ static void grow_object_hash(void)
>  	obj_hash_size = new_hash_size;
>  }
>  
> -void *create_object(const unsigned char *sha1, int type, void *o)
> +void *create_object(const unsigned char *sha1, void *o)
>  {
>  	struct object *obj = o;
>  
>  	obj->parsed = 0;
>  	obj->used = 0;
> -	obj->type = type;
>  	obj->flags = 0;
>  	hashcpy(obj->sha1, sha1);
>  
> @@ -163,7 +162,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
>  {
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj)
> -		obj = create_object(sha1, OBJ_NONE, alloc_object_node());
> +		obj = create_object(sha1, alloc_object_node());
>  	return obj;
>  }
>  
> diff --git a/object.h b/object.h
> index 6e12f2c..8020ace 100644
> --- a/object.h
> +++ b/object.h
> @@ -79,7 +79,7 @@ extern struct object *get_indexed_object(unsigned int);
>   */
>  struct object *lookup_object(const unsigned char *sha1);
>  
> -extern void *create_object(const unsigned char *sha1, int type, void *obj);
> +extern void *create_object(const unsigned char *sha1, void *obj);
>  
>  /*
>   * Returns the object, having parsed it to find out what it is.
> diff --git a/tag.c b/tag.c
> index 7b07921..79552c7 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -40,7 +40,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
>  {
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj)
> -		return create_object(sha1, OBJ_TAG, alloc_tag_node());
> +		return create_object(sha1, alloc_tag_node());
>  	if (!obj->type)
>  		obj->type = OBJ_TAG;
>  	if (obj->type != OBJ_TAG) {
> diff --git a/tree.c b/tree.c
> index c8c49d7..ed66575 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -183,7 +183,7 @@ struct tree *lookup_tree(const unsigned char *sha1)
>  {
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj)
> -		return create_object(sha1, OBJ_TREE, alloc_tree_node());
> +		return create_object(sha1, alloc_tree_node());
>  	if (!obj->type)
>  		obj->type = OBJ_TREE;
>  	if (obj->type != OBJ_TREE) {
> 

ATB,
Ramsay Jones
