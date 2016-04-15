From: Jeff King <peff@peff.net>
Subject: Re: [Bug?] "git commit --amend" always gives author-date to summary?
Date: Thu, 14 Apr 2016 22:03:01 -0400
Message-ID: <20160415020300.GA22112@sigill.intra.peff.net>
References: <xmqqh9f3gaqh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:03:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqt6F-0007Vk-1z
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbcDOCDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:03:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:49869 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752507AbcDOCDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:03:05 -0400
Received: (qmail 7118 invoked by uid 102); 15 Apr 2016 02:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:03:03 -0400
Received: (qmail 5710 invoked by uid 107); 15 Apr 2016 02:03:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:03:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 22:03:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9f3gaqh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291589>

On Thu, Apr 14, 2016 at 02:07:50PM -0700, Junio C Hamano wrote:

> A simple reproduction.  Doing one of these
> 
>     $ git commit --amend --no-edit
>     $ echo >MSG frotz; git commit --amend -F MSG
> 
> on any commit, whether it is your own commit or somebody else's,
> seems to always show the "Date:" of the original commit, e.g.
> 
>     $ git checkout v2.8.0^0
>     $ git commit --amend --no-edit
>     [detached HEAD a6f2a14] Git 2.8
>      Date: Mon Mar 28 12:19:45 2016 -0700
>      3 files changed, 14 insertions(+), 9 deletions(-)
>     $ git checkout v2.8.0^^2
>     $ git commit --amend --no-edit
>     [detached HEAD df9f57e] Documentation: fix git-p4 AsciiDoc formatting
>      Author: Lars Schneider <larsxschneider@gmail.com>
>      Date: Wed Mar 23 11:59:01 2016 +0100
>      1 file changed, 3 insertions(+), 5 deletions(-)
> 
> I can understand the latter, but I am not sure if it makes sense to
> do the former.  The output is coming from b7242b8c (commit: print
> "Date" line when the user has set date, 2014-05-01), whose objective
> I can agree with, but does not seem to match the use case.

That's working as I intended it in both cases. The point is to show
extra information whenever we have picked an ident or date that is not
the "normal" one. As you noted later, leaving the old author date is the
normal thing for "--amend", but it's still different from a normal
commit that uses the current user and the current date. So I guess it
depends on how you define normal.

IMHO, we are better off generally erring on the side of printing extra
information. The command is already quite chatty, and we are more likely
to remind somebody that they wanted "--reset-author" than to bother
thing.

> [...]
> I suspect that there are people who are already depending on this
> behaviour, so it may not be worth fixing, but I found it somewhat
> irritating (especially after wasting about an hour or so doing wild
> goose chase trying to find a stray invocation of "date" somewhere in
> my script that eventually uses "git commit --amend").
> 
> Thoughts?

So I don't agree that is a "fix" to change it. But if it bothers you, I
don't mind a knob to suppress it in certain cases.

-Peff
