From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Mon, 21 Mar 2016 15:53:48 -0400
Message-ID: <20160321195348.GA31650@sigill.intra.peff.net>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Laurent Arnoud <laurent@spkdev.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:53:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5tl-0006fn-U2
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606AbcCUTxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:53:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:35488 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756517AbcCUTxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:53:51 -0400
Received: (qmail 4479 invoked by uid 102); 21 Mar 2016 19:53:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 15:53:50 -0400
Received: (qmail 8733 invoked by uid 107); 21 Mar 2016 19:54:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 15:54:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 15:53:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289449>

On Sun, Mar 20, 2016 at 10:50:48PM -0700, Junio C Hamano wrote:

> > Support `--no-sign` option to countermand configuration `tag.gpgsign`.
> 
> That sound quite counter-intuitive.
> [...]

I was the one who suggested --no-sign, as we usually like to have a way
to countermand the config. But having read your message, I agree that is
probably not the right mental model.

In particular, this:

> I can sort-of understand (but do not necessarily agree that it is a
> good idea) adding new two configurations, i.e.
> 
>  - "even without -a/-s, force the user to annotate the tag" is one
>    configuration, and
> 
>  - "even when the user did not say -s, force the user to sign an
>    annotated tag" is the other.
> 
> And with such a system, I can see why you would need an option
> "--lightweight" to force creation of a light-weight tag (i.e. to
> countermand the first one).  You can view this new option as
> something that sits next to existing -a/-s.  The current system lets
> user choose among the three variants (lightweight, annotated and
> signed) by not giving any, giving -a, and giving -s option
> respectively, but with the "--lightweight" option, the user can ask
> for one of the three explicitly, as opposed to using "lack of either
> -a/-s" as a signal to create lightweight one.

makes sense to me (though like you, I do not necessarily think it is a
good idea and would not use it myself).

Another similar approach would be to collapse this down to a single
variable that selects from the options. IOW:

  1. Add --lightweight for explicitly adding a lightweight tag.

  2. When we are creating a tag and none of "-a", "-s", or
     "--lightweight" is given, use the default given in
     tag.defaultTagType (or whatever we call it), which can
     be "lightweight", "annotated", or "signed".

  3. tag.defaultTagType defaults to "lightweight".

That is conceptually simpler to me, with the main differences being:

  - in yours, the second config would mean that an explicit "-a" implies
    "-s" (unless the user says --no-sign).

  - in mine, there is no way to kick in the signing _only_ when we are
    annotating. If you configure "signed", then you have to explicitly
    say "--lightweight" for lightweight tags.

I dunno. It sounds like Laurent would set it to "signed", and that would
do what he wants. But like I said, I would not plan to use the feature
myself, and I could see it ending up a little bit annoying when you _do_
want a lightweight tag.

-Peff
