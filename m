From: Junio C Hamano <gitster@pobox.com>
Subject: Re* Change in "git checkout" behaviour between 1.6.0.2 and 1.6.0.3
Date: Wed, 12 Nov 2008 11:52:35 -0800
Message-ID: <7vfxlwoh6k.fsf_-_@gitster.siamese.dyndns.org>
References: <80wsf9ovsp.fsf@tiny.isode.net>
 <491B131D.2050501@drmicha.warpmail.net> <80r65gon3m.fsf@tiny.isode.net>
 <7vprl0oiw6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Ln6-0007NR-Kp
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbYKLTxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbYKLTxA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:53:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbYKLTw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:52:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 451527C13C;
	Wed, 12 Nov 2008 14:52:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 86AFC7C133; Wed,
 12 Nov 2008 14:52:42 -0500 (EST)
In-Reply-To: <7vprl0oiw6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 12 Nov 2008 11:15:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80A31746-B0F3-11DD-A148-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100811>

Junio C Hamano <gitster@pobox.com> writes:

>> Looks like a deliberate change with (what seems to me to be) an
>> unfortunate interaction with "git clone -n"
>
> Yeah, it was meant to allow:
>
> 	git clone -n $there $here
>         cd $here
>         git checkout
>
> and was not taking care of the case to switch branches when the initial
> checkout is made.
>
> Perhaps this would help.
> ...

Here is a more involved but hopefully more maintainable fix.

-- >8 --
Subject: checkout: Fix "initial checkout" detection

Earlier commit 5521883 (checkout: do not lose staged removal, 2008-09-07)
tightened the rule to prevent switching branches from losing local
changes, so that staged removal of paths can be protected, while
attempting to keep a loophole to still allow a special case of switching
out of an un-checked-out state.

However, the loophole was made a bit too tight, and did not allow
switching from one branch (in an un-checked-out state) to check out
another branch.

The change to builtin-checkout.c in this commit loosens it to allow this,
by not insisting the original commit and the new commit to be the same.

It also introduces a new function, is_index_unborn (and an associated
macro, is_cache_unborn), to check if the repository is truly in an
un-checked-out state more reliably, by making sure that $GIT_INDEX_FILE
did not exist when populating the in-core index structure.  A few places
the earlier commit 5521883 added the check for the initial checkout
condition are updated to use this function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c  |    3 +--
 builtin-read-tree.c |    2 +-
 cache.h             |    2 ++
 read-cache.c        |    5 +++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git c/builtin-checkout.c w/builtin-checkout.c
index 05eee4e..25845cd 100644
--- c/builtin-checkout.c
+++ w/builtin-checkout.c
@@ -269,8 +269,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		}
 
 		/* 2-way merge to the new branch */
-		topts.initial_checkout = (!active_nr &&
-					  (old->commit == new->commit));
+		topts.initial_checkout = is_cache_unborn();
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge;
diff --git c/builtin-read-tree.c w/builtin-read-tree.c
index 0706c95..38fef34 100644
--- c/builtin-read-tree.c
+++ w/builtin-read-tree.c
@@ -206,7 +206,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			break;
 		case 2:
 			opts.fn = twoway_merge;
-			opts.initial_checkout = !active_nr;
+			opts.initial_checkout = is_cache_unborn();
 			break;
 		case 3:
 		default:
diff --git c/cache.h w/cache.h
index a1e4982..3960931 100644
--- c/cache.h
+++ w/cache.h
@@ -255,6 +255,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
+#define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
 #define write_cache(newfd, cache, entries) write_index(&the_index, (newfd))
 #define discard_cache() discard_index(&the_index)
@@ -360,6 +361,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_from(struct index_state *, const char *path);
+extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 extern int write_index(const struct index_state *, int newfd);
 extern int discard_index(struct index_state *);
diff --git c/read-cache.c w/read-cache.c
index 967f483..525d138 100644
--- c/read-cache.c
+++ w/read-cache.c
@@ -1239,6 +1239,11 @@ unmap:
 	die("index file corrupt");
 }
 
+int is_index_unborn(struct index_state *istate)
+{
+	return (!istate->cache_nr && !istate->alloc && !istate->timestamp);
+}
+
 int discard_index(struct index_state *istate)
 {
 	istate->cache_nr = 0;
