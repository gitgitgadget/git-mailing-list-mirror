From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 6/7] submodule update: Don't fetch when the submodule commit
 is already present
Date: Wed, 02 Mar 2011 00:04:21 +0100
Message-ID: <4D6D7B75.9040300@web.de>
References: <4D6D7A50.5090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:04:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYcW-0002Rf-8d
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 00:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1CAXEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 18:04:40 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:47423 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab1CAXEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 18:04:39 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1C20418A52288;
	Wed,  2 Mar 2011 00:04:22 +0100 (CET)
Received: from [93.240.102.247] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuYcA-0006wO-00; Wed, 02 Mar 2011 00:04:22 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6D7A50.5090802@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19pJXdR9C7IcYnblNRyH1ln1ku+FIQLs8wu0AiH
	6prBv7qAz3MwB4MobXkyaj4BaeymRRfGWw+jP3YvPR9f5Xm+8h
	na7gHTFE5lamtUTO5PIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168279>

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
 git-submodule.sh            |    5 ++++-
 t/t7406-submodule-update.sh |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..c16e275 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -466,8 +466,11 @@ cmd_update()

 			if test -z "$nofetch"
 			then
+				# Run fetch only if $sha1 isn't present or it
+				# is not reachable from a ref.
 				(clear_local_git_env; cd "$path" &&
-					git-fetch) ||
+					((rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
+					 test -z "$rev") || git-fetch)) ||
 				die "Unable to fetch in submodule path '$path'"
 			fi

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index fa9d23a..bf7c788 100755
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
1.7.4.1.291.g6060
