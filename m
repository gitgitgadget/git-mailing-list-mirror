From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] diff --check: explain why we do not care whether old
 side is binary
Date: Thu, 26 Jun 2008 15:34:54 -0700
Message-ID: <7vfxqzq0z5.fsf_-_@gitster.siamese.dyndns.org>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
 <20080625181422.GC4039@steel.home>
 <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
 <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
 <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com>
 <7vk5gbq10p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:36:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC04l-0003D6-Md
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508AbYFZWfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbYFZWfI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:35:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbYFZWfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:35:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C0E6E23DA4;
	Thu, 26 Jun 2008 18:35:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F192F23DA0; Thu, 26 Jun 2008 18:34:58 -0400 (EDT)
In-Reply-To: <7vk5gbq10p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 15:33:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1EAB159C-43D0-11DD-AE78-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86495>

All other codepaths refrain from running textual diff when either the old
or the new side is binary, but this function only checks the new side.  I
was almost going to change it to check both, but that would be a bad
change.  Explain why to prevent future mistakes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 8939423..c00d633 100644
--- a/diff.c
+++ b/diff.c
@@ -1544,8 +1544,9 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 static void builtin_checkdiff(const char *name_a, const char *name_b,
 			      const char *attr_path,
-			     struct diff_filespec *one,
-			     struct diff_filespec *two, struct diff_options *o)
+			      struct diff_filespec *one,
+			      struct diff_filespec *two,
+			      struct diff_options *o)
 {
 	mmfile_t mf1, mf2;
 	struct checkdiff_t data;
@@ -1564,6 +1565,12 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
+	/*
+	 * All the other codepaths check both sides, but not checking
+	 * the "old" side here is deliberate.  We are checking the newly
+	 * introduced changes, and as long as the "new" side is text, we
+	 * can and should check what it introduces.
+	 */
 	if (diff_filespec_is_binary(two))
 		goto free_and_return;
 	else {
-- 
1.5.6.1.78.gde8d9
