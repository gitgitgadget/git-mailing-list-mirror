From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-grep: don't use sscanf
Date: Mon, 12 Mar 2007 13:11:29 +0100
Message-ID: <87lki2r79q.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 13:11:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQjNG-0004oH-6y
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 13:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965748AbXCLMLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 08:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965739AbXCLMLb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 08:11:31 -0400
Received: from mx.meyering.net ([82.230.74.64]:42505 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965748AbXCLMLa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 08:11:30 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 49FD484F6; Mon, 12 Mar 2007 13:11:29 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42021>

If you use scanf or sscanf to parse integers, your code probably
accepts bogus inputs.  For example, builtin-grep (aka git-grep) uses
sscanf(scan, "%u", &num) to parse the integer argument to -A, -B, -C.
Currently, "-C 1,000" and "-C 4294967297" are both treated just like
"-C 1":

    $ git-grep -h -C 4294967297 juggle
    out and you may find it easier to switch back and forth if you
    juggle multiple lines of development simultaneously. Of
    course, you will pay the price of more disk usage to hold

The obvious fix is to use strtoul instead.  But using a bare strtoul is
too messy, at least when done properly, so I've added a wrapper function.

The new function in the patch below belongs elsewhere if it would be
useful in replacing any of the four remaining uses of sscanf.

One final note:  With this change, I get a slightly different
diagnostic depending on the context size:

  $ ./git-grep -h -C 4294967296 juggle
  fatal: 4294967296: invalid context length argument
  [Exit 128]
  $ ./git-grep -h -C 4294967295 juggle
  grep: 4294967295: invalid context length argument

  [Exit 1]

A common convention that makes it easy to identify the source
of a diagnostic is to include the program name before the first ":".
Whether that should be "git" or "git-grep" is another question.
Using "grep" or "fatal" is misleading.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-grep.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 694da5b..9a151bf 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -431,6 +431,18 @@ static const char emsg_missing_context_len[] =
 static const char emsg_missing_argument[] =
 "option requires an argument -%s";

+static int
+strtoul_ui (char const *s, unsigned int *result)
+{
+	char *p;
+	errno = 0;
+	unsigned long ul = strtoul (s, &p, 10);
+	if (errno || *p || p == s || (unsigned int) ul != ul)
+		return 0;
+	*result = ul;
+	return 1;
+}
+
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
@@ -553,7 +565,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 				scan = arg + 1;
 				break;
 			}
-			if (sscanf(scan, "%u", &num) != 1)
+			if (!strtoul_ui (scan, &num))
 				die(emsg_invalid_context_len, scan);
 			switch (arg[1]) {
 			case 'A':
--
1.5.0.3.353.g8a3f
