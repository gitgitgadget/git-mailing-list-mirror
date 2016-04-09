From: Jeff King <peff@peff.net>
Subject: Re: git segfaults on older Solaris releases
Date: Sat, 9 Apr 2016 13:39:05 -0400
Message-ID: <20160409173904.GA5127@sigill.intra.peff.net>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
 <5706C0D4.9030707@jupiterrise.com>
 <5708A90E.1050705@jupiterrise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 19:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aowqq-0002aq-PA
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 19:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbcDIRjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 13:39:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:46910 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754452AbcDIRjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 13:39:10 -0400
Received: (qmail 3437 invoked by uid 102); 9 Apr 2016 17:39:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:39:09 -0400
Received: (qmail 12920 invoked by uid 107); 9 Apr 2016 17:39:12 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:39:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 13:39:05 -0400
Content-Disposition: inline
In-Reply-To: <5708A90E.1050705@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291102>

On Sat, Apr 09, 2016 at 09:02:38AM +0200, Tom G. Christensen wrote:

> I've finished testing 2.8.1 and I found one more case where a null is being
> printed and causing a segfault. This happens even on Solaris 8 and 9.
> The failling test is t3200.63.

Oh good, this one wasn't me. :)

It's just a normal "oops, we feed NULL and nobody on glibc noticed
because it silently replaced it with "(null)" case. I did find a few
other oddities while fixing it, though. +cc Patrick, who worked in this
area most recently.

  [1/3]: config: lower-case first word of error strings
  [2/3]: git_config_set_multivar_in_file: all non-zero returns are errors
  [3/3]: git_config_set_multivar_in_file: handle "unset" errors

I think we may want some additional improvements. While doing 1/3, I
noticed that many of these error messages could stand to be marked for
translation. As other people are already looking at mass-conversion,
I stopped short of doing it here (and merely contented myself with
throwing a conflict into their patches ;) ).

The other thing is that 2/3 notices the error return from the
config-setting functions is weird. It's sometimes negative and sometimes
positive. I fixed this caller, but I think it's possible for the
negative values to leak into our exit codes:

  $ touch .git/config
  $ git config foo.bar baz
  error: could not lock config file .git/config: File exists
  $ echo $?
  255

I seem to recall some systems having trouble with negative error codes,
so we may want to make that more consistent.

-Peff
