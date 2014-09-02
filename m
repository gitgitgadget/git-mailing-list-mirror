From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] cache-tree: propagate invalidation up when punting
Date: Tue, 02 Sep 2014 14:24:03 -0700
Message-ID: <xmqq4mwpzpfw.fsf_-_@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<20140831120703.GA1240@serenity.lan>
	<xmqqfvg9zqw9.fsf@gitster.dls.corp.google.com>
	<xmqq8um1zq1q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 23:24:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvYk-0005uH-29
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbaIBVYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:24:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59324 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754740AbaIBVYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:24:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0231237CF8;
	Tue,  2 Sep 2014 17:24:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bZJ7YhUN7DLKwZo5pcfdDsoEZ5g=; b=DpkL1K
	uEGj8IxjoZ3jZys2P8kDJFPGqDHcgXTkykmhV9oVfxhhH89ZESMh8WdqiS4wWZZL
	/8tYBLUW1LcSh7WfUqa/xRt5Y2WqQiex0uRpdXN0Z+5uSNvkHLghoJmrrCvfI6z3
	6SxSdQ2VrOeBN/Awc4aIQxMdcZZCuucInaO2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xmYTPeXvd4Ryxu3XgeEX9HX0Z1cfQBMm
	f7tL+t/qT9E0C60FzCSfILpwX6oYqLCDUjX+E1aEVxSzFOkfhM04lVzQWAPsnhx9
	5xJH2lj8yYr02VUhDY21V66L4Cb9fva05gtNFAoaprCnytERRi3lps1rVY50eaC9
	W+9E3kIDhTk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECE5A37CF7;
	Tue,  2 Sep 2014 17:24:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7470637CF6;
	Tue,  2 Sep 2014 17:24:05 -0400 (EDT)
In-Reply-To: <xmqq8um1zq1q.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Sep 2014 14:10:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 77B0D994-32E7-11E4-8BAC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256370>

We punt from "repair"ing the hash tree during a branch switching if
it involves having to create a new tree object that does not yet
exist in the object store.  "mkdir dir && >dir/file && git add dir"
followed by "git checkout" is one example, when a tree that records
the state of such "dir/" is not in the object store.

However, after discovering that we do not have a tree object that
records the state of "dir/", we failed to propagate the fact up the
callchain to stop the code to attempt populating the level that has
"dir/" as its immediate subdirectory.  This led the caller detect
and report a non-existent error.

Reported-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache-tree.c          | 2 +-
 t/t0090-cache-tree.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index f951d7d..e3baf42 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -398,7 +398,7 @@ static int update_one(struct cache_tree *it,
 		it->entry_count, it->subtree_nr,
 		sha1_to_hex(it->sha1));
 #endif
-	return i;
+	return to_invalidate ? -1 : i;
 }
 
 int cache_tree_update(struct cache_tree *it,
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
