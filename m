From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule status: properly pass options with --recursive
Date: Fri, 26 Oct 2012 00:20:29 +0200
Message-ID: <5089BB2D.90400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 00:20:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRVnE-0000OC-6e
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 00:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071Ab2JYWUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 18:20:34 -0400
Received: from mout.web.de ([212.227.17.11]:50267 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab2JYWUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 18:20:33 -0400
Received: from [192.168.178.41] ([91.3.191.79]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0LgHKO-1T6Qe20GlI-00niKD; Fri, 26 Oct 2012 00:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-Provags-ID: V02:K0:H+3psgksBGiJOOP8+OZgOqMsdFReFuRBDR43S0SeV/1
 hI8NX46NguTr3mBfnwniHJqr3kDyZc++eo680pQ1qIvMHCf1P/
 kktFbmsW+wnoGDqpWN2YM6W6aAqspSHKUs3DGabyijpHPf0P/W
 FHpXLLb77qrQ1RXEQIX2kn+kzZ7OcVL8NMVZTcAG0Up03Jtih0
 ifkN70Nd+ALyWdpVtENsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208421>

When renaming orig_args to orig_flags in 98dbe63d (submodule: only
preserve flags across recursive status/update invocations) the call site
of the recursive cmd_status was forgotten. At that place orig_args is
still passed into the recursion, which is always empty now. This clears
all options when recursing, as that variable is never set.

Fix that by renaming orig_args to orig_flags there too and add a test to
catch that bug.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I noticed that when reviewing Phil's "Teach --recursive to submodule
sync" patch.

 git-submodule.sh             | 2 +-
 t/t7407-submodule-foreach.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..c089d48 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -990,7 +990,7 @@ cmd_status()
 				prefix="$displaypath/"
 				clear_local_git_env
 				cd "$sm_path" &&
-				eval cmd_status "$orig_args"
+				eval cmd_status "$orig_flags"
 			) ||
 			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
 		fi
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9b69fe2..eca36b5 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -245,6 +245,14 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
 	test_cmp expect actual
 '

+test_expect_success 'ensure "status --quiet --recursive" preserves the --quiet flag' '
+	(
+		cd clone3 &&
+		git submodule status --quiet --recursive -- nested1 > ../actual
+	) &&
+	! test -s actual
+'
+
 test_expect_success 'use "git clone --recursive" to checkout all submodules' '
 	git clone --recursive super clone4 &&
 	(
-- 
1.8.0.dirty
