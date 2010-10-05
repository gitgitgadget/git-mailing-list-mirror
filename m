From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 3/3] Add the 'fetch.recursive' config setting
Date: Tue, 05 Oct 2010 22:45:05 +0200
Message-ID: <4CAB8E51.3060501@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3EO4-0007Ts-9L
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab0JEUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:45:08 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:38613 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab0JEUpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:45:06 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id C0E47174FF6E8;
	Tue,  5 Oct 2010 22:45:05 +0200 (CEST)
Received: from [93.246.38.65] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P3ENl-0006fv-00; Tue, 05 Oct 2010 22:45:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CAB8DDF.8080004@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/6v4eFbeerGQn4YXNrccPWptLgzUVh6vK1HeX/
	NHKk743dEVPX9d8n8wsOdRj1DTPWsAGLeFk7u2AQQu1EnX66Vu
	ZEjyKU1GHCCNYpQSP96A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158242>

This new boolean option can be used to override the default for "git
fetch" and "git pull", which is to recurse into populated submodules
and fetch all new commits there too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt    |    4 +++
 submodule.c                 |    7 +++++
 t/t5526-fetch-submodules.sh |   56 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bc9b768..6f259c1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -879,6 +879,10 @@ diff.wordRegex::
 	sequences that match the regular expression are "words", all other
 	characters are *ignorable* whitespace.

+fetch.recursive::
+	A boolean value which overrides the default behavior of fetch and
+	pull, which is to recursively fetch populated sumodules too.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/submodule.c b/submodule.c
index e4437b4..d4adb37 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,6 +12,7 @@
 struct string_list config_name_for_path;
 struct string_list config_fetch_for_name;
 struct string_list config_ignore_for_name;
+static int config_fetch_recursive = 1;

 static int add_submodule_odb(const char *path)
 {
@@ -68,6 +69,10 @@ int submodule_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
+	if (!strcmp(var, "fetch.recursive")) {
+		config_fetch_recursive = git_config_bool(var, value);
+		return 0;
+	}
 	return 0;
 }

@@ -287,6 +292,8 @@ int fetch_populated_submodules(int num_options, const char **options,
 			fetch_option = unsorted_string_list_lookup(&config_fetch_for_name, name);
 			if (fetch_option && !fetch_option->util)
 				continue;
+			if (!fetch_option && !config_fetch_recursive)
+				continue;
 		}

 		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index f4e3157..35ef2ff 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -16,8 +16,8 @@ add_upstream_commit() {
 		git add subfile &&
 		git commit -m new subfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "From $pwd/submodule" > ../expect.err &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+		echo "From $pwd/submodule" > ../expect_1st.err &&
+		echo "   $head1..$head2  master     -> origin/master" >> ../expect_1st.err
 	)
 	(
 		cd deepsubmodule &&
@@ -27,9 +27,10 @@ add_upstream_commit() {
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "From $pwd/deepsubmodule" >> ../expect.err &&
-		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
-	)
+		echo "From $pwd/deepsubmodule" > ../expect_2nd.err &&
+		echo "   $head1..$head2  master     -> origin/master" >> ../expect_2nd.err
+	) &&
+	cat expect_1st.err expect_2nd.err > expect.err
 }

 test_expect_success setup '
@@ -58,6 +59,7 @@ test_expect_success setup '
 		git submodule update --init --recursive
 	) &&
 	echo "Fetching submodule submodule" > expect.out &&
+	cp expect.out expect_1st.out &&
 	echo "Fetching submodule submodule/deepsubmodule" >> expect.out
 '

@@ -160,4 +162,48 @@ test_expect_success "--recursive propagates to submodules" '
 	test_cmp expect.err actual.err
 '

+test_expect_success "fetch.recursive sets default and --recursive overrides it" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		(
+			cd submodule &&
+			git config -f .gitmodules --unset submodule.deepsubmodule.fetch &&
+			git config fetch.recursive false
+		) &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect_1st.out actual.out &&
+	test_cmp expect_1st.err actual.err &&
+	(
+		cd downstream &&
+		git fetch --recursive >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect_2nd.err actual.err
+'
+
+test_expect_success "fetch setting from .git/config overrides fetch.recursive config setting" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git config submodule.submodule.fetch true &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect_1st.out actual.out &&
+	test_cmp expect_1st.err actual.err &&
+	(
+		cd downstream &&
+		(
+			cd submodule &&
+			git config --unset fetch.recursive
+		) &&
+		git config fetch.recursive false &&
+		git config submodule.submodule.fetch true &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect_2nd.err actual.err
+'
+
 test_done
-- 
1.7.3.1.108.gb6303
