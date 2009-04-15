From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: use shorten_unambiguous_ref
Date: Wed, 15 Apr 2009 04:12:46 -0400
Message-ID: <20090415081246.GE23332@coredump.intra.peff.net>
References: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net> <20090410171458.GA26478@sigill.intra.peff.net> <7vprff41lf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 10:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu0GK-0003Ne-3O
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 10:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbZDOIM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 04:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbZDOIMx
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 04:12:53 -0400
Received: from peff.net ([208.65.91.99]:50036 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbZDOIMw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 04:12:52 -0400
Received: (qmail 14776 invoked by uid 107); 15 Apr 2009 08:12:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 04:12:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 04:12:46 -0400
Content-Disposition: inline
In-Reply-To: <7vprff41lf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116597>

On Tue, Apr 14, 2009 at 09:55:08AM -0700, Junio C Hamano wrote:

> I was hoping that a single "shorten" function that does not even take
> "unambiguous" parameter would be used by almost everybody.  As far as I
> can see, Bert's "rev-parse --abbrev-ref" RFC is the only caller that might
> need to use a value different from warn_ambiguous_refs, and all the other
> existing callers (including fill_tracking_info() for "upstream" report by
> git-branch) do not have to pass "0" but can use the default.  IOW, we can
> have:
> 
> 	const char *shorten_ref_unambiguous(const char *ref, int strict);
> 	const char *shorten_ref(const char *ref)
>         {
>         	return shorten_ref_unambiguous(ref, warn_ambiguous_refs);
> 	}
> 
> and only specialized callers that really care use shorten_ref_unambiguous
> (without Bert's [PATCH-RFC 3/2] we do not have any such specialized
> caller, I think).

I think that is a sensible approach; I also thought when reading Bert's
patch that the parameter seemed like it would not be used in most
situations.

> But I am not sure how well prettify_ref() fits into this picture.  It is
> called only from transport and is meant to deal with refs that exist on
> the remote side, so ambiguity check against our local namespace would not
> make much sense.  We could:
> 
> 	const char *shorten_ref_internal(const char *ref, int mode);
> 	const char *shorten_ref(const char *ref)
>         {
> 		unsigned mode = warn_ambiguous_refs ? SHORTEN_STRICT : 0;
>         	return shorten_ref_internal(ref, mode);
> 	}
> 	const char *prettify_ref(const char *ref)
>         {
>         	return shorten_ref_internal(ref, SHORTEN_PREFIX_ONLY);
>         }
> 
> and have the SHORTEN_PREFIX_ONLY logic inherit from what the current
> prettify_ref() does, but at that point it I do not think it makes sense
> anymore.

There are three things wrong with prettify_ref:

  1. It takes a ref struct instead of a string with a refname (but only
     looks at ref->name). This is easily fixed.

  2. It does the same thing as shorten_ref_unambiguous, but without any
     ambiguity check, so the names should be related. That is easily
     changed, too, once we settle on the name (either it is shorten_ref
     to the other's _unambiguous form, or the unambiguous one becomes
     shorten_ref, and this becomes shorten_ref_remote or something).

  3. It uses its own "skip these random things rules" instead of being
     based on the usual ref lookup rules. I think this can be folded
     into the unambiguous case by simply bailing on the first textual
     match.  I don't know in practice if it matters that much.

-Peff
