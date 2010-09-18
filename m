From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] fetch: Fix a bug swallowing the output of recursive submodule
 fetching
Date: Sun, 19 Sep 2010 00:33:34 +0200
Message-ID: <4C953E3E.6020709@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 00:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox5yZ-0001TJ-If
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 00:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab0IRWdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 18:33:37 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39023 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0IRWdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 18:33:36 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6BF9216917EF8;
	Sun, 19 Sep 2010 00:33:35 +0200 (CEST)
Received: from [93.240.106.153] (helo=[192.168.178.29])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Ox5yR-0003u5-00; Sun, 19 Sep 2010 00:33:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4C953DE5.6020900@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX195tiiQiADveBfAdsE4V1gRDTjk+8PqBoIlGiJE
	ChQHsMY/LKrZfmmxvWB0e0ZxkG7oUgBBvzZizLWNU52QEkIDml
	7uu+4b0ev2AxkE6W4fyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156476>

Due to a copy and paste bug only the first level of recursion was seen
when doing a "git fetch" on a nested submodule tree. Fix that and extend
t5526 to find such breakage in the future.

Reported-by: Kevin Ballard <kevin@sb.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c                 |    1 -
 t/t5526-fetch-submodules.sh |   30 +++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2380638..a62cae5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -256,7 +256,6 @@ int fetch_populated_submodules(int forced)
 	cp.env = local_repo_env;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-	cp.out = -1;

 	for_each_string_list_item(name_for_path, &config_name_for_path) {
 		struct strbuf submodule_path = STRBUF_INIT;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 489ef1a..cabf118 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -16,29 +16,49 @@ add_upstream_commit() {
 		git add subfile &&
 		git commit -m new subfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "From $pwd/submodule" > ../expect.err
+		echo "From $pwd/submodule" > ../expect.err &&
+		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+	)
+	(
+		cd deepsubmodule &&
+		head1=$(git rev-parse --short HEAD) &&
+		echo new >> deepsubfile &&
+		test_tick &&
+		git add deepsubfile &&
+		git commit -m new deepsubfile &&
+		head2=$(git rev-parse --short HEAD) &&
+		echo "From $pwd/deepsubmodule" >> ../expect.err &&
 		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
 	)
 }

 test_expect_success setup '
+	mkdir deepsubmodule &&
+	(
+		cd deepsubmodule &&
+		git init &&
+		echo deepsubcontent > deepsubfile &&
+		git add deepsubfile &&
+		git commit -m new deepsubfile
+	) &&
 	mkdir submodule &&
 	(
 		cd submodule &&
 		git init &&
 		echo subcontent > subfile &&
 		git add subfile &&
-		git commit -m new subfile
+		git submodule add "$pwd/deepsubmodule" deepsubmodule &&
+		git commit -a -m new
 	) &&
 	git submodule add "$pwd/submodule" submodule &&
 	git commit -am initial &&
 	git clone . downstream &&
 	(
 		cd downstream &&
-		git submodule init &&
-		git submodule update
+		git submodule update --init --recursive
 	) &&
-	echo "Fetching submodule submodule" > expect.out
+	echo "Fetching submodule submodule" > expect.out &&
+	echo "Fetching submodule deepsubmodule" >> expect.out
 '

 test_expect_success "fetch recurses into submodules" '
-- 
1.7.3.rc2.234.g00c0
