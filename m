From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/16] pack-objects: use a faster hash table
Date: Wed, 26 Jun 2013 00:47:52 -0400
Message-ID: <20130626044752.GA26755@sigill.intra.peff.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-4-git-send-email-tanoku@gmail.com>
 <87a9mdnae3.fsf@linux-k42r.v.cablecom.net>
 <20130626021417.GB21212@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 26 06:48:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrheB-0004jG-N0
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 06:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3FZEr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 00:47:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:54203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab3FZErz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 00:47:55 -0400
Received: (qmail 4585 invoked by uid 102); 26 Jun 2013 04:48:59 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Jun 2013 23:48:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2013 00:47:52 -0400
Content-Disposition: inline
In-Reply-To: <20130626021417.GB21212@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229027>

On Tue, Jun 25, 2013 at 10:14:17PM -0400, Jeff King wrote:

> So I suspect two things (but as I said, haven't verified):
> 
>   1. You could speed up pack-objects just by keeping the table half full
>      rather than 3/4 full.

I wasn't able to show any measurable speedup with this. I tried to make
as specific a measurement as I could, by adding a "counting only" option
like this:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fc12df8..a0438d0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2452,6 +2452,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	const char *rp_av[6];
 	int rp_ac = 0;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
+	int counting_only = 0;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -2515,6 +2516,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
 			    N_("do not hide commits by grafts"), 0),
+		OPT_BOOL(0, "counting-only", &counting_only,
+			 N_("exit after counting objects phase")),
 		OPT_END(),
 	};
 
@@ -2600,6 +2603,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
 
+	if (counting_only)
+		return 0;
 	if (non_empty && !nr_result)
 		return 0;
 	if (nr_result)

and even doing the whole object traversal ahead of time to just focus on
the object-entry hash, like this:

  git rev-list --objects --all >objects.out
  time git pack-objects --counting-only --stdout <objects.out

Tweaking the hash size didn't have any effect, but using Vicent's khash
patch actually made it about 5% slower. So I wonder if I'm even
measuring the right thing. Vicent, how did you get the timings you
showed in the commit message?

-Peff
