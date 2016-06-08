From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed, 8 Jun 2016 15:00:43 -0400
Message-ID: <20160608190043.GA19572@sigill.intra.peff.net>
References: <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
 <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
 <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
 <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com>
 <20160607202351.GA5726@sigill.intra.peff.net>
 <xmqq4m93mu8v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:00:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAiii-0005UR-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbcFHTAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:00:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:51424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752432AbcFHTAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:00:47 -0400
Received: (qmail 31550 invoked by uid 102); 8 Jun 2016 19:00:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:00:45 -0400
Received: (qmail 11323 invoked by uid 107); 8 Jun 2016 19:00:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:00:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2016 15:00:43 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4m93mu8v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296833>

On Wed, Jun 08, 2016 at 11:05:20AM -0700, Junio C Hamano wrote:

> > Likewise, I'm not sure if "get" should be allowed to return contents
> > that don't match the sha1.
> 
> Yes, this is what I was getting at.  It would be ideal to come up
> with a way to do the large-blob offload without resorting to hacks
> (like LFS and annex where "the same object contents will always
> result in the same object name" is deliberately broken), and "object
> name must match what the data hashes down to" is a basic requirement
> for that.

I meant to elaborate here more, but it looks like I didn't.

One thing that an external odb command might want to be able to do is
say "I _do_ have that object, but it would be expensive or impossible to
get right now, so I will give you a placeholder" (e.g., you are just
trying to run "git log" while on an airplane, and you would not want to
die() because you cannot fetch some blob).

But the right way is not to have "get" send content that does not match
the requested sha1. It needs to make git aware that the object is a
placeholder, so git does not do stupid things like write the bogus
content into a loose object.

The right way may be as simple as the external odb returning a non-zero
exit code, and git fills in the placeholder data itself (or dies,
possibly, depending on what the user asks it to do).

One of the reasons I worked up that initial external-odb patch was
because I knew that before we settled on a definite interface, we would
have to try it out and see what odd corner cases came up. E.g., when do
we fault in objects in a way that's annoying to the user? Which code
paths need to handle "we do have this object available, but you can't
see it right now, so what kind of fallback can we do?". Etc.

Unfortunately I never actually did any of that testing. ;)

-Peff
