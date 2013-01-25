From: Jeff King <peff@peff.net>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 23:08:56 -0500
Message-ID: <20130125040856.GA30533@sigill.intra.peff.net>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:09:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyabS-0000CJ-PR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab3AYEI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:08:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48825 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847Ab3AYEI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:08:58 -0500
Received: (qmail 6642 invoked by uid 107); 25 Jan 2013 04:10:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 23:10:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 23:08:56 -0500
Content-Disposition: inline
In-Reply-To: <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214486>

On Thu, Jan 24, 2013 at 07:59:58PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> ... (e.g., how should "log" know that a submodule diff might later want
> >> to see the same entry? Should we optimistically free and then make it
> >> easier for the later user to reliably ensure the buffer is primed? Or
> >> should we err on the side of keeping it in place?).
> >
> > My knee-jerk reaction is that we should consider that commit->buffer
> > belongs to the revision traversal machinery.  Any other uses bolted
> > on later can borrow it if buffer still exists (I do not think pretty
> > code rewrites the buffer contents in place in any way), or they can
> > ask read_sha1_file() to read it themselves and free when they are
> > done.
> 
> I've been toying with an idea along this line.
> 
>  commit.h        | 16 ++++++++++++++++
>  builtin/blame.c | 27 ++++++++-------------------
>  commit.c        | 20 ++++++++++++++++++++
>  3 files changed, 44 insertions(+), 19 deletions(-)

I think we are on the same page as far as what needs to happen at the
call sites.

My suggested implementation had a separate buffer, but you are right
that we may need to actually set "commit->buffer" because sub-functions
expect to find it there (the alternative might be cleaning up the
sub-function interfaces). I haven't looked at the call-sites yet.

This:

> +extern int ensure_commit_buffer(struct commit *);
> +extern void discard_commit_buffer(struct commit *);
> +
> +#define with_commit_buffer(commit) \
> +	do { \
> +		int had_buffer_ = !!commit->buffer; \
> +		if (!had_buffer_) \
> +			ensure_commit_buffer(commit); \
> +		do
> +
> +#define done_with_commit_buffer(commit) \
> +		while (0); \
> +		if (!had_buffer_) \
> +			discard_commit_buffer(commit); \
> +	} while (0)

is pretty nasty, though. I know it gets the job done, but in my
experience, macros which do not behave syntactically like functions are
usually a good sign that you are doing something gross and
unmaintainable.

I dunno.

-Peff
