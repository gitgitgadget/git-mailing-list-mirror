From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-import: implement --min-pack-size parameter
Date: Fri, 22 Apr 2016 23:13:13 -0400
Message-ID: <20160423031313.GA15043@sigill.intra.peff.net>
References: <20160423024225.GA4293@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Apr 23 05:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ato16-0004xR-LF
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 05:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbcDWDNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 23:13:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:54701 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751363AbcDWDNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 23:13:16 -0400
Received: (qmail 15251 invoked by uid 102); 23 Apr 2016 03:13:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 23:13:16 -0400
Received: (qmail 14297 invoked by uid 107); 23 Apr 2016 03:13:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 23:13:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 23:13:13 -0400
Content-Disposition: inline
In-Reply-To: <20160423024225.GA4293@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292296>

On Sat, Apr 23, 2016 at 02:42:25AM +0000, Eric Wong wrote:

> With many incremental imports, small packs become highly
> inefficient due to the need to readdir scan and load many
> indices to locate even a single object.  Frequent repacking and
> consolidation may be prohibitively expensive in terms of disk
> I/O, especially in large repositories where the initial packs
> were aggressively optimized and marked with .keep files.
> 
> In those cases, users may be better served with loose objects
> and relying on "git gc --auto".
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   There should be a matching config file directive, but I'm
>   not sure how/if it should affect other commands.  So I'm
>   not sure if it should be "pack.packSizeMin" or
>   "fastimport.packSizeMin" or something else.

This same concept exists for pushing/fetching, but there we measure it
not in bytes but by the number of objects. Which is probably a better
measure. A single 10MB blob is better as a loose object than as a pack,
but a thousand 10KB blobs should be a pack.

There we have fetch.unpackLimit and receive.unpackLimit for the two
operations, plus transfer.unpackLimit to control both of them. This
doesn't necessarily need to be tied to that config, but you could
certainly consider it in the same boat. It's a way of transferring a
load of objects into the repository.

So it would make some sense to me to have fastimport.unpackLimit,
falling back to transfer.unpackLimit.

-Peff
