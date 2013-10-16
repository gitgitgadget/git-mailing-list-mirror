From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Wed, 16 Oct 2013 04:53:16 -0400
Message-ID: <20131016085316.GA31314@sigill.intra.peff.net>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
 <20131015231427.GF9464@google.com>
 <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
 <20131015235739.GI9464@google.com>
 <525E3A80.5000500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 10:53:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWMr9-0002yZ-9e
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 10:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760293Ab3JPIxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 04:53:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:50260 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760123Ab3JPIxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 04:53:20 -0400
Received: (qmail 22109 invoked by uid 102); 16 Oct 2013 08:53:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Oct 2013 03:53:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Oct 2013 04:53:16 -0400
Content-Disposition: inline
In-Reply-To: <525E3A80.5000500@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236239>

On Wed, Oct 16, 2013 at 09:04:32AM +0200, Johannes Sixt wrote:

> > Yes, another possibility in that vein would be to teach rev-parse
> > --parseopt an OPTIONS_LONG_STICKED output format, and then parse with
> 
> Aren't you people trying to solve something that can't besolved? What does
> 
>   git commit -S LICENSE
> 
> mean? Commit the index and sign with the key-id "LICENSE" or commit just
> the file "LICENSE" with the default key-id?

It means the latter. Because the argument is optional, you must use the
"sticked" form:

  git commit -SLICENSE

If the caller does not know whether the argument is optional or not,
they should use the sticked form to be on the safe side.

The problem, as I understand it, arises from the fact that shell scripts
can use "git rev-parse --parseopt" to check and normalize their
arguments. So for example:

  # pretend we got "-bs" on our command line
  set -- -bs

  git rev-parse --parseopt -- "$@" <<\EOF
  usage...
  --
  b!    the "b" option
  s!    the "s" option
  EOF

would produce:

  set -- -b -s --

The latter is much easier to parse in the shell, because options are
split, it ends with "--", etc. But what is the normalized form for an
optional argument? It either needs to be consistently "sticked" or
"unsticked", either:

  set -- -S '' --     ;# default
  set -- -S 'foo' --  ;# not default

or

  set -- -S --    ;# default
  set -- -Sfoo -- ;# not default

so that reading the normalized form is unambiguous.

-Peff
