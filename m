From: Jeff King <peff@peff.net>
Subject: Re: name-rev does not show the shortest path
Date: Mon, 27 Aug 2007 05:24:23 -0400
Message-ID: <20070827092422.GA20340@coredump.intra.peff.net>
References: <20070823103817.GF6573@informatik.uni-freiburg.de> <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk> <20070824125230.GA12030@informatik.uni-freiburg.de> <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk> <7v6434eq9o.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0708251701150.16728@wbgn129.biozentrum.uni-wuerzburg.de> <20070826092323.GB30474@coredump.intra.peff.net> <Pine.LNX.4.64.0708261733400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaph-00049B-Al
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 11:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbXH0JY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 05:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbXH0JY0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 05:24:26 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4867 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbXH0JYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 05:24:25 -0400
Received: (qmail 29814 invoked by uid 111); 27 Aug 2007 09:24:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 27 Aug 2007 05:24:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2007 05:24:23 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708261733400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56793>

On Sun, Aug 26, 2007 at 05:38:22PM +0200, Johannes Schindelin wrote:

> > that is no longer taken into account, so you end up with things like
> > "foo~999" with generation "3" is better than "bar~10" with generation
> > "5".
> 
> But this did not happen here, right?  Just the first part was different...

Yes, in this case, I think the process is stopping because the
generations and merge traversals are the same for two paths, but the
'tip_name' information is indicating a much larger generational
difference from a ref. For example, "tags/v2.6.22-rc1~1131^2" loses out
to "tags/v2.6.22~1808^2", which seems very wrong.

I found it informative to instrument the code like this:

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 61eba34..9830595 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -41,19 +41,26 @@ static void name_rev(struct commit *commit,
 			die("generation: %d, but deref?", generation);
 	}
 
+	printf("considering %s~%d\n", tip_name, generation);
 	if (name == NULL) {
 		name = xmalloc(sizeof(rev_name));
 		commit->util = name;
+		printf("  better than NULL\n");
 		goto copy_data;
 	} else if (name->merge_traversals > merge_traversals ||
 			(name->merge_traversals == merge_traversals &&
 			 name->generation > generation)) {
+		printf("  better than %s~%d\n",
+				name->tip_name, name->generation);
 copy_data:
 		name->tip_name = tip_name;
 		name->merge_traversals = merge_traversals;
 		name->generation = generation;
-	} else
+	} else {
+		printf("  not as good as %s~%d\n",
+				name->tip_name, name->generation);
 		return;
+	}
 
 	for (parents = commit->parents;
 			parents;


> The old code _should_ have worked; it is more likely that your different 
> metric just hides the bug.  The old metric tried to favour less merge 
> traversals over more traversals, but at the same time, it favoured smaller 
> numbers over larger ones (but as you found out, only in the last 
> component).

Right, the problem is that we have effectively _thrown away_ the
"smaller numbers over larger ones" information for components other than
the last. I wonder if what we really want is to maintain a list of
generations, one per merge traversal.

So that foo~500^2~20 and bar~499^2~20 would be represented as:

  [500, 21]
  [499, 21]

And then you could compare names by favoring smaller numbers in earlier
traversals (you could still use "fewer merge traversals" as a metric
before that, as well).

> I guess there is something else going on, such as the tag v2.6.22-rc1 
> being marked uninteresting because v2.6.22 and its ancestors being 
> traversed already.

I don't think that is the case; it tries to name quite a few revs based
on v2.6.22-rc1, but they lose out to existing names given when
traversing from v2.6.22.

-Peff
