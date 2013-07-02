From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] fetch-pack: avoid quadratic list insertion in
 mark_complete
Date: Tue, 2 Jul 2013 02:16:23 -0400
Message-ID: <20130702061623.GA27856@sigill.intra.peff.net>
References: <20130702061149.GB1206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 08:16:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uttt2-0004NP-1F
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 08:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252Ab3GBGQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 02:16:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:54501 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932199Ab3GBGQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 02:16:16 -0400
Received: (qmail 20627 invoked by uid 102); 2 Jul 2013 06:17:25 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Jul 2013 01:17:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 02:16:23 -0400
Content-Disposition: inline
In-Reply-To: <20130702061149.GB1206@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229365>

We insert the commit pointed to by each ref one-by-one into
the "complete" commit_list using insert_by_date. Because
each insertion is O(n), we end up with O(n^2) behavior.

This typically doesn't matter, because the number of refs is
reasonably small. And even if there are a lot of refs, they
often point to a smaller set of objects (in which case the
optimization in commit ea5f220 keeps our "n" small).

However, in pathological repositories (hundreds of thousands
of refs, each pointing to a unique commit), this quadratic
behavior can make a difference. Since we do not care about
the list order until we have finished building it, we can
simply keep it unsorted during the insertion phase, then
sort it afterwards.

On a repository like the one described above, this dropped
the time to do a no-op fetch from 2.0s to 1.7s. On normal
repositories, it probably does not matter at all, but it
does not hurt to protect ourselves from pathological cases.

Signed-off-by: Jeff King <peff@peff.net>
---
A note on the timings. I measured the times above last year when I wrote
the same patch here:

  http://article.gmane.org/gmane.comp.version-control.git/194939

And earlier tonight, I did a fetch that showed the same result. But when
I tried to replicate it while writing the commit message, I had trouble,
because either:

  1. I was fetching actual commits, in which case the more serious
     problem behavior in find_common kicked in, ruining the measurement.

  2. It was a no-op fetch, in which case quickfetch() kicked in and we
     did not call mark_complete at all.

So I'm rather confused how I managed to get timings earlier (both last
year, and earlier today). But I still think it's an obviously correct
thing to do, and does protect us in case (1) above (actually fetching a
commit) once we fix the problem in find_common.

 fetch-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index abe5ffb..4df8abd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -505,7 +505,7 @@ static int mark_complete(const char *refname, const unsigned char *sha1, int fla
 		struct commit *commit = (struct commit *)o;
 		if (!(commit->object.flags & COMPLETE)) {
 			commit->object.flags |= COMPLETE;
-			commit_list_insert_by_date(commit, &complete);
+			commit_list_insert(commit, &complete);
 		}
 	}
 	return 0;
@@ -622,6 +622,7 @@ static int everything_local(struct fetch_pack_args *args,
 	if (!args->depth) {
 		for_each_ref(mark_complete, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
+		commit_list_sort_by_date(&complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
-- 
1.8.3.rc2.14.g7eee6b3
