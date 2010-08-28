From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] checkout: Use submodule.*.ignore settings from .git/config
 and .gitmodules
Date: Sat, 28 Aug 2010 16:50:07 +0200
Message-ID: <4C79221F.907@web.de>
References: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302> <4C755778.7010306@web.de> <7vlj7uqwr6.fsf@alter.siamese.dyndns.org> <4C7591D7.9050508@web.de> <4C7921BD.7030600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 16:50:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpMjY-0003g7-U7
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 16:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab0H1OuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 10:50:10 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:34234 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0H1OuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 10:50:09 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id BFA11166D13C0;
	Sat, 28 Aug 2010 16:50:07 +0200 (CEST)
Received: from [93.240.119.11] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OpMjP-0000jv-00; Sat, 28 Aug 2010 16:50:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C7921BD.7030600@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/sVyaPgHunbfPhUhQVZ8Oam/C25f08wFi3BCbB
	aftn9Nc/ZqQugM+KVx/AOAc/jrLYvjeKJ+HHFI4Z6n7yGbvMIi
	nCAnBgWcq4Gk1m6xcCqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154646>

For "git status" and the diff family the submodule.*.ignore settings from
.git/config and .gitmodules can be used to override the default set via
diff.ignoreSubmodules on a per-submodule basis. Let's do this consistently
and teach checkout to use these settings too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/checkout.c            |    5 +++++
 t/t2013-checkout-submodule.sh |   16 ++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 19c23b2..f365169 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -627,6 +627,10 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
+
+	if (!prefixcmp(var, "submodule."))
+		return parse_submodule_config_option(var, value);
+
 	return git_xmerge_config(var, value, NULL);
 }

@@ -711,6 +715,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));

+	gitmodules_config();
 	git_config(git_checkout_config, &opts);

 	opts.track = BRANCH_TRACK_UNSPECIFIED;
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 3beb0b3..70edbb3 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -46,4 +46,20 @@ test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
 	! test -s actual
 '

+test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .gitmodules' '
+	git config diff.ignoreSubmodules none &&
+	git config -f .gitmodules submodule.submodule.path submodule &&
+	git config -f .gitmodules submodule.submodule.ignore untracked &&
+	git checkout HEAD >actual 2>&1 &&
+	! test -s actual
+'
+
+test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/config' '
+	git config -f .gitmodules submodule.submodule.ignore none &&
+	git config submodule.submodule.path submodule &&
+	git config submodule.submodule.ignore all &&
+	git checkout HEAD >actual 2>&1 &&
+	! test -s actual
+'
+
 test_done
-- 
1.7.2.2.515.g13860
