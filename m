From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "git branch -M @{-1}"
Date: Thu, 26 Feb 2009 22:12:22 -0800
Message-ID: <7vprh4o1bt.fsf_-_@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <86d4c5e00902262027y13b19eb7nf89a45e83b986801@mail.gmail.com>
 <7veixkpi4a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Deskin Miller <deskinm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 07:15:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcw03-0007HH-PS
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 07:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZB0GMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 01:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbZB0GMb
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 01:12:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbZB0GMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 01:12:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CE0FB21B0;
	Fri, 27 Feb 2009 01:12:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E7EF521AF; Fri,
 27 Feb 2009 01:12:23 -0500 (EST)
In-Reply-To: <7veixkpi4a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Feb 2009 21:24:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C6745BA-0495-11DE-83C3-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111632>

Earlier, we've taught "git branch -d <name>" that <name> is supposed to be
a branch name and not a random extended SHA-1.  "git branch -m <name> [<name>]" 
needs to be taught the same.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-branch.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index c34af27..3f97838 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -425,21 +425,27 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
 
-	strbuf_addf(&oldref, "refs/heads/%s", oldname);
+	if (interpret_nth_last_branch(oldname, &oldref) == strlen(oldname))
+		strbuf_splice(&oldref, 0, 0, "refs/heads/", 11);
+	else
+		strbuf_addf(&oldref, "refs/heads/%s", oldname);
 
 	if (check_ref_format(oldref.buf))
 		die("Invalid branch name: %s", oldref.buf);
 
-	strbuf_addf(&newref, "refs/heads/%s", newname);
+	if (interpret_nth_last_branch(newname, &newref) == strlen(newname))
+		strbuf_splice(&newref, 0, 0, "refs/heads/", 11);
+	else
+		strbuf_addf(&newref, "refs/heads/%s", newname);
 
 	if (check_ref_format(newref.buf))
 		die("Invalid branch name: %s", newref.buf);
 
 	if (resolve_ref(newref.buf, sha1, 1, NULL) && !force)
-		die("A branch named '%s' already exists.", newname);
+		die("A branch named '%s' already exists.", newref.buf + 11);
 
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
-		 oldref.buf, newref.buf);
+		    oldref.buf, newref.buf);
 
 	if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die("Branch rename failed");
