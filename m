From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 14:02:01 -0500
Message-ID: <20090121190201.GA21686@coredump.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiMP-0007o9-1J
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbZAUTCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbZAUTCG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:02:06 -0500
Received: from peff.net ([208.65.91.99]:59321 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbZAUTCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:02:05 -0500
Received: (qmail 16783 invoked by uid 107); 21 Jan 2009 19:02:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 14:02:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 14:02:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901210209580.19014@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106642>

On Wed, Jan 21, 2009 at 02:10:17AM +0100, Johannes Schindelin wrote:

> 	- symbolic links are inspected for correct targets now, and if they
> 	  point somewhere else than expected, they are removed (this can
> 	  error out if the file could not be removed) and recreated.

Now you _do_ have a race on this, and triggering it will cause you to
run a random version of git from your PATH, not using valgrind (instead
of running the version from the repo using valgrind). Something like:

  A: execvp("git-foo")
  B: oops, "git-foo" is out of date
  B: rm $GIT_VALGRIND/git-foo
  A: look for $GIT_VALGRIND/git-foo; not there
  A: look for $PATH[1]/git-foo; ok, there it is
  B: ln -s ../../git-valgrind $GIT_VALGRIND/git-foo

> +--valgrind::
> +	Execute all Git binaries with valgrind and stop on errors (the
> +	exit code will be 126).

It doesn't necessarily stop: it just causes the command to fail, which
causes the test to fail. Which _will_ stop if you have "-i".

Also, you might want to mention that valgrind errors go to stderr, so
using "-v" is helpful.

> +	# override all git executables in PATH and TEST_DIRECTORY/..
> +	GIT_VALGRIND=$TEST_DIRECTORY/valgrind/bin

I think you should leave GIT_VALGRIND pointing to the main valgrind
directory. That way it is more convenient for people using
GIT_VALGRIND_OPTIONS to make use of GIT_VALGRIND without having to ".."
everything (for example, they may want to pick and choose suppressions
to load for their platform).

> +			case "$base" in
> +			*.sh|*.perl)
> +				symlink_target=../unprocessed-script
> +			esac

AFAIK, this triggers an error if I try to call "git-foo.perl" directly.
What does this have to do with valgrind? Why does this error checking
happen when I run --valgrind, but _not_ otherwise?

And yes, I know the answer is "because it's easy to do here, since
--valgrind is munging the PATH anyway". But my point is that that is an
_implementation_ detail, and the external behavior to a user is
nonsensical.

The fact that there are other uses for munging the PATH than valgrind
implies to me that we should _always_ be munging the PATH like this to
catch these sorts of errors. And then "--valgrind" can just change the
way we munge.

> +			# create the link, or replace it if it is out of date
> +			if test ! -h "$GIT_VALGRIND"/"$base" ||
> +			    test "$symlink_target" != \
> +					"$(readlink "$GIT_VALGRIND"/"$base")"
> +			then

readlink is not portable; it's part of GNU coreutils. Right now valgrind
basically only runs on Linux, which I think generally means that
readlink will be available (though I have no idea if there are
distributions that vary in this). However, there is an experimental
valgrind port to FreeBSD and NetBSD, which are unlikely to have
readlink.

-Peff
