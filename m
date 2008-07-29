From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT 1.6.0-rc1
Date: Tue, 29 Jul 2008 01:13:44 -0700
Message-ID: <7v4p69jefb.fsf@gitster.siamese.dyndns.org>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
 <20080728063838.GB4234@blimp.local>
 <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
 <20080728213727.GA3721@blimp.local>
 <7vr69dky93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:15:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkME-0001U1-J0
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbYG2IN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbYG2IN4
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:13:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbYG2INy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:13:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 019A743E10;
	Tue, 29 Jul 2008 04:13:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E198A43E0F; Tue, 29 Jul 2008 04:13:46 -0400 (EDT)
In-Reply-To: <7vr69dky93.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 28 Jul 2008 23:20:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4652CCFE-5D46-11DD-94E5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90596>

Junio C Hamano <gitster@pobox.com> writes:

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Junio C Hamano, Mon, Jul 28, 2008 08:44:52 +0200:
>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>> 
>>> > t2103-update-index-ignore-missing.sh still broken on Windows because
>>> > of stat.st_size being 0 for directories there.
>>> 
>>> I recall we did not reach a useful conclusion of that discussion.
>>
>> Why isn't the proposed patch useful? (and would it be possible to make
>> the answer out of plain, small and short words?)
>
> Can you answer out of plain, small and short words why the proposed patch
> is correct without unwanted side effects, not just "this seems to solve
> the particular issue for me but I don't know if it has unintended side
> effects"?

Ok, I took a deeper look at the codepaths involved.  Although it does work
around the issue, I do not think your patch alone is the "correct" one in
the longer term.

It needs a bit of explanation, and the explanation won't be exactly
"plain, small and short", unfortunately.

-- >8 --
[PATCH] Teach gitlinks to ie_modified() and ce_modified_check_fs()

The ie_modified() function is the workhorse for refresh_cache_entry(),
i.e. checking if an index entry that is stat-dirty actually has changes.

After running quicker check to compare cached stat information with
results from the latest lstat(2) to answer "has modification" early, the
code goes on to check if there really is a change by comparing the staged
data with what is on the filesystem by asking ce_modified_check_fs().
However, this function always said "no change" for any gitlinks that has a
directory at the corresponding path.  This made ie_modified() to miss
actual changes in the subproject.

The patch fixes this first by modifying an existing short-circuit logic
before calling the ce_modified_check_fs() function.  It knows that for any
filesystem entity to which ie_match_stat() says its data has changed, if
its cached size is nonzero then the contents cannot match, which is a
correct optimization only for blob objects.  We teach gitlink objects to
this special case, as we already know that any gitlink that
ie_match_stat() says is modified is indeed modified at this point in the
codepath.

With the above change, we could leave ce_modified_check_fs() broken, but
it also futureproofs the code by teaching it to use ce_compare_gitlink(),
instead of assuming (incorrectly) that any directory is unchanged.

Originally noticed by Alex Riesen on Cygwin.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b5916b0..a940f8d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -152,7 +152,7 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 		break;
 	case S_IFDIR:
 		if (S_ISGITLINK(ce->ce_mode))
-			return 0;
+			return ce_compare_gitlink(ce) ? DATA_CHANGED : 0;
 	default:
 		return TYPE_CHANGED;
 	}
@@ -192,6 +192,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 			changed |= TYPE_CHANGED;
 		break;
 	case S_IFGITLINK:
+		/* We ignore most of the st_xxx fields for gitlinks */
 		if (!S_ISDIR(st->st_mode))
 			changed |= TYPE_CHANGED;
 		else if (ce_compare_gitlink(ce))
@@ -298,11 +299,22 @@ int ie_modified(const struct index_state *istate,
 	if (changed & (MODE_CHANGED | TYPE_CHANGED))
 		return changed;
 
-	/* Immediately after read-tree or update-index --cacheinfo,
-	 * the length field is zero.  For other cases the ce_size
-	 * should match the SHA1 recorded in the index entry.
+	/*
+	 * Immediately after read-tree or update-index --cacheinfo,
+	 * the length field is zero, as we have never even read the
+	 * lstat(2) information once, and we cannot trust DATA_CHANGED
+	 * returned by ie_match_stat() which in turn was returned by
+	 * ce_match_stat_basic() to signal that the filesize of the
+	 * blob changed.  We have to actually go to the filesystem to
+	 * see if the contents match, and if so, should answer "unchanged".
+	 *
+	 * The logic does not apply to gitlinks, as ce_match_stat_basic()
+	 * already has checked the actual HEAD from the filesystem in the
+	 * subproject.  If ie_match_stat() already said it is different,
+	 * then we know it is.
 	 */
-	if ((changed & DATA_CHANGED) && ce->ce_size != 0)
+	if ((changed & DATA_CHANGED) &&
+	    (S_ISGITLINK(ce->ce_mode) || ce->ce_size != 0))
 		return changed;
 
 	changed_fs = ce_modified_check_fs(ce, st);
@@ -1331,6 +1343,11 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 	 * falsely clean entry due to touch-update-touch race, so we leave
 	 * everything else as they are.  We are called for entries whose
 	 * ce_mtime match the index file mtime.
+	 *
+	 * Note that this actually does not do much for gitlinks, for
+	 * which ce_match_stat_basic() always goes to the actual
+	 * contents.  The caller checks with is_racy_timestamp() which
+	 * always says "no" for gitlinks, so we are not called for them ;-)
 	 */
 	struct stat st;
 
