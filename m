From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/4] index-pack: Track the object_entry that creates each
 base_data
Date: Mon, 14 Jul 2008 22:50:01 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142249100.12484@xanadu.home>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <1216001267-33235-2-git-send-email-spearce@spearce.org>
 <1216001267-33235-3-git-send-email-spearce@spearce.org>
 <1216001267-33235-4-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 04:51:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIadU-0003JJ-RE
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 04:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbYGOCu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 22:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbYGOCu3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 22:50:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46253 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbYGOCu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 22:50:29 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100ITW17D2OK0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 22:50:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1216001267-33235-4-git-send-email-spearce@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88504>

On Sun, 13 Jul 2008, Shawn O. Pearce wrote:

> If we free the data stored within a base_data we need the struct
> object_entry to get the data back again for use with another
> dependent delta.  Storing the object_entry* makes it simple to call
> get_data_from_pack() to recover the compressed information.
> 
> This however means we must add the missing baes object to the end

Typo?

> of our packfile prior to calling resolve_delta() on each of the
> dependent deltas.  Adding the base first ensures we can read the
> base back from the pack we indexing, as if it had been included by
> the remote side.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

ACK

> ---
>  index-pack.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/index-pack.c b/index-pack.c
> index 6c59fd3..7239e89 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -29,6 +29,7 @@ union delta_base {
>  struct base_data {
>  	struct base_data *base;
>  	struct base_data *child;
> +	struct object_entry *obj;
>  	void *data;
>  	unsigned long size;
>  };
> @@ -476,6 +477,7 @@ static void resolve_delta(struct object_entry *delta_obj,
>  	sha1_object(result.data, result.size, type, delta_obj->idx.sha1);
>  	nr_resolved_deltas++;
>  
> +	result.obj = delta_obj;
>  	link_base_data(base_obj, &result);
>  
>  	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
> @@ -588,6 +590,7 @@ static void parse_pack_objects(unsigned char *sha1)
>  			continue;
>  		base_obj.data = get_data_from_pack(obj);
>  		base_obj.size = obj->size;
> +		base_obj.obj = obj;
>  		link_base_data(NULL, &base_obj);
>  
>  		if (ref)
> @@ -633,7 +636,8 @@ static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_c
>  	return size;
>  }
>  
> -static void append_obj_to_pack(const unsigned char *sha1, void *buf,
> +static struct object_entry *append_obj_to_pack(
> +			       const unsigned char *sha1, void *buf,
>  			       unsigned long size, enum object_type type)
>  {
>  	struct object_entry *obj = &objects[nr_objects++];
> @@ -654,6 +658,7 @@ static void append_obj_to_pack(const unsigned char *sha1, void *buf,
>  	obj[1].idx.offset = obj[0].idx.offset + n;
>  	obj[1].idx.offset += write_compressed(output_fd, buf, size, &obj[0].idx.crc32);
>  	hashcpy(obj->idx.sha1, sha1);
> +	return obj;
>  }
>  
>  static int delta_pos_compare(const void *_a, const void *_b)
> @@ -697,6 +702,12 @@ static void fix_unresolved_deltas(int nr_unresolved)
>  		base_obj.data = read_sha1_file(d->base.sha1, &type, &base_obj.size);
>  		if (!base_obj.data)
>  			continue;
> +
> +		if (check_sha1_signature(d->base.sha1, base_obj.data,
> +				base_obj.size, typename(type)))
> +			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
> +		base_obj.obj = append_obj_to_pack(d->base.sha1, base_obj.data,
> +			base_obj.size, type);
>  		link_base_data(NULL, &base_obj);
>  
>  		find_delta_children(&d->base, &first, &last);
> @@ -706,11 +717,6 @@ static void fix_unresolved_deltas(int nr_unresolved)
>  				resolve_delta(child, &base_obj, type);
>  		}
>  
> -		if (check_sha1_signature(d->base.sha1, base_obj.data,
> -				base_obj.size, typename(type)))
> -			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
> -		append_obj_to_pack(d->base.sha1, base_obj.data,
> -			base_obj.size, type);
>  		unlink_base_data(&base_obj);
>  		display_progress(progress, nr_resolved_deltas);
>  	}
> -- 
> 1.5.6.2.393.g45096
> 


Nicolas
