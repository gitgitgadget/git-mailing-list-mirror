From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] unpack_entry: do not die when we fail to apply a
 delta
Date: Fri, 14 Jun 2013 18:19:36 -0400
Message-ID: <20130614221936.GD29138@sigill.intra.peff.net>
References: <20130614214943.GA29138@sigill.intra.peff.net>
 <20130614215334.GB3821@sigill.intra.peff.net>
 <7vk3lwmk0r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 00:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UncLS-0000CP-0z
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 00:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab3FNWTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 18:19:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:59610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab3FNWTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 18:19:41 -0400
Received: (qmail 24099 invoked by uid 102); 14 Jun 2013 22:20:36 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Jun 2013 17:20:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2013 18:19:36 -0400
Content-Disposition: inline
In-Reply-To: <7vk3lwmk0r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227929>

On Fri, Jun 14, 2013 at 02:59:00PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  test_expect_success \
> > +    'corruption of delta base reference pointing to wrong object' \
> > +    'create_new_pack --delta-base-offset &&
> > +     git prune-packed &&
> > +     printf "\220\033" | do_corrupt_object $blob_3 2 &&
> 
> Interesting.  You cheated in a different way with a hardcoded
> offset, instead of hardcoded knowledge of where the object name
> is stored in binary in the .idx file ;-)

Yes. We could get it with:

  git show-index <"$pack.idx" |
  cut -d' ' -f1 |
  perl -e '
    @pos = map { chomp; $_ } <>;
    my $ofs = $pos[2] - $pos[0];

    my @bin;
    unshift @bin, $ofs & 127;
    while ($ofs >>= 7) {
      $ofs--;
      unshift @bin, 128 | ($ofs & 127);
    }

    binmode STDOUT;
    print chr for @bin;
  '

if that's not too ugly. Maybe the REF_DELTA one is less ugly, then, as
it would not need to do the packed offset encoding, but just convert
$blob1 from hex into binary.

-Peff
