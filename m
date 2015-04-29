From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 19:11:50 -0400
Message-ID: <20150429231150.GB3887@peff.net>
References: <1430341032.14907.9.camel@ubuntu>
 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
 <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
 <1430346576.14907.40.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynb93-00061d-K2
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 01:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbbD2XLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 19:11:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:51946 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106AbbD2XLw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 19:11:52 -0400
Received: (qmail 26949 invoked by uid 102); 29 Apr 2015 23:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 18:11:52 -0500
Received: (qmail 31932 invoked by uid 107); 29 Apr 2015 23:12:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 19:12:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 19:11:50 -0400
Content-Disposition: inline
In-Reply-To: <1430346576.14907.40.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268036>

On Wed, Apr 29, 2015 at 03:29:36PM -0700, David Turner wrote:

> Overall, I agree.  I think the disadvantages are somewhat overstated.
> 
> As I said above, I don't think the cwd is a problem.  The output for
> symlinks which point outside the repo should be absolute (in the case of
> absolute symlinks), or relative to the repo root (for relative
> symlinks).  In other words, if my repo contains:
> foo/bar -> ../../baz
> then the output[1] would be 
> symlink 6
> ../baz
> 
> I can't think of any other output that would be reasonable here, but
> maybe there's something I don't understand.

Yeah, I agree if you let git punt on leaving the filesystem, most of the
complicated problems go away. It still feels a bit more magical than I
expect out of cat-file, and there are still corner cases (e.g., do we do
cycle detection? Or just have a limit to the recursion depth?)

And if you are punting on some cases, I think you'd still want to be
able to report on the symlinks you couldn't resolve (e.g., because they
went out of tree, pointed to non-existent files, or caused cycles). So
it seems like %(intreemode) is a good first step, because it lets you
express that (and more).

And then you could implement --follow-symlinks on top of that; it can't
catch all cases, but you've left callers with an escape hatch to do
their own resolution if they want, without having to implement a new
syntax for it.

-Peff
