From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG RFC/PATCH] git-cvsimport
Date: Mon, 16 Aug 2010 09:25:01 -0700
Message-ID: <7vpqxicyoy.fsf@alter.siamese.dyndns.org>
References: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
 <4C68BD66.9060506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 16 18:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol2VF-0002PR-EP
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 18:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836Ab0HPQZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 12:25:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab0HPQZP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 12:25:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE5BCCDACB;
	Mon, 16 Aug 2010 12:25:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O36L6ybe82iV
	19xxq+2Tvnyeslg=; b=aa6lqn6YfISpDHtlCsV2Ef/B7w68UoIKaZM1LJ1R66Pb
	ctr/U0ds37WS3cEGfwCRqc9DgwzfRrKhWAJrRN3F4Kv2gIhSavOIdwC6O9gfA0i9
	VFGU/yNdsICApWheySUSUZJQX77VYQfvVFQtKYnwbho33GdyAjli0TmvU6ql+Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tFcWcx
	aRs0dF28wQwUQ6iNNfm3/DyMW7oYMPusJZLHzGW/S7tuyofudL+OaWmsIwcf1MEH
	cKEf/xMwLT8NE8e+Gvn2H3R0RQXxp0p6V4Lh6zwGjbqnu1u0stxh3iVLChXNeH/I
	SXUijXIOAkPz/o2fvTf7YkEvDnHUUMs7ID7EE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A7AACDAC5;
	Mon, 16 Aug 2010 12:25:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 355E9CDAA3; Mon, 16 Aug
 2010 12:25:04 -0400 (EDT)
In-Reply-To: <4C68BD66.9060506@alum.mit.edu> (Michael Haggerty's message of
 "Mon\, 16 Aug 2010 06\:24\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6741A4A-A952-11DF-A102-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153660>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> My guess is that cvsps is using CVS commands to access the test CVS
> repository, and that CVS wants to write to the file CVSROOT/history t=
o
> log what is being done.  The logging behavior can be turned off eithe=
r:
> ...
> Apparently -R and "$CVSREADONLYFS" were added in CVS 1.12.1, which wa=
s
> released in 2003.

That unfortunately does not solve much.  t9602 seems to want to create =
a
new CVSROOT/val-tags file, so if =C3=86var wants to keep the source tre=
e
read-only, the test CVS repository needs to be copied to a scratch plac=
e.

Perhaps something like this?  I actually have to wonder why cvsIMPORT
needs to write into anywhere, though.

-- >8 --
Subject: cvs tests: do not touch test CVS repositories shipped with sou=
rce

Some tests in t96xx series (cvsimport) want to write into the control a=
rea
(CVSROOT) of their test CVS repositories, but this does not work well w=
hen
the source area is made read-only (test trash directories are moved via
--root=3Delse/where option).

Copy the supplied test CVS repository to a scratch place at the beginni=
ng
of these tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/Makefile                         |    1 -
 t/lib-cvs.sh                       |    6 ++++++
 t/t9601-cvsimport-vendor-branch.sh |    3 +--
 t/t9602-cvsimport-branches-tags.sh |    3 +--
 t/t9603-cvsimport-patchsets.sh     |    3 +--
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index cf5f9e2..876d2ca 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -28,7 +28,6 @@ pre-clean:
=20
 clean:
 	$(RM) -r 'trash directory'.* test-results
-	$(RM) t????/cvsroot/CVSROOT/?*
 	$(RM) -r valgrind/bin
=20
 aggregate-results-and-cleanup: $(T)
diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 648d161..b51d2e1 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -30,6 +30,12 @@ case "$cvsps_version" in
 	;;
 esac
=20
+setup_cvs_test_repository () {
+	CVSROOT=3D"$(pwd)/.cvsroot" &&
+	cp -r "$TEST_DIRECTORY/$1/cvsroot" "$CVSROOT" &&
+	export CVSROOT
+}
+
 test_cvs_co () {
 	# Usage: test_cvs_co BRANCH_NAME
 	rm -rf module-cvs-"$1"
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-ven=
dor-branch.sh
index 3afaf56..b23479f 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -34,8 +34,7 @@
 test_description=3D'git cvsimport handling of vendor branches'
 . ./lib-cvs.sh
=20
-CVSROOT=3D"$TEST_DIRECTORY"/t9601/cvsroot
-export CVSROOT
+setup_cvs_test_repository t9601
=20
 test_expect_success 'import a module with a vendor branch' '
=20
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-bra=
nches-tags.sh
index 67878b2..ed01d8a 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -6,8 +6,7 @@
 test_description=3D'git cvsimport handling of branches and tags'
 . ./lib-cvs.sh
=20
-CVSROOT=3D"$TEST_DIRECTORY"/t9602/cvsroot
-export CVSROOT
+setup_cvs_test_repository t9602
=20
 test_expect_success 'import module' '
=20
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchse=
ts.sh
index 958bdce..93c4fa8 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -14,8 +14,7 @@
 test_description=3D'git cvsimport testing for correct patchset estimat=
ion'
 . ./lib-cvs.sh
=20
-CVSROOT=3D"$TEST_DIRECTORY"/t9603/cvsroot
-export CVSROOT
+setup_cvs_test_repository t9603
=20
 test_expect_failure 'import with criss cross times on revisions' '
=20
