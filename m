From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] clone: Supply the right commit hash to post-checkout when
 -b is used
Date: Wed, 14 Oct 2009 00:11:09 +0200
Message-ID: <20091013221109.GA30972@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ranguvar@archlinux.us,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 00:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxpmI-00073g-VV
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 00:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760669AbZJMWMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 18:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbZJMWMD
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 18:12:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:40733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754986AbZJMWMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 18:12:01 -0400
Received: (qmail invoked by alias); 13 Oct 2009 22:11:13 -0000
Received: from i59F57E86.versanet.de (EHLO atjola.homenet) [89.245.126.134]
  by mail.gmx.net (mp025) with SMTP; 14 Oct 2009 00:11:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19rX/NOlFtrB0BLfBzrqe80M5YqdkdpNu455JDega
	A3G+4iZAdyuCat
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130225>

When we use -b <branch>, we may checkout something else than what the
remote's HEAD references, but we still used remote_head to supply the
new ref value to the post-checkout hook, which is wrong.

So instead of using remote_head to find the value to be passed to the
post-checkout hook, we have to use our_head_points_at, which is always
correctly setup, even if -b is not used.

This also fixes a segfault when "clone -b <branch>" is used with a
remote repo that doesn't have a valid HEAD, as in such a case
remote_head is NULL, but we still tried to access it.

Reported-by: Devin Cofer <ranguvar@archlinux.us>
Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 builtin-clone.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 4992c25..5762a6f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -641,7 +641,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			die("unable to write new index file");
=20
 		err |=3D run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
-				sha1_to_hex(remote_head->old_sha1), "1", NULL);
+				sha1_to_hex(our_head_points_at->old_sha1), "1",
+				NULL);
=20
 		if (!err && option_recursive)
 			err =3D run_command_v_opt(argv_submodule, RUN_GIT_CMD);
--=20
1.6.5.7.g9ecb2
