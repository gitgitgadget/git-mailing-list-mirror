From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Thu, 28 Feb 2008 21:47:35 -0800
Message-ID: <7v3arcfh54.fsf@gitster.siamese.dyndns.org>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com>
 <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com>
 <20080225184648.GC15131@sigill.intra.peff.net>
 <20080228084328.GA18350@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 06:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUy6d-0006MS-Oi
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 06:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbYB2Frv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 00:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYB2Fru
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 00:47:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYB2Fru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 00:47:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A60E2E47;
	Fri, 29 Feb 2008 00:47:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5C4432E46; Fri, 29 Feb 2008 00:47:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75506>

Jeff King <peff@peff.net> writes:

> I like it; I think it made it a lot more obvious which side was which
> during the rebase. I checked with cherry-pick, as well; it more or less
> makes sense, except that the cherry-picked commit is called "upstream."

While I like the fact that somebody is trying to tackle the
consistency issue, I do not like the approach itself.  Fudging
the issue at the merge-tool UI level may make things appear more
consistent when viewing the merge from within merge-tool, but it
makes the views merge-tool gives and vi/less gives inconsistent.

It would be a lot more sensible to make sure that we always show
the side that the end-user modified first and then the side the
other party changed.

A regular merge, cherry-pick and revert all start from user's
side and play the change from the other side, and conflicted
hunks are shown in the right order.  It is only "rebase" (with
or without -m) that gets it wrong.  Even though it internally
operates as if our own changes are coming from the other side,
we should show our change first and then theirs to make it
consistent and easier to read.

So how about doing it like this, instead?  I am not proud of the
use of an environment variable to pass this control around, but
the idea should be obvious.

Note that some tests are written to expect the current hunk
order and will start failing, so if we were to go this route, we
would need to adjust them as well.

--

 git-rebase.sh |    3 +++
 ll-merge.c    |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bdcea0e..422879f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -48,6 +48,9 @@ prec=4
 verbose=
 git_am_opt=
 
+GITHEAD_SWAP_CONFLICT=in-rebase
+export GITHEAD_SWAP_CONFLICT
+
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
 	test -d "$dotest" || die "$dotest directory does not exist"
diff --git a/ll-merge.c b/ll-merge.c
index 5ae7433..1d0040f 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -76,6 +76,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 				       virtual_ancestor);
 	}
 
+	if (getenv("GITHEAD_SWAP_CONFLICT")) {
+		mmfile_t *s;
+		const char *n;
+		s = src1; src1 = src2; src2 = s;
+		n = name1; name1 = name2; name2 = n;
+	}
 	memset(&xpp, 0, sizeof(xpp));
 	return xdl_merge(orig,
 			 src1, name1,

