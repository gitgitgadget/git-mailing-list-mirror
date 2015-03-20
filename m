From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] repack: turn on "ref paranoia" when doing a
 destructive repack
Date: Fri, 20 Mar 2015 14:43:13 -0400
Message-ID: <20150320184313.GD23849@peff.net>
References: <20150320184215.GA26368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 19:44:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1uD-0003Mp-KC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbbCTSoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:44:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:36034 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751523AbbCTSnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:43:16 -0400
Received: (qmail 29041 invoked by uid 102); 20 Mar 2015 18:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:43:15 -0500
Received: (qmail 26951 invoked by uid 107); 20 Mar 2015 18:43:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:43:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 14:43:13 -0400
Content-Disposition: inline
In-Reply-To: <20150320184215.GA26368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265933>

If we are repacking with "-ad", we will drop any unreachable
objects. Likewise, using "-Ad --unpack-unreachable=<time>"
will drop any old, unreachable objects. In these cases, we
want to make sure the reachability we compute with "--all"
is complete. We can do this by passing GIT_REF_PARANOIA=1 in
the environment to pack-objects.

Note that "-Ad" is safe already, because it only loosens
unreachable objects. It is up to "git prune" to avoid
deleting them.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c            | 8 ++++++--
 t/t5312-prune-corruption.sh | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 28fbc70..f2edeb0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -228,13 +228,17 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		get_non_kept_pack_filenames(&existing_packs);
 
 		if (existing_packs.nr && delete_redundant) {
-			if (unpack_unreachable)
+			if (unpack_unreachable) {
 				argv_array_pushf(&cmd.args,
 						"--unpack-unreachable=%s",
 						unpack_unreachable);
-			else if (pack_everything & LOOSEN_UNREACHABLE)
+				argv_array_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
+			} else if (pack_everything & LOOSEN_UNREACHABLE) {
 				argv_array_push(&cmd.args,
 						"--unpack-unreachable");
+			} else {
+				argv_array_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
+			}
 		}
 	} else {
 		argv_array_push(&cmd.args, "--unpacked");
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 5ffb817..e8d04ef 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -38,7 +38,7 @@ test_expect_success 'put bogus object into pack' '
 	verbose git cat-file -e $bogus
 '
 
-test_expect_failure 'destructive repack keeps packed object' '
+test_expect_success 'destructive repack keeps packed object' '
 	test_might_fail git repack -Ad --unpack-unreachable=now &&
 	verbose git cat-file -e $bogus &&
 	test_might_fail git repack -ad &&
-- 
2.3.3.520.g3cfbb5d
