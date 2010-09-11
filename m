From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] ls-tree $di $dir: do not mistakenly recurse into
 directories
Date: Sat, 11 Sep 2010 12:00:19 -0700
Message-ID: <7vd3skf6m4.fsf_-_@alter.siamese.dyndns.org>
References: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
 <vpqzkvr5u73.fsf@bauges.imag.fr> <7vhbhwf6q5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davi.reis@gmail.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Sep 11 21:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuVJU-0008P1-VF
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 21:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab0IKTAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 15:00:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab0IKTAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 15:00:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C43D8D5856;
	Sat, 11 Sep 2010 15:00:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JAiKItqxqYPNJzfN1hhJLJ4BMj8=; b=sh6IYW
	55NgHmXoS6W5BcZCjplYJTHi1tJD346Ex0y4HPZrvg/Qd0EqGVRNCEDozVyxez1E
	SSGoBTelh1nxe6CqEeGHdmgjIw3bsgHwD+ETweh70CO0pBh7bBWBSvu4J3EAdcap
	eMphj+iaoiDNvZlxLOIC7CBpVvOqg4SdK8oO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v/Pw/2HdM/9fpXI9g4BXqNzKkCiWXArt
	WIByaqYBEKUPfHVor2lfeFT8uhRvhBoxDsk2fqifhbAwSU+ZPCLfOuPNfw/IeOGC
	OfjS+dV983CeP+pLfvhC8+tiihBd/q+XkATCMFxyDGQzwAu0IpHHDmrSZZNisswB
	JUWKmThS44I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DF94D5855;
	Sat, 11 Sep 2010 15:00:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46ED9D5853; Sat, 11 Sep
 2010 15:00:21 -0400 (EDT)
In-Reply-To: <7vhbhwf6q5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 11 Sep 2010 11\:57\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D73271B4-BDD6-11DF-A981-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156006>

When applying two pathspecs, one of which is named as a prefix to the
other, we mistakenly recursed into the shorter one.

Noticed and fixed by David Reis.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

  > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
  >
  >> That's so close to a real test-case...
  >
  > Let's do this.
  >
  >  * t3101 seems somewhat stale; fix the style and add a few missing " &&"
  >    cascades as a preparatory patch.
  >
  >  * Add the "mistaken prefix computation causes unwarranted recursion" fix
  >    with a test.
  >
  > Here is the first one in such a series.

  and here is the second one.

 builtin/ls-tree.c          |    2 ++
 t/t3101-ls-tree-dirname.sh |   20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dc86b0d..a818756 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -52,6 +52,8 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 		speclen = strlen(spec);
 		if (speclen <= len)
 			continue;
+		if (spec[len] && spec[len] != '/')
+			continue;
 		if (memcmp(pathname, spec, len))
 			continue;
 		return 1;
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 026f9f8..ed8160c 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -15,6 +15,7 @@ This test runs git ls-tree with the following in a tree.
     path2/1.txt        - a file in a directory
     path3/1.txt        - a file in a directory
     path3/2.txt        - a file in a directory
+    path30/3.txt       - a file in a directory
 
 Test the handling of mulitple directories which have matching file
 entries.  Also test odd filename and missing entries handling.
@@ -24,7 +25,7 @@ entries.  Also test odd filename and missing entries handling.
 test_expect_success 'setup' '
 	echo 111 >1.txt &&
 	echo 222 >2.txt &&
-	mkdir path0 path0/a path0/a/b path0/a/b/c &&
+	mkdir path0 path0/a path0/a/b path0/a/b/c path30 &&
 	echo 111 >path0/a/b/c/1.txt &&
 	mkdir path1 path1/b path1/b/c &&
 	echo 111 >path1/b/c/1.txt &&
@@ -33,6 +34,7 @@ test_expect_success 'setup' '
 	mkdir path3 &&
 	echo 111 >path3/1.txt &&
 	echo 222 >path3/2.txt &&
+	echo 333 >path30/3.txt &&
 	find *.txt path* \( -type f -o -type l \) -print |
 	xargs git update-index --add &&
 	tree=`git write-tree` &&
@@ -53,6 +55,7 @@ test_expect_success 'ls-tree plain' '
 040000 tree X	path1
 040000 tree X	path2
 040000 tree X	path3
+040000 tree X	path30
 EOF
 	test_output
 '
@@ -68,6 +71,7 @@ test_expect_success 'ls-tree recursive' '
 100644 blob X	path2/1.txt
 100644 blob X	path3/1.txt
 100644 blob X	path3/2.txt
+100644 blob X	path30/3.txt
 EOF
 	test_output
 '
@@ -164,6 +168,7 @@ test_expect_success 'ls-tree --full-tree' '
 040000 tree X	path1
 040000 tree X	path2
 040000 tree X	path3
+040000 tree X	path30
 EOF
 	test_output
 '
@@ -181,6 +186,7 @@ test_expect_success 'ls-tree --full-tree -r' '
 100644 blob X	path2/1.txt
 100644 blob X	path3/1.txt
 100644 blob X	path3/2.txt
+100644 blob X	path30/3.txt
 EOF
 	test_output
 '
@@ -195,6 +201,7 @@ test_expect_success 'ls-tree --abbrev=5' '
 040000 tree X	path1
 040000 tree X	path2
 040000 tree X	path3
+040000 tree X	path30
 EOF
 	test_cmp expected check
 '
@@ -208,6 +215,7 @@ path0
 path1
 path2
 path3
+path30
 EOF
 	test_output
 '
@@ -222,6 +230,16 @@ path1/b/c/1.txt
 path2/1.txt
 path3/1.txt
 path3/2.txt
+path30/3.txt
+EOF
+	test_output
+'
+
+test_expect_success 'ls-tree with two dirnames' '
+	git ls-tree --name-only $tree path3 path30 >current &&
+	cat >expected <<\EOF &&
+path3
+path30
 EOF
 	test_output
 '
-- 
1.7.3.rc1.215.g6997c
