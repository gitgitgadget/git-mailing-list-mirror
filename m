From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 17:50:47 -0400
Message-ID: <20131016215047.GA10260@sigill.intra.peff.net>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <20131015231427.GF9464@google.com>
 <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
 <20131015235739.GI9464@google.com>
 <525E3A80.5000500@viscovery.net>
 <20131016085316.GA31314@sigill.intra.peff.net>
 <xmqqsiw051zc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYzX-0005Qn-18
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761992Ab3JPVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:50:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:50608 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761982Ab3JPVut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:50:49 -0400
Received: (qmail 26367 invoked by uid 102); 16 Oct 2013 21:50:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Oct 2013 16:50:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Oct 2013 17:50:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsiw051zc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236274>

On Wed, Oct 16, 2013 at 02:40:07PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... But what is the normalized form for an
> > optional argument? It either needs to be consistently "sticked" or
> > "unsticked", either:
> >
> >   set -- -S '' --     ;# default
> >   set -- -S 'foo' --  ;# not default
> >
> > or
> >
> >   set -- -S --    ;# default
> >   set -- -Sfoo -- ;# not default
> >
> > so that reading the normalized form is unambiguous.
> 
> The analysis makes sense.  Either form do not let you distinguish
> between the case where the end user wanted to explicitly pass "" as
> the optional parameter to -S and the case where she gave -S without
> any optional parameter, though.

I almost mentioned that, but I am not sure that it matters. Keep in mind
that:

  git my-script -S foo

already does not involve "foo" with S, because it is not "sticked". So
there is no way for the _user_ to distinguish between "I want the
default" and "I passed you an empty string"; because the argument must
be sticked they both look like "-S". And that distinction is already
impossible in the definition of optional arguments, and is not a problem
with going through the "git rev-parse --parseopt" channel at all.

So the only bug is the ambiguity in the current normalized form. Of the
two forms above, I think I prefer:

  set -- -S '' --

because it more closely matches the non-optional form we produce
today, and because it is slightly less work to parse (you can check that
$1 is "-S", and then store or check "$2", rather than having to match
"-S*" and parse off the beginning).

> Which pretty much agrees with j6t's (and my earlier) comment that
> there is no way to solve this issue completely, I think.

I guess it depends on what the issue is. :)

No, I do not think you can ever "fix" the options to let those two cases
be distinguishable. But I do not think anybody is really asking for
that; the real concern is that the "rev-parse --parseopt" normalization
is ambiguous, and that is easily fixable.

-Peff
