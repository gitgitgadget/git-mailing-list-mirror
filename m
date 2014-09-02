From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] cache-tree: do not try to use an invalidated subtree info to build a tree
Date: Tue, 02 Sep 2014 15:39:04 -0700
Message-ID: <xmqqvbp5y7ef.fsf_-_@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<20140831120703.GA1240@serenity.lan>
	<xmqqfvg9zqw9.fsf@gitster.dls.corp.google.com>
	<xmqq8um1zq1q.fsf@gitster.dls.corp.google.com>
	<xmqq4mwpzpfw.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 00:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOwjS-00066n-4H
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 00:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbaIBWjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 18:39:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55705 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308AbaIBWjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 18:39:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FA6B370BA;
	Tue,  2 Sep 2014 18:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3WcwUBRBuCsjzlfDzU5qBhv/yxU=; b=qVAozv
	rlERTrC18kB/KWm8Hmbx6LPN18HIpOMz8GtC71ktGrdVTj/AxIodhXAnUVIDp98P
	gD8HzSbQFTJ2G6ZMMebb7xNEHFRH0A40wxhQv7PlS7kd8IFY9D+Ql2O9AlfzeHur
	8AikLMZydsq1TlnE+KUTlBI91U1/G+Rikc86Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ORZ8i4boklfXd0rHi5f1n1sgOZHsK4ys
	00BzTRfntT5b3LAJgBOqWb7wLmBovAJjHL+E19YRzsigdVWIEVqHkCkVeR38utvV
	FsvIZY2OISzic95vD+bzgungYhbrmj0gnJlm/NkpiUfv3CthHHwMfqklYxZaov1i
	DSs31qyWL30=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24CD9370B9;
	Tue,  2 Sep 2014 18:39:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B3E6370B2;
	Tue,  2 Sep 2014 18:39:06 -0400 (EDT)
In-Reply-To: <xmqq4mwpzpfw.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Tue, 02 Sep 2014 14:24:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F2658360-32F1-11E4-8D14-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256372>

We punt from repairing the cache-tree during a branch switching if
it involves having to create a new tree object that does not yet
exist in the object store.  "mkdir dir && >dir/file && git add dir"
followed by "git checkout" is one example, when a tree that records
the state of such "dir/" is not in the object store.

However, after discovering that we do not have a tree object that
records the state of "dir/", the caller failed to remember the fact
that it noticed the cache-tree entry it received for "dir/" is
invalidated, it already knows it should not be populating the level
callchain to stop the code to attempt populating the level that has
"dir/" as its immediate subdirectory, and it is not an error at all
for the sublevel cache-tree entry gave it a bogus object name it
shouldn't even look at.

This led the caller detect and report a non-existent error.  The end
result was the same and we avoided stuffing a non-existent tree to
the cache-tree, but we shouldn't have issued an alarming error
message to the user.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Second try.  The level that has intent-to-add entries needs to be
   kept invalidated but the level above it needs to treat as if the
   i-t-a entries do not exist and build the whole tree; a directory
   that does not yet have corresponding tree object while repairing
   the cache-tree needs to invalidate itself *and* propagate the
   (in)validity upwards.  They have to be treated differently but
   the first attempt failed to do so.

 cache-tree.c          | 7 ++++++-
 t/t0090-cache-tree.sh | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index f951d7d..57597ac 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -316,6 +316,7 @@ static int update_one(struct cache_tree *it,
 		int pathlen, entlen;
 		const unsigned char *sha1;
 		unsigned mode;
+		int expected_missing = 0;
 
 		path = ce->name;
 		pathlen = ce_namelen(ce);
@@ -332,8 +333,10 @@ static int update_one(struct cache_tree *it,
 			i += sub->count;
 			sha1 = sub->cache_tree->sha1;
 			mode = S_IFDIR;
-			if (sub->cache_tree->entry_count < 0)
+			if (sub->cache_tree->entry_count < 0) {
 				to_invalidate = 1;
+				expected_missing = 1;
+			}
 		}
 		else {
 			sha1 = ce->sha1;
@@ -343,6 +346,8 @@ static int update_one(struct cache_tree *it,
 		}
 		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
 			strbuf_release(&buffer);
+			if (expected_missing)
+				return -1;
 			return error("invalid object %06o %s for '%.*s'",
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
 		}
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 48c4240..f9648a8 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -210,4 +210,12 @@ test_expect_success 'partial commit gives cache-tree' '
 	test_cache_tree
 '
 
+test_expect_success 'no phantom error when switching trees' '
+	mkdir newdir &&
+	>newdir/one &&
+	git add newdir/one &&
+	git checkout 2>errors &&
+	! test -s errors
+'
+
 test_done
-- 
2.1.0-391-g57244f3
