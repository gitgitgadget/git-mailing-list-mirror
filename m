From: Rob Hoelz <rob@hoelz.ro>
Subject: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 12:22:16 -0500
Message-ID: <20130327122216.5de0c336@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, josh@joshtriplett.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 18:22:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKu3i-00037Y-9t
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3C0RWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:22:18 -0400
Received: from hoelz.ro ([66.228.44.67]:39250 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab3C0RWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:22:17 -0400
Received: from localhost.localdomain (108-234-129-20.lightspeed.milwwi.sbcglobal.net [108.234.129.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id 06800280F5;
	Wed, 27 Mar 2013 13:22:16 -0400 (EDT)
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219287>

git push currently doesn't consider pushInsteadOf when
using pushurl; this test tests that.

If you use pushurl with an alias that has a pushInsteadOf configuration
value, Git does not take advantage of it.  For example:

[url "git://github.com/"]
    insteadOf = github:
[url "git://github.com/myuser/"]
    insteadOf = mygithub:
[url "git@github.com:myuser/"]
    pushInsteadOf = mygithub:
[remote "origin"]
    url     = github:organization/project
    pushurl = mygithub:project

With the above configuration, the following occurs:

$ git push origin master
fatal: remote error:
  You can't push to git://github.com/myuser/project.git
  Use git@github.com:myuser/project.git

So you can see that pushurl is being followed (it's not attempting to
push to git://github.com/organization/project), but insteadOf values are
being used as opposed to pushInsteadOf values for expanding the pushurl
alias.

This commit fixes that.

Signed-off-by: Rob Hoelz <rob@hoelz.ro>
---
 remote.c              |  6 +++-
 t/t5516-fetch-push.sh | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index e53a6eb..1ea240a 100644
--- a/remote.c
+++ b/remote.c
@@ -465,7 +465,11 @@ static void alias_all_urls(void)
 		if (!remotes[i])
 			continue;
 		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
-			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
+			char *copy = xstrdup(remotes[i]->pushurl[j]);
+			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites_push);
+			if (!strcmp(copy, remotes[i]->pushurl[j]))
+				remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
+			free(copy);
 		}
 		add_pushurl_aliases = remotes[i]->pushurl_nr == 0;
 		for (j = 0; j < remotes[i]->url_nr; j++) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c31e5c1..119f043 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -244,6 +244,83 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 	)
 '
 
+test_expect_success 'push with pushInsteadOf and explicit pushurl (pushurl + pushInsteadOf does rewrite in this case)' '
+	mk_empty &&
+	rm -rf ro rw &&
+	TRASH="$(pwd)/" &&
+	mkdir ro &&
+	mkdir rw &&
+	git init --bare rw/testrepo &&
+	test_config "url.file://$TRASH/ro/.insteadOf" ro: &&
+	test_config "url.file://$TRASH/rw/.pushInsteadOf" rw: &&
+	test_config remote.r.url ro:wrong &&
+	test_config remote.r.pushurl rw:testrepo &&
+	git push r refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd rw/testrepo &&
+		echo "$the_commit commit	refs/remotes/origin/master" > expected &&
+		git for-each-ref refs/remotes/origin > actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'push without pushInsteadOf and explicit pushurl (pushurl + insteadOf is used for rewrite)' '
+	mk_empty &&
+	rm -rf ro rw &&
+	TRASH="$(pwd)/" &&
+	mkdir ro &&
+	mkdir rw &&
+	git init --bare rw/testrepo &&
+	test_config "url.file://$TRASH/ro/.insteadOf" ro: &&
+	test_config "url.file://$TRASH/rw/.insteadOf" rw: &&
+	test_config remote.r.url ro:wrong &&
+	test_config remote.r.pushurl rw:testrepo &&
+	git push r refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd rw/testrepo &&
+		echo "$the_commit commit	refs/remotes/origin/master" > expected &&
+		git for-each-ref refs/remotes/origin > actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'push with pushInsteadOf but without explicit pushurl (url + pushInsteadOf is used for rewrite)' '
+	mk_empty &&
+	rm -rf ro rw &&
+	TRASH="$(pwd)/" &&
+	mkdir ro &&
+	mkdir rw &&
+	git init --bare rw/testrepo &&
+	test_config "url.file://$TRASH/ro/.insteadOf" rw: &&
+	test_config "url.file://$TRASH/rw/.pushInsteadOf" rw: &&
+	test_config remote.r.url rw:testrepo &&
+	git push r refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd rw/testrepo &&
+		echo "$the_commit commit	refs/remotes/origin/master" > expected &&
+		git for-each-ref refs/remotes/origin > actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'push without pushInsteadOf and without explicit pushurl (url + insteadOf is used for rewrite)' '
+	mk_empty &&
+	rm -rf ro rw &&
+	TRASH="$(pwd)/" &&
+	mkdir ro &&
+	mkdir rw &&
+	git init --bare rw/testrepo &&
+	test_config "url.file://$TRASH/rw/.insteadOf" rw: &&
+	test_config remote.r.url rw:testrepo &&
+	git push r refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd rw/testrepo &&
+		echo "$the_commit commit	refs/remotes/origin/master" > expected &&
+		git for-each-ref refs/remotes/origin > actual &&
+		test_cmp expected actual
+	)
+'
+
 test_expect_success 'push with matching heads' '
 
 	mk_test heads/master &&
-- 
1.8.2
