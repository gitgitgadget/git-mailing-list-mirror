From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 6/6] submodule update: Don't fetch when the submodule commit
 is already present
Date: Wed, 23 Feb 2011 21:36:47 +0100
Message-ID: <4D656FDF.5050400@web.de>
References: <4D656F25.5090007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 21:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsLSA-0008Ft-0Z
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 21:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab1BWUgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 15:36:49 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:33417 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab1BWUgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 15:36:48 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id DCD80189C4F87;
	Wed, 23 Feb 2011 21:36:47 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsLS3-00063t-00; Wed, 23 Feb 2011 21:36:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D656F25.5090007@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18oarigYCq5N2HoBU4YtX9xJpD6kiZUjN8u0Mvl
	o8wDBh2WXXgND6bN0vNkJ2bFlMtQL7118N0jNCjBzYTeQz2Zhn
	sRlLY5QTJxY4A140hGAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167727>

If the commit to be checked out on "git submodule update" has already been
fetched in the submodule there is no need to run "git fetch" again. Since
"git fetch" recently learned recursion (and the new on-demand mode to
fetch commits recorded in the superproject is enabled by default) this
will happen pretty often, thereby making the unconditional fetch during
"git submodule update" unnecessary.

If the commit is not present in the submodule (e.g. the user disabled the
fetch on-demand mode) the fetch will be run as before.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh            |    2 +-
 t/t7406-submodule-update.sh |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b90589..ea49760 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -465,7 +465,7 @@ cmd_update()
 			if test -z "$nofetch"
 			then
 				(clear_local_git_env; cd "$path" &&
-					git-fetch) ||
+					(git rev-parse --verify $sha1 >/dev/null || git-fetch)) ||
 				die "Unable to fetch in submodule path '$path'"
 			fi

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index bfb4975..ee3eec5 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -74,6 +74,26 @@ test_expect_success 'submodule update detaching the HEAD ' '
 	)
 '

+apos="'";
+test_expect_success 'submodule update does not fetch already present commits' '
+	(cd submodule &&
+	  echo line3 >> file &&
+	  git add file &&
+	  test_tick &&
+	  git commit -m "upstream line3"
+	) &&
+	(cd super/submodule &&
+	  head=$(git rev-parse --verify HEAD) &&
+	  echo "Submodule path ${apos}submodule$apos: checked out $apos$head$apos" > ../../expected &&
+	  git reset --hard HEAD~1
+	) &&
+	(cd super &&
+	  git submodule update > ../actual 2> ../actual.err
+	) &&
+	test_cmp expected actual &&
+	! test -s actual.err
+'
+
 test_expect_success 'submodule update --rebase staying on master' '
 	(cd super/submodule &&
 	  git checkout master
-- 
1.7.4.1.190.g13e20
