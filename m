From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] Allow "git remote --mirror" to mirror stashes
Date: Thu, 27 Mar 2008 23:16:58 -0700
Message-ID: <7vbq4z4bl1.fsf@gitster.siamese.dyndns.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
 <1205604534.7589.20.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: joakim.tjernlund@transmode.se,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 07:18:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf7ue-0007Pn-Nj
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 07:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbYC1GRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 02:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYC1GRM
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 02:17:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYC1GRM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 02:17:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 423E52DCB;
	Fri, 28 Mar 2008 02:17:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0D0D22DCA; Fri, 28 Mar 2008 02:17:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78385>

When you have "remote.$there.fetch = refs/*:refs/*" and the remote has a
ref directly under refs/ (e.g. "stash"), "git fetch" still errored out
even with fixes in -rc1.

This should hopefully fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Rather than failing, it would be better to allow "git fetch" to succeed
   by doing this, but on the other hand, stash is purely a local matter,
   so it might make more sense to avoid exposing it from the uploader.

 builtin-fetch-pack.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 65350ca..472bad5 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -363,10 +363,17 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 		return_refs = NULL;
 
 	for (ref = *refs; ref; ref = next) {
+		int trash = 0;
+
 		next = ref->next;
-		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_ref_format(ref->name + 5))
-			; /* trash */
+		if (!memcmp(ref->name, "refs/", 5)) {
+			trash = check_ref_format(ref->name + 5);
+			if (trash == CHECK_REF_FORMAT_ONELEVEL)
+				trash = 0;
+		}
+
+		if (trash)
+			; /* this is trash */
 		else if (args.fetch_all &&
 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
 			*newtail = ref;
