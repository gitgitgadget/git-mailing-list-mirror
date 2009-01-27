From: Jeff King <peff@peff.net>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Mon, 26 Jan 2009 22:52:23 -0500
Message-ID: <20090127035223.GA28690@coredump.intra.peff.net>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com> <20090126210027.GG27604@coredump.intra.peff.net> <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com> <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Perry Smith <pedzsan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 04:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRf1L-0008DX-AY
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 04:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbZA0Dw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 22:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbZA0Dw0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 22:52:26 -0500
Received: from peff.net ([208.65.91.99]:41379 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbZA0Dw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 22:52:26 -0500
Received: (qmail 8422 invoked by uid 107); 27 Jan 2009 03:52:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 22:52:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 22:52:23 -0500
Content-Disposition: inline
In-Reply-To: <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107303>

On Mon, Jan 26, 2009 at 04:57:16PM -0600, Perry Smith wrote:

> A few other comments:  I had to add in the --without-tcltk flag.  I
> don't have tcl installed but the config did not autodetect that it was
> not present.

Hmm. It looks like we respect --with[out]-tcltk, and without it we
always say "just use wish from the PATH" without detecting whether it
actually exists:

    # No Tcl/Tk switches given. Do not check for Tcl/Tk, use bare
    # 'wish'.
    TCLTK_PATH=wish
    AC_SUBST(TCLTK_PATH)

I'm sure the fix would be something along the lines of

    if which wish; then
      TCLTK_PATH=wish
    else
      NO_TCLTK=yes
    fi

but I know for fact that is not portable and that there must be some
special autoconf way of doing the same thing.

> I can't tell if make test is happy or not.  The output looks like its
> happy but the exit code is 2.

That doesn't sound very happy. You should see either a "command failed"
error from make, or some results like:

   '/bin/sh' ./aggregate-results.sh test-results/t*-*
   fixed   1
   success 4026
   failed  0
   broken  3
   total   4030

where "broken" is OK (it is a test that is marked as "we know this is
broken currently, but ideally it would be fixed in the future") but
"failed" is a problem.

But I believe unless you are using "make -k", that it won't even
aggregate the results if something fails, and you should just see make
complaining about the failed test script.

-Peff
