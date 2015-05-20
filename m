From: Jeff King <peff@peff.net>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 17:55:47 -0400
Message-ID: <20150520215547.GD8421@peff.net>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
 <vpq382rkvzf.fsf@anie.imag.fr>
 <d21002e0fa92b03c3d417c8996328563@www.dscho.org>
 <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
 <20150520182218.GD14561@peff.net>
 <20150520183115.GB7142@peff.net>
 <xmqqlhgjm19z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:55:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBy1-0002Cb-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbbETVzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:55:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:33507 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751075AbbETVzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:55:50 -0400
Received: (qmail 4259 invoked by uid 102); 20 May 2015 21:55:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 16:55:49 -0500
Received: (qmail 28533 invoked by uid 107); 20 May 2015 21:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 17:55:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 17:55:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhgjm19z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269532>

On Wed, May 20, 2015 at 01:39:36PM -0700, Junio C Hamano wrote:

> Yeah, "bad object" sounds as if we tried to parse something that
> exists and it was corrupt.  So classifying "a file or a pack index
> entry exists where a valid object with that name should reside in"
> as "bad object" and "there is no such file or a pack index entry
> that would house the named object" as "missing object" _might_ make
> things better.
> 
> But let's think about it a bit more.  Would it have prevented the
> original confusion if we said "missing object"?  I have a feeling
> that it wouldn't have.  Faheem was so convinced that the object
> named with the 40-hex *must* exist in the cloned repository, and if
> we told "missing object" to such a person, it will just enforce the
> (mis)conception that the repository is somehow corrupt, when it is
> not.
> 
> So...

I dunno. If it were phrased not as "missing object" but as "there is no
such object in the repository", then it seems more clear to me that the
error is in the request, not in the repository (and hopefully the user
would examine their assumption that it should be).

But "bad object" is just a horrible error message. It actively implies
corruption. And I think if we do have corruption, then parse_object()
already reports it. For example:

  # helpers
  objfile() {
    printf '.git/objects/%s' $(echo $1 | sed 's,..,&/,')
  }
  blob=$(echo content | git hash-object -w --stdin)

  # object with a sha1 mismatch
  mismatch=1234567890123456789012345678901234567890
  mkdir .git/objects/12
  cp $(objfile $blob) $(objfile $mismatch)

  # plain old missing object
  missing=1234abcdef1234abcdef1234abcdef1234abcdef

  # object with data corruption
  corrupt=$blob
  chmod +w $(objfile $corrupt)
  dd if=/dev/zero of=$(objfile $corrupt) bs=1 count=1 conv=notrunc seek=10

  # now show each
  for bad in corrupt mismatch missing; do
    echo "==> $bad"
    git --no-pager show $(eval "echo \$$bad")
  done

produces:

  ==> corrupt
  error: inflate: data stream error (invalid distance too far back)
  error: unable to unpack d95f3ad14dee633a758d2e331151e950dd13e4ed header
  error: inflate: data stream error (invalid distance too far back)
  fatal: loose object d95f3ad14dee633a758d2e331151e950dd13e4ed (stored in .git/objects/d9/5f3ad14dee633a758d2e331151e950dd13e4ed) is corrupt
  ==> mismatch
  error: sha1 mismatch 1234567890123456789012345678901234567890
  fatal: bad object 1234567890123456789012345678901234567890
  ==> missing
  fatal: bad object 1234abcdef1234abcdef1234abcdef1234abcdef

Note that the "missing" case is the only one that _doesn't_ give further
clarification, and it is likely to be the most common (however just
changing "bad object" to "no such object" would be a bad idea, as it
makes the second case harder to understand).

-Peff
