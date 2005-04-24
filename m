From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] Add some functions for commit lists
Date: Sat, 23 Apr 2005 19:12:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231906110.2344@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504232003490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 04:06:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPWVm-0006mh-Ba
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 04:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVDXCKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 22:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVDXCKx
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 22:10:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:47340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262227AbVDXCKo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 22:10:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O2Ads4025300
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 19:10:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O2AcAq025798;
	Sat, 23 Apr 2005 19:10:39 -0700
To: Daniel Barkalow <barkalow@iabervon.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504232003490.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Daniel Barkalow wrote:
>
> This adds a function for inserting an item in a commit list, a function
> for sorting a commit list by date, and a function for progressively
> scanning a commit history from most recent to least recent.

Ok. This is more in like with what I was hoping for, looks good.

All patches applied and pushed out, and I wrote a trivial "rev-list" thing 
that is kind of a cut-down rev-tree which just lists the commits in the 
order the "fake time order".

The "fake time order" just uses this progressive commit history scan, 
which is different from the old "sort by date" in that it still takes 
parenthood into account, and always shows the child first.

It turns out that since git is so damn fast, when I commit a mbox of 
patches, they often all get the same date, since we "only" do dates with a 
one-second granularity. So sorting by date ends up doing strange things, 
when some of the entries have no sort order.

Daniel's date-based incremental scanning solves this problem, and also 
means that we get output immediately without having to parse the whole 
tree down to the root.

So with this, git-pasky should probably do the following..

			Linus

-
Make gitlog.sh use the new simple time-based commit traversal
helpers.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

gitlog.sh: a496a864f9586e47a4d7bd3ae0af0b3e07b7deb8
--- a/gitlog.sh
+++ b/gitlog.sh
@@ -11,7 +11,7 @@
 
 base=$(gitXnormid.sh -c $1) || exit 1
 
-rev-tree $base | sort -rn | while read time commit parents; do
+rev-list $base | while read commit; do
 	echo commit ${commit%:*};
 	cat-file commit $commit | \
 		while read key rest; do
