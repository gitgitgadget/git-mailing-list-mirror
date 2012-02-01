From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3 2/2] find_pack_entry(): do not keep packed_git pointer
 locally
Date: Wed, 01 Feb 2012 11:02:52 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1202011100010.2759@xanadu.home>
References: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 <1328104135-475-1-git-send-email-pclouds@gmail.com>
 <1328104135-475-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_2g62EMdDeiH2kXP0Yd35og)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 17:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsceQ-0007Cu-S1
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 17:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab2BAQDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 11:03:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49226 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab2BAQDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 11:03:08 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYQ005LV1MB1S60@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Feb 2012 10:56:36 -0500 (EST)
In-reply-to: <1328104135-475-2-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189520>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_2g62EMdDeiH2kXP0Yd35og)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 1 Feb 2012, Nguyễn Thái Ngọc Duy wrote:

> Commit f7c22cc (always start looking up objects in the last used pack
> first - 2007-05-30) introduce a static packed_git* pointer as an
> optimization.  The kept pointer however may become invalid if
> free_pack_by_name() happens to free that particular pack.
> 
> Current code base does not access packs after calling
> free_pack_by_name() so it should not be a problem. Anyway, move the
> pointer out so that free_pack_by_name() can reset it to avoid running
> into troubles in future.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


>  Since Junio's already done the hard work. It'd be silly of me not to
>  take advantage and credit for free :)

Maybe a little "Thanks to Junio for code layout suggestions" in the 
commit message would give him some credit back.

>  The new loop looks much better.

Indeed.

>  sha1_file.c |   27 +++++++++++++--------------
>  1 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index ff5bf42..ebe77b3 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -54,6 +54,8 @@ static struct cached_object empty_tree = {
>  	0
>  };
>  
> +static struct packed_git *last_found_pack;
> +
>  static struct cached_object *find_cached_object(const unsigned char *sha1)
>  {
>  	int i;
> @@ -720,6 +722,8 @@ void free_pack_by_name(const char *pack_name)
>  			close_pack_index(p);
>  			free(p->bad_object_sha1);
>  			*pp = p->next;
> +			if (last_found_pack == p)
> +				last_found_pack = NULL;
>  			free(p);
>  			return;
>  		}
> @@ -2044,27 +2048,22 @@ static int find_pack_entry_1(const unsigned char *sha1,
>  
>  static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  {
> -	static struct packed_git *last_found = (void *)1;
>  	struct packed_git *p;
>  
>  	prepare_packed_git();
>  	if (!packed_git)
>  		return 0;
> -	p = (last_found == (void *)1) ? packed_git : last_found;
>  
> -	do {
> -		if (find_pack_entry_1(sha1, p, e)) {
> -			last_found = p;
> -			return 1;
> -		}
> +	if (last_found_pack && find_pack_entry_1(sha1, last_found_pack, e))
> +		return 1;
>  
> -		if (p == last_found)
> -			p = packed_git;
> -		else
> -			p = p->next;
> -		if (p == last_found)
> -			p = p->next;
> -	} while (p);
> +	for (p = packed_git; p; p = p->next) {
> +		if (p == last_found_pack || !find_pack_entry_1(sha1, p, e))
> +			continue;
> +
> +		last_found_pack = p;
> +		return 1;
> +	}
>  	return 0;
>  }
>  
> -- 
> 1.7.8.36.g69ee2
> 

--Boundary_(ID_2g62EMdDeiH2kXP0Yd35og)--
