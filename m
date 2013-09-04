From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2013, #01; Tue, 3)
Date: Wed, 4 Sep 2013 05:01:53 -0400
Message-ID: <20130904090153.GA22348@sigill.intra.peff.net>
References: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 11:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH8yQ-0006Sv-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 11:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934451Ab3IDJB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 05:01:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:34840 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934416Ab3IDJB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 05:01:57 -0400
Received: (qmail 31813 invoked by uid 102); 4 Sep 2013 09:01:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Sep 2013 04:01:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Sep 2013 05:01:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233825>

On Tue, Sep 03, 2013 at 04:00:32PM -0700, Junio C Hamano wrote:

> * jk/duplicate-objects-in-packs (2013-08-24) 6 commits
>  - default pack.indexDuplicates to false
>  - index-pack: optionally reject packs with duplicate objects
>  - test index-pack on packs with recoverable delta cycles
>  - add tests for indexing packs with delta cycles
>  - sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
>  - test-sha1: add a binary output mode
> 
>  A packfile that stores the same object more than once is broken and
>  will be rejected.
> 
>  Will merge to 'next'.

Hmph. I happened to be looking at the write_idx_file code a few minutes
ago, and noticed the results of commit 68be2fe (receive-pack,
fetch-pack: reject bogus pack that records objects twice, 2011-11-16).

Now I feel like a dunce for reimplementing the same thing a few lines
above (and the reason I did not catch it in my tests is that "index-pack
--strict" is not enabled by default).

We should probably drop the two top commits. We may want to keep the
test from the second-to-last, though, but change it to use "index-pack
--strict". Like this:

-- >8 --
Subject: t5308: check that index-pack --strict detects duplicate objects

Commit 68be2fe long ago taught index-pack to notice and
reject duplicate objects if --strict is given (which it is
for incoming packs, if transfer.fsckObjects is set).
However, it never tested the code, because we did not have
an easy way of generating such a bogus pack.

Now that we have test infrastructure to handle this, let's
confirm that it works.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5308-pack-detect-duplicates.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 04fe242..9c5a876 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -70,4 +70,11 @@ test_expect_success 'lookup in duplicated pack (GIT_USE_LOOKUP)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'index-pack can reject packs with duplicates' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	test_must_fail git index-pack --strict --stdin <dups.pack &&
+	test_expect_code 1 git cat-file -e $LO_SHA1
+'
+
 test_done
-- 
1.8.4.2.g87d4a77
