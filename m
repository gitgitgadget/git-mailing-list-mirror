From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tweak "bundle verify" of a complete history
Date: Mon, 04 Jun 2012 11:51:13 -0700
Message-ID: <7v1uluud0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 20:51:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbcND-0004Sw-D9
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 20:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952Ab2FDSvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 14:51:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45939 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755071Ab2FDSvR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 14:51:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4094D84D9;
	Mon,  4 Jun 2012 14:51:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=T
	iNP0e7xGEFkuWvEAnZY+mOHcEE=; b=XYvSoUWkYKioCLstob4gYPIW4lEJU/itW
	TsXHWdOFtlM1TGNOQ7jA4ITV6CPoMmR/eANUxzYHbIBY5EDNpZpe6USD8KNEZunm
	0dJPkPJbYWsYoENV57oxoMq5K5YusWHIG7VThcnvPLd0cdhXaTBx4NuTJjyQOqdx
	slayNJLzV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=xb/
	JR4YuDfRt1AVbcxeD0dRvZUQQAczXxdKed/jtyj/xquhpcyJKbL1EFoX4FSh3SBD
	0FW+SF4DND09Lr1OKNWf+ppO83zeyfXNHgZB/KR+0KBe1LJMCtP5p72VJ6sGI1Dn
	e2RpXm2iDAgE4rdIc+qFWGJRg6dezvF5bVO6breU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37F0B84D8;
	Mon,  4 Jun 2012 14:51:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A563984D3; Mon,  4 Jun 2012
 14:51:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43EDFAB2-AE76-11E1-95B6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199168>

A bundle that records a complete history without prerequiste is a
useful way to sneakernet the sources of your configuration files
under your home directory, etc.  E.g.

    $ GIT_DIR=/srv/git/homesrc.git git bundle create x.bndl HEAD master

Running "git bundle verify" on such a "complete" bundle, however,
gives somewhat a funny output.

    $ git bundle verify x.bndl
    The bundle contains 2 refs
    b2611f37ebc7ed6435a72d77fbc5f8b48a7d7146 HEAD
    b2611f37ebc7ed6435a72d77fbc5f8b48a7d7146 refs/heads/master
    The bundle requires these 0 refs
    x.bndl is okay

Reword "requires these 0 refs" to say "The bundle records a complete
history" instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * verify_bundle() is to check if you can fetch from the bundle into
   the current repository by verifying that you have the necessary
   commits and history behind them.  However, the command line UI
   "git bundle verify x.bndl" may look to the end users that it may
   also check the integrity of what is recorded in the bundle.  We
   may want to add fsck-like check to this function to make sure
   there is no corruption in the pack data.

   That is not the problem this patch tries to solve.  Hint, hint...

 bundle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/bundle.c b/bundle.c
index 8d31b98..8d12816 100644
--- a/bundle.c
+++ b/bundle.c
@@ -188,12 +188,16 @@ int verify_bundle(struct bundle_header *header, int verbose)
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
-		r = &header->prerequisites;
-		printf_ln(Q_("The bundle requires this ref",
-			     "The bundle requires these %d refs",
-			     r->nr),
-			  r->nr);
-		list_refs(r, 0, NULL);
+		if (!r->nr) {
+			printf_ln(_("The bundle records a complete history."));
+		} else {
+			r = &header->prerequisites;
+			printf_ln(Q_("The bundle requires this ref",
+				     "The bundle requires these %d refs",
+				     r->nr),
+				  r->nr);
+			list_refs(r, 0, NULL);
+		}
 	}
 	return ret;
 }
	
