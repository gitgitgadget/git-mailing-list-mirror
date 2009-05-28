From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 23:26:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905272312370.3906@xanadu.home>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
 <m3y6siboij.fsf@localhost.localdomain>
 <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
 <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
 <20090527215314.GA10362@coredump.intra.peff.net>
 <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
 <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com>
 <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alan Manuel Gloria <almkglor@gmail.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 28 05:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9WG4-0007p7-C1
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 05:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZE1D0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 23:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbZE1D0M
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 23:26:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35130 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZE1D0L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 23:26:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKC007O447I7YI0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 May 2009 23:26:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120142>

On Wed, 27 May 2009, Linus Torvalds wrote:

> Something like the following may also work, as a more generic "just don't 
> even bother trying to delta huge files".
> 
> Totally untested. Maybe it works. Maybe it doesn't.
> 
> 		Linus
> 
> ---
>  Documentation/config.txt |    7 +++++++
>  builtin-pack-objects.c   |    9 +++++++++
>  2 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2c03162..8c21027 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1238,6 +1238,13 @@ older version of git. If the `{asterisk}.pack` file is smaller than 2 GB, howeve
>  you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
>  the `{asterisk}.idx` file.
>  
> +pack.packDeltaLimit::
> +	The default maximum size of objects that we try to delta.

The option name feels a bit wrong here, like if it meant the max number 
of deltas in a pack.  Nothing better comes to my mind at the moment 
though.

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 9742b45..9a0072b 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -85,6 +85,7 @@ static struct progress *progress_state;
>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
>  static int pack_compression_seen;
>  
> +static unsigned long pack_delta_limit = 64*1024*1024;
>  static unsigned long delta_cache_size = 0;
>  static unsigned long max_delta_cache_size = 0;
>  static unsigned long cache_max_small_delta_size = 1000;
> @@ -1270,6 +1271,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	if (trg_entry->type != src_entry->type)
>  		return -1;
>  
> +	/* If we limit delta generation, don't even bother for larger blobs */
> +	if (pack_delta_limit && trg_entry->size >= pack_delta_limit)
> +		return -1;

I'd suggest filtering delta candidates out of delta_list up front in 
prepare_pack() instead.


Nicolas
