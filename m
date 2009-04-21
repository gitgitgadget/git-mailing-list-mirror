From: Jeff King <peff@peff.net>
Subject: Re: Bug in test-lib.sh: test_create_repo() / RFC
Date: Mon, 20 Apr 2009 23:06:38 -0400
Message-ID: <20090421030638.GE14479@coredump.intra.peff.net>
References: <49EC8BE6.2030709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 05:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw6LK-0004NZ-Qq
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 05:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbZDUDGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 23:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbZDUDGo
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 23:06:44 -0400
Received: from peff.net ([208.65.91.99]:59271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbZDUDGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 23:06:43 -0400
Received: (qmail 6163 invoked by uid 107); 21 Apr 2009 03:06:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 23:06:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 23:06:38 -0400
Content-Disposition: inline
In-Reply-To: <49EC8BE6.2030709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117080>

On Mon, Apr 20, 2009 at 04:51:18PM +0200, Michael J Gruber wrote:

> Problem:
> Since a6d63b7 (test-lib: avoid assuming that templates/ are in the
> GIT_EXEC_PATH, 2009-02-04), test_create_repo() assumes to be called from
> a directory such that `pwd`/../templates/blt/ contains templates for
> git-init.
> 
> Several tests (see below) call test_create_repo() from a different
> directory, which means the repo is created without any of the default
> files (and that a mv .git/hooks .git/hooks-disabled later in the
> function errors out). Now, for most tests this probably doesn't matter
> at all but it's not nice.

If I am understanding it correctly, I think this is simply a bug
introduced by a6d63b7, and the fix is maint-worthy.

And I think the right fix is:

> - Simply use $(TEST_DIRECTORY)/../templates/blt/. Nice and easy. But
> uses the templates from the git repo containing t/ even when testing
> against and installed git (just like now, for most of the tests).

The original code (before a6d63b7) used $(GIT_EXEC_PATH), since it
handily pointed to "$(TEST_DIRECTORY)/.." (and I didn't check, but I
suspect that line predates $(TEST_DIRECTORY) entirely). So I think this
is just doing what the a6d63b7 should have done in the first place,
instead of using `pwd` to guess at the top-level location.

One thing to consider: we now have code to test an installed version of
git. Should it be using the vanilla hooks from the source directory, or
should it be using the regular templates? I think that question is
orthogonal to the bug you mention, though -- the current code is trying
to use the hooks from the source directory, but it is just failing to do
so; by fixing it, you certainly won't be breaking the
test-installed-version case.

-Peff
