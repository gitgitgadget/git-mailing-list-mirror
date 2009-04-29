From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: different git-merge behavior with regard to submodules in
	1.6.2.4 vs. 1.6.2.1
Date: Wed, 29 Apr 2009 10:42:09 +0200
Message-ID: <20090429084209.GA24064@localhost>
References: <gt7err$3m4$1@ger.gmane.org> <7v4ow8my1u.fsf@gitster.siamese.dyndns.org> <20090428211257.GA31191@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 10:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz5O9-00088o-Kx
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 10:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbZD2Ims (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbZD2Imr
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 04:42:47 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:6518 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbZD2Imq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 04:42:46 -0400
Received: from darc.dyndns.org ([84.154.45.219]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Apr 2009 10:42:41 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Lz5Mn-0000N5-Bo; Wed, 29 Apr 2009 10:42:09 +0200
Content-Disposition: inline
In-Reply-To: <20090428211257.GA31191@pvv.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 29 Apr 2009 08:42:43.0664 (UTC) FILETIME=[76991500:01C9C8A6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117869>

From: Clemens Buchacher <drizzd@aon.at>
Date: Tue, 28 Apr 2009 21:16:02 +0200
Subject: [PATCH] fix recursive merge with submodule add/add conflict

In case of a submodule we should not attempt to update the working
copy, but we do have to update the index.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Tue, Apr 28, 2009 at 11:12:57PM +0200, Finn Arne Gangstad wrote:
> On Tue, Apr 28, 2009 at 11:29:49AM -0700, Junio C Hamano wrote:
> > Tim Olsen <tim@brooklynpenguin.com> writes:
> > 
> > > $ git merge origin/deployed
> > > fatal: cannot read object 83055ffdddde60d41d9811aae77e78be50b329f8
> > > 'rubydav': It is a submodule!

> The current error message is not an improvement I think, it should say
> that merge does not support merging submodules, not complain about
> being unable to read some object because it is a submodule.

The fatal error is indeed caused by 0eb6574 (update cache for conflicting
submodule entries). The problem is also documented by t7405. The test
exposes a problem even previous to this commit, wherein "git diff" aborts
with

	fatal: read error 'sub'

which is why I thought this was broken anyways. Only I see now that I have
made things worse.

The appended patch should fix both problems for now. I'm still not satisfied
with the result, because the conflicting submodule path is not marked as
unmerged. I modified t7405 to reflect this failure. I think we should be
able to handle this in the same way we handle symlinks.

> I added the "CONFLICT (submodule) Merge conflict .. needs <SHA-1>"
> messages when I tried to work with submodules a while (1-2 years?)
> ago.  The intention was that you could enter the submodule(s), write
> "git merge <SHA-1>", and resolve the conflict that way.

I think you should get that information from git diff instead.

> git is unfortunately not capable of merging submodules at all, so I
> added these error messages to give me a hint about what I needed to do
> in conflicting submodules to get something useful. I have used git a
> lot more now, so maybe it is time to pick this up again and implement
> proper recursive sub-module merging.

Are you sure it's always the right thing to merge conflicting submodule
versions? The user could easily commit two versions, which you would never
want merge -- due to changed history, for example. On the other hand, if a
fast-forward merge is possible I suppose this could be considered a
non-conflicting change.

Clemens
---
 merge-recursive.c          |   11 ++++++-----
 t/t7405-submodule-merge.sh |    3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d6f0582..b14b3fe 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1116,13 +1116,14 @@ static int process_entry(struct merge_options *o,
 				 o->branch1, o->branch2);
 
 		clean_merge = mfi.clean;
-		if (!mfi.clean) {
-			if (S_ISGITLINK(mfi.mode))
-				reason = "submodule";
+		if (S_ISGITLINK(mfi.mode)) {
+			reason = "submodule";
+			add_cacheinfo(mfi.mode, mfi.sha, path, 0, 0, ADD_CACHE_OK_TO_ADD);
+		} else
+			update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
+		if (!mfi.clean)
 			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 					reason, path);
-		}
-		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
 	} else if (!o_sha && !a_sha && !b_sha) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index aa6c44c..b881370 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -59,7 +59,8 @@ test_expect_failure 'merging with modify/modify conflict' '
 	git checkout -b test1 a &&
 	test_must_fail git merge b &&
 	test -f .git/MERGE_MSG &&
-	git diff
+	git diff &&
+	test -n "`git ls-files -u`"
 
 '
 
-- 
1.6.3.rc2
