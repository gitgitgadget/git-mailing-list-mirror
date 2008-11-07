From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/4] repack: don't repack local objects in packs with .keep
 file
Date: Thu, 06 Nov 2008 19:54:08 -0600
Message-ID: <P5afFyDEMjF9ynd9dfSfGeRo_GFY_K6ZAn2nIYo8_xGgSl4LapbSOA@cipher.nrlssc.navy.mil>
References: <oDevG_2ETMLvy6rfSqvxfmFqABeVqlDUcU6FjP07E5IzqLaopWkQbQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 02:55:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyGZP-0005uF-Ql
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 02:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYKGByR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 20:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYKGByR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 20:54:17 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44240 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYKGByQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 20:54:16 -0500
Received: by mail.nrlssc.navy.mil id mA71s98U017443; Thu, 6 Nov 2008 19:54:09 -0600
In-Reply-To: <oDevG_2ETMLvy6rfSqvxfmFqABeVqlDUcU6FjP07E5IzqLaopWkQbQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Nov 2008 01:54:09.0568 (UTC) FILETIME=[B9982200:01C9407B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100277>

If the user created a .keep file for a local pack, then it can be inferred
that the user does not want those objects repacked.

This fixes the repack bug tested by t7700.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-repack.sh     |    2 +-
 t/t7700-repack.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index d39eb6c..8bb2201 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -83,7 +83,7 @@ case ",$all_into_one," in
 esac
 
 args="$args $local $quiet $no_reuse$extra"
-names=$(git pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+names=$(git pack-objects --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
 if [ -z "$names" ]; then
 	if test -z "$quiet"; then
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 7aaff0b..356afe3 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -4,7 +4,7 @@ test_description='git repack works correctly'
 
 . ./test-lib.sh
 
-test_expect_failure 'objects in packs marked .keep are not repacked' '
+test_expect_success 'objects in packs marked .keep are not repacked' '
 	echo content1 > file1 &&
 	echo content2 > file2 &&
 	git add . &&
-- 
1.6.0.3.552.g12334
