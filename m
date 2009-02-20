From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Fri, 20 Feb 2009 01:25:43 -0500
Message-ID: <20090220062543.GA27837@coredump.intra.peff.net>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 20 07:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaOqw-00005W-Nq
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 07:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbZBTGZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 01:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbZBTGZq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 01:25:46 -0500
Received: from peff.net ([208.65.91.99]:35572 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbZBTGZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 01:25:46 -0500
Received: (qmail 32556 invoked by uid 107); 20 Feb 2009 06:26:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 01:26:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 01:25:43 -0500
Content-Disposition: inline
In-Reply-To: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110804>

On Fri, Feb 20, 2009 at 06:18:09AM +0100, Michael Haggerty wrote:

> The test suite for "git cvsimport" is pretty limited, and I would like
> to improve the situation.  This patch series contains the first of
> what I hope will eventually be several additions to the "git
> cvsimport" test suite.

Great. I agree the test suite is terrible for cvsimport; what little is
there was added only after a regression where it was totally broken. ;)

> I am the maintainer of cvs2svn/cvs2git.  Most of the new tests will
> probably use fragments from the cvs2svn test suite.  I should admit
> that part of my motivation for adding tests to the "git cvsimport"
> test suite is to document its weaknesses, which do not seem to be
> especially well known.

I don't think it is a problem to document cvsimport's weakness. It is
clear from list traffic that it has shortcomings, and IMHO documenting
them clearly and rigorously with test cases is the first step to fixing
them (or admitting that people should just use something else ;) ).

The only downside I see is that it bloats git's test suite a bit (and
cvs tests are often slow to run). We can always make them optional,
I suppose.

I do wonder, though, whether it would be simpler to make a "cvs import
test suite" that could pluggably test cvs2svn, git-cvsimport, or other
converters. Then you could test each on the exact same set of test
repos. And abstracting "OK, now make a repository from this cvsroot"
wouldn't be that hard for each command (I wouldn't think, but obviously
I haven't tried it :) ).

> Patch 1 splits out some code into a library usable by multiple
> CVS-related tests.

That is definitely a good first step, though the usual naming convention
is t/lib-cvs.sh. See t/lib-{git-svn,httpd,rebase}.sh, for example.

> Patch 2 changes the library to add the -f option when invoking cvs (to
> make it ignore the user's ~/.cvsrc file).

The code in t9600 (which gets moved to lib-cvs in your patch 1) sets
HOME explicitly. So is this really a problem?

> Patch 3 adds a new test to t9600, namely to compare the entire module
> as checked out by CVS vs. git.

Sounds reasonable.

> Patch 4 adds a new test script t9601 that tests "git cvsimport"'s
> handling of CVS vendor branches.  One of these tests fails due to an
> actual bug.

Cool. Are you volunteering to fix git-cvsimport, too? :)

> The second is that the new test script uses a small CVS repository
> that is part of the test suite (i.e., the *,v files are committed
> directly into the git source tree).  This is different than the
> approach of t9600, which creates its own test CVS repository using CVS
> commands.  The reasons for this are:

I think that's fine. There are other places in the test suite where
things that are a pain to produce are just included as content (e.g.,
see some of the SVN tests in the 9100 series).

And I think all of the reasons you gave are compelling.

> Finally, the *,v files comprising the CVS repository have blank
> trailing lines, triggering a warning from "git diff --check".  I don't
> think that CVS strictly requires the blank lines, but they are always
> generated by CVS, so I left them in.  But if the "git diff --check"
> warnings are considered a serious problem, the blank lines could
> probably be removed.

It's best to leave them in, I think, to create as realistic a test as
possible. But you should mark the paths as "we don't care about
whitespace" using gitattributes. I.e.,:

diff --git a/t/t9601/.gitattributes b/t/t9601/.gitattributes
new file mode 100644
index 0000000..562b12e
--- /dev/null
+++ b/t/t9601/.gitattributes
@@ -0,0 +1 @@
+* -whitespace

-Peff
