From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in
 xdl_cleanup_records()
Date: Thu, 18 Aug 2011 15:44:27 -0700
Message-ID: <20110818224427.GB8481@sigill.intra.peff.net>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
 <1313546037-4104-1-git-send-email-rctay89@gmail.com>
 <20110817052147.GA11253@sigill.intra.peff.net>
 <CALUzUxovdmhnRKPaEq01-q0pvez91s_Z_rHWg-FkwcU0VD3HQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:44:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuBKG-0002sb-7Y
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab1HRWoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:44:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33471
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab1HRWob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:44:31 -0400
Received: (qmail 26421 invoked by uid 107); 18 Aug 2011 22:45:11 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 18:45:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 15:44:27 -0700
Content-Disposition: inline
In-Reply-To: <CALUzUxovdmhnRKPaEq01-q0pvez91s_Z_rHWg-FkwcU0VD3HQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179650>

On Wed, Aug 17, 2011 at 11:55:32PM +0800, Tay Ray Chuan wrote:

> On Wed, Aug 17, 2011 at 1:21 PM, Jeff King <peff@peff.net> wrote:
> > Wait, what? It was using 0 seconds of user time before, but still taking
> > 8.5 seconds? What was it doing? Did you actually warm up your disk cache
> > before taking these measurements?
> 
> Three runs on the same machine, after a restart.
> 
>   $ time git show >/dev/null
> 
>   real    0m6.505s
>   user    0m0.031s
>   sys     0m0.015s
> [...]

So it is spending only .046s of CPU time, but is taking 6.5 seconds of
wall clock time. Which implies to me that the dataset doesn't fit in
your disk cache, or it is swapping a lot. Or you are on a really
bogged-down multiuser system. :)

But if I understand correctly, your patch is about increasing runtime
performance of a slow algorithm. So is actually the improvement of an
O(m*n) algorithm to an O(n) one, or does your new algorithm have better
memory access patterns that avoid trashing swap?

Downloading the files from the original problem report, I see much
different timings:

  [before]
  $ time git diff >/dev/null
  real    0m7.690s
  user    0m7.648s
  sys     0m0.024s

  [after (your v2 patch)]
  real    0m0.272s
  user    0m0.236s
  sys     0m0.036s

So I think your patch _is_ an improvement in algorithmic runtime. I just
don't see how your numbers make any sense. Am I missing something? Is
msysgit's bash "time" just broken?

-Peff
