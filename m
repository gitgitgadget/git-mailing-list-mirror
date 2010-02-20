From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] cherry_pick_list: quit early if one side is empty
Date: Sat, 20 Feb 2010 12:42:04 +0100
Message-ID: <a39e9a6e6f043121568de106f41f5b01eb38a200.1266665083.git.trast@student.ethz.ch>
References: <20100220072728.GA12168@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Laine Walker-Avina <lwalkera@pasco.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 12:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ninj5-0003eM-Er
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 12:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0BTLmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 06:42:08 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:33851 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab0BTLmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 06:42:07 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 12:42:05 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 12:42:04 +0100
X-Mailer: git-send-email 1.7.0.139.gd1a75.dirty
In-Reply-To: <20100220072728.GA12168@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140526>

The --cherry-pick logic starts by counting the commits on each side,
so that it can filter away commits on the bigger one.  However, so
far it missed an opportunity for optimization: it doesn't need to do
any work if either side is empty.

This in particular helps the common use-case 'git rebase -i HEAD~$n':
it internally uses --cherry-pick, but since HEAD~$n is a direct
ancestor the left side is always empty.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

On Saturday 20 February 2010 08:27:28 Jeff King wrote:
> 
> From my reading of the code, that is right, but this is the first time I
> ever looked at it, so who knows? :)

Junio agreed too, so here's a real patch.  To keep the complexity of
git-rebase--interactive from exploding even further, you can drop the
earlier one.

> Does it really make sense to treat binary files as anything other than a
> blob for generating patch id? That is, should we simply turn it into:
> 
>   binary diff
>   $from_sha1
>   $to_sha1
> 
> and hash that for the patch id?

I tend to agree, but I can't seem to find out what flags to flip :-(


 revision.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 438cc87..29721ec 100644
--- a/revision.c
+++ b/revision.c
@@ -547,6 +547,9 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 			right_count++;
 	}
 
+	if (!left_count || !right_count)
+		return;
+
 	left_first = left_count < right_count;
 	init_patch_ids(&ids);
 	if (revs->diffopt.nr_paths) {
-- 
1.7.0.139.gd1a75.dirty
