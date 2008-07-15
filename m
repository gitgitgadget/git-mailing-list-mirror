From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] index-pack: Honor core.deltaBaseCacheLimit when
 resolving deltas
Date: Tue, 15 Jul 2008 01:05:32 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807150100470.12484@xanadu.home>
References: <20080715044534.GA2794@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 07:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIckF-0005FR-EC
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 07:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYGOFFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 01:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYGOFFg
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 01:05:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51434 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYGOFFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 01:05:35 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100CVE7H8HWC0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 15 Jul 2008 01:05:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080715044534.GA2794@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88523>

On Tue, 15 Jul 2008, Shawn O. Pearce wrote:

> If we are trying to resolve deltas for a long delta chain composed
> of multi-megabyte objects we can easily run into requiring 500M+
> of memory to hold each object in the chain on the call stack while
> we recurse into the dependent objects and resolve them.
> 
> We now use a simple delta cache that discards objects near the
> bottom of the call stack first, as they are the most least recently
> used objects in this current delta chain.  If we recurse out of a
> chain we may find the base object is no longer available, as it was
> free'd to keep memory under the deltaBaseCacheLimit.  In such cases
> we must unpack the base object again, which will require recursing
> back to the root of the top of the delta chain as we released that
> root first.
> 
> The astute reader will probably realize that we can still exceed
> the delta base cache limit, but this happens only if the most
> recent base plus the delta plus the inflated dependent sum up to
> more than the base cache limit.  Due to the way patch_delta is
> currently implemented we cannot operate in less memory anyway.

You may also set the limit lower than the size of the largest object 
which is going to bust it too.  Same goes for the cache in sha1_file.c.  
There is simply a limit to how tight we can sanely make memory usage.

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

ACK

> ---
> 
>  Version 2 plugs the case Nico noticed, where the patch was causing
>  the exact behavior it was trying to prevent while recovering from
>  what it did to avoid the excessive memory usage in the first place.
> 
>  The change was in get_base_data() where we now unpack the delta
>  after we have unpacked the base.  Nico and I both missed that we
>  must also bump base_cache_used when we restore the base, and we
>  must also prune the bases in case this base has caused us to go
>  over the limit.
> 
>  :-)
> 
>  index-pack.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/index-pack.c b/index-pack.c
> index 7239e89..b4ec736 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -52,6 +52,7 @@ struct delta_entry
>  static struct object_entry *objects;
>  static struct delta_entry *deltas;
>  static struct base_data *base_cache;
> +static size_t base_cache_used;
>  static int nr_objects;
>  static int nr_deltas;
>  static int nr_resolved_deltas;
> @@ -220,6 +221,20 @@ static void bad_object(unsigned long offset, const char *format, ...)
>  	die("pack has bad object at offset %lu: %s", offset, buf);
>  }
>  
> +static void prune_base_data(struct base_data *retain)
> +{
> +	struct base_data *b = base_cache;
> +	for (b = base_cache;
> +	     base_cache_used > delta_base_cache_limit && b;
> +	     b = b->child) {
> +		if (b->data && b != retain) {
> +			free(b->data);
> +			b->data = NULL;
> +			base_cache_used -= b->size;
> +		}
> +	}
> +}
> +
>  static void link_base_data(struct base_data *base, struct base_data *c)
>  {
>  	if (base)
> @@ -229,6 +244,8 @@ static void link_base_data(struct base_data *base, struct base_data *c)
>  
>  	c->base = base;
>  	c->child = NULL;
> +	base_cache_used += c->size;
> +	prune_base_data(c);
>  }
>  
>  static void unlink_base_data(struct base_data *c)
> @@ -238,7 +255,10 @@ static void unlink_base_data(struct base_data *c)
>  		base->child = NULL;
>  	else
>  		base_cache = NULL;
> -	free(c->data);
> +	if (c->data) {
> +		free(c->data);
> +		base_cache_used -= c->size;
> +	}
>  }
>  
>  static void *unpack_entry_data(unsigned long offset, unsigned long size)
> @@ -456,6 +476,30 @@ static void sha1_object(const void *data, unsigned long size,
>  	}
>  }
>  
> +static void *get_base_data(struct base_data *c)
> +{
> +	if (!c->data) {
> +		struct object_entry *obj = c->obj;
> +
> +		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
> +			void *base = get_base_data(c->base);
> +			void *raw = get_data_from_pack(obj);
> +			c->data = patch_delta(
> +				base, c->base->size,
> +				raw, obj->size,
> +				&c->size);
> +			free(raw);
> +			if (!c->data)
> +				bad_object(obj->idx.offset, "failed to apply delta");
> +		} else
> +			c->data = get_data_from_pack(obj);
> +
> +		base_cache_used += c->size;
> +		prune_base_data(c);
> +	}
> +	return c->data;
> +}
> +
>  static void resolve_delta(struct object_entry *delta_obj,
>  			  struct base_data *base_obj, enum object_type type)
>  {
> @@ -468,7 +512,7 @@ static void resolve_delta(struct object_entry *delta_obj,
>  	delta_obj->real_type = type;
>  	delta_data = get_data_from_pack(delta_obj);
>  	delta_size = delta_obj->size;
> -	result.data = patch_delta(base_obj->data, base_obj->size,
> +	result.data = patch_delta(get_base_data(base_obj), base_obj->size,
>  			     delta_data, delta_size,
>  			     &result.size);
>  	free(delta_data);
> -- 
> 1.5.6.2.393.g45096
> 


Nicolas
