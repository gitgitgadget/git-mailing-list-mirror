From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] apply: refuse touching a file beyond symlink
Date: Fri, 30 Jan 2015 15:48:05 -0500
Message-ID: <20150130204805.GA10616@peff.net>
References: <xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
 <xmqqa914klg0.fsf@gitster.dls.corp.google.com>
 <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
 <xmqqtwzadrj8.fsf@gitster.dls.corp.google.com>
 <xmqqa911e2ot.fsf_-_@gitster.dls.corp.google.com>
 <20150130181153.GA25513@peff.net>
 <xmqq61bocao1.fsf@gitster.dls.corp.google.com>
 <xmqq1tmcc9l9.fsf@gitster.dls.corp.google.com>
 <20150130201620.GA4133@peff.net>
 <xmqqwq44auml.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 30 21:48:19 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHIUD-00067s-TK
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 Jan 2015 21:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760089AbbA3UsK (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Jan 2015 15:48:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:43485 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753982AbbA3UsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2015 15:48:08 -0500
Received: (qmail 4417 invoked by uid 102); 30 Jan 2015 20:48:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 14:48:08 -0600
Received: (qmail 27144 invoked by uid 107); 30 Jan 2015 20:48:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Jan 2015 15:48:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2015 15:48:05 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwq44auml.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263197>

On Fri, Jan 30, 2015 at 12:20:02PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I had the impression that we did not apply in any arbitrary order that
> > could work, but rather that we did deletions first followed by
> > additions. But I am fairly ignorant of the apply code.
> 
> No, you are thinking about the write-out of the finished result,
> which may have to turn existing directory to a file or vice versa on
> the filesystem, but that happens _after_ we decide what to turn into
> what else, completely in-core.
> 
> And the decision to determine what the input _means_ should not
> depend on the order of patches in the input.

Ah, OK. Yeah, doing it progressively can only be accurate if our
name-checks follow the same order as applying, because we are checking
against a particular state.

But could we instead pull this check to just before the write-out time?
That is, to let any horrible thing happen in-core, as long as what we
write out to the index and the filesystem is sane?

-Peff
