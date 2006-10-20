From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Remove unused index tracking code.
Date: Thu, 19 Oct 2006 21:11:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610192058130.1971@xanadu.home>
References: <1168a0313ac1152d43731965fbbb6d4ccfd865a1.1161301889.git.jaharkes@cs.cmu.edu>
 <20061020002048.GC7162@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 03:11:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gaiuq-0003kB-Du
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 03:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWJTBLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 21:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWJTBLN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 21:11:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60904 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751648AbWJTBLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 21:11:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7E00ACKTYMJSU0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Oct 2006 21:11:11 -0400 (EDT)
In-reply-to: <20061020002048.GC7162@delft.aura.cs.cmu.edu>
X-X-Sender: nico@xanadu.home
To: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29398>

On Thu, 19 Oct 2006, Jan Harkes wrote:

> Tracking the offsets is not that hard, but calculating the sha1 for the
> deltas is tricky, we may have already seen and written out the base we
> need. So it is actually easier to avoid the complexity altogether and
> rely on git-index-pack to rebuild the index. The indexing step is also a
> useful validation whether the final pack contains a base for every delta.
> 
> Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>

I don't think it is a good idea.

After looking at the problem for a while I should side with Linus.  
unpack-objects is not the proper tool for the job.  The way to go is to 
make input to index-pack streamable.

This patch in particular creates additional restrictions on pack 
files that were not present before.  And I don't think this is a good 
thing.

This patch impose an ordering on REF_DELTA objects that doesn't need to 
exist.  Say for example that an OFS_DELTA depends on an object which is 
a REF_DELTA object.  With this patch any pack with the base for that 
REF_DELTA stored after the OFS_DELTA object will be broken.

And to really do thin pack fixing properly we really want to just append 
missing base objects at the end of the pack which falls in the broken 
case above.

So this is a NAK from me.

> ---
>  builtin-unpack-objects.c |   57 +++++++++++-----------------------------------
>  1 files changed, 14 insertions(+), 43 deletions(-)
> 
> diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> index b95c93c..3df7938 100644
> --- a/builtin-unpack-objects.c
> +++ b/builtin-unpack-objects.c
> @@ -89,29 +89,6 @@ static void *get_data(unsigned long size
>  }
>  
>  static struct sha1file *pack_file;
> -static unsigned long pack_file_offset;
> -
> -struct index_entry {
> -	unsigned long offset;
> -	unsigned char sha1[20];
> -};
> -
> -static unsigned int index_nr, index_alloc;
> -static struct index_entry **index_array;
> -
> -static void add_pack_index(unsigned char *sha1)
> -{
> -	struct index_entry *entry;
> -	int nr = index_nr;
> -	if (nr >= index_alloc) {
> -		index_alloc = (index_alloc + 64) * 3 / 2;
> -		index_array = xrealloc(index_array, index_alloc * sizeof(*index_array));
> -	}
> -	entry = xmalloc(sizeof(*entry));
> -	entry->offset = pack_file_offset;
> -	hashcpy(entry->sha1, sha1);
> -	index_array[nr++] = entry;
> -}
>  
>  static void write_pack_delta(const unsigned char *base, const void *delta, unsigned long delta_size)
>  {
> @@ -122,11 +99,9 @@ static void write_pack_delta(const unsig
>  	sha1write(pack_file, header, hdrlen);
>  	sha1write(pack_file, base, 20);
>  	datalen = sha1write_compressed(pack_file, delta, delta_size);
> -
> -	pack_file_offset += hdrlen + 20 + datalen;
>  }
>  
> -static void write_pack_object(const char *type, const unsigned char *sha1, const void *buf, unsigned long size)
> +static void write_pack_object(const void *buf, unsigned long size, const char *type, const unsigned char *sha1)
>  {
>  	unsigned char header[10];
>  	unsigned hdrlen, datalen;
> @@ -134,8 +109,6 @@ static void write_pack_object(const char
>  	hdrlen = encode_header(string_to_type(type, sha1), size, header);
>  	sha1write(pack_file, header, hdrlen);
>  	datalen = sha1write_compressed(pack_file, buf, size);
> -
> -	pack_file_offset += hdrlen + datalen;
>  }
>  
>  struct delta_info {
> @@ -160,22 +133,21 @@ static void add_delta_to_list(unsigned c
>  
>  static void added_object(unsigned char *sha1, const char *type, void *data, unsigned long size);
>  
> -static void write_object(void *buf, unsigned long size, const char *type,
> -	unsigned char *base, void *delta, unsigned long delta_size)
> +static void write_object(void *buf, unsigned long size, const char *type)
>  {
>  	unsigned char sha1[20];
>  
>  	if (pack_file) {
>  		if (hash_sha1_file(buf, size, type, sha1) < 0)
>  			die("failed to compute object hash");
> -		add_pack_index(sha1);
> -		if (0 && base)
> -			write_pack_delta(base, delta, delta_size);
> -		else
> -			write_pack_object(type, sha1, buf, size);
> -	} else if (write_sha1_file(buf, size, type, sha1) < 0)
> -		die("failed to write object");
> -	added_object(sha1, type, buf, size);
> +
> +		write_pack_object(buf, size, type, sha1);
> +	} else {
> +		if (write_sha1_file(buf, size, type, sha1) < 0)
> +		    die("failed to write object");
> +
> +		added_object(sha1, type, buf, size);
> +	}
>  }
>  
>  static void resolve_delta(const char *type, unsigned char *base_sha1,
> @@ -190,7 +162,7 @@ static void resolve_delta(const char *ty
>  			     &result_size);
>  	if (!result)
>  		die("failed to apply delta");
> -	write_object(result, result_size, type, base_sha1, delta, delta_size);
> +	write_object(result, result_size, type);
>  	free(delta);
>  	free(result);
>  }
> @@ -225,7 +197,7 @@ static void unpack_non_delta_entry(enum 
>  	default: die("bad type %d", kind);
>  	}
>  	if (!dry_run && buf)
> -		write_object(buf, size, type, NULL, NULL, 0);
> +		write_object(buf, size, type);
>  	free(buf);
>  }
>  
> @@ -334,12 +306,11 @@ static void unpack_all(const char *repac
>  		newhdr.hdr_signature = htonl(PACK_SIGNATURE);
>  		newhdr.hdr_version = htonl(PACK_VERSION);
>  		newhdr.hdr_entries = htonl(nr_objects);
> -		
> +
>  		pack_file = sha1create("%s.pack", repack);
>  		sha1write(pack_file, &newhdr, sizeof(newhdr));
> -		pack_file_offset = sizeof(newhdr);
>  	}
> -		
> +
>  
>  	use(sizeof(struct pack_header));
>  	for (i = 0; i < nr_objects; i++)
> -- 
> 1.4.2.1
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Nicolas
