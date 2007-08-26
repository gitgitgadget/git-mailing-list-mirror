From: Jeff King <peff@peff.net>
Subject: Re: name-rev does not show the shortest path
Date: Sun, 26 Aug 2007 05:23:23 -0400
Message-ID: <20070826092323.GB30474@coredump.intra.peff.net>
References: <20070823103817.GF6573@informatik.uni-freiburg.de> <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk> <20070824125230.GA12030@informatik.uni-freiburg.de> <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk> <7v6434eq9o.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0708251701150.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 26 11:23:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPELc-0004iv-CW
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 11:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXHZJX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 05:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXHZJX1
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 05:23:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1173 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbXHZJX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 05:23:26 -0400
Received: (qmail 19711 invoked by uid 111); 26 Aug 2007 09:23:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Aug 2007 05:23:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Aug 2007 05:23:23 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708251701150.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56680>

On Sat, Aug 25, 2007 at 05:04:33PM +0200, Johannes Schindelin wrote:

> I briefly looked into this, and did not find out why it is behaving that 
> way.  It _should_ pick the closer one with this code:
> 
>         } else if (name->merge_traversals > merge_traversals ||
>                         (name->merge_traversals == merge_traversals &&
>                          name->generation > generation)) {
> 
> However, it did not even get to that code in my tests.  I'll have to look 
> at that problem closer in a quiet moment (which I will not have for at 
> least another 24 hours).

It does execute that code, just not for the rev in question. We hit the
third part of that conditional and stop recursing on a different rev, so
we only touch our "interesting" rev one time.

That being said, I think this test is totally bogus. You're just looking
at the generation and merge traversals from some tip. However, the tip
_isn't_ the actual ref, but instead gets re-written as a string when we
follow a merge. That string contains important generational information
that is no longer taken into account, so you end up with things like
"foo~999" with generation "3" is better than "bar~10" with generation
"5".

Here is a patch (below) that tracks an absolute "distance to ref" and at
least names the rev in question after v2.6.22-rc1. However, because it
is now preferring "distance to ref" strictly over merge traversals, it
seems to generate some obscenely long names:

0567a0c022d5b343370a343121f38fd89925de55 tags/v2.6.22-rc1~1^2^2^2~11^2~13^2~8^2~1^3~5

So perhaps there is a more sane metric, but I'd have to think about it
more.

-Peff

---
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 61eba34..c003e20 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -13,13 +13,14 @@ typedef struct rev_name {
 	const char *tip_name;
 	int merge_traversals;
 	int generation;
+	int distance;
 } rev_name;
 
 static long cutoff = LONG_MAX;
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, int merge_traversals, int generation,
-		int deref)
+		int deref, int distance)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
@@ -45,13 +46,16 @@ static void name_rev(struct commit *commit,
 		name = xmalloc(sizeof(rev_name));
 		commit->util = name;
 		goto copy_data;
-	} else if (name->merge_traversals > merge_traversals ||
-			(name->merge_traversals == merge_traversals &&
-			 name->generation > generation)) {
+	} else if (name->distance > distance ||
+			(name->distance == distance &&
+			 name->merge_traversals > merge_traversals ||
+			 (name->merge_traversals == merge_traversals &&
+			  name->generation > generation))) {
 copy_data:
 		name->tip_name = tip_name;
 		name->merge_traversals = merge_traversals;
 		name->generation = generation;
+		name->distance = distance;
 	} else
 		return;
 
@@ -75,10 +79,10 @@ copy_data:
 						parent_number);
 
 			name_rev(parents->item, new_name,
-				merge_traversals + 1 , 0, 0);
+				merge_traversals + 1 , 0, 0, distance + 1);
 		} else {
 			name_rev(parents->item, tip_name, merge_traversals,
-				generation + 1, 0);
+				generation + 1, 0, distance + 1);
 		}
 	}
 }
@@ -120,7 +124,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 		else if (!prefixcmp(path, "refs/"))
 			path = path + 5;
 
-		name_rev(commit, xstrdup(path), 0, 0, deref);
+		name_rev(commit, xstrdup(path), 0, 0, deref, 0);
 	}
 	return 0;
 }
