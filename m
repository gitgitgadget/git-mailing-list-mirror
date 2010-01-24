From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #07; Fri, 22)
Date: Sun, 24 Jan 2010 00:10:20 -0800
Message-ID: <7vljfn9b4j.fsf@alter.siamese.dyndns.org>
References: <7vtyudfqju.fsf@alter.siamese.dyndns.org> <4B5B25C6.70604@web.de>
 <7v7hr8d1xg.fsf@alter.siamese.dyndns.org>
 <7veilg9rqp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 09:10:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYxYN-0000T1-Bx
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 09:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab0AXIKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 03:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005Ab0AXIKf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 03:10:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab0AXIKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 03:10:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2BCA928A3;
	Sun, 24 Jan 2010 03:10:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sWQyiu13U08ReFIFO6VFBV/7jMQ=; b=ddWngt
	r7x8L6c0GzGHkTCQFop+JG1FHfTTgv+VchB24PqFhYf9HCLTPN1XfvEnAk0xF0wR
	226x2hmpxVz/LcPa/XAihRYS6w2+G2DKuWQKEOlz0pq7mdk6LGI9JniWPwjVopj6
	+p+kMXD8YaM9JWzkJZFl7n4c0dH2hc4kDq9eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l50bMAqQuz+alwM7J3xE83rYEwUHi8Vw
	sAVQ4H9shR6wbVjmxk+7Cqw0iMZbY7ebRaTYmKwSMWD+IdH7vkJSVGpb8G2/Mll5
	+qUllONTOHGRL5Xjo6MPVojZlbdo3TQC/o/BVmN9QBiPk9iZNOkByxTKtn2tgY5Y
	YX0oK4a856c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE0E69289F;
	Sun, 24 Jan 2010 03:10:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5889289D; Sun, 24 Jan
 2010 03:10:21 -0500 (EST)
In-Reply-To: <7veilg9rqp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 23 Jan 2010 18\:11\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED4DF09E-08BF-11DF-B364-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137885>

Junio C Hamano <gitster@pobox.com> writes:

> I think we need to clarify the rule for ce_uptodate(ce).

A first step to do so may look like this.

-- >8 --
Subject: Make ce_uptodate() trustworthy again

The rule has always been that a cache entry that is ce_uptodate(ce)
means that we already have checked the work tree entity and we know
there is no change in the work tree compared to the index, and nobody
should have to double check.  Note that false ce_uptodate(ce) does not
mean it is known to be dirty---it only means we don't know if it is
clean.

There are a few codepaths (refresh-index and preload-index are among
them) that mark a cache entry as up-to-date based solely on the return
value from ie_match_stat(); this function uses lstat() to see if the
work tree entity has been touched, and for a submodule entry, if its
HEAD points at the same commit as the commit recorded in the index of
the superproject (a submodule that is not even cloned is considered
clean).

A submodule is no longer considered unmodified merely because its HEAD
matches the index of the superproject these days, in order to prevent
people from forgetting to commit in the submodule and updating the
superproject index with the new submodule commit, before commiting the
state in the superproject.  However, the patch to do so didn't update
the codepath that marks cache entries up-to-date based on the updated
definition and instead worked it around by saying "we don't trust the
return value of ce_uptodate() for submodules."

This makes ce_uptodate() trustworthy again by not marking submodule
entries up-to-date.

The next step _could_ be to introduce a few "in-core" flag bits to
cache_entry structure to record "this entry is _known_ to be dirty",
call is_submodule_modified() from ie_match_stat(), and use these new
bits to avoid running this rather expensive check more than once, but
that can be a separate patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c      |    2 +-
 preload-index.c |    2 ++
 read-cache.c    |    6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 23e180e..c6c425e 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -161,7 +161,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 
-		if ((ce_uptodate(ce) && !S_ISGITLINK(ce->ce_mode)) || ce_skip_worktree(ce))
+		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
 
 		/* If CE_VALID is set, don't look at workdir for file removal */
diff --git a/preload-index.c b/preload-index.c
index 9289933..e3d0bda 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -47,6 +47,8 @@ static void *preload_thread(void *_data)
 
 		if (ce_stage(ce))
 			continue;
+		if (S_ISGITLINK(ce->ce_mode))
+			continue;
 		if (ce_uptodate(ce))
 			continue;
 		if (!ce_path_match(ce, p->pathspec))
diff --git a/read-cache.c b/read-cache.c
index 79938bf..309b77a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -612,7 +612,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
-		ce_mark_uptodate(alias);
+		if (!S_ISGITLINK(alias->ce_mode))
+			ce_mark_uptodate(alias);
 		alias->ce_flags |= CE_ADDED;
 		return 0;
 	}
@@ -1050,7 +1051,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 			 * because CE_UPTODATE flag is in-core only;
 			 * we are not going to write this change out.
 			 */
-			ce_mark_uptodate(ce);
+			if (!S_ISGITLINK(ce->ce_mode))
+				ce_mark_uptodate(ce);
 			return ce;
 		}
 	}
