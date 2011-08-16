From: Jeff King <peff@peff.net>
Subject: Re: "git apply --check" successes but git am says "does not match
 index"
Date: Mon, 15 Aug 2011 17:13:07 -0700
Message-ID: <20110816001306.GA23695@sigill.intra.peff.net>
References: <loom.20110814T113311-277@post.gmane.org>
 <20110815232318.GA4699@sigill.intra.peff.net>
 <7vhb5ijkq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zemacsh <ruini.xue@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 02:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt7HQ-00059q-Li
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 02:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab1HPANL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 20:13:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59264
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab1HPANL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 20:13:11 -0400
Received: (qmail 30717 invoked by uid 107); 16 Aug 2011 00:13:49 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Aug 2011 20:13:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2011 17:13:07 -0700
Content-Disposition: inline
In-Reply-To: <7vhb5ijkq0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179398>

On Mon, Aug 15, 2011 at 04:52:55PM -0700, Junio C Hamano wrote:

> I am kind of surprised that we have not done the 'refresh once upfront'
> already and nobody ever run into this for the past 5 years. It seems that
> I inherited that behaviour from git-applymbox ;-)

It's a pretty rare set of circumstances:

  1. You make a file stat-dirty, but don't actually change its contents.

  2. You don't run any index-refreshing porcelains.

  3. You apply a patch that touches that file.

> It is sensible to refresh once at the beginning and also when restarting
> with "am --resolved".

The patch below does this. I think this makes the "update-index" call in
git-rebase.sh:522 redundant when the "am" backend is used. But it is
still needed for the other backends. I wonder if "git rebase" actually
suffers from the same problem, since it seems to refresh only on
--continue, but not at the beginning.

-- >8 --
Subject: [PATCH] am: refresh the index at start and --resolved

If a file is unchanged but stat-dirty, we may erroneously
fail to apply patches, thinking that they conflict with a
dirty working tree.

This patch adds a call to "update-index --refresh". It comes
as late as possible, so that we don't bother with it for
thinks like "git rebase --abort", or when mbox-splitting
fails. However, it does come before we actually start
applying patches, meaning we will only call it once when we
start applying patches (or any time we return to "am" after
having resolved conflicts), and not once per patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-am.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 463c741..6592424 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -511,6 +511,8 @@ else
 	fi
 fi
 
+git update-index -q --refresh
+
 case "$resolved" in
 '')
 	case "$HAS_HEAD" in
-- 
1.7.6.10.g62f04
