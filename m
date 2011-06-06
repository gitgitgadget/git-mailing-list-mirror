From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/3] submodule add: allow relative repository path even when
 no url is set
Date: Mon, 06 Jun 2011 21:58:04 +0200
Message-ID: <4DED314C.3000203@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vipskb0br.fsf@alter.siamese.dyndns.org> <4DED30E0.6090608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:58:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfwC-0004Ap-OX
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab1FFT6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 15:58:07 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33629 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab1FFT6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 15:58:06 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 1C00D1918F137;
	Mon,  6 Jun 2011 21:58:05 +0200 (CEST)
Received: from [93.240.124.249] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QTfw5-0004yA-00; Mon, 06 Jun 2011 21:58:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DED30E0.6090608@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18oa4R/UU9darePhZjR+d3iJGGE40gaWIP6zM06
	1k0Pix9QVpahEbB60yGT7dYKP3mQmav7FBY5rudRNqSKwJJTFp
	vET2qfFxbaJT1ystSRgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175156>

Adding a submodule with a relative repository path did only succeed when
the superproject's default remote was set. But when that is unset, the
superproject is its own authoritative upstream, so lets use its working
directory as upstream instead.

This allows users to set up a new superpoject where the submodules urls
are configured relative to the superproject's upstream while its default
remote can be configured later.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-submodule.txt |    4 +++-
 git-submodule.sh                |    2 +-
 t/t7400-submodule-basic.sh      |    7 +++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 5e7a413..408998e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -78,7 +78,9 @@ to exist in the superproject. If <path> is not given, the
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
 or ../), the location relative to the superproject's origin
-repository.
+repository. If the superproject doesn't have an origin configured
+the superproject is its own authoritative upstream and the current
+working directory is used instead.
 +
 <path> is the relative location for the cloned submodule to
 exist in the superproject. If <path> does not exist, then the
diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..3fbc21e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,7 +34,7 @@ resolve_relative_url ()
 {
 	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
-		die "remote ($remote) does not have a url defined in .git/config"
+		remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
 	remoteurl=${remoteurl%/}
 	sep=/
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cae5fd0..9099e80 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -446,10 +446,13 @@ test_expect_success 'add should fail when path is used by an existing directory'
 	)
 '

-test_expect_success 'add should fail when path is relative but no url is set in the superproject' '
+test_expect_success 'use superproject as upstream when path is relative and no url is set there' '
 	(
 		cd addtest &&
-		test_must_fail git submodule add ../repo relative
+		git submodule add ../repo relative &&
+		test "$(git config -f .gitmodules submodule.relative.url)" = ../repo &&
+		git submodule sync relative &&
+		test "$(git config submodule.relative.url)" = "$submodurl/repo"
 	)
 '

-- 
1.7.6.rc0.3.g28a66
