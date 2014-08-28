From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Accept object data in the fsck_object() function
Date: Thu, 28 Aug 2014 13:47:52 -0700
Message-ID: <xmqqvbpc8hon.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646400.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:48:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN6c6-0002ZF-3P
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 22:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbaH1UsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 16:48:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51929 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbaH1UsD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 16:48:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A185367FC;
	Thu, 28 Aug 2014 16:48:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1t6txFUi4woUScXp9IxYIlofpIQ=; b=UuFFx7
	kHsHDRTvGuut2qwuwBnQ/peilMr/7nlgK+Bchgjskmf57Zc4xUZU31F98O6157HC
	7ugyPLFVdW3d7W/Kd/JpUOlkzuo/8LAcV9utA0O/Br6HFCi27Xl5IifbUF0QtiST
	4qDSwEMuJ6j8OD1DQI7eY2Sab1vECWxoUqmWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kn5K9Ywotg0h9dtU5idElZff6Otu4QSS
	68OUKzFLrVGjNMg5fJEQP3Jpk+MfEoz7AMmsv3gqyZGohakKcoXftoAH7HDWnllj
	6cxN7IUM1ygRP0fIURU30cmjoW1kZbtvfcn9+UKl83wOXQn22iRR0TdXC7Y2t0c8
	P9l2HYX+mqI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC4EB367FB;
	Thu, 28 Aug 2014 16:48:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B4BC367F1;
	Thu, 28 Aug 2014 16:47:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1408281646400.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 28 Aug 2014 16:46:42 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9577C95C-2EF4-11E4-ABAA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256123>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When fsck'ing an incoming pack, we need to fsck objects that cannot be
> read via read_sha1_file() because they are not local yet (and might even
> be rejected if transfer.fsckobjects is set to 'true').
>
> For commits, there is a hack in place: we basically cache commit
> objects' buffers anyway, but the same is not true, say, for tag objects.
>
> By refactoring fsck_object() to take the object buffer and size as
> optional arguments -- optional, because we still fall back to the
> previous method to look at the cached commit objects if the caller
> passes NULL -- we prepare the machinery for the upcoming handling of tag
> objects.
>
> The assumption that such buffers are inherently NUL terminated is now
> wrong, of course, hence we pass the size of the buffer so that we can
> add a sanity check later, to prevent running past the end of the buffer.

A nice side effect may be that we can now check (and perhaps warn) a
commit buffer with a NUL inside, perhaps?   I am not suggesting to
add such a check to this series, but mentioning the possibilty here
may have a merit.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/fsck.c           |  2 +-
>  builtin/index-pack.c     |  3 ++-
>  builtin/unpack-objects.c | 14 ++++++++++----
>  fsck.c                   | 24 +++++++++++++++---------
>  fsck.h                   |  4 +++-
>  5 files changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d42a27d..d9f4e6e 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -298,7 +298,7 @@ static int fsck_obj(struct object *obj)
>  
>  	if (fsck_walk(obj, mark_used, NULL))
>  		objerror(obj, "broken links");
> -	if (fsck_object(obj, check_strict, fsck_error_func))
> +	if (fsck_object(obj, NULL, 0, check_strict, fsck_error_func))
>  		return -1;
>  
>  	if (obj->type == OBJ_TREE) {
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 5568a5b..f2465ff 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -773,7 +773,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  			if (!obj)
>  				die(_("invalid %s"), typename(type));
>  			if (do_fsck_object &&
> -			    fsck_object(obj, 1, fsck_error_function))
> +			    fsck_object(obj, buf, size, 1,
> +				    fsck_error_function))
>  				die(_("Error in object"));
>  			if (fsck_walk(obj, mark_link, NULL))
>  				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 99cde45..855d94b 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -164,10 +164,10 @@ static unsigned nr_objects;
>   * Called only from check_object() after it verified this object
>   * is Ok.
>   */
> -static void write_cached_object(struct object *obj)
> +static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
>  {
>  	unsigned char sha1[20];
> -	struct obj_buffer *obj_buf = lookup_object_buffer(obj);
> +
>  	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), sha1) < 0)
>  		die("failed to write object %s", sha1_to_hex(obj->sha1));
>  	obj->flags |= FLAG_WRITTEN;
> @@ -180,6 +180,8 @@ static void write_cached_object(struct object *obj)
>   */
>  static int check_object(struct object *obj, int type, void *data)
>  {
> +	struct obj_buffer *obj_buf;
> +
>  	if (!obj)
>  		return 1;
>  
> @@ -198,11 +200,15 @@ static int check_object(struct object *obj, int type, void *data)
>  		return 0;
>  	}
>  
> -	if (fsck_object(obj, 1, fsck_error_function))
> +	obj_buf = lookup_object_buffer(obj);
> +	if (!obj_buf)
> +		die("Whoops! Cannot find object '%s'", sha1_to_hex(obj->sha1));
> +	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, 1,
> +			fsck_error_function))
>  		die("Error in object");
>  	if (fsck_walk(obj, check_object, NULL))
>  		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
> -	write_cached_object(obj);
> +	write_cached_object(obj, obj_buf);
>  	return 0;
>  }
>  
> diff --git a/fsck.c b/fsck.c
> index 56156ff..dd77628 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -277,7 +277,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
>  }
>  
>  static int fsck_commit_buffer(struct commit *commit, const char *buffer,
> -			      fsck_error error_func)
> +	unsigned long size, fsck_error error_func)
>  {
>  	unsigned char tree_sha1[20], sha1[20];
>  	struct commit_graft *graft;
> @@ -322,15 +322,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>  	return 0;
>  }
>  
> -static int fsck_commit(struct commit *commit, fsck_error error_func)
> +static int fsck_commit(struct commit *commit, const char *data,
> +	unsigned long size, fsck_error error_func)
>  {
> -	const char *buffer = get_commit_buffer(commit, NULL);
> -	int ret = fsck_commit_buffer(commit, buffer, error_func);
> -	unuse_commit_buffer(commit, buffer);
> +	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
> +	int ret = fsck_commit_buffer(commit, buffer, size, error_func);
> +	if (!data)
> +		unuse_commit_buffer(commit, buffer);
>  	return ret;
>  }
>  
> -static int fsck_tag(struct tag *tag, fsck_error error_func)
> +static int fsck_tag(struct tag *tag, const char *data,
> +	unsigned long size, fsck_error error_func)
>  {
>  	struct object *tagged = tag->tagged;
>  
> @@ -339,7 +342,8 @@ static int fsck_tag(struct tag *tag, fsck_error error_func)
>  	return 0;
>  }
>  
> -int fsck_object(struct object *obj, int strict, fsck_error error_func)
> +int fsck_object(struct object *obj, void *data, unsigned long size,
> +	int strict, fsck_error error_func)
>  {
>  	if (!obj)
>  		return error_func(obj, FSCK_ERROR, "no valid object to fsck");
> @@ -349,9 +353,11 @@ int fsck_object(struct object *obj, int strict, fsck_error error_func)
>  	if (obj->type == OBJ_TREE)
>  		return fsck_tree((struct tree *) obj, strict, error_func);
>  	if (obj->type == OBJ_COMMIT)
> -		return fsck_commit((struct commit *) obj, error_func);
> +		return fsck_commit((struct commit *) obj, (const char *) data,
> +			size, error_func);
>  	if (obj->type == OBJ_TAG)
> -		return fsck_tag((struct tag *) obj, error_func);
> +		return fsck_tag((struct tag *) obj, (const char *) data,
> +			size, error_func);
>  
>  	return error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck error)",
>  			  obj->type);
> diff --git a/fsck.h b/fsck.h
> index 1e4f527..d1e6387 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -28,6 +28,8 @@ int fsck_error_function(struct object *obj, int type, const char *fmt, ...);
>   *    0		everything OK
>   */
>  int fsck_walk(struct object *obj, fsck_walk_func walk, void *data);
> -int fsck_object(struct object *obj, int strict, fsck_error error_func);
> +/* If NULL is passed for data, we assume the object is local and read it. */
> +int fsck_object(struct object *obj, void *data, unsigned long size,
> +	int strict, fsck_error error_func);
>  
>  #endif
