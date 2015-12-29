From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] compiling with -fsanitize=undefined
Date: Tue, 29 Dec 2015 01:44:35 -0500
Message-ID: <20151229064435.GA31944@sigill.intra.peff.net>
References: <20151229063449.GA28755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 07:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDo1U-0008IJ-6X
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbbL2Gok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:44:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:46548 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753153AbbL2Goh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:44:37 -0500
Received: (qmail 16083 invoked by uid 102); 29 Dec 2015 06:44:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:44:38 -0600
Received: (qmail 18946 invoked by uid 107); 29 Dec 2015 06:44:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:44:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 01:44:35 -0500
Content-Disposition: inline
In-Reply-To: <20151229063449.GA28755@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283078>

On Tue, Dec 29, 2015 at 01:34:49AM -0500, Jeff King wrote:

>   2. We have some unaligned memory accesses that presumably work OK on
>      x86, but would blow up on ARM or other platforms (I didn't test).
> 
> The latter looks like it's in the untracked cache code (Duy and
> Christian cc'd). Running t7063 gets me this:
> 
> dir.c:2631:45: runtime error: member access within misaligned address 0x7f19806ff185 for type 'const struct ondisk_untracked_cache', which requires 4 byte alignment
> 0x7f19806ff185: note: pointer points here
>  31 33 29 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00
>              ^

I took a brief look at fixing this, and it may actually be a false
positive, as well (in a manner of speaking; if the compiler thinks it is
undefined behavior, it may still be worth fixing so we don't fall prey
to some optimizations-gone-wild).

The line in question is:

  load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
		 ouc->info_exclude_sha1);

where "ouc" is the on-disk data cast to a struct. So we definitely
generate an unaligned pointer, but then we only access its contents via
get_be32(), which handles alignment. So it might actually be OK. I
dunno.

-Peff
