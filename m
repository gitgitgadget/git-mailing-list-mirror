From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 18:14:50 -0400
Message-ID: <20150519221450.GB779@peff.net>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
 <1431806796-28902-1-git-send-email-gjthill@gmail.com>
 <xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
 <xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
 <20150519063716.GA22771@peff.net>
 <xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
 <xmqqd21w8mal.fsf@gitster.dls.corp.google.com>
 <xmqq1tic8lgj.fsf@gitster.dls.corp.google.com>
 <xmqqk2w473i2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:14:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupmr-0002hI-D9
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbESWOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:14:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:32870 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751134AbbESWOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:14:52 -0400
Received: (qmail 19322 invoked by uid 102); 19 May 2015 22:14:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 17:14:52 -0500
Received: (qmail 17716 invoked by uid 107); 19 May 2015 22:14:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 18:14:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 18:14:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2w473i2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269420>

On Tue, May 19, 2015 at 12:48:21PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Yuck; please discard the previous one.  write_in_full() side is also
> > writing into that process, so we should do the same.
> 
> OK, without these two, and with the "true" filter that does not read
> anything reinstated in the test script, t0021 used to die
> 
>     i=0; while sh t0021-conversion.sh; do i=$(( $i + 1 )); done
> 
> after 150 iteration or so for me.  With these two, it seems to go on
> without breaking (I bored after 1000 iterations), so I'd declare it
> good enough ;-)

Your revised patch 2 looks good to me. I think you could test it more
reliably by simply adding a larger file, like:

  test-genrandom foo $((128 * 1024 + 1)) >big &&
  echo 'big filter=epipe' >.gitattributes &&
  git config filter.epipe.clean true &&
  git add big

The worst case if you get the size of the pipe buffer too small is that
the test will erroneously pass, but that is OK. As long as one person
has a reasonable-sized buffer, they will complain to the list
eventually. :)

-Peff
