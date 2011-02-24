From: Jeff King <peff@peff.net>
Subject: Re: new behaviour in git merge
Date: Thu, 24 Feb 2011 06:52:33 -0500
Message-ID: <20110224115233.GA31356@sigill.intra.peff.net>
References: <20110224143353.ddaa316a.sfr@canb.auug.org.au>
 <20110224081553.GD25595@sigill.intra.peff.net>
 <20110224202454.d3b8668e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Thu Feb 24 12:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsZkQ-0006Pb-68
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 12:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab1BXLwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 06:52:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48769 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab1BXLwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 06:52:35 -0500
Received: (qmail 21979 invoked by uid 111); 24 Feb 2011 11:52:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 11:52:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 06:52:33 -0500
Content-Disposition: inline
In-Reply-To: <20110224202454.d3b8668e.sfr@canb.auug.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167800>

[+cc Elijah Newren; this is a bug that bisects to one of your commits.
 The backstory is that during a merge, many unrelated files get
 unnecessarily re-written with the same content. Read on for details.]

On Thu, Feb 24, 2011 at 08:24:54PM +1100, Stephen Rothwell wrote:

> In today's linux-next tree (available at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git),
> commit ad11c1e8abca18872c2993b09b1abde418955b6c is just before the merge
> and commit a2c06ee2fe5b48a71e697bae00c6e7195fc016b6 is what was merged.
> 
> I just did this in a copy of my tree:
> 
> 	git reset --hard ad11c1e8abca18872c2993b09b1abde418955b6c
> 	sleep 90
> 	git merge a2c06ee2fe5b48a71e697bae00c6e7195fc016b6
> 
> A comparison of the ls -lR ouput before and after showed a lot of changed
> modification times.
> 
> Several other merges showed the same problem.

Thanks for the reproduction recipe. I was able to bisect using this
script as my test:

-- >8 --
#!/bin/sh

stat() {
  git ls-files -z | xargs --null stat --format='%Y %n' | sort
}

cd linux-next &&
git reset --hard ad11c1e8abca18872c2993b09b1abde418955b6c &&
sleep 3 &&
stat >before &&
git merge a2c06ee2fe5b48a71e697bae00c6e7195fc016b6 &&
stat >after &&
comm -13 before after | cut -d' ' -f2 | sort >stat-diff &&
git diff-tree -r --name-only HEAD HEAD^ >tree-diff &&
comm -23 stat-diff tree-diff >extra-stats &&
if test -s extra-stats; then
  cat extra-stats
  echo FAIL
  exit 1
else
  echo OK
  exit 0
fi
-- 8< --

It bisects to 882fd11 (merge-recursive: Delay content merging for
renames, 2010-09-20). And indeed, looking further at the files that get
modified, they appear to be renames on one side of the merge, but not
touched on the other side. But rather than notice that there is nothing
to be done on them, we seem to update the index and write out the new
entries.

The patch below makes the problem go away in your test case, but also
introduces some test failures in t3509, so I'm sure there is something
else going on. I'm somewhat clueless about the merge code, so I'll defer
to Elijah, who wrote 882fd11, and see what he says.

-Peff

diff --git a/merge-recursive.c b/merge-recursive.c
index 0ca54bd..1dd643f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1083,7 +1083,8 @@ static int process_renames(struct merge_options *o,
 					b = ren1->pair->two;
 					a = &src_other;
 				}
-				update_stages_and_entry(ren1_dst, ren1->dst_entry, one, a, b, 1);
+				if (hashcmp(one->sha1, b->sha1))
+					update_stages_and_entry(ren1_dst, ren1->dst_entry, one, a, b, 1);
 				if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
 					setup_rename_df_conflict_info(RENAME_NORMAL,
 								      ren1->pair,
