From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3 v2] Make "git-remote rm" delete refs acccording to fetch specs
Date: Sun, 1 Jun 2008 00:40:47 -0400
Message-ID: <20080601044047.GF12896@spearce.org>
References: <20080601035901.GC32176@spearce.org> <20080601042804.GA32293@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 06:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2fOW-0003Hm-5J
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 06:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbYFAEkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 00:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYFAEkv
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 00:40:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51807 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYFAEku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 00:40:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K2fNB-0000Dk-1j; Sun, 01 Jun 2008 00:40:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9F43C20FBAE; Sun,  1 Jun 2008 00:40:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080601042804.GA32293@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83430>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> To avoid deleting refs used by another remote we only clear refs
> that are unique to this remote.  This prevents `git prune rm alt`
> from removing the refs used by say origin if alt was just using a
> different URL for the same repository.

Hmm.  You probably should squash this test case into that patch.

--8<--
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0d7ed1f..96e461b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -182,6 +182,18 @@ test_expect_success 'add alt && prune' '
 	 git rev-parse --verify refs/remotes/origin/side2)
 '
 
+test_expect_success 'rm alt' '
+	(cd alttst &&
+	 git remote rm alt &&
+	 tokens_match z z$(git config remote.alt.url) &&
+	 tokens_match z z$(git config remote.alt.fetch) &&
+	 git rev-parse --verify refs/remotes/origin/side2 &&
+	 git remote rm origin &&
+	 tokens_match z z$(git config remote.alt.url) &&
+	 tokens_match z z$(git config remote.alt.fetch) &&
+	 ! git rev-parse --verify refs/remotes/origin/side2)
+'
+
 cat > one/expect << EOF
   apis/master
   apis/side

-- 
Shawn.
