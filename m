From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] branch: show upstream branch when double verbose
Date: Mon, 13 Apr 2009 04:34:14 -0400
Message-ID: <20090413083413.GB9846@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407071656.GE2924@coredump.intra.peff.net> <49DB089A.7080207@drmicha.warpmail.net> <20090409082350.GD17221@coredump.intra.peff.net> <adf1fd3d0904090315x10b8c481g311832c40c450c47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 10:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtHdt-0006t9-MM
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 10:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbZDMIeQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 04:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZDMIeP
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 04:34:15 -0400
Received: from peff.net ([208.65.91.99]:46556 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbZDMIeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 04:34:15 -0400
Received: (qmail 30893 invoked by uid 107); 13 Apr 2009 08:34:17 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 04:34:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 04:34:14 -0400
Content-Disposition: inline
In-Reply-To: <adf1fd3d0904090315x10b8c481g311832c40c450c47@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116419>

On Thu, Apr 09, 2009 at 12:15:08PM +0200, Santi B=C3=A9jar wrote:

> I've been thinking about this and both formats seems OK for me,
> although using the +5 -6 format for just -v seems a good point.

The trivial patch for this is below:

---
diff --git a/builtin-branch.c b/builtin-branch.c
index 3275821..c056a4d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -317,14 +317,14 @@ static void fill_tracking_info(struct strbuf *sta=
t, const char *branch_name,
=20
 	strbuf_addch(stat, '[');
 	if (show_upstream_ref)
-		strbuf_addf(stat, "%s: ",
+		strbuf_addf(stat, "%s ",
 			shorten_unambiguous_ref(branch->merge[0]->dst));
 	if (!ours)
-		strbuf_addf(stat, "behind %d] ", theirs);
+		strbuf_addf(stat, "-%d] ", theirs);
 	else if (!theirs)
-		strbuf_addf(stat, "ahead %d] ", ours);
+		strbuf_addf(stat, "+%d] ", ours);
 	else
-		strbuf_addf(stat, "ahead %d, behind %d] ", ours, theirs);
+		strbuf_addf(stat, "+%d -%d] ", ours, theirs);
 }
=20
 static int matches_merge_filter(struct commit *commit)


I actually think it looks a bit ugly without the upstream name, as the
short bit in brackets blends in with the commit subject:

  next        1412037 [+2] shorter tracking format for branch -v

whereas I think this is better:

  next        1412037 [origin/next +2] shorter tracking format for bran=
ch -v

but I am still lukewarm on the concept personally (i.e., I am not
opposed, but I am not taking it further than the "how about this" patch
below, so if somebody thinks it is a good idea they should speak up and
advocate for it).

> Just to bikeshed a bit more :) we could use a format more similar to
> the "git fetch" output, like:
>=20
>   next         c4628f8 [4...6 origin/next] Merge branch 'jk/no-perl' =
into next
>   next         c4628f8 [4.. origin/next] Merge branch 'jk/no-perl' in=
to next
>   next         c4628f8 [..6 origin/next] Merge branch 'jk/no-perl' in=
to next

Personally, I find that pretty ugly, and a bit confusing. The ".."
notation would make more sense if there were actual revisions on the en=
d
and not numbers. But then of course you have to show the numbers
separately. Something like this makes at least has some logic to it:

  origin/next...next: 4,6
  origin/next..next: 4
  next..origin/next: 6

but it looks horribly ugly and is way more confusing than it needs to
be.

-Peff
