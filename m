From: Jeff King <peff@peff.net>
Subject: Re: git-status producing incorrect results
Date: Thu, 14 Feb 2008 12:18:23 -0500
Message-ID: <20080214171823.GA28762@coredump.intra.peff.net>
References: <20080214164505.GA21932@coredump.intra.peff.net> <alpine.LFD.1.00.0802140902470.6110@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhjt-0001jn-R9
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbYBNRS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbYBNRS2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:18:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1135 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbYBNRS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:18:27 -0500
Received: (qmail 9180 invoked by uid 111); 14 Feb 2008 17:18:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 12:18:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 12:18:23 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802140902470.6110@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73894>

On Thu, Feb 14, 2008 at 09:04:59AM -0800, Linus Torvalds wrote:

> ACK again, that's almost certainly the right long-term fix, but it 
> essentially requires a "copy_index()" thing that creates a new index from 
> an existing copy (so that we don't need to re-read it) etc infrastructure 
> changes, so I think your patch is the correct one for now.

Here is the cleaned-up mini-fix for now, then.

-- >8 --
commit: discard index after setting up partial commit

There may still be some entries from the original index that
should be discarded before we show the status. In
particular, if a file was added in the index but not
included in the partial commit, it would still show up in
the status listing as staged for commit.

Ultimately the correct fix is to keep the two states in
separate index_state variables. Then we can avoid having
to reload the cache from the temporary file altogether, and
just point wt_status_print at the correct index.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-commit.c  |    4 ++++
 t/t7502-status.sh |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 0442c8e..6612b4f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -317,6 +317,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&false_lock))
 		die("unable to write temporary index file");
+
+	discard_cache();
+	read_cache_from(false_lock.filename);
+
 	return false_lock.filename;
 }
 
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index b64ce30..e006074 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -128,4 +128,25 @@ test_expect_success 'status without relative paths' '
 
 '
 
+cat <<EOF >expect
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/
+#	expect
+#	output
+#	untracked
+EOF
+test_expect_success 'status of partial commit excluding new file in index' '
+	git status dir1/modified >output &&
+	diff -u expect output
+'
+
 test_done
-- 
1.5.4.1.1324.gfec5c
