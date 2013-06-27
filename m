From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap
 format
Date: Thu, 27 Jun 2013 13:17:33 -0400
Message-ID: <20130627171733.GA17601@sigill.intra.peff.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com>
 <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <7vtxkl28m7.fsf@alter.siamese.dyndns.org>
 <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
 <CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
 <CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com>
 <20130627024521.GA6936@sigill.intra.peff.net>
 <CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsFpE-000472-1R
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab3F0RRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 13:17:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:40401 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab3F0RRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 13:17:35 -0400
Received: (qmail 8694 invoked by uid 102); 27 Jun 2013 17:18:41 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Jun 2013 12:18:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2013 13:17:33 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229122>

On Thu, Jun 27, 2013 at 09:07:38AM -0700, Shawn O. Pearce wrote:

> > And the pack-order versus idx-order for the bitmaps is still up in the
> > air. Do we have numbers on the on-disk sizes of the resulting EWAHs?
> 
> I did not see any presented in this thread, and I am very interested
> in this aspect of the series. The path hash cache should be taking
> about 9.9M of disk space, but I recall reading the bitmap file is 8M.
> I don't understand.

I don't know there the 8M number came from, or if it was on the kernel
repo. My bitmap-enabled pack of linux-2.6 (about 3.2M objects) using
Vicent's patches looks like:

  $ du -sh *
  42M     pack-9ea76831aec6c49c5ff42509a2a2ce97da13c5ad.bitmap
  87M     pack-9ea76831aec6c49c5ff42509a2a2ce97da13c5ad.idx
  630M    pack-9ea76831aec6c49c5ff42509a2a2ce97da13c5ad.pack

Packing the same repo with "jgit debug-gc" (jgit 3.0.0) yields:

  $ du -sh *
  3.0M    pack-2478783825733a1f1012f0087a0b5a92aa7437d8.bitmap
  82M     pack-2478783825733a1f1012f0087a0b5a92aa7437d8.idx
  585M    pack-2478783825733a1f1012f0087a0b5a92aa7437d8.pack
  4.8M    pack-f61fb76112372288923be7a0464476892dfebe3e.idx
  97M     pack-f61fb76112372288923be7a0464476892dfebe3e.pack

If we assume that 12M of that is name-hash, that's still an order of
magnitude larger. For reference, jgit created 327 bitmaps (according to
its progress eye candy), and Vicent's patches generated 385. So that
explains some of the increase, but the per-bitmap size is still much
larger.

> The path hash cache may still be required, Colby and I have been
> debating the merits of having the data available for delta compression
> vs. the increase in memory required to hold it.

I guess this is not an option for JGit, but for C git, an mmap-able
name-hash file means we can just fault in the pages mentioning objects
we actually need it for. And its use can be completely optional; in
fact, it doesn't even need to be inside the .bitmap file (though I
cannot think of a reason it would be useful outside of having bitmaps).

-Peff
