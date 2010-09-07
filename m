From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] t1450 (fsck): remove dangling objects
Date: Mon, 6 Sep 2010 20:47:07 -0500
Message-ID: <20100907014707.GC1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:49:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnJH-00072w-KY
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab0IGBtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:49:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44357 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0IGBtN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:49:13 -0400
Received: by gyd8 with SMTP id 8so1795381gyd.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2y9UOLEtifqP+/ZfruTR47aTX96jVsp4rXGPWt1bnCA=;
        b=XmiZcwDb35QTmdWoaMYc+kkIycbWBEbjO3ecCsQpA2IQWCyEH1jy01TFJZADhN8zgi
         7C8WwVyJGTZRTKEZ60JYdXbPxjNtwtOnp/UX53AR6eKrJBDzTLVdyqFnlAm98CqUy469
         /n9eoB+n9O8FZCE+Hmu9gWlaXQkRAbyZoXAAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ma1P5pLhsexAIylE6wDDGm9gD8QPu2MyoBXalEu2L/KiL+9nnlIzk8rl9lygb9xSr4
         ojzbLe/k3lYVR0alxMDGECQCfUA5zpQAi0ewn1VJSocIzncSuWA4sxiRg26AwottI3ew
         Tb81ZiZrc/jCHdfbM4GANE10EGVK2dY9NsXao=
Received: by 10.100.120.14 with SMTP id s14mr916999anc.151.1283824150533;
        Mon, 06 Sep 2010 18:49:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n7sm10331738ane.1.2010.09.06.18.49.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:49:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014135.GA1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155659>

The fsck test is generally careful to remove the corrupt objects
it inserts, but dangling objects are left behind due to some typos
and omissions.  It is better to clean up more completely, to
simplify the addition of later tests.  So:

 - guard setup and cleanup with test_expect_success to catch
   typos and errors;
 - check both stdout and stderr when checking for empty fsck
   output;
 - use test_cmp empty file in place of test $(wc -l <file) = 0,
   for better debugging output when running tests with -v;
 - add a remove_object () helper and use it to replace broken
   object removal code that forgot about the fanout in
   .git/objects;
 - disable gc.auto, to avoid tripping up object removal if the
   number of objects ever reaches that threshold.
 - use test_when_finished to ensure cleanup tasks are run and
   succeed when tests fail;
 - add a new final test that no breakage or dangling objects
   was left behind.

While at it, add a brief description to test_description of the
history that is expected to persist between tests.

Part of a campaign to clean up subshell usage in tests.

Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1450-fsck.sh |  140 ++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 82 insertions(+), 58 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 759cf12..1be415e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1,21 +1,23 @@
 #!/bin/sh
 
-test_description='git fsck random collection of tests'
+test_description='git fsck random collection of tests
+
+* (HEAD) B
+* (master) A
+'
 
 . ./test-lib.sh
 
 test_expect_success setup '
+	git config gc.auto 0 &&
 	git config i18n.commitencoding ISO-8859-1 &&
 	test_commit A fileA one &&
 	git config --unset i18n.commitencoding &&
 	git checkout HEAD^0 &&
 	test_commit B fileB two &&
 	git tag -d A B &&
-	git reflog expire --expire=now --all
-'
-
-test_expect_success 'HEAD is part of refs' '
-	test 0 = $(git fsck | wc -l)
+	git reflog expire --expire=now --all &&
+	>empty
 '
 
 test_expect_success 'loose objects borrowed from alternate are not missing' '
@@ -25,110 +27,132 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
 		git init &&
 		echo ../../../.git/objects >.git/objects/info/alternates &&
 		test_commit C fileC one &&
-		git fsck >out &&
-		! grep "missing blob" out
-	)
+		git fsck >../out 2>&1
+	) &&
+	{
+		grep -v dangling out >actual ||
+		:
+	} &&
+	test_cmp empty actual
 '
 
-test_expect_success 'valid objects appear valid' '
-	{ git fsck 2>out; true; } &&
-	! grep error out &&
-	! grep fatal out
+test_expect_success 'HEAD is part of refs, valid objects appear valid' '
+	git fsck >actual 2>&1 &&
+	test_cmp empty actual
 '
 
 # Corruption tests follow.  Make sure to remove all traces of the
 # specific corruption you test afterwards, lest a later test trip over
 # it.
 
+test_expect_success 'setup: helpers for corruption tests' '
+	sha1_file() {
+		echo "$*" | sed "s#..#.git/objects/&/#"
+	} &&
+
+	remove_object() {
+		file=$(sha1_file "$*") &&
+		test -e "$file" &&
+		rm -f "$file"
+	}
+'
+
 test_expect_success 'object with bad sha1' '
 	sha=$(echo blob | git hash-object -w --stdin) &&
-	echo $sha &&
 	old=$(echo $sha | sed "s+^..+&/+") &&
 	new=$(dirname $old)/ffffffffffffffffffffffffffffffffffffff &&
 	sha="$(dirname $new)$(basename $new)"
 	mv .git/objects/$old .git/objects/$new &&
+	test_when_finished "remove_object $sha" &&
 	git update-index --add --cacheinfo 100644 $sha foo &&
+	test_when_finished "git read-tree -u --reset HEAD" &&
 	tree=$(git write-tree) &&
+	test_when_finished "remove_object $tree" &&
 	cmt=$(echo bogus | git commit-tree $tree) &&
+	test_when_finished "remove_object $cmt" &&
 	git update-ref refs/heads/bogus $cmt &&
-	(git fsck 2>out; true) &&
-	grep "$sha.*corrupt" out &&
-	rm -f .git/objects/$new &&
-	git update-ref -d refs/heads/bogus &&
-	git read-tree -u --reset HEAD
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+
+	test_might_fail git fsck 2>out &&
+	cat out &&
+	grep "$sha.*corrupt" out
 '
 
 test_expect_success 'branch pointing to non-commit' '
-	git rev-parse HEAD^{tree} > .git/refs/heads/invalid &&
+	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
+	test_when_finished "git update-ref -d refs/heads/invalid" &&
 	git fsck 2>out &&
-	grep "not a commit" out &&
-	git update-ref -d refs/heads/invalid
+	cat out &&
+	grep "not a commit" out
 '
 
-new=nothing
 test_expect_success 'email without @ is okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@/AT/" basis >okay &&
 	new=$(git hash-object -t commit -w --stdin <okay) &&
-	echo "$new" &&
+	test_when_finished "remove_object $new" &&
 	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	git fsck 2>out &&
 	cat out &&
-	! grep "error in commit $new" out
+	! grep "commit $new" out
 '
-git update-ref -d refs/heads/bogus
-rm -f ".git/objects/$new"
 
-new=nothing
 test_expect_success 'email with embedded > is not okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@[a-z]/&>/" basis >bad-email &&
 	new=$(git hash-object -t commit -w --stdin <bad-email) &&
-	echo "$new" &&
+	test_when_finished "remove_object $new" &&
 	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	git fsck 2>out &&
 	cat out &&
 	grep "error in commit $new" out
 '
-git update-ref -d refs/heads/bogus
-rm -f ".git/objects/$new"
-
-cat > invalid-tag <<EOF
-object ffffffffffffffffffffffffffffffffffffffff
-type commit
-tag invalid
-tagger T A Gger <tagger@example.com> 1234567890 -0000
-
-This is an invalid tag.
-EOF
 
 test_expect_success 'tag pointing to nonexistent' '
-	tag=$(git hash-object -t tag -w --stdin < invalid-tag) &&
-	echo $tag > .git/refs/tags/invalid &&
+	cat >invalid-tag <<-\EOF
+	object ffffffffffffffffffffffffffffffffffffffff
+	type commit
+	tag invalid
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+
+	This is an invalid tag.
+	EOF
+
+	tag=$(git hash-object -t tag -w --stdin <invalid-tag) &&
+	test_when_finished "remove_object $tag" &&
+	echo $tag >.git/refs/tags/invalid &&
+	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
 	cat out &&
-	grep "broken link" out &&
-	rm .git/refs/tags/invalid
+	grep "broken link" out
 '
 
-cat > wrong-tag <<EOF
-object $(echo blob | git hash-object -w --stdin)
-type commit
-tag wrong
-tagger T A Gger <tagger@example.com> 1234567890 -0000
-
-This is an invalid tag.
-EOF
-
 test_expect_success 'tag pointing to something else than its type' '
-	tag=$(git hash-object -t tag -w --stdin < wrong-tag) &&
-	echo $tag > .git/refs/tags/wrong &&
+	sha=$(echo blob | git hash-object -w --stdin) &&
+	test_when_finished "remove_object $sha" &&
+	cat >wrong-tag <<-EOF &&
+	object $sha
+	type commit
+	tag wrong
+	tagger T A Gger <tagger@example.com> 1234567890 -0000
+
+	This is an invalid tag.
+	EOF
+
+	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
+	test_when_finished "remove_object $tag" &&
+	echo $tag >.git/refs/tags/wrong &&
+	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
 	cat out &&
-	grep "error in tag.*broken links" out &&
-	rm .git/refs/tags/wrong
+	grep "error in tag.*broken links" out
 '
 
-
+test_expect_success 'cleaned up' '
+	git fsck >actual 2>&1 &&
+	test_cmp empty actual
+'
 
 test_done
-- 
1.7.2.3
