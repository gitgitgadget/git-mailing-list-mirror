From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/4] reset: use "unpack_trees()" directly instead of
 "git read-tree"
Date: Thu, 31 Dec 2009 23:03:06 -0800
Message-ID: <7vhbr6mhn9.fsf@alter.siamese.dyndns.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
 <20091230055448.4475.64716.chriscool@tuxfamily.org>
 <7vtyv6o18q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 08:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQbY1-0004fC-84
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 08:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab0AAHDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 02:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086Ab0AAHDe
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 02:03:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab0AAHDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 02:03:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6EE38D231;
	Fri,  1 Jan 2010 02:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=13glL3UGqONQCPeEM7eMAiTzYE0=; b=UN4eO0
	gUc85/Z9RpKtNN4bxwuH4CN+DyOYQSeyDYzw/JGjslauM6nUB6LHHmod+LjownQZ
	VbckBADM7yjlvFTJfKdY5H/YZBUErT7+TxR0VlkmJPnWHxD5jTlntGyd4PTAR6rc
	bxgv8Fu+R+KeCJh4tm6yrvaLaMiD722WJnMrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llZLRlWSL/8nrIVBpLVKq3QMEUTEbQIu
	QNT33behfZepwovnMYLLi+IetS5SZ8UyqXhtbvTqf1dexGemTE54WjgWrw04uG2R
	7agureq6M0nkw1xaz99gAfl2Qfy2cTd8Z5nrB1SpT0zMHpxFkqhT4XMLix0dCS1h
	84mNGzAkoDw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E374F8D22D;
	Fri,  1 Jan 2010 02:03:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF1788D22B; Fri,  1 Jan
 2010 02:03:07 -0500 (EST)
In-Reply-To: <7vtyv6o18q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 31 Dec 2009 21\:14\:29 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE3528B4-F6A3-11DE-8395-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136004>

Junio C Hamano <gitster@pobox.com> writes:

> At least disallowing means that the user _is notified_ and has to manually
> deal with the situation.  Pretending it succeeded by resetting only the
> index while still leaving the conflicted state in the work tree intact is
> a bit worse in that sense.
>
>> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
>> index c9044c9..b40999f 100644
>> --- a/Documentation/git-reset.txt
>> +++ b/Documentation/git-reset.txt
>> @@ -122,7 +122,7 @@ entries:
>>         X       U     A    B     --soft  (disallowed)
>>                                  --mixed  X       B     B
>>                                  --hard   B       B     B
>> -                                --merge (disallowed)
>> +                                --merge  X       B     B
>
> IOW, I think the result should be "B B B" instead of "X B B" in this
> case.

A squashable fix-up on top of your patch to match the wish in the part you
quoted from 9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01) would
look like this, I think.

It does three things:

 - Updates the documentation to match the wish of original "reset --merge"
   better, namely, "An unmerged entry is a sign that the path didn't have
   any local modification and can be safely resetted to whatever the new
   HEAD records";

 - Updates read_index_unmerged(), which reads the index file into the
   cache while dropping any higher-stage entries down to stage #0, not to
   copy the object name recorded in the cache entry.  The code used to
   take the object name from the highest stage entry ("theirs" if you
   happened to have stage #3, or "ours" if they removed while you kept),
   which essentially meant that you are getting random results and didn't
   make sense.

   The _only_ reason we want to keep a previously unmerged entry in the
   index at stage #0 is so that we don't forget the fact that we have
   corresponding file in the work tree in order to be able to remove it
   when the tree we are resetting to does not have the path.  In order to
   differentiate such an entry from ordinary cache entry, the cache entry
   added by read_index_unmerged() records null sha1.

 - Updates merged_entry() and deleted_entry() so that they pay attention to
   cache entries with null sha1 (note that we _might_ want to use a new
   in-core ce->ce_flags instead of using the null-sha1 hack).  They are
   previously unmerged entries, and the files in the work tree that
   correspond to them are resetted away by oneway_merge() to the version
   from the tree we are resetting to.

Please take this with a grain of salt as I am under slight influence of
CH3-CH2-OH while writing it, and I usually almost never drink.

---

 Documentation/git-reset.txt |    4 ++--
 read-cache.c                |    2 +-
 t/t7110-reset-merge.sh      |   14 +++++++-------
 unpack-trees.c              |   19 ++++++++++++-------
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index cf2433d..dc73dca 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -122,14 +122,14 @@ entries:
        X       U     A    B     --soft  (disallowed)
 				--mixed  X       B     B
 				--hard   B       B     B
-				--merge  X       B     B
+				--merge  B       B     B
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
        X       U     A    A     --soft  (disallowed)
 				--mixed  X       A     A
 				--hard   A       A     A
-				--merge (disallowed)
+				--merge  A       A     A
 
 X means any state and U means an unmerged index.
 
diff --git a/read-cache.c b/read-cache.c
index 1bbaf1c..616dd03 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1606,7 +1606,7 @@ int read_index_unmerged(struct index_state *istate)
 		len = strlen(ce->name);
 		size = cache_entry_size(len);
 		new_ce = xcalloc(1, size);
-		hashcpy(new_ce->sha1, ce->sha1);
+		/* don't copy sha1; this should not match anything */
 		memcpy(new_ce->name, ce->name, len);
 		new_ce->ce_flags = create_ce_flags(len, 0);
 		new_ce->ce_mode = ce->ce_mode;
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index ff2875c..249df7c 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -135,27 +135,27 @@ test_expect_success 'setup 2 different branches' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
-# file1:     X       U     B    C     --merge  X       C     C
+# file1:     X       U     B    C     --merge  C       C     C
 test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
     test_must_fail git merge branch1 &&
-    cat file1 >orig_file1 &&
     git reset --merge HEAD^ &&
     test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
     test -z "$(git diff --cached)" &&
-    test_cmp file1 orig_file1
+    test -z "$(git diff)"
 '
 
 # The next test will test the following:
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
-# file1:     X       U     B    B     --merge  (disallowed)
-test_expect_success '"reset --merge HEAD" fails with pending merge' '
+# file1:     X       U     B    B     --merge  B       B     B
+test_expect_success '"reset --merge HEAD" is ok with pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
-    test_must_fail git reset --merge HEAD &&
+    git reset --merge HEAD &&
     test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
-    test -n "$(git diff --cached)"
+    test -z "$(git diff --cached)" &&
+    test -z "$(git diff)"
 '
 
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index dd5999c..4a4d18c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -666,7 +666,11 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 {
 	int update = CE_UPDATE;
 
-	if (old) {
+	if (!old) {
+		if (verify_absent(merge, "overwritten", o))
+			return -1;
+		invalidate_ce_path(merge, o);
+	} else if (!is_null_sha1(old->sha1)) {
 		/*
 		 * See if we can re-use the old CE directly?
 		 * That way we get the uptodate stat info.
@@ -682,11 +686,12 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 				return -1;
 			invalidate_ce_path(old, o);
 		}
-	}
-	else {
-		if (verify_absent(merge, "overwritten", o))
-			return -1;
-		invalidate_ce_path(merge, o);
+	} else {
+		/*
+		 * Previously unmerged entry left as an existence
+		 * marker by read_index_unmerged();
+		 */
+		invalidate_ce_path(old, o);
 	}
 
 	add_entry(o, merge, update, CE_STAGEMASK);
@@ -702,7 +707,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 			return -1;
 		return 0;
 	}
-	if (verify_uptodate(old, o))
+	if (!is_null_sha1(old->sha1) && verify_uptodate(old, o))
 		return -1;
 	add_entry(o, ce, CE_REMOVE, 0);
 	invalidate_ce_path(ce, o);
