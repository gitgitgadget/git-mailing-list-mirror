From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Show submodules as modified when they contain a dirty
 work tree
Date: Thu, 14 Jan 2010 22:38:57 +0100
Message-ID: <4B4F8EF1.3080709@web.de>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de> <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de> <7v6375lkpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVXPG-0005gN-SR
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 22:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab0ANVjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 16:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896Ab0ANVjB
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 16:39:01 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:54497 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab0ANVjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 16:39:00 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9FFFB13C176F7;
	Thu, 14 Jan 2010 22:38:58 +0100 (CET)
Received: from [80.128.55.33] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NVXP8-00016d-00; Thu, 14 Jan 2010 22:38:58 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7v6375lkpj.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX197yrxnDD8y1N5ZumKwP6FOzkzpN63qXaqNFZEN
	afUgNNNfCtFGzI6l00yBR63CEZI7jqgwOaJOQn4snKnB8uhyP3
	5+umz0IJqOnM/4VkfSMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137028>

Am 13.01.2010 23:10, schrieb Junio C Hamano:
> And a patch to add:
> 
>>> * It doesn't give detailed output when doing a "git diff* -p" with or
>>>   without the --submodule option. It should show something like
>>>
>>>     diff --git a/sub b/sub
>>>     index 5431f52..3f35670 160000
>>>     --- a/sub
>>>     +++ b/sub
>>>     @@ -1 +1 @@
>>>     -Subproject commit 5431f529197f3831cdfbba1354a819a79f948f6f
>>>     +Subproject commit 3f356705649b5d566d97ff843cf193359229a453-dirty
>>>
> 
> would look like the attached.

Your patch did not show submodules as dirty when the refs were identical.
The following patch fixes that and extends the test to catch that too.

-- >8 --
Subject: Show a modified submodule directory as dirty even if the refs match

When the submodules HEAD and the ref committed in the HEAD of the
superproject were the same, "git diff[-index] HEAD" did not show the
submodule as dirty when it should.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 diff-lib.c                |    3 ++-
 t/t4027-diff-submodule.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 5ce226b..9cdf6da 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -233,7 +233,8 @@ static int get_stat_data(struct cache_entry *ce,
 			return -1;
 		}
 		changed = ce_match_stat(ce, &st, 0);
-		if (changed) {
+		if (changed
+		    || (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name))) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			sha1 = null_sha1;
 		}
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index bf8c980..83c1914 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -97,6 +97,41 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
 	test_cmp expect.body actual.body
 '

+test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)' '
+	git commit -m "x" sub &&
+	echo >>sub/world &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		echo >>world &&
+		git add world
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		git clean -qfdx &&
+		>cruft
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subprev $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
 test_expect_success 'git diff (empty submodule dir)' '
 	: >empty &&
 	rm -rf sub/* sub/.git &&
-- 
1.6.6.294.g1f7f2.dirty
