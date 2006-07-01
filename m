From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Sat, 1 Jul 2006 17:06:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607011657460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <fork0@t-online.de>
X-From: git-owner@vger.kernel.org Sat Jul 01 17:07:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwh4a-0004ZJ-MC
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 17:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWGAPGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 11:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWGAPGV
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 11:06:21 -0400
Received: from mail.gmx.de ([213.165.64.21]:24467 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751518AbWGAPGP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 11:06:15 -0400
Received: (qmail invoked by alias); 01 Jul 2006 15:06:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 01 Jul 2006 17:06:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23047>

Hi,

On Fri, 30 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +int discard_cache()
> > +{
> > +	int ret;
> > +	
> > +	if (cache_mmap == NULL)
> > +		return 0;
> > +	ret = munmap(cache_mmap, cache_mmap_size);
> > +	cache_mmap = NULL;
> > +	cache_mmap_size = 0;
> > +	active_nr = active_cache_changed = 0;
> > +	/* no need to throw away allocated active_cache */
> > +	return ret;
> > +}
> > +
> 
> I haven't been following the details of the patches in this
> thread while they are being cooked actively, but two things to
> look out for are:
> 
>  - I am guessing you run discard_cache() because you want to
>    read in a new cache (or start from a clean slate).  I am not
>    sure what you are doing with the old cache tree data
>    structure.  If you are starting from a clean slate
>    (i.e. there is no read_cache_from() after you call
>    discard_cache), you would probably need to discard the old
>    cache tree; otherwise your next write-tree may produce an
>    incorrect index file.  If you keep the old one and later
>    swap it in, the problem might be even more severe.

True, I missed that one. But it is just a call to 
cache_tree_free(active_cache_tree); in discard_cache(), right?

>  - index_timestamp is left as the old value in this patch when
>    you switch cache using read_cache_from() directly.  I have a
>    suspicion you may be bitten by "Racy Git" problem, especially
>    because the operations are supposed to happen quickly thanks
>    to the effort of you two ;-) increasing the risks that the
>    file timestamp of the working tree file and the cached entry
>    match.

Yes. Again, just one line to discard_cache(), right?

	index_file_timestamp = 0;

If there is more to it, please don't let me die dumb.

Ciao,
Dscho
