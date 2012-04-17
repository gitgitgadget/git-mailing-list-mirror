From: Jeff King <peff@peff.net>
Subject: [PATCH] gc: fix off-by-one in append_option
Date: Tue, 17 Apr 2012 16:32:55 -0700
Message-ID: <20120417233255.GA24626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 01:33:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKHtR-0001DS-Q8
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 01:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab2DQXdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 19:33:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37449
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab2DQXc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 19:32:59 -0400
Received: (qmail 10782 invoked by uid 107); 17 Apr 2012 23:33:07 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Apr 2012 19:33:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Apr 2012 16:32:55 -0700
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195825>

The append_option function appends a string to a
NULL-terminated array, taking care not to overflow the
array. However, it's comparison was over-cautious, and
checked that there was enough room for two options, not one
(plus the NULL-terminator, of course).  This could cause
very long command-lines (e.g., "git gc --aggressive" when
"--unpack-unreachable" is in use) to hit the limit.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this when trying a "git gc --aggressive" with the current
"next". The culprit is my 7e52f56 (gc: do not explode objects which will
be immediately pruned) which adds two extra options to the repack
invocation.

This patch is enough to fix it, as the current limit is big enough when
the off-by-one error is removed.  The currentl limit is 10, which
appears to have been pulled out of thin air by 0d7566a (Add --aggressive
option to 'git gc', 2007-05-09) as "big enough".

Obviously this would be much nicer with argv_array. Unfortunately, I
don't think there is a way to have a nice initializer with argv_array.
The current code looks like this:

  static const char *argv_repack[MAX_ADD] = {"repack", "-d", "-l", NULL };

and in an ideal world you would have something like:

  static struct argv_array argv_repack = ARGV_ARRAY_INIT("repack", "-d", "-l");

Of course that would involve variadic macros, which we can't count on.
But even beyond that it's tough, because you are mixing static
initialization with a dynamic structure. You can hack around that by
copying the defaults during first push, but that's extra complexity, and
the syntax is still ugly.

What do you think of just:

  static struct argv_array argv_repack;
  [...]
  argv_init_from_string(&argv_repack, "repack -d -l");

I prefer static initialization when we can do it, but it just seems like
too much trouble in this case.

 builtin/gc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 1bc2fe3..d80a961 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -74,7 +74,7 @@ static void append_option(const char **cmd, const char *opt, int max_length)
 	for (i = 0; cmd[i]; i++)
 		;
 
-	if (i + 2 >= max_length)
+	if (i + 1 >= max_length)
 		die(_("Too many options specified"));
 	cmd[i++] = opt;
 	cmd[i] = NULL;
-- 
1.7.9.6.8.g992e5
