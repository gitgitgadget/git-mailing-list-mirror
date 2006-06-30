From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Fri, 30 Jun 2006 09:44:16 -0700
Message-ID: <7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
References: <20060630002756.GD22618@steel.home>
	<Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <fork0@t-online.de>
X-From: git-owner@vger.kernel.org Fri Jun 30 18:44:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwM6T-0005eP-3x
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 18:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWF3QoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 12:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWF3QoT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 12:44:19 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15584 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750868AbWF3QoS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 12:44:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630164418.LOTE554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 12:44:18 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 30 Jun 2006 16:43:29 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22996>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +int discard_cache()
> +{
> +	int ret;
> +	
> +	if (cache_mmap == NULL)
> +		return 0;
> +	ret = munmap(cache_mmap, cache_mmap_size);
> +	cache_mmap = NULL;
> +	cache_mmap_size = 0;
> +	active_nr = active_cache_changed = 0;
> +	/* no need to throw away allocated active_cache */
> +	return ret;
> +}
> +

I haven't been following the details of the patches in this
thread while they are being cooked actively, but two things to
look out for are:

 - I am guessing you run discard_cache() because you want to
   read in a new cache (or start from a clean slate).  I am not
   sure what you are doing with the old cache tree data
   structure.  If you are starting from a clean slate
   (i.e. there is no read_cache_from() after you call
   discard_cache), you would probably need to discard the old
   cache tree; otherwise your next write-tree may produce an
   incorrect index file.  If you keep the old one and later
   swap it in, the problem might be even more severe.

 - index_timestamp is left as the old value in this patch when
   you switch cache using read_cache_from() directly.  I have a
   suspicion you may be bitten by "Racy Git" problem, especially
   because the operations are supposed to happen quickly thanks
   to the effort of you two ;-) increasing the risks that the
   file timestamp of the working tree file and the cached entry
   match.
