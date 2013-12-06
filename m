From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] rev-parse: be more careful with munging arguments
Date: Fri, 6 Dec 2013 17:07:52 -0500
Message-ID: <20131206220751.GB25620@sigill.intra.peff.net>
References: <20131206220520.GA30652@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 23:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp3Z3-0006BL-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 23:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161516Ab3LFWHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 17:07:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:51862 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161513Ab3LFWHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 17:07:53 -0500
Received: (qmail 11207 invoked by uid 102); 6 Dec 2013 22:07:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 16:07:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 17:07:52 -0500
Content-Disposition: inline
In-Reply-To: <20131206220520.GA30652@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238957>

When rev-parse looks at whether an argument like "foo..bar"
or "foobar^@" is a difference or parent-shorthand, it
internally munges the arguments so that it can pass the
individual rev arguments to get_sha1. However, we do not
consistently un-munge the result.

For cases where we do not match (e.g., "doesnotexist..HEAD"),
we wouuld then want to try to treat the argument as a
filename. try_difference gets this right, and always
unmunges in this case. However, try_parent_shorthand never
unmunges, leading to incorrect error messages, or even
incorrect results:

  $ git rev-parse foobar^@
  foobar
  fatal: ambiguous argument 'foobar': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

  $ >foobar
  $ git rev-parse foobar^@
  foobar

For cases where we do match, neither function unmunges. This
does not currently matter, since we are done with the
argument. However, a future patch will do further
processing, and this prepares for it. In addition, it's
simply a confusing interface for some cases to modify the
const argument, and others not to.

Signed-off-by: Jeff King <peff@peff.net>
---
As an aside, this is one of those places where C's string functions do
gross things with const. We modify a const argument to the function
without any casts or warnings, because the return value from strstr
implicitly drops the const. Time for us all to move to C++ with
templated strstr, right?

 builtin/rev-parse.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bb694ab..a60fcd3 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -286,6 +286,7 @@ static int try_difference(const char *arg)
 				exclude = n;
 			}
 		}
+		*dotdot = '.';
 		return 1;
 	}
 	*dotdot = '.';
@@ -309,8 +310,10 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 
 	*dotdot = 0;
-	if (get_sha1_committish(arg, sha1))
+	if (get_sha1_committish(arg, sha1)) {
+		*dotdot = '^';
 		return 0;
+	}
 
 	if (!parents_only)
 		show_rev(NORMAL, sha1, arg);
@@ -319,6 +322,7 @@ static int try_parent_shorthands(const char *arg)
 		show_rev(parents_only ? NORMAL : REVERSED,
 				parents->item->object.sha1, arg);
 
+	*dotdot = '^';
 	return 1;
 }
 
-- 
1.8.5.524.g6743da6
