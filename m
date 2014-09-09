From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsck: exit with non-zero status upon error from fsck_obj()
Date: Tue, 09 Sep 2014 15:03:33 -0700
Message-ID: <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
References: <1409177412.15185.3.camel@leckie>
	<20140829185325.GC29456@peff.net>
	<xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
	<1409343480.19256.2.camel@leckie> <20140829203145.GA510@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTVl-0002nu-5s
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbaIIWDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:03:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59012 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbaIIWDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:03:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9F7038EA7;
	Tue,  9 Sep 2014 18:03:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bBLKDke3twh5fdIqjHO64CITptA=; b=vdVfpz
	NeHXIfHqOxLnFaPUIuH79TmS6aclz4UoWtyaKT8YEXHRYhBGSPJQNjYHhRhycqXS
	wcds4StC0aTEKAmovtXE+nbiJqG6K+8MgAgzxd7DmpG9RoPafG0ZtZOAFDOg5IOV
	6oMvPHaVTi2psv0aFAxBIro8sN5TxImXt/0Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJcGYtSRKvB3Ag3UkZBqUgltY3exgXTC
	aZSIneBtse2Nag/hGdhfLpLNQbiUXL/G7JTnHZ1Ey08Oozy+wftd8RaNzou8CeOr
	GcDLYqil+lGm+yt+W7Hpv0A/lpp5dXOcwdCX7DqhlfsNSZifYDd13f5slDBT3e99
	9EqnCukJ8dM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C09EF38EA6;
	Tue,  9 Sep 2014 18:03:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E7D838EA5;
	Tue,  9 Sep 2014 18:03:35 -0400 (EDT)
In-Reply-To: <20140829203145.GA510@peff.net> (Jeff King's message of "Fri, 29
	Aug 2014 16:31:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 25147EE4-386D-11E4-B4A1-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256712>

From: Jeff King <peff@peff.net>
Date: Fri, 29 Aug 2014 16:31:46 -0400

Upon finding a corrupt loose object, we forgot to note the error to
signal it with the exit status of the entire process.

[jc: adjusted t1450 and added another test]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I think your fix is a right one that catches all the "we can
   parse minimally for the purpose of 'struct object' class system,
   but the object is semantically broken" cases, as fsck_obj() is
   where such a validation should all happen.

   I can haz a sign off?  Thanks.

 builtin/fsck.c  |  3 ++-
 t/t1450-fsck.sh | 30 +++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1affdd5..8abe644 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -389,7 +389,8 @@ static void fsck_sha1_list(void)
 		unsigned char *sha1 = entry->sha1;
 
 		sha1_list.entry[i] = NULL;
-		fsck_sha1(sha1);
+		if (fsck_sha1(sha1))
+			errors_found |= ERROR_OBJECT;
 		free(entry);
 	}
 	sha1_list.nr = 0;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8c739c9..c8dff9c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -101,7 +101,7 @@ test_expect_success 'email with embedded > is not okay' '
 	test_when_finished "remove_object $new" &&
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
-	git fsck 2>out &&
+	test_must_fail git fsck 2>out &&
 	cat out &&
 	grep "error in commit $new" out
 '
@@ -113,7 +113,7 @@ test_expect_success 'missing < email delimiter is reported nicely' '
 	test_when_finished "remove_object $new" &&
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
-	git fsck 2>out &&
+	test_must_fail git fsck 2>out &&
 	cat out &&
 	grep "error in commit $new.* - bad name" out
 '
@@ -125,7 +125,7 @@ test_expect_success 'missing email is reported nicely' '
 	test_when_finished "remove_object $new" &&
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
-	git fsck 2>out &&
+	test_must_fail git fsck 2>out &&
 	cat out &&
 	grep "error in commit $new.* - missing email" out
 '
@@ -137,7 +137,7 @@ test_expect_success '> in name is reported' '
 	test_when_finished "remove_object $new" &&
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
-	git fsck 2>out &&
+	test_must_fail git fsck 2>out &&
 	cat out &&
 	grep "error in commit $new" out
 '
@@ -151,11 +151,31 @@ test_expect_success 'integer overflow in timestamps is reported' '
 	test_when_finished "remove_object $new" &&
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
-	git fsck 2>out &&
+	test_must_fail git fsck 2>out &&
 	cat out &&
 	grep "error in commit $new.*integer overflow" out
 '
 
+test_expect_success 'malformatted tree object' '
+	test_when_finished "git update-ref -d refs/tags/wrong" &&
+	test_when_finished "remove_object \$T" &&
+	T=$(
+		GIT_INDEX_FILE=test-index &&
+		export GIT_INDEX_FILE &&
+		rm -f test-index &&
+		>x &&
+		git add x &&
+		T=$(git write-tree) &&
+		(
+			git cat-file tree $T &&
+			git cat-file tree $T
+		) |
+		git hash-object -w -t tree --stdin
+	) &&
+	test_must_fail git fsck 2>out &&
+	grep "error in tree .*contains duplicate file entries" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
-- 
2.1.0-449-g93bbe5b
