From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 15:56:12 -0400
Message-ID: <20151030195611.GC5486@sigill.intra.peff.net>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <20151026191724.GE7881@google.com>
 <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info>
 <xmqqlhakky0e.fsf@gitster.mtv.corp.google.com>
 <20151030190256.GI7881@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:56:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFmd-00085X-Fs
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760042AbbJ3T4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:56:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:50623 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757370AbbJ3T4O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:56:14 -0400
Received: (qmail 9833 invoked by uid 102); 30 Oct 2015 19:56:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 14:56:14 -0500
Received: (qmail 26048 invoked by uid 107); 30 Oct 2015 19:56:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 15:56:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 15:56:12 -0400
Content-Disposition: inline
In-Reply-To: <20151030190256.GI7881@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280536>

On Fri, Oct 30, 2015 at 12:02:56PM -0700, Jonathan Nieder wrote:

> > I'd just be happy as long as the feature becomes available, and I'd
> > leave the choice of consistent and convenient naming to others who
> > have stronger opinions ;-)
> 
> Here's a suggested patch.
> 
> -- >8 --
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Subject: Facilitate debugging Git executables in tests with gdb
> 
> When prefixing a Git call in the test suite with 'debug ', it will now
> be run with GDB, allowing the developer to debug test failures more
> conveniently.

At the risk of repeating what I just said elsewhere in the thread, I
think this patch is the best of the proposed solutions.

> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -19,4 +19,10 @@ GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
>  PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
>  
> -exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> +if test -n "$GIT_TEST_GDB"
> +then
> +	unset GIT_TEST_GDB
> +	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> +else
> +	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> +fi

Somebody suggested elsewhere that the name "gdb" be configurable. We
could stick that in the same variable, like:

  test "$GIT_TEST_GDB" = 1 && GIT_TEST_GDB=gdb
  exec ${GIT_TEST_GDB} --args ...

but that does not play well with the "debug" function, which does not
know which value to set it to. I guess we would need GIT_TEST_GDB_PATH
or something.

I am happy to let that get added later by interested parties (I am happy
with "gdb" myself). I just wanted to mention it to make sure we are not
painting ourselves into any corners.

-Peff
