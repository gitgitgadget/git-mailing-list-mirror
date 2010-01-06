From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/6] transport-helper.c::push_refs(): ignore
 helper-reported status if ref is not to be pushed
Date: Wed, 6 Jan 2010 07:04:56 -0500
Message-ID: <20100106120456.GA7221@coredump.intra.peff.net>
References: <20091224154352.ecefd242.rctay89@gmail.com>
 <20091224154258.08b4fe44.rctay89@gmail.com>
 <20091224154158.15ba580f.rctay89@gmail.com>
 <20091224154057.33611ae7.rctay89@gmail.com>
 <20091224154005.a642c8ec.rctay89@gmail.com>
 <20091224154445.ad4b7a01.rctay89@gmail.com>
 <20100105063253.GA19368@coredump.intra.peff.net>
 <20100105180113.6e0572dc.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:05:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSUdW-00045E-8R
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 13:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab0AFMFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 07:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755726Ab0AFMFG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 07:05:06 -0500
Received: from peff.net ([208.65.91.99]:54098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720Ab0AFMFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 07:05:04 -0500
Received: (qmail 16466 invoked by uid 107); 6 Jan 2010 12:09:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 06 Jan 2010 07:09:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jan 2010 07:04:56 -0500
Content-Disposition: inline
In-Reply-To: <20100105180113.6e0572dc.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136261>

On Tue, Jan 05, 2010 at 06:01:13PM +0800, Tay Ray Chuan wrote:

> > It seems like this should be checking for REF_STATUS_NONE explicitly
> > instead of trying to enumerate the reasons we might not have tried to
> > push. Shouldn't helpers _only_ be pushing REF_STATUS_NONE refs?
> >
> > I think right now the two cases are equivalent, since non-ff and
> > uptodate are the only two states set before the helper is invoked. But
> > we have discussed in the past (and I still have a patch floating around
> > for) a REF_STATUS_REWIND which would treat strict rewinds differently
> > (silently ignoring them instead of making an error). Explicitly checking
> > REF_STATUS_NONE future-proofs against new states being added.
> 
> I'm not really sure if this is true (ie. that if status is not non-ff
> or uptodate, then it is REF_STATUS_NONE), but we could step around this

Well, consider it this way. If it's _not_ REF_STATUS_NONE, then what is
it, and what does it mean to be overwriting it?

Maybe I am misunderstanding the problem the patch is addressing, but the
point of these REF_STATUS feels was to act as a small state machine.
Everything starts as NONE, and then:

  - we compare locally against remote refs. We may transition:
      NONE -> UPTODATE
      NONE -> REJECT_NONFASTFORWARD
      NONE -> REJECT_NODELETE

  - we send the push list
      NONE -> EXPECTING_REPORT (if the remote supports individual status)
      NONE -> OK (otherwise)

  - we get back status responses
      EXPECTING_REPORT -> OK
      EXPECTING_REPORT -> REMOTE_REJECT

I haven't looked closely at the new transport helper code, but I would
think it should stick more or less to those transitions. The exception
would be that some transports don't necessarily handle EXPECTING_REPORT
in the same way, and may transition directly from NONE to
OK/REMOTE_REJECT.

So offhand, I would say that your list should also probably include
REJECT_NODELETE. However, I think that status is just for old servers
which didn't support the delete-refs protocol extension. So presumably
that is none of the new helpers, as they all post-date the addition of
that feature by quite a few years.

> by introducing a property, say, ref->should_push, that is set to 1,
> after all the vetting has been carried out and just before we talk to
> the server.

I'd rather not introduce new state. The point of the status flag was to
encapsulate all of that information, and a new state variable just seems
like introducing extra complexity. If we are not in the NONE state, I
don't see why we would tell the helper about a ref at all.

-Peff
