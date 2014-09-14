From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body
 headers
Date: Sat, 13 Sep 2014 21:01:21 -0400
Message-ID: <20140914010120.GA28498@peff.net>
References: <20140913093746.GD6600@mwanda>
 <20140913154556.GA12361@kroah.com>
 <20140913203645.GB24854@peff.net>
 <20140913204745.GA12291@msilap.einon.net>
 <20140913205751.GA17875@mwanda>
 <20140913210908.GG6549@mwanda>
 <20140913212504.GA25190@peff.net>
 <20140913225713.GB189120@vauxhall.crustytoothpaste.net>
 <20140914004725.GA28010@peff.net>
 <CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 03:01:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSyBz-0007VC-OR
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 03:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbaINBBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 21:01:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:47894 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752214AbaINBBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 21:01:23 -0400
Received: (qmail 20781 invoked by uid 102); 14 Sep 2014 01:01:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 20:01:23 -0500
Received: (qmail 11663 invoked by uid 107); 14 Sep 2014 01:01:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 21:01:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 21:01:21 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256989>

On Sat, Sep 13, 2014 at 05:55:49PM -0700, Junio C Hamano wrote:

> On Sat, Sep 13, 2014 at 5:47 PM, Jeff King <peff@peff.net> wrote:
> >
> > On Sat, Sep 13, 2014 at 10:57:14PM +0000, brian m. carlson wrote:
> >
> > > I wonder if git send-email should do what mutt does in this case, which
> > > is use quoted-printable encoding and encode the first F as =46 (as well
> > > as any equals signs as =3D).  It looks like mailinfo.c already is
> > > capable of handling that, and that would avoid the entire issue.
> >
> > That's not an unreasonable tactic. However, I think we'd still want to
> > do something with mailinfo on the receiving end, similar to the patch I
> > sent. We don't know that the sending side is necessarily send-email.
> 
> Hmm, isn't the ">" stuffing in front of a beginning-of-line "From " purely
> a local matter of MUA that stores messages in (old-style) mbox format
> where a line that begins with "From " is what defines the end of the
> previous message?

Yes, it is[1].

> Why should send-email do anything when it sends individual messages
> separately out?

It does not need to, but the QP-transformation helps protect against
other, stupider software downstream.  And unlike From-quoting it is
actually well-specified and reversible.

-Peff

[1] We do use the mbox format in git, and AFAIK do not do any
    From-quoting of this nature.  I haven't tested, but I suspect that
    certain format-patch output would be corrupted when reading back via
    "git am", let alone other random mbox readers.  If we wanted to do
    the QP magic brian suggests, it would probably make sense to do it
    as part of format-patch.
