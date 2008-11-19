From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 12:54:00 +0100
Message-ID: <4923FE58.3090503@viscovery.net>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 12:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2lem-0006vo-0R
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 12:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbYKSLyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 06:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYKSLyN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 06:54:13 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19660 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbYKSLyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 06:54:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L2ldB-00012J-Ay; Wed, 19 Nov 2008 12:54:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1756069F; Wed, 19 Nov 2008 12:54:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101327>

Alex Riesen schrieb:
> The opened packs seem to stay open forever.

In my MinGW port I have the patch below that avoids that t5303 fails
because of a pack file that remains open. (Open files cannot be replaced
on Windows.) I had hoped that your patch would help, but it does not.
Something else still keeps the pack file open. Can anything be done about
that?

-- Hannes

From: Johannes Sixt <j6t@kdbg.org>
Date: Mon, 17 Nov 2008 09:25:19 +0100
Subject: [PATCH] t5303: Do not overwrite an existing pack

This test corrupts a pack file, then repacks the objects. The consequence
is that the repacked pack file has the same name as the original file
(that has been corrupted).

During its operation, git-pack-objects opens the corrupted file and keeps
it open at all times. On Windows, this is a problem because a file that is
open in any process cannot be delete or replaced, but that is what we do
in some of the test cases, and so they fail.

The work-around is to write the repacked objects to a file of a different
name, and replace the original after git-pack-objects has terminated.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5303-pack-corruption-resilience.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh
b/t/t5303-pack-corruption-resilience.sh
index 5132d41..41c83e3 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -43,8 +43,11 @@ create_new_pack() {

 do_repack() {
     pack=`printf "$blob_1\n$blob_2\n$blob_3\n" |
-          git pack-objects $@ .git/objects/pack/pack` &&
-    pack=".git/objects/pack/pack-${pack}"
+          git pack-objects $@ .git/objects/pack/packtmp` &&
+    packtmp=".git/objects/pack/packtmp-${pack}" &&
+    pack=".git/objects/pack/pack-${pack}" &&
+    mv "${packtmp}.pack" "${pack}.pack" &&
+    mv "${packtmp}.idx" "${pack}.idx"
 }

 do_corrupt_object() {
-- 
1.6.0.4.1683.g35125
