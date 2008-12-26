From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] describe: Avoid unnecessary warning when using --all
Date: Fri, 26 Dec 2008 14:02:01 -0800
Message-ID: <20081226220201.GA20516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, rene.scharfe@lsrfire.ath.cx,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 23:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGKmA-0002e8-He
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 23:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbYLZWCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 17:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbYLZWCE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 17:02:04 -0500
Received: from george.spearce.org ([209.20.77.23]:33125 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbYLZWCD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 17:02:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D5D4B38200; Fri, 26 Dec 2008 22:02:01 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103954>

In 212945d4 ("Teach git-describe to verify annotated tag names
before output") git-describe learned how to output a warning if
an annotated tag object was matched but its internal name doesn't
match the local ref name.

However, "git describe --all" causes the local ref name to be
prefixed with "tags/", so we need to skip over this prefix before
comparing the local ref name with the name recorded inside of the
tag object.

Patch-by: Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Shawn O. Pearce <sop@google.com>
---
 IMHO, suitable for maint...

 builtin-describe.c  |    2 +-
 t/t6120-describe.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index d2cfb1b..3a007ed 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -158,7 +158,7 @@ static void display_name(struct commit_name *n)
 		n->tag =3D lookup_tag(n->sha1);
 		if (!n->tag || parse_tag(n->tag) || !n->tag->tag)
 			die("annotated tag %s not available", n->path);
-		if (strcmp(n->tag->tag, n->path))
+		if (strcmp(n->tag->tag, all ? n->path + 5 : n->path))
 			warning("tag '%s' is really '%s' here", n->tag->tag, n->path);
 	}
=20
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e6c9e59..8c7e081 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -100,6 +100,12 @@ check_describe B --tags HEAD^^2^
 check_describe B-0-* --long HEAD^^2^
 check_describe A-3-* --long HEAD^^2
=20
+: >err.expect
+check_describe A --all A^0
+test_expect_success 'no warning was displayed for A' '
+	test_cmp err.expect err.actual
+'
+
 test_expect_success 'rename tag A to Q locally' '
 	mv .git/refs/tags/A .git/refs/tags/Q
 '
--=20
1.6.1.302.gccd4d
