From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 15:01:10 +0100
Message-ID: <39e5cb38658919ed989f954a0917dfaa292f6350.1260453234.git.git@drmicha.warpmail.net>
References: <20091210133645.GA2149@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jari Aalto <jari.aalto@cante.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 15:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIjbM-00049r-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 15:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760680AbZLJOC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 09:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760608AbZLJOC2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 09:02:28 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47532 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760584AbZLJOC2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 09:02:28 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4773DC5194;
	Thu, 10 Dec 2009 09:02:34 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Dec 2009 09:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=smtpout; bh=Q8O7EnmLfnzigUuSh8ENVgoHUDw=; b=anQnbgmRCphuX7a13wYLlEB9rMA9QNx3NASzBvcQ97Z9IudEjc7zkSlWgyFZ/Vc7dFysuft79xxvbF1e8nugV1O89dUwYtZJSFK8CcNVYmrTeZAyp1X11gZ1fgcubfjVz7ffbtEDMO+xb+YkA/zZLWVdZd5gUYLgGN8B6GZ/hvw=
X-Sasl-enc: rNvviosjYmkA94XCOvLuQMmHE/ulwi+2qfWY3jlz/x0N 1260453751
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B9FA64AAB0B;
	Thu, 10 Dec 2009 09:02:31 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.292.gd8fe
In-Reply-To: <20091210133645.GA2149@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135029>

Print the sha1 of the deleted tag (in addition to the tag name) so that
one can easily recreate a mistakenly deleted tag:

git tag -d tagname
Deleted tag 'tagname' (was DEADBEEF)
git tag 'tagname' DEADBEEF

We output the previous ref also in the case of forcefully overwriting
tags.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Suggested-by: Jari Aalto <jari.aalto@cante.net>
Helped-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
---
v2 changes the wording to match with branch -d and uses the same
for forcefully overwriting tags.

Zolt=C3=A1n, I don't think we should make this into a race. Posting in
the relevant thread (and actually following it) would help this.

Also, I think we should really compare the sha1 the tag points to,
i.e. like below and like in your v1 (not v2). Different tag object
is different tag (message may differ, e.g.).

 builtin-tag.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index c479018..4ef1c4f 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -140,7 +140,7 @@ static int delete_tag(const char *name, const char =
*ref,
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
-	printf("Deleted tag '%s'\n", name);
+	printf("Deleted tag '%s' (was %s)\n", name, find_unique_abbrev(sha1, =
DEFAULT_ABBREV));
 	return 0;
 }
=20
@@ -479,6 +479,8 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		die("%s: cannot lock the ref", ref);
 	if (write_ref_sha1(lock, object, NULL) < 0)
 		die("%s: cannot update the ref", ref);
+	if (force && hashcmp(prev, object))
+		printf("Updated tag '%s' (was %s)\n", tag, find_unique_abbrev(prev, =
DEFAULT_ABBREV));
=20
 	strbuf_release(&buf);
 	return 0;
--=20
1.6.6.rc1.292.gd8fe
