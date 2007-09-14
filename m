From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix "git diff" setup code
Date: Fri, 14 Sep 2007 11:19:55 -0700
Message-ID: <7v4phxaz3o.fsf@gitster.siamese.dyndns.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
	<20070906022539.GG18160@spearce.org>
	<20070906101648.GD6665@basalt.office.altlinux.org>
	<20070909044648.GH18160@spearce.org>
	<7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
	<20070913035137.GM3099@spearce.org>
	<7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
	<20070914000108.GE3619@basalt.office.altlinux.org>
	<7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
	<20070914024303.GH3619@basalt.office.altlinux.org>
	<alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
	<alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
	<alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:36:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWFlx-0003Sn-WB
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbXINSUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXINSUF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:20:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbXINSUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 14:20:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D78D134BA4;
	Fri, 14 Sep 2007 14:20:19 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 14 Sep 2007 10:17:39 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58174>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For some inexplicable reason, "git diff" would call "diff_setup_done()" 
> iff we hadn't given an explicit output format.
>
> That makes no sense, since much of what diff_setup_done() does is exactly 
> about checking the output format!

We did not even have _any_ setup_done() call in "git diff"
itself in the original, because setup_revisions() has its own
call to setup_done(), and it always called setup_revisions()
before you reached that part of the code you have in your patch.
Commit 047fbe906b375e8a3a7564ad0e4443f62dd528a2 ("builtin-diff:
turn recursive on when defaulting to --patch format.") added the
call to setup_done() only when we are defaulting to output
format, to re-validate the consistency of output format options.

The screw-up was commit fcfa33ec905fcde1c16e7cbbe00d7147b89f1f01
(diff: make more cases implicit --no-index) that made the call
to setup_revisions() conditional if setup_diff_no_index()
decides to take over, but it forgot that setup_diff_no_index()
does not call setup_done().

So I tend to think the attached is a better fix.

---
 diff-lib.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f5568c3..da55713 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -298,6 +298,8 @@ int setup_diff_no_index(struct rev_info *revs,
 	revs->diffopt.nr_paths = 2;
 	revs->diffopt.no_index = 1;
 	revs->max_count = -2;
+	if (diff_setup_done(&revs->diffopt) < 0)
+		die("diff_setup_done failed");
 	return 0;
 }
 
