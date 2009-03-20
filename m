From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.defaultOptions"
Date: Fri, 20 Mar 2009 15:49:30 -0400
Message-ID: <20090320194930.GB26934@coredump.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0903170825340.16242@kiwi.cs.ucla.edu> <20090320070148.GD27008@coredump.intra.peff.net> <alpine.GSO.2.00.0903200911530.16242@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:51:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkkkP-0002bu-EI
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231AbZCTTto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 15:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755109AbZCTTto
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:49:44 -0400
Received: from peff.net ([208.65.91.99]:51189 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279AbZCTTtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 15:49:43 -0400
Received: (qmail 10626 invoked by uid 107); 20 Mar 2009 19:49:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 15:49:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 15:49:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0903200911530.16242@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113996>

On Fri, Mar 20, 2009 at 10:11:27AM -0700, Keith Cascio wrote:

> (a) numeric data (integers, chars, and floats): define magic value(s)
> that represent pristineness.  Initialize all fields to PRISTINE.
> Later, if a field has any value other than PRISTINE, we know there was
> intent-to-change.

Good point. Though we will need to make sure that existing code is never
looking at PRISTINE values, which aren't likely to make much sense (I
suspect most will be INT_MAX or -1, as 0 is a reasonable value for many
of the options). This should be easy for most code, since the flattening
will get rid of PRISTINE. But remember that there are pieces of code
that do something like:

  if (some_diff_option_is_set)
     set_some_other_related_diff_option;

which will need to be PRISTINE-aware.

> >   3. Introduce some mechanism to help future callers get it right
> >   (since otherwise assigning directly is a subtle bug).
> 
> Yes, in the future, someone could write naughty code that sets a bit
> flag directly rather than using one of the macros.  In C, we probably
> can't make that impossible.  But generally speaking we can't protect
> against all forms of gross negligence.

I think you can safely ignore this complaint. I was worried we would
need something like:

  DIFF_SET(&opt, stat_name_width, 10);

It is much easier to mistakenly write this as

  opt.state_name_width = 10;

than it is to accidentally do a bit-set when there is a DIFF_OPT_SET
macro. That is, I think most people _want_ to use DIFF_OPT_SET because
it is easier to read and less typing.

So I saw this as a problem more for non-bit options, but you have
already addressed that above.

> All in all, turns out v3 requires surprisingly little modification of
> existing code outside of diff.h/diff.c.  Actually, it only adds 3
> lines, that's it!!
>
>  builtin-diff.c                  |    2 +
>  builtin-log.c                   |    1 +
>  diff.c                          |  112 ++++++++++++++++++++++++-
>  diff.h                          |   17 +++-
>
> Shall I post v3?

Yes, please. It is much better to be talking about actual code than
hypotheticals.

-Peff
