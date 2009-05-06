From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] t4200: convert sed expression which operates on non-text file to perl
Date: Wed,  6 May 2009 17:56:18 -0500
Message-ID: <Lle9L7vlL2vfnqjU75q2MW9kwH-igiKVkmBrtmLzQmOXU0OyvCI2tl4UD8Kdhyg0x_gCHDJIHDM@cipher.nrlssc.navy.mil>
References: <7vpreluckk.fsf@alter.siamese.dyndns.org> <Lle9L7vlL2vfnqjU75q2MR6WXGGP9aOKv8J97cnRHcQgyJeGbOMDDB2xJugZ0LoonfCRYmzXx9E@cipher.nrlssc.navy.mil>
Cc: pclouds@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 07 00:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1q2c-0006J8-50
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 00:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZEFW4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 18:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbZEFW43
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 18:56:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52942 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbZEFW42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 18:56:28 -0400
Received: by mail.nrlssc.navy.mil id n46MuQXC030239; Wed, 6 May 2009 17:56:26 -0500
In-Reply-To: <Lle9L7vlL2vfnqjU75q2MR6WXGGP9aOKv8J97cnRHcQgyJeGbOMDDB2xJugZ0LoonfCRYmzXx9E@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 May 2009 22:56:26.0038 (UTC) FILETIME=[E2675560:01C9CE9D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118400>

POSIX only requires sed to work on text files and MERGE_RR is not a text
file.  Some versions of sed complain that this file is not newline
terminated, and exit non-zero.  Use perl instead which does not have a
problem with it.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Initially, I changed this to use the tr workaround Junio suggested, so it
looked like this:

   sha1=$(tr '\000' '\012' <.git/MERGE_RR | sed -e 's/	.*//')

Then I noticed Jeff King's commit e85fe4d8 which changed uses of tr to perl
for portability's sake.  So the line became:

   sha1=$(perl -pe 'y/\000/\012/' .git/MERGE_RR | sed -e 's/	.*//')

Then I thought, "Why call sed?  I already started up perl, let _it_ do the
substitution.", so it became:

   sha1=$(perl -pe 'y/\000/\012/; s/	.*//' .git/MERGE_RR)

And then I thought, "Why do I need the transliteration?".  So we end up
with this simple patch.

-brandon


 t/t4200-rerere.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 504802c..5a1721d 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
 	test_must_fail git merge first
 '
 
-sha1=$(sed -e 's/	.*//' .git/MERGE_RR)
+sha1=$(perl -pe 's/	.*//' .git/MERGE_RR)
 rr=.git/rr-cache/$sha1
 test_expect_success 'recorded preimage' "grep ^=======$ $rr/preimage"
 
-- 
1.6.2.4.24.gde59d2
