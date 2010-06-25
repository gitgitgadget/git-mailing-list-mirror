From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] fetch: don't output non-errors on stderr
Date: Fri, 25 Jun 2010 13:30:41 +0000
Message-ID: <1277472641-18148-1-git-send-email-avarab@gmail.com>
References: <1277418881-11286-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 25 15:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS901-0002jV-7U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 15:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0FYNbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 09:31:12 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49887 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0FYNbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 09:31:11 -0400
Received: by wwi17 with SMTP id 17so1058929wwi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oVbav3ou9Omk8vX24w95ce/DSpBAufUTDpBU536Xj0E=;
        b=DKkmOX+3vBC4mzWN2D4bHK+EZ40lVLzotohn0fDhuQEKeyho2R2nKwJTMKYn6P9FGZ
         zQKuaJ5BwnWerRNowq+2SF3RlfAS42jFq4N1XaioRz9ZzATneTFuRu0dokKo8GO/aZ6E
         llWiA6DFh+BLb3P3259olFonfph0f/M1y4s78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B+S2/tdGYOaZsZfwrVyTLR1tsIGQC/8RBaTIJp0iYCu3A6z5NMnDrqhnnGbs2zxflR
         VAr/yjUq8CkMAEJSXiFeEbuLIliIL1+82VCKSeGXm2ilg/V0jiprDyf7RkraGADK8CY8
         Rs2YzK/caaAct724p5WqaDSxe2kfVjH4beVMU=
Received: by 10.227.143.66 with SMTP id t2mr584284wbu.116.1277472668450;
        Fri, 25 Jun 2010 06:31:08 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id t15sm78477524wbc.23.2010.06.25.06.31.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 06:31:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277418881-11286-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149682>

Change git-fetch to only print to stderr if it has encountered an
error. A normal branch update (like "* branch HEAD -> FETCH_HEAD") is
no longer output to stderr but on stdout. Genuine errors (like
"[rejected]" messages) still go to stderr.

With this change I can run a cron script I've been developing
(http://github.com/avar/github-backup) without redirecting stderr to
/dev/null.

Before the change error messages were drowned out by git-fetch's
non-error update notices, which didn't need my attention.

The changes in t/t5521-pull-options.sh invert the previously tested
for behavior of checking if normal messages are output on stderr. The
changes in t/t5510-fetch.sh however contain no behavioral changes,
just assertions that will break if git fetch's behavior is changed
again.

There still aren't tests for some of the errors output by
builtin/fetch.c's update_local_ref function.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Thu, Jun 24, 2010 at 22:34, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> The small changes to the test suite that this requires is a testiment
> to how bad our test coverage is in this area. As far as I can see the
> error messages that update_local_ref can emit aren't being tested
> for. Fixing that is outside the scope of this patch, however.

Here's an updated patch that has a some of those supposedly out of
scope tests. The new tests have the same behavior, but will start
breaking if this behavior is changed again.

 builtin/fetch.c         |    5 ++-
 t/t5510-fetch.sh        |   57 +++++++++++++++++++++++++++++++++------=
-------
 t/t5521-pull-options.sh |   12 +++++-----
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5cb369c..116b322 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -397,13 +397,14 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
 				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
+			FILE *fout =3D rc ? stderr : stdout;
 			if (verbosity >=3D 0 && !shown_url) {
-				fprintf(stderr, "From %.*s\n",
+				fprintf(fout, "From %.*s\n",
 						url_len, url);
 				shown_url =3D 1;
 			}
 			if (verbosity >=3D 0)
-				fprintf(stderr, " %s\n", note);
+				fprintf(fout, " %s\n", note);
 		}
 	}
 	free(url);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4eb10f6..808b256 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -51,7 +51,9 @@ test_expect_success "fetch test" '
 	echo >file updated by origin &&
 	git commit -a -m "updated by origin" &&
 	cd two &&
-	git fetch &&
+	git fetch >out 2>err &&
+	test ! -s err &&
+	test -s out &&
 	test -f .git/refs/heads/one &&
 	mine=3D`git rev-parse refs/heads/one` &&
 	his=3D`cd ../one && git rev-parse refs/heads/master` &&
@@ -61,7 +63,9 @@ test_expect_success "fetch test" '
 test_expect_success "fetch test for-merge" '
 	cd "$D" &&
 	cd three &&
-	git fetch &&
+	git fetch >out 2>err &&
+	test ! -s err &&
+	test -s out &&
 	test -f .git/refs/heads/two &&
 	test -f .git/refs/heads/one &&
 	master_in_two=3D`cd ../two && git rev-parse master` &&
@@ -81,7 +85,9 @@ test_expect_success 'fetch tags when there is no tags=
' '
     cd notags &&
     git init &&
=20
-    git fetch -t ..
+    git fetch -t .. >out 2>err &&
+    test ! -s err &&
+    test ! -s out
=20
 '
=20
@@ -95,7 +101,10 @@ test_expect_success 'fetch following tags' '
 	cd four &&
 	git init &&
=20
-	git fetch .. :track &&
+	git fetch .. :track >out 2>err &&
+	test ! -s err &&
+	test -s out &&
+
 	git show-ref --verify refs/tags/anno &&
 	git show-ref --verify refs/tags/light
=20
@@ -109,8 +118,9 @@ test_expect_success 'fetch must not resolve short t=
ag name' '
 	cd five &&
 	git init &&
=20
-	test_must_fail git fetch .. anno:five
-
+	! git fetch .. anno:five >out 2>err &&
+	test -s err &&
+	test ! -s out
 '
=20
 test_expect_success 'fetch must not resolve short remote name' '
@@ -122,7 +132,9 @@ test_expect_success 'fetch must not resolve short r=
emote name' '
 	cd six &&
 	git init &&
=20
-	test_must_fail git fetch .. six:six
+	! git fetch .. six:six >out 2>err &&
+	test -s err &&
+	test ! -s out
=20
 '
=20
@@ -148,7 +160,9 @@ test_expect_success 'create bundle 2' '
 test_expect_success 'unbundle 1' '
 	cd "$D/bundle" &&
 	git checkout -b some-branch &&
-	test_must_fail git fetch "$D/bundle1" master:master
+	! git fetch "$D/bundle1" master:master >out 2>err &&
+	test -s err &&
+	test ! -s out
 '
=20
=20
@@ -167,7 +181,9 @@ test_expect_success 'bundle 1 has only 3 files ' '
=20
 test_expect_success 'unbundle 2' '
 	cd "$D/bundle" &&
-	git fetch ../bundle2 master:master &&
+	git fetch ../bundle2 master:master >out 2>err &&
+	test ! -s err &&
+	test -s out &&
 	test "tip" =3D "$(git log -1 --pretty=3Doneline master | cut -b42-)"
 '
=20
@@ -203,7 +219,9 @@ test_expect_success 'fetch via rsync' '
 	mkdir rsynced &&
 	(cd rsynced &&
 	 git init --bare &&
-	 git fetch "rsync:$(pwd)/../.git" master:refs/heads/master &&
+	 git fetch "rsync:$(pwd)/../.git" master:refs/heads/master >out 2>err=
 &&
+	 test ! -s err &&
+	 test -s out &&
 	 git gc --prune &&
 	 test $(git rev-parse master) =3D $(cd .. && git rev-parse master) &&
 	 git fsck --full)
@@ -237,14 +255,17 @@ test_expect_success 'fetch with a non-applying br=
anch.<name>.merge' '
 	git config branch.master.merge refs/heads/bigfoot &&
 	git config remote.blub.url one &&
 	git config remote.blub.fetch "refs/heads/*:refs/remotes/one/*" &&
-	git fetch blub
+	git fetch blub >out 2>err &&
+	test ! -s err &&
+	test -s out
 '
=20
 # the strange name is: a\!'b
 test_expect_success 'quoting of a strangely named repo' '
-	test_must_fail git fetch "a\\!'\''b" > result 2>&1 &&
-	cat result &&
-	grep "fatal: '\''a\\\\!'\''b'\''" result
+	test_must_fail git fetch "a\\!'\''b" >out 2>err &&
+	test -s err &&
+	test ! -s out &&
+	grep "fatal: '\''a\\\\!'\''b'\''" err
 '
=20
 test_expect_success 'bundle should record HEAD correctly' '
@@ -267,7 +288,9 @@ test_expect_success 'explicit fetch should not upda=
te tracking' '
 	(
 		cd three &&
 		o=3D$(git rev-parse --verify refs/remotes/origin/master) &&
-		git fetch origin master &&
+		git fetch origin master >out 2>err &&
+		test ! -s err &&
+		test -s out &&
 		n=3D$(git rev-parse --verify refs/remotes/origin/master) &&
 		test "$o" =3D "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/side
@@ -295,7 +318,9 @@ test_expect_success 'configured fetch updates track=
ing' '
 	(
 		cd three &&
 		o=3D$(git rev-parse --verify refs/remotes/origin/master) &&
-		git fetch origin &&
+		git fetch origin  >out 2>err &&
+		test ! -s err &&
+		test -s out &&
 		n=3D$(git rev-parse --verify refs/remotes/origin/master) &&
 		test "$o" !=3D "$n" &&
 		git rev-parse --verify refs/remotes/origin/side
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 1b06691..7ec36e7 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -23,16 +23,16 @@ test_expect_success 'git pull' '
 	mkdir cloned &&
 	(cd cloned && git init &&
 	git pull "../parent" >out 2>err &&
-	test -s err &&
-	test ! -s out)
+	test ! -s err &&
+	test -s out)
 '
=20
 test_expect_success 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
 	git pull -v "../parent" >out 2>err &&
-	test -s err &&
-	test ! -s out)
+	test ! -s err &&
+	test -s out)
 '
=20
 test_expect_success 'git pull -v -q' '
@@ -47,8 +47,8 @@ test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
 	git pull -q -v "../parent" >out 2>err &&
-	test ! -s out &&
-	test -s err)
+	test ! -s err &&
+	test -s out)
 '
=20
 test_expect_success 'git pull --force' '
--=20
1.7.1.251.g92a7
