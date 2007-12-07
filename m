From: Jeff King <peff@peff.net>
Subject: [PATCH] quote_path: convert empty path to "./"
Date: Fri, 7 Dec 2007 11:57:04 -0500
Message-ID: <20071207165703.GA8889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 17:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0gW4-0007N3-Vi
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 17:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbXLGQ5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 11:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbXLGQ5I
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 11:57:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1803 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbXLGQ5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 11:57:07 -0500
Received: (qmail 6061 invoked by uid 111); 7 Dec 2007 16:57:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 07 Dec 2007 11:57:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 11:57:04 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67436>

Now that we are correctly removing leading prefixes from files in git
status, there is a degenerate case: the directory matching the prefix.
Because we show only the directory name for a directory that contains
only untracked files, it gets collapsed to an empty string.

Example:

  $ git init
  $ mkdir subdir
  $ touch subdir/file
  $ git status
  ...
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #       subdir/

  So far, so good.

  $ cd subdir
  $ git status
  ....
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #

  Oops, that's a bit confusing.

  This patch prints './' to show that there is some output.

---
I think it looks a bit ugly because it is so small (though just '.' was
even worse). But I don't see what else would make sense.

 wt-status.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 02dbb75..31d83bf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -121,6 +121,9 @@ static char *quote_path(const char *in, int len,
 		}
 	}
 
+	if (!out->len)
+		strbuf_addstr(out, "./");
+
 	return out->buf;
 }
 
-- 
1.5.3.7.2156.g3d791-dirty
