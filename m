From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/17] request-pull: use the annotated tag contents
Date: Wed, 09 Nov 2011 05:20:54 -0800
Message-ID: <7v8vnpwhxl.fsf@alter.siamese.dyndns.org>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 14:21:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO85O-0001tW-IP
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 14:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab1KINU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 08:20:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab1KINU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 08:20:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1071E5F79;
	Wed,  9 Nov 2011 08:20:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TxCawTjNiYUWRbjpyI1Hc0tn6VU=; b=ydQdEZ
	aS9F7sxwH4b5TVQdMz28G/sOVTojWbQdpuEbBq7PDm26xZ53zm7FN0zMDsbSJrxF
	0ZsdCQi5Yq5WCilARoGzghKFSmU4FbuDTccDZ0aB7VBxZNuGLecqfvgk1behxLa8
	e0uGB2sXHnx8/Gkm5psIEWMVVVXZlGTDwBGbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWWZ91CwCie7gRoS5ctqfpDc7gaj5SbI
	o7yn3QdLfJED4NleicWBurpAP5RPuYW+vkFHtYXYqUmzZ0PMHIE0lOAmZY5Xbw9W
	+RKQJS3F2m4KVfGA9h83JCdPbh+0euBrIeu5Nqi3lBAEeoM3MoDVK35aWuDPnufu
	JRWqEKbQCVQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0672C5F78;
	Wed,  9 Nov 2011 08:20:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57E645F77; Wed,  9 Nov 2011
 08:20:56 -0500 (EST)
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Tue, 8 Nov 2011 17:01:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A82DB638-0AD5-11E1-B2C5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185156>

The integrator tool will start allowing to pull signed or an annotated
tag, i.e.

    $ git pull $there tags/for-linus

and the description in the tag is used to convey a meaningful message from
the lieutenant to the integrator to justify the history being pulled.

Include the message in the pull request e-mail, as the same information is
useful in this context, too. It would encourage the lieutenants to write
meaningful messages in their signed tags.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Goes on top of jc/request-pull-show-head-4 that has been cooking in
   the 'next' branch.

 git-request-pull.sh     |   14 ++++++++++++++
 t/t5150-request-pull.sh |    4 ++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 626cf25..c6a5b7a 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -48,6 +48,8 @@ then
 	fi
 fi
 
+tag_name=$(git describe --exact "$head^0" 2>/dev/null)
+
 test -n "$base" && test -n "$url" || usage
 baserev=$(git rev-parse --verify "$base"^0) &&
 headrev=$(git rev-parse --verify "$head"^0) || exit
@@ -82,8 +84,20 @@ then
 	echo "(from the branch description for $branch local branch)"
 	echo
 	git config "branch.$branch_name.description"
+fi &&
+
+if test -n "$tag_name"
+then
+	git cat-file tag "$tag_name" |
+	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
+	echo
+fi &&
+
+if test -n "$branch_name" || test -n "$tag_name"
+then
 	echo "----------------------------------------------------------------"
 fi &&
+
 git shortlog ^$baserev $headrev &&
 git diff -M --stat --summary $patch $merge_base..$headrev || status=1
 
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 5bd1682..ea6f692 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -86,6 +86,7 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 	s/$downstream_url_for_sed/URL/g
 	s/for-upstream/BRANCH/g
 	s/mnemonic.txt/FILENAME/g
+	s/^version [0-9]/VERSION/
 	/^ FILENAME | *[0-9]* [-+]*\$/ b diffstat
 	/^AUTHOR ([0-9]*):\$/ b shortlog
 	p
@@ -201,6 +202,9 @@ test_expect_success 'pull request format' '
 	  SUBJECT (DATE)
 
 	----------------------------------------------------------------
+	VERSION
+
+	----------------------------------------------------------------
 	SHORTLOG
 
 	DIFFSTAT
-- 
1.7.8.rc1.82.gde0f9
