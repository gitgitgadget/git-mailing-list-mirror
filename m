From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] fetch/push: readd rsync support
Date: Fri, 28 Sep 2007 01:20:18 -0400
Message-ID: <20070928052018.GW3099@spearce.org>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site> <Pine.LNX.4.64.0709280606530.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 07:20:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib8HC-00062X-Jd
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 07:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbXI1FUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 01:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbXI1FUY
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 01:20:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47396 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbXI1FUY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 01:20:24 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ib8Hd-00074L-EY; Fri, 28 Sep 2007 01:21:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 20A3620FBAE; Fri, 28 Sep 2007 01:20:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709280606530.28395@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59367>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> +static int disconnect_rsync(struct transport *transport)
> +{
> +	return 0;
> +}
>  
>  /* Generic functions for using commit walkers */
>  
> @@ -402,7 +730,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  	ret->url = url;
>  
>  	if (!prefixcmp(url, "rsync://")) {
> -		/* not supported; don't populate any ops */
> +		ret->get_refs_list = get_refs_via_rsync;
> +		ret->fetch = fetch_objs_via_rsync;
> +		ret->push = rsync_transport_push;
> +		ret->disconnect = disconnect_rsync;
>  
>  	} else if (!prefixcmp(url, "http://")
>  	        || !prefixcmp(url, "https://")

For what it's worth disconnect is an optional operation.  You did
not need to implement it if you don't allocate a data member in
the struct transport.  So removing disconnect_rsync() could save
you 6 lines or so.

I see push is now supported again.  Didn't we remove rsync push
support a long time ago?  Like say in:

  commit c485104741ccdf32dd0c96fcb886c38a0b5badbd
  Author: c.shoemaker@cox.net <c.shoemaker@cox.net>
  Date:   Sat Oct 29 00:16:33 2005 -0400

    Add usage help to git-push.sh
    
    Also clarify failure to push to read-only remote.  Especially,
    state why rsync:// is not used for pushing.
    
    [jc: ideally rsync should not be used for anything]
    
    Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

I guess it is nice to see that you can't kill rsync.  Like Windows
it always finds it way back into your life.

-- 
Shawn.
