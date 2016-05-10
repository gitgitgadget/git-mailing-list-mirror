From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t3404: be resilient against running with the -x flag
Date: Tue, 10 May 2016 16:58:01 -0400
Message-ID: <20160510205800.GC19958@sigill.intra.peff.net>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
 <alpine.DEB.2.20.1605101607180.4092@virtualbox>
 <xmqqshxpofqh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:58:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EjJ-0007Ue-Oo
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbcEJU6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:58:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:37265 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751325AbcEJU6E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:58:04 -0400
Received: (qmail 28720 invoked by uid 102); 10 May 2016 20:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 16:58:03 -0400
Received: (qmail 1358 invoked by uid 107); 10 May 2016 20:58:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 16:58:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2016 16:58:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqshxpofqh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294191>

On Tue, May 10, 2016 at 12:49:42PM -0700, Junio C Hamano wrote:

> I wonder if we can fix "-x" instead so that we do not have to
> butcher tests like this patch does.  It was quite clear what it
> expected to see before this patch, and it is sad that the workaround
> makes less readable (and relies on the real output we are looking
> for never begins with '+').

I don't think there is a scalable, portable way to do so. "-x" output is
going to stderr, and is inherited by any functions or subshells. So
either we have to ask "-x" output to go somewhere else, or we have to
turn it off inside the functions and subshells. The latter requires
tweaking each site, which isn't scalable. And there is no way to do the
former in a portable way (AFAIK).

That being said, bash supports BASH_XTRACEFD, so maybe something like
this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 286c5f3..482ec11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -321,6 +321,7 @@ then
 else
 	exec 4>/dev/null 3>/dev/null
 fi
+BASH_XTRACEFD=4
 
 test_failure=0
 test_count=0

would help Dscho's case (and people on other shells aren't helped, but
they are not hurt either).

-Peff
