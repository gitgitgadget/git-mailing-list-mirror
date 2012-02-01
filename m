From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3 1/2] Factor find_pack_entry()'s core out
Date: Wed, 01 Feb 2012 10:59:26 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1202011056140.2759@xanadu.home>
References: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 <1328104135-475-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Dl3H2lczOHqfQ08mxtt9cQ)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 16:59:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rscav-0005OY-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 16:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab2BAP72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 10:59:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10108 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab2BAP72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 10:59:28 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYQ00GMU1QPVRC0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Feb 2012 10:59:13 -0500 (EST)
In-reply-to: <1328104135-475-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189519>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Dl3H2lczOHqfQ08mxtt9cQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 1 Feb 2012, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  sha1_file.c |   59 +++++++++++++++++++++++++++++++++--------------------------
>  1 files changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 88f2151..ff5bf42 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2010,11 +2010,42 @@ int is_pack_valid(struct packed_git *p)
>  	return !open_packed_git(p);
>  }
>  
> +static int find_pack_entry_1(const unsigned char *sha1,
> +			     struct packed_git *p, struct pack_entry *e)

This looks all goot but the name.  Pretty please, try to find something 
that is more descriptive than "1".  Suggestions: 
"find_pack_entry_lookup", "find_pack_entry_inner", etc.

With that fixed, you can add:

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> +{
> +	off_t offset;
> +	if (p->num_bad_objects) {
> +		unsigned i;
> +		for (i = 0; i < p->num_bad_objects; i++)
> +			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
> +				return 0;
> +	}
> +
> +	offset = find_pack_entry_one(sha1, p);
> +	if (!offset)
> +		return 0;
> +
> +	/*
> +	 * We are about to tell the caller where they can locate the
> +	 * requested object.  We better make sure the packfile is
> +	 * still here and can be accessed before supplying that
> +	 * answer, as it may have been deleted since the index was
> +	 * loaded!
> +	 */
> +	if (!is_pack_valid(p)) {
> +		warning("packfile %s cannot be accessed", p->pack_name);
> +		return 0;
> +	}
> +	e->offset = offset;
> +	e->p = p;
> +	hashcpy(e->sha1, sha1);
> +	return 1;
> +}
> +
>  static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  {
>  	static struct packed_git *last_found = (void *)1;
>  	struct packed_git *p;
> -	off_t offset;
>  
>  	prepare_packed_git();
>  	if (!packed_git)
> @@ -2022,35 +2053,11 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  	p = (last_found == (void *)1) ? packed_git : last_found;
>  
>  	do {
> -		if (p->num_bad_objects) {
> -			unsigned i;
> -			for (i = 0; i < p->num_bad_objects; i++)
> -				if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
> -					goto next;
> -		}
> -
> -		offset = find_pack_entry_one(sha1, p);
> -		if (offset) {
> -			/*
> -			 * We are about to tell the caller where they can
> -			 * locate the requested object.  We better make
> -			 * sure the packfile is still here and can be
> -			 * accessed before supplying that answer, as
> -			 * it may have been deleted since the index
> -			 * was loaded!
> -			 */
> -			if (!is_pack_valid(p)) {
> -				warning("packfile %s cannot be accessed", p->pack_name);
> -				goto next;
> -			}
> -			e->offset = offset;
> -			e->p = p;
> -			hashcpy(e->sha1, sha1);
> +		if (find_pack_entry_1(sha1, p, e)) {
>  			last_found = p;
>  			return 1;
>  		}
>  
> -		next:
>  		if (p == last_found)
>  			p = packed_git;
>  		else
> -- 
> 1.7.8.36.g69ee2
> 

--Boundary_(ID_Dl3H2lczOHqfQ08mxtt9cQ)--
