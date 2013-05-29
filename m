From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/25] object_array_entry: fix memory handling of the name field
Date: Wed, 29 May 2013 09:24:34 -0700
Message-ID: <7vfvx5wy7x.fsf@alter.siamese.dyndns.org>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
	<1369472904-12875-16-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 29 18:24:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhjB4-0007BH-Ek
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab3E2QYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 12:24:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab3E2QYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:24:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B69E522011;
	Wed, 29 May 2013 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eeUp+EoU+pLepqjQykKcrMz5En4=; b=fR8TYz
	qFPkWfzFYIphPwTM8678qdZhqjNhCgrIAujksA0fkmsPmyo057CBV+8xIky8IYAh
	MjEcBN7rcCMkQCvILcue3XxY+7YkNCn+0nZ/c/WiP1k7BUYYX6rsLbmkkqXK6zIZ
	kmXyI8s208IdCLwHYGTHruSZdoj/yO5f5PVnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rUYpEQYFp4tex6Hp8CZHrQfJRgVT2RUO
	M6wIMyUkuTo+Zx+upemyZ6Vul3QwsGy92xezoUTiPkq0lQksUXsiKGgYh2KQkS3K
	W3gT9+cf7bW5IdQ8fpUCuAFD8KUy4L+AgHIjwQAw6JYV3Bx/ML5BsIszwyki+awn
	B3EfWbbUdMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC0212200F;
	Wed, 29 May 2013 16:24:36 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7F502200C;
	Wed, 29 May 2013 16:24:35 +0000 (UTC)
In-Reply-To: <1369472904-12875-16-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Sat, 25 May 2013 11:08:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4081BFAA-C87C-11E2-9D0D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225839>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change the callers that were already passing copies to
> add_object_array_with_mode() to either skip the copy, or (if the
> memory needed to be allocated anyway) freeing the memory itself.
>
> A part of this commit effectively reverts
>
>     70d26c6e76 read_revisions_from_stdin: make copies for handle_revision_arg
>
> because the copying introduced by that commit (which is still
> necessary) is now done at a deeper level.

Good.  Thanks for working on this.

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  bundle.c   |  2 +-
>  object.c   | 26 +++++++++++++++++++++++---
>  object.h   |  8 +++++++-
>  revision.c |  6 ++++--
>  4 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 4b0e5cd..3d64311 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -281,7 +281,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>  			if (!get_sha1_hex(buf.buf + 1, sha1)) {
>  				struct object *object = parse_object_or_die(sha1, buf.buf);
>  				object->flags |= UNINTERESTING;
> -				add_pending_object(&revs, object, xstrdup(buf.buf));
> +				add_pending_object(&revs, object, buf.buf);
>  			}
>  		} else if (!get_sha1_hex(buf.buf, sha1)) {
>  			struct object *object = parse_object_or_die(sha1, buf.buf);
> diff --git a/object.c b/object.c
> index 10b5349..e4ff714 100644
> --- a/object.c
> +++ b/object.c
> @@ -260,11 +260,18 @@ void add_object_array(struct object *obj, const char *name, struct object_array
>  	add_object_array_with_mode(obj, name, array, S_IFINVALID);
>  }
>  
> +/*
> + * A zero-length string to which object_array_entry::name can be
> + * initialized without requiring a malloc/free.
> + */
> +char object_array_slopbuf[1];
> +
>  void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
>  {
>  	unsigned nr = array->nr;
>  	unsigned alloc = array->alloc;
>  	struct object_array_entry *objects = array->objects;
> +	struct object_array_entry *entry;
>  
>  	if (nr >= alloc) {
>  		alloc = (alloc + 32) * 2;
> @@ -272,9 +279,16 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
>  		array->alloc = alloc;
>  		array->objects = objects;
>  	}
> -	objects[nr].item = obj;
> -	objects[nr].name = name;
> -	objects[nr].mode = mode;
> +	entry = &objects[nr];
> +	entry->item = obj;
> +	if (!name)
> +		entry->name = NULL;
> +	else if (!*name)
> +		/* Use our own empty string instead of allocating one: */
> +		entry->name = object_array_slopbuf;
> +	else
> +		entry->name = xstrdup(name);
> +	entry->mode = mode;
>  	array->nr = ++nr;
>  }
>  
> @@ -289,6 +303,9 @@ void object_array_filter(struct object_array *array,
>  			if (src != dst)
>  				objects[dst] = objects[src];
>  			dst++;
> +		} else {
> +			if (objects[src].name != object_array_slopbuf)
> +				free(objects[src].name);
>  		}
>  	}
>  	array->nr = dst;
> @@ -319,6 +336,9 @@ void object_array_remove_duplicates(struct object_array *array)
>  			if (src != array->nr)
>  				objects[array->nr] = objects[src];
>  			array->nr++;
> +		} else {
> +			if (objects[src].name != object_array_slopbuf)
> +				free(objects[src].name);
>  		}
>  	}
>  }
> diff --git a/object.h b/object.h
> index 6c1c27f..2ff68c5 100644
> --- a/object.h
> +++ b/object.h
> @@ -11,7 +11,13 @@ struct object_array {
>  	unsigned int alloc;
>  	struct object_array_entry {
>  		struct object *item;
> -		const char *name;
> +		/*
> +		 * name or NULL.  If non-NULL, the memory pointed to
> +		 * is owned by this object *except* if it points at
> +		 * object_array_slopbuf, which is a static copy of the
> +		 * empty string.
> +		 */
> +		char *name;
>  		unsigned mode;
>  	} *objects;
>  };
> diff --git a/revision.c b/revision.c
> index be73cb4..4aeda33 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -88,7 +88,9 @@ void add_object(struct object *obj,
>  		struct name_path *path,
>  		const char *name)
>  {
> -	add_object_array(obj, path_name(path, name), p);
> +	char *pn = path_name(path, name);
> +	add_object_array(obj, pn, p);
> +	free(pn);
>  }
>  
>  static void mark_blob_uninteresting(struct blob *blob)
> @@ -1288,7 +1290,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>  			}
>  			die("options not supported in --stdin mode");
>  		}
> -		if (handle_revision_arg(xstrdup(sb.buf), revs, 0,
> +		if (handle_revision_arg(sb.buf, revs, 0,
>  					REVARG_CANNOT_BE_FILENAME))
>  			die("bad revision '%s'", sb.buf);
>  	}
