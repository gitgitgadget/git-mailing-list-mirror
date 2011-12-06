From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] grep multithreading and scaling
Date: Mon, 5 Dec 2011 19:40:12 -0500
Message-ID: <20111206004012.GA12760@sigill.intra.peff.net>
References: <201111291507.04754.trast@student.ethz.ch>
 <cover.1322830368.git.trast@student.ethz.ch>
 <20111202173400.GC23447@sigill.intra.peff.net>
 <201112051038.16423.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 06 01:40:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXj5N-0006Ph-2t
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 01:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab1LFAkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 19:40:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39954
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752Ab1LFAkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 19:40:14 -0500
Received: (qmail 31270 invoked by uid 107); 6 Dec 2011 00:46:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Dec 2011 19:46:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2011 19:40:12 -0500
Content-Disposition: inline
In-Reply-To: <201112051038.16423.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186302>

On Mon, Dec 05, 2011 at 10:38:16AM +0100, Thomas Rast wrote:

> I just found out that on Linux, there's mincore() that can tell us
> (racily, but who cares) whether a given file mapping is in memory.  If
> you would like to try it, see the source at the end, but I'm getting
> things such as

Neat, I didn't know about mincore.

> So that looks fairly promising, and the order would then be:
> 
> - if stat-clean, and we have mincore(), and it tells us we can do it
>   cheaply: grab file from tree
> 
> - if it's a loose object: decompress it
> 
> - if stat-clean: grab file from tree
> 
> - access packs as usual

I don't think your third one makes sense. If the working tree file isn't
stat clean, then either:

  1. the pack file is in cache, and it's way faster than faulting in the
     working tree file from disk

  2. the pack file is not in cache, and it's a toss-up whether it is
     faster to fault in the smaller compressed pack-file version and
     uncompress it, or to fault in the larger on-disk version. The
     exact result will depend on the ratio of CPU to disk speed, the
     quality of your filesystem, and the size and contents of your file.

     And possibly on the exact delta chains you have. Though this
     optimization only happens when the file is in the index, which
     usually means it's recent, which means it will tend to be at the
     head of the delta chain.

So it probably just makes sense to grab the working tree file only if
mincore() tells us we have all (or most) of it, and otherwise go to the
packfile.

> Ok, I see, I missed that part.  Perhaps the heuristic should then be
> "if the regex boils down to memmem, disable threading", but let's see
> what loose object decompression in parallel can give us.

Yeah. I'd really rather have parallel object decompression than some
complex Linux-only mincore optimization (even though that optimization
_could_ yield extra savings on top of properly threading, if the blob
retrieval is threaded, I think I'll care less about how much CPU time it
takes).

-Peff
