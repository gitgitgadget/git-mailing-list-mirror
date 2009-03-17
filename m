From: Jeff King <peff@peff.net>
Subject: Re: GIT_WORK_TREE=dir git ls-files --deleted
Date: Tue, 17 Mar 2009 05:03:19 -0400
Message-ID: <20090317090319.GM18475@coredump.intra.peff.net>
References: <201bac3a0903161841y6bc59fe5iaf0c221c08db5f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonas Bernoulli <jonas@bernoul.li>
X-From: git-owner@vger.kernel.org Tue Mar 17 10:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjVEI-0000Il-Ia
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 10:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbZCQJD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 05:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbZCQJD3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 05:03:29 -0400
Received: from peff.net ([208.65.91.99]:49540 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbZCQJD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 05:03:28 -0400
Received: (qmail 3143 invoked by uid 107); 17 Mar 2009 09:03:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 05:03:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 05:03:19 -0400
Content-Disposition: inline
In-Reply-To: <201bac3a0903161841y6bc59fe5iaf0c221c08db5f43@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113444>

On Tue, Mar 17, 2009 at 02:41:50AM +0100, Jonas Bernoulli wrote:

> git ls-files --deleted seams to be broken when GIT_WORK_TREE is set as
> can be observed below.
> 
> Instead of just showing deleted files it also shows at least unchanged
> and modified files.
> 
> I have observed this behaviour with git.git and do not know if
> released versions are affected.

I don't think it has ever worked correctly. A fix is below, but I'm
really unsure if it is right. It seems like we should be able to just
refresh the index and see its status, rather than calling the lstat
ourselves. But perhaps this is an optimization to avoid refresh (see
builtin-ls-files.c, lines 186-202). Junio?

-- >8 --
Subject: [PATCH] ls-files: require worktree when --deleted is given

The code will end up calling lstat() to check whether the
file still exists; obviously this doesn't work if we're not
in the worktree.

Signed-off-by: Jeff King <peff@peff.net>
---
The version in next has the same bug, but the code is totally different
due to parseopt-ification (but the fix is still a one-liner to set
require_work_tree when show_deleted is set).

 builtin-ls-files.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 9dec282..ca6f33d 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -419,6 +419,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted = 1;
+			require_work_tree = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-m") || !strcmp(arg, "--modified")) {
-- 
1.6.2.1.137.gb6aa78
