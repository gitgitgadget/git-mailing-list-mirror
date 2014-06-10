From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/15] use get_commit_buffer everywhere
Date: Tue, 10 Jun 2014 17:27:53 -0400
Message-ID: <20140610212753.GA15332@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181323.GL20315@sigill.intra.peff.net>
 <xmqqbnu1emfa.fsf@gitster.dls.corp.google.com>
 <20140610000223.GA20644@sigill.intra.peff.net>
 <xmqqioo8agvo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:27:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTaJ-000346-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbaFJV1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:27:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:41324 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751937AbaFJV1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:27:54 -0400
Received: (qmail 18179 invoked by uid 102); 10 Jun 2014 21:27:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:27:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:27:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioo8agvo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251237>

On Tue, Jun 10, 2014 at 09:06:35AM -0700, Junio C Hamano wrote:

> > So any call to strbuf_detach on the result would be disastrous.
> 
> You are right.  Where did this original crap come from X-<...

I do not know if that face means you actually looked at the history, but
in case you did not...

It was added by Duy's 13f8b72 (Convert commit_tree() to take strbuf as
message, 2011-12-15). However that was v2 of his patch. If you read the
original thread, you can see that v1 passed a separate pointer/length
pair, and was only changed after a reviewer-who-shall-not-be-named asked
him to change it. ;)

Of course there were many people participating in the review, and none
of us noticed it. I think it is simply a subtle bug.

> > I feel like the most elegant solution is for create_notes_commit to take
> > a buf/len pair rather than a strbuf, but it unfortunately is just
> > feeding that to commit_tree. Adjusting that code path would affect quite
> > a few other spots.
> >
> > The other obvious option is actually populating the strbuf, but it feels
> > ugly to have to make a copy just to satisfy the function interface.
> >
> > Maybe a cast and a warning comment are the least evil thing, as below? I
> > dunno, it feels pretty wrong.
> 
> Yeah, it does feel wrong wrong wrong.  Perhaps this big comment
> would serve as a marker for a low-hanging fruit for somebody else to
> fix it, e.g. by using strbuf-add to make a copy, which would be the
> easiest and safest workaround?

I really think commit_tree is the culprit here. It doesn't actually want
a strbuf at all, but takes one to make passing the pointer/len pair
simpler. Fixing it turned out to be not _too_ disruptive, and it showed
that there is another dubious use of strbuf_attach from a different
caller.

I'll post my re-rolled series with those fixes in a moment.

-Peff
