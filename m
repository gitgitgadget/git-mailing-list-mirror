From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] factorize pack structure allocation
Date: Thu, 26 Jun 2008 08:40:17 +0200
Message-ID: <486339D1.7040706@op5.se>
References: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 08:41:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBlAT-00011i-PG
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 08:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbYFZGkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 02:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbYFZGkV
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 02:40:21 -0400
Received: from mail.op5.se ([193.201.96.20]:38364 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbYFZGkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 02:40:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8775B24B0B83;
	Thu, 26 Jun 2008 08:38:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mk4Bew9ztvTm; Thu, 26 Jun 2008 08:38:19 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 939531B80005;
	Thu, 26 Jun 2008 08:38:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86406>

Nicolas Pitre wrote:
> New pack structures are currently allocated in 2 different places
> and all members have to be initialized explicitly.  This is prone
> to errors leading to segmentation faults as found by Teemu Likonen.
> 
> Let's have a common place where this structure is allocated, and have 
> all members implicitly initialized to zero.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
> diff --git a/sha1_file.c b/sha1_file.c
> index a92f023..c56f674 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -792,18 +792,28 @@ unsigned char* use_pack(struct packed_git *p,
>  	return win->base + offset;
>  }
>  
> +static struct packed_git *alloc_packed_git(int extra)
> +{
> +	struct packed_git *p = xmalloc(sizeof(*p) + extra);
> +	memset(p, 0, sizeof(*p));
> +	p->pack_fd = -1;
> +	return p;
> +}
> +

Minor nit; Use xcalloc() instead. It initializes the allocated area
to zero by default, either by the glibc allocator when it re-uses old
memory, or by the kernel when it's handed to userspace. It's a
micro-optimization, but a worthwhile one imo, especially for repos
with lots and lots of packs (git gc --auto runs galore).

The "calloc() returns nulified memory" dogma conforms to C89 and is
thus about as portable as it gets.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
