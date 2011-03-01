From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 3/7] config: teach the fetch.recurseSubmodules option the
 'on-demand' value
Date: Wed, 02 Mar 2011 00:02:24 +0100
Message-ID: <4D6D7B00.1020807@web.de>
References: <4D6D7A50.5090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:02:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYaN-0001UQ-Ef
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 00:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab1CAXC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 18:02:26 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:45501 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756600Ab1CAXC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 18:02:26 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0975C199E1552;
	Wed,  2 Mar 2011 00:02:25 +0100 (CET)
Received: from [93.240.102.247] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuYaG-0006Go-00; Wed, 02 Mar 2011 00:02:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6D7A50.5090802@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Avwy2pLk+asNvCZm8kUaRB7Y2bRfcfidMtShY
	nRdkGc2VrZciRhN0/KY5see/ua2WD6vb1NA71bqdS6rizTG9mL
	DVdFjZFJ1WiwbQLRFhdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168276>

To enable the user to change the default behavior of "git fetch" and "git
pull" regarding submodule recursion add the new "on-demand" value which
has just been added to the "--recurse-submodules" command line option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt    |   10 +++++++---
 submodule.c                 |    2 +-
 t/t5526-fetch-submodules.sh |   28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 96ce272..7b06fe5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -900,9 +900,13 @@ diff.wordRegex::
 	characters are *ignorable* whitespace.

 fetch.recurseSubmodules::
-	A boolean value which changes the behavior for fetch and pull, the
-	default is to not recursively fetch populated submodules unless
-	configured otherwise.
+	This option can be either set to a boolean value or to 'on-demand'.
+	Setting it to a boolean changes the behavior of fetch and pull to
+	unconditionally recurse into submodules when set to true or to not
+	recurse at all when set to false. When set to 'on-demand' (the default
+	value), it tells fetch and pull to recurse only into those submodules
+	where new commits are recorded in the commmits fetched for the
+	superproject.

 fetch.unpackLimit::
 	If the number of objects fetched over the git native
diff --git a/submodule.c b/submodule.c
index 86a99af..a1753f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -71,7 +71,7 @@ int submodule_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
-		config_fetch_recurse_submodules = git_config_bool(var, value);
+		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
 		return 0;
 	}
 	return 0;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 4cd723c..e6d873a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -372,4 +372,32 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 	test_cmp expect.err.file actual.err
 '

+test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules
+	) &&
+	add_upstream_commit &&
+	git config --global fetch.recurseSubmodules false &&
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err.2 &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2
+	head -2 expect.err >> expect.err.2 &&
+	(
+		cd downstream &&
+		git config fetch.recurseSubmodules on-demand &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	git config --global --unset fetch.recurseSubmodules &&
+	(
+		cd downstream &&
+		git config --unset fetch.recurseSubmodules
+	) &&
+	test_cmp expect.out.sub actual.out &&
+	test_cmp expect.err.2 actual.err
+'
+
 test_done
-- 
1.7.4.1.291.g6060
