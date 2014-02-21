From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 6/6] Document some functions defined in object.c
Date: Fri, 21 Feb 2014 12:33:21 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402211222270.17677@knanqh.ubzr>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
 <1393000327-11402-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 21 18:33:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGtyk-0001tv-LO
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 18:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230AbaBURdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 12:33:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13932 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbaBURdc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 12:33:32 -0500
Received: from xanadu.home ([66.130.143.177]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N1C00GYBWRL7N80@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Feb 2014 12:33:21 -0500 (EST)
In-reply-to: <1393000327-11402-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242478>

On Fri, 21 Feb 2014, Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Minor nits below.


> ---
>  object.c | 23 ++++++++++++++++++++++-
>  object.h |  7 +++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/object.c b/object.c
> index 584f7ac..c34e225 100644
> --- a/object.c
> +++ b/object.c
> @@ -43,14 +43,26 @@ int type_from_string(const char *str)
>  	die("invalid object type \"%s\"", str);
>  }
>  
> +/*
> + * Return a numerical hash value between 0 and n-1 for the object with
> + * the specified sha1.  n must be a power of 2.
> + *
> + * Since the sha1 is essentially random, we just take the required
> + * bits from the first sizeof(unsigned int) bytes of sha1.

This might be improved a little.  The only reason for the sizeof() is 
actually to copy those bits into a properly aligned integer.  Some 
architectures have alignment restrictions that incure a significant cost 
when integer operations are performed on unaligned data whereas sha1 
pointers don't have any particular alignment requirements.  Once upon a 
time this used to simply be:

	return *(unsigned int *)sha1 & (n - 1);

The memcpy is there only to avoid unaligned accesses.


> + */
>  static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
>  {
>  	unsigned int hash;
> +
>  	memcpy(&hash, sha1, sizeof(unsigned int));
> -	/* Assumes power-of-2 hash sizes in grow_object_hash */
>  	return hash & (n - 1);
>  }

Other than that...

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>



>  
> +/*
> + * Insert obj into the hash table hash, which has length size (which
> + * must be a power of 2).  On collisions, simply overflow to the next
> + * empty bucket.
> + */
>  static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
>  {
>  	unsigned int j = hash_obj(obj->sha1, size);
> @@ -63,6 +75,10 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
>  	hash[j] = obj;
>  }
>  
> +/*
> + * Look up the record for the given sha1 in the hash map stored in
> + * obj_hash.  Return NULL if it was not found.
> + */
>  struct object *lookup_object(const unsigned char *sha1)
>  {
>  	unsigned int i, first;
> @@ -92,6 +108,11 @@ struct object *lookup_object(const unsigned char *sha1)
>  	return obj;
>  }
>  
> +/*
> + * Increase the size of the hash map stored in obj_hash to the next
> + * power of 2 (but at least 32).  Copy the existing values to the new
> + * hash map.
> + */
>  static void grow_object_hash(void)
>  {
>  	int i;
> diff --git a/object.h b/object.h
> index dc5df8c..732bf4d 100644
> --- a/object.h
> +++ b/object.h
> @@ -42,7 +42,14 @@ struct object {
>  extern const char *typename(unsigned int type);
>  extern int type_from_string(const char *str);
>  
> +/*
> + * Return the current number of buckets in the object hashmap.
> + */
>  extern unsigned int get_max_object_index(void);
> +
> +/*
> + * Return the object from the specified bucket in the object hashmap.
> + */
>  extern struct object *get_indexed_object(unsigned int);
>  
>  /*
> -- 
> 1.8.5.3
> 
