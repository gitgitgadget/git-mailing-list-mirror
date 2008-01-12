From: Jeff King <peff@peff.net>
Subject: valgrind test script integration
Date: Sat, 12 Jan 2008 06:10:44 -0500
Message-ID: <20080112111044.GA24257@coredump.intra.peff.net>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 12:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDeHP-0004bb-MX
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 12:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762998AbYALLK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 06:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762849AbYALLKu
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 06:10:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1355 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762657AbYALLKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 06:10:47 -0500
Received: (qmail 6326 invoked by uid 111); 12 Jan 2008 11:10:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 12 Jan 2008 06:10:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2008 06:10:44 -0500
Content-Disposition: inline
In-Reply-To: <20080112090432.GA6134@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70307>

On Sat, Jan 12, 2008 at 04:04:32AM -0500, Jeff King wrote:

> I couldn't reproduce this just running the test, but running it under
> valgrind showed a memory access error. Fix is below.

BTW, this could have been caught automagically if we had valgrind
integration in the test scripts. Below is a rudimentary patch to do so.
I'm not that familiar with valgrind, so input from those more
knowledgeable is appreciated, and maybe we can get something official
post-1.5.4.

You can use it like "./t7300-clean.sh -m"; each call to 'git' is run
through valgrind, and returns an error if the original program had an
error, or if valgrind turned up any errors.

It of course runs horribly slowly. I've just kicked off a

  make GIT_TEST_OPTS='-i -m'

now. A few caveats:

 - It barfs on _any_ valgrind error. On my Debian unstable system,
   anything that touches nss ends up with an error deep in the dlopen
   code.  Therefore to make this useful, I had to put

     {
       dl hack
       Memcheck:Addr4
       obj:/lib/ld-2.7.so
     }

   into /usr/lib/valgrind/default.supp

   We should maybe have a 'git.supp' error suppression file, but in this
   case, the error really seems to be platform-specific.

 - We only catch calls to 'git', not 'git-foo' (and in fact for that
   reason this doesn't catch the t7300 bug by itself, since that uses
   git-clean). A follow-on patch will deal with this.

---
 t/test-lib.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 90b6844..415e918 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -84,6 +84,8 @@ do
 	--no-python)
 		# noop now...
 		shift ;;
+	-m|--m|--me|--mem|--memc|--memch|--memche|--memchec|--memcheck)
+		alias git='memcheck git'; shift ;;
 	*)
 		break ;;
 	esac
@@ -120,6 +122,12 @@ say () {
 	say_color info "$*"
 }
 
+memcheck() {
+	valgrind -q --error-exitcode=1 --leak-check=no "$@" && return 0
+	echo >&2 valgrind failure: "$@"
+	return 1
+}
+
 test "${test_description}" != "" ||
 error "Test script did not set test_description."
 
-- 
1.5.4.rc3.1.g027628-dirty
