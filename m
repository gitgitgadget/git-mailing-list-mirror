From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] lookup_object: remove hashtable_index() and optimize
 hash_obj()
Date: Thu, 12 Sep 2013 16:08:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309121606130.20709@syhkavp.arg>
References: <alpine.LFD.2.03.1309101811510.20709@syhkavp.arg>
 <20130911184845.GA25386@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 22:08:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDBT-0005Tg-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab3ILUII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:08:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18206 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab3ILUIG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:08:06 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT10010W3XGT470@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Sep 2013 16:08:04 -0400 (EDT)
In-reply-to: <20130911184845.GA25386@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234687>

On Wed, 11 Sep 2013, Jeff King wrote:

> On Tue, Sep 10, 2013 at 06:17:12PM -0400, Nicolas Pitre wrote:
> 
> > Also remove the modulus as this is an expansive operation.
> > The size argument is always a power of 2 anyway, so a simple
> > mask operation provides the same result.
> > 
> > On a 'git rev-list --all --objects' run this decreased the time spent
> > in lookup_object from 27.5% to 24.1%.
> 
> Nice. This is a tiny bit subtle, though, as the power-of-2 growth
> happens elsewhere, and we may want to tweak it later (the decorate.c
> hash, for example, grows by 3/2).
> 
> Maybe it's worth squashing in one or both of the comments below as a
> warning to anybody who tries to tweak it.

Agreed.

@Junio: are you willing to squash those in, or do you prefer a resent?

> ---
> diff --git a/object.c b/object.c
> index e2dae22..5f792cb 100644
> --- a/object.c
> +++ b/object.c
> @@ -47,6 +47,7 @@ static unsigned int hash_obj(const unsigned char *sha1, unsigned int n)
>  {
>  	unsigned int hash;
>  	memcpy(&hash, sha1, sizeof(unsigned int));
> +	/* Assumes power-of-2 hash sizes in grow_object_hash */
>  	return hash & (n - 1);
>  }
>  
> @@ -94,6 +95,10 @@ static void grow_object_hash(void)
>  static void grow_object_hash(void)
>  {
>  	int i;
> +	/*
> +	 * Note that this size must always be power-of-2 to match hash_obj
> +	 * above.
> +	 */
>  	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
>  	struct object **new_hash;
>  
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
