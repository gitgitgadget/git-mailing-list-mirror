From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 2/2] Document some functions defined in object.c
Date: Fri, 28 Feb 2014 12:49:11 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402281248470.17677@knanqh.ubzr>
References: <1393604957-7571-1-git-send-email-mhagger@alum.mit.edu>
 <1393604957-7571-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	=?ISO-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:49:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRYt-0006mh-0X
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbaB1RtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:49:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25930 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbaB1RtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 12:49:13 -0500
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N1P009EVW601E90@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Feb 2014 12:49:12 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 33A6C2DA0711; Fri, 28 Feb 2014 12:49:12 -0500 (EST)
In-reply-to: <1393604957-7571-3-git-send-email-mhagger@alum.mit.edu>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242995>

On Fri, 28 Feb 2014, Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  object.c | 29 ++++++++++++++++++++++++++++-
>  object.h |  7 +++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/object.c b/object.c
> index 584f7ac..57a0890 100644
> --- a/object.c
> +++ b/object.c
> @@ -43,14 +43,32 @@ int type_from_string(const char *str)
>  	die("invalid object type \"%s\"", str);
>  }
>  
> +/*
> + * Return a numerical hash value between 0 and n-1 for the object with
> + * the specified sha1.  n must be a power of 2.  Please note that the
> + * return value is *not* consistent across computer architectures.
> + */
>  static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
>  {
>  	unsigned int hash;
> +
> +	/*
> +	 * Since the sha1 is essentially random, we just take the
> +	 * required number of bits directly from the first
> +	 * sizeof(unsigned int) bytes of sha1.  First we have to copy
> +	 * the bytes into a properly aligned integer.  If we cared
> +	 * about getting consistent results across architectures, we
> +	 * would have to call ntohl() here, too.
> +	 */
>  	memcpy(&hash, sha1, sizeof(unsigned int));
> -	/* Assumes power-of-2 hash sizes in grow_object_hash */
>  	return hash & (n - 1);
>  }
>  
> +/*
> + * Insert obj into the hash table hash, which has length size (which
> + * must be a power of 2).  On collisions, simply overflow to the next
> + * empty bucket.
> + */
>  static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
>  {
>  	unsigned int j = hash_obj(obj->sha1, size);
> @@ -63,6 +81,10 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
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
> @@ -92,6 +114,11 @@ struct object *lookup_object(const unsigned char *sha1)
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
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
