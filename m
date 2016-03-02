From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bundle doc: 'verify' is not about verifying the bundle
Date: Wed, 2 Mar 2016 04:22:36 -0500
Message-ID: <20160302092236.GB30065@sigill.intra.peff.net>
References: <xmqqd1rd7uey.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 10:22:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2zb-0006tX-5m
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbcCBJWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 04:22:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:53106 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754527AbcCBJWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 04:22:40 -0500
Received: (qmail 13073 invoked by uid 102); 2 Mar 2016 09:22:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 04:22:39 -0500
Received: (qmail 22030 invoked by uid 107); 2 Mar 2016 09:22:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 04:22:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2016 04:22:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd1rd7uey.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288116>

On Tue, Mar 01, 2016 at 01:36:05PM -0800, Junio C Hamano wrote:

> Even though the command does read the bundle header and checks to
> see if it looks reasonable, the thin-pack data stream that follows
> the header in the bundle file is not checked.  More importantly,
> because the thin-pack data does not have a trailing checksum like
> on-disk packfiles do, there isn't much "verification" the command
> can do without unpacking the objects from the stream even if it
> wanted to.

Are you sure about that trailing checksum thing?

  $ git tag foo $(echo foo | git hash-object -w --stdin)
  $ git bundle create foo.bundle foo
  $ perl -ne '
      BEGIN { binmode STDIN; binmode STDOUT }
      $print = 1 if /^PACK/;
      print if $print;
    ' <foo.bundle >foo.pack

  $ tail -c 20 foo.pack | xxd -p -c 20
  aa4e77be3695e8003bf4fbd2139b3fe0a9a22c8f

  $ git index-pack --stdin <foo.pack
  aa4e77be3695e8003bf4fbd2139b3fe0a9a22c8f

So I think we could pretty easily check for bit errors in the packfile
(we can't in the ref data; including a separate sha1 there might be a
nice improvement).

But...

> The documentation gives an incorrect impression that the thin-pack
> data contained in the bundle is validated, but the command is to
> validate that the receiving repository is ready to accept the
> bundle, not to check the validity of a bundle file.  Rephrase the
> paragraph to clarify this.

I still think this is a good change, though. "verify" is doing a
separate thing here than asking "did I get bit errors". We might _also_
want that check, but it is probably less interesting than "does the
bundle have all of the objects it claims to". And you can only find that
by expanding the objects, which would _also_ notice bit errors.

And the simplest way to do that is "git bundle apply". :)

-Peff
