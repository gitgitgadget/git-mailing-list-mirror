From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the
 reflog file
Date: Tue, 9 Dec 2014 13:54:34 -0500
Message-ID: <20141209185433.GB31158@peff.net>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
 <20141205002331.GJ16345@google.com>
 <20141205021931.GA29570@google.com>
 <54857871.5090805@alum.mit.edu>
 <xmqqfvcomzib.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:54:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPvl-0006ag-0U
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbaLISyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:54:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:50618 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751200AbaLISyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:54:36 -0500
Received: (qmail 13393 invoked by uid 102); 9 Dec 2014 18:54:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 12:54:36 -0600
Received: (qmail 2759 invoked by uid 107); 9 Dec 2014 18:54:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 13:54:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 13:54:34 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvcomzib.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261141>

On Tue, Dec 09, 2014 at 10:47:24AM -0800, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > This isn't documented very well. I thought I saw a comment somewhere in
> > the code that stated it explicitly, but I can't find it now. In any
> > case, my understanding of the locking protocol for reflogs is:
> >
> >     The reflog for "$refname", which is stored at
> >     "$GIT_DIR/logs/$refname", is locked by holding
> >     "$GIT_DIR/refs/$refname.lock", *even if the corresponding
> >     reference is packed*.
> >
> > This implies that readers, who don't pay attention to locks, have to be
> > prepared for the possibility that the reflog is in the middle of an
> > update and that the last line is incomplete. This is handled by
> > show_one_reflog_ent(), which discards incomplete lines.
> 
> Interesting, as I think I saw Peff did something around that area
> recently.

Yeah, and I had no idea about the truncated-line race which Michael
described at the time. It makes me glad that I took the time to do the
more careful thing[1] (fixing the reverse-reflog parser to properly
include the newline when present) and not the quick-and-easy thing[2]
(teaching show_one_reflog_ent to accept entries without newlines).

What you have queued in jk/for-each-reflog-ent-reverse should be fine,
even in light of what Michael said.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/260849

[2] http://article.gmane.org/gmane.comp.version-control.git/260807
