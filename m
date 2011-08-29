From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] do not require filters to consume stdin
Date: Mon, 29 Aug 2011 16:31:07 -0400
Message-ID: <20110829203107.GA4946@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 22:39:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8bh-0000do-0F
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab1H2Uiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:38:52 -0400
Received: from wren.kitenet.net ([80.68.85.49]:58940 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab1H2Uiv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:38:51 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Aug 2011 16:38:51 EDT
Received: from gnu.kitenet.net (dialup-4.153.14.169.Dial1.Atlanta1.Level3.net [4.153.14.169])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 446C4118BA7
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 16:31:12 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 2EA2C44BFE; Mon, 29 Aug 2011 16:31:07 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180346>

A clean filter that uses %f to examine a file may not need to consume
the entire file content from stdin every time it's run, due to caching
or other optimisations to support large files.

Ignore the SIGPIPE that may result when writing to the filter
if it exits without consuming stdin, and do not check that all
content is sent to it. The filter is still required to exit
successfully, so a crash in the filter should still be handled
correctly.
---

There has been discussion before about using clean and smudge filters
with %f to handle big files in git, with the file content stored outside
git somewhere.  A simplistic clean filter for large files could look
like this:

#!/bin/sh
file="$1"
ln -f $file ~/.big/$file
echo $file

But trying to use this will fail on truely large files. For example:

$ ls -l sorta.huge 
-rw-r--r-- 3 joey joey 524288000 Aug 29 15:19 sorta.huge
$ git add sorta.huge 
broken pipe  git add sorta.huge
$ echo $?
141

The SIGPIPE occurs because git expects the clean filter to read
the full file content from stdin. (Although if the content is small
enough, a SIGPIPE may not occur.) So the clean filter needs to
look like this:

#!/bin/sh
file="$1"
cat >/dev/null
ln -f $file ~/.big/$file
echo $file

But this means much more work has to be done whenever the clean filter
is run. Including every time git status is run. So it's currently
impractical to use clean/smudge filters like this for large files.
This patch should close that gap and allow such filters to be developed.

 convert.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 416bf83..3d528c4 100644
--- a/convert.c
+++ b/convert.c
@@ -330,7 +330,7 @@ static int filter_buffer(int in, int out, void *data)
 	 */
 	struct child_process child_process;
 	struct filter_params *params = (struct filter_params *)data;
-	int write_err, status;
+	int write_err = 0, status;
 	const char *argv[] = { NULL, NULL };
 
 	/* apply % substitution to cmd */
@@ -360,9 +360,11 @@ static int filter_buffer(int in, int out, void *data)
 	if (start_command(&child_process))
 		return error("cannot fork to run external filter %s", params->cmd);
 
-	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
+	signal(SIGPIPE, SIG_IGN);
+	write_in_full(child_process.in, params->src, params->size);
 	if (close(child_process.in))
 		write_err = 1;
+	signal(SIGPIPE, SIG_DFL);
 	if (write_err)
 		error("cannot feed the input to external filter %s", params->cmd);
 
-- 
1.7.5.4
