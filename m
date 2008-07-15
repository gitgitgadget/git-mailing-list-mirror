From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/4] index-pack: Chain the struct base_data on the stack
 for traversal
Date: Mon, 14 Jul 2008 22:48:35 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142240460.12484@xanadu.home>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <1216001267-33235-2-git-send-email-spearce@spearce.org>
 <1216001267-33235-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 04:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIabj-0002tG-6n
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 04:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761051AbYGOCsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 22:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760988AbYGOCsi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 22:48:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38575 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759704AbYGOCsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 22:48:37 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100IPD14Z2OK0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 22:48:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1216001267-33235-3-git-send-email-spearce@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88503>

On Sun, 13 Jul 2008, Shawn O. Pearce wrote:

> We need to release earlier inflated base objects when memory gets
> low, which means we need to be able to walk up or down the stack
> to locate the objects we want to release, and free their data.
> 
> The new link/unlink routines allow inserting and removing the struct
> base_data during recursion inside resolve_delta, and the global
> base_cache gives us the head of the chain (bottom of the stack)
> so we can traverse it.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

You don't really need that 'base' pointer, do you?  When linking a new 
child, then the 'child' pointer simply has to be overwritten.  there is 
a window where that 'child' pointer would be invalid after the child 
structure has been discarded, but no walking of the list should occur at 
that point anyway.

> ---
>  index-pack.c |   34 +++++++++++++++++++++++++++++++---
>  1 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/index-pack.c b/index-pack.c
> index db03478..6c59fd3 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -27,6 +27,8 @@ union delta_base {
>  };
>  
>  struct base_data {
> +	struct base_data *base;
> +	struct base_data *child;
>  	void *data;
>  	unsigned long size;
>  };
> @@ -48,6 +50,7 @@ struct delta_entry
>  
>  static struct object_entry *objects;
>  static struct delta_entry *deltas;
> +static struct base_data *base_cache;
>  static int nr_objects;
>  static int nr_deltas;
>  static int nr_resolved_deltas;
> @@ -216,6 +219,27 @@ static void bad_object(unsigned long offset, const char *format, ...)
>  	die("pack has bad object at offset %lu: %s", offset, buf);
>  }
>  
> +static void link_base_data(struct base_data *base, struct base_data *c)
> +{
> +	if (base)
> +		base->child = c;
> +	else
> +		base_cache = c;
> +
> +	c->base = base;
> +	c->child = NULL;
> +}
> +
> +static void unlink_base_data(struct base_data *c)
> +{
> +	struct base_data *base = c->base;
> +	if (base)
> +		base->child = NULL;
> +	else
> +		base_cache = NULL;
> +	free(c->data);
> +}
> +
>  static void *unpack_entry_data(unsigned long offset, unsigned long size)
>  {
>  	z_stream stream;
> @@ -452,6 +476,8 @@ static void resolve_delta(struct object_entry *delta_obj,
>  	sha1_object(result.data, result.size, type, delta_obj->idx.sha1);
>  	nr_resolved_deltas++;
>  
> +	link_base_data(base_obj, &result);
> +
>  	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
>  	if (!find_delta_children(&delta_base, &first, &last)) {
>  		for (j = first; j <= last; j++) {
> @@ -471,7 +497,7 @@ static void resolve_delta(struct object_entry *delta_obj,
>  		}
>  	}
>  
> -	free(result.data);
> +	unlink_base_data(&result);
>  }
>  
>  static int compare_delta_entry(const void *a, const void *b)
> @@ -562,6 +588,7 @@ static void parse_pack_objects(unsigned char *sha1)
>  			continue;
>  		base_obj.data = get_data_from_pack(obj);
>  		base_obj.size = obj->size;
> +		link_base_data(NULL, &base_obj);
>  
>  		if (ref)
>  			for (j = ref_first; j <= ref_last; j++) {
> @@ -575,7 +602,7 @@ static void parse_pack_objects(unsigned char *sha1)
>  				if (child->real_type == OBJ_OFS_DELTA)
>  					resolve_delta(child, &base_obj, obj->type);
>  			}
> -		free(base_obj.data);
> +		unlink_base_data(&base_obj);
>  		display_progress(progress, nr_resolved_deltas);
>  	}
>  }
> @@ -670,6 +697,7 @@ static void fix_unresolved_deltas(int nr_unresolved)
>  		base_obj.data = read_sha1_file(d->base.sha1, &type, &base_obj.size);
>  		if (!base_obj.data)
>  			continue;
> +		link_base_data(NULL, &base_obj);
>  
>  		find_delta_children(&d->base, &first, &last);
>  		for (j = first; j <= last; j++) {
> @@ -683,7 +711,7 @@ static void fix_unresolved_deltas(int nr_unresolved)
>  			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
>  		append_obj_to_pack(d->base.sha1, base_obj.data,
>  			base_obj.size, type);
> -		free(base_obj.data);
> +		unlink_base_data(&base_obj);
>  		display_progress(progress, nr_resolved_deltas);
>  	}
>  	free(sorted_by_pos);
> -- 
> 1.5.6.2.393.g45096
> 


Nicolas
