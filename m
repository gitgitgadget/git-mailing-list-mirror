From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib.sh: Dynamic test for the prerequisite SANITY
Date: Tue, 27 Jan 2015 14:20:19 -0800
Message-ID: <xmqqh9vbkgrg.fsf@gitster.dls.corp.google.com>
References: <54C7B115.7020405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:20:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGEUu-00023o-VF
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 23:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119AbbA0WUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 17:20:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933097AbbA0WUW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2015 17:20:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B77432CC2;
	Tue, 27 Jan 2015 17:20:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4x/AsQ+gwVXX
	mEn2tEfRifTP43o=; b=LMyhQxqEVl+5mb6/nXRCtanwDgNs/0jtvgY3Jno0w01w
	K915iSzLPGML1wrHu1yfxlyfRUVVETkGL3e/mgmzVWrCeKbw7iCZ+OGQWozjkMq8
	nSMr3DprM3Y6daudU87laJxYa8a5/9a/QdhelyVGA9/u94TXu8PKR/hqR31oYSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EY9cuT
	6nvIrrPrGco83ZPYlrRW5t0UhUJsJs01nwLLl/oL8q1AAL25yQgIP0yUydOHS30n
	p7/SPaIBnEgiFeSUEJaREGkcGA5RbQkVC67h5wmhZRhO7nIh3BNfJowmKH+L0Vxc
	dk5mKxqGn3Ea8tg2hWnrR0xHIsmmxf66N1f18=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9154E32CC1;
	Tue, 27 Jan 2015 17:20:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E15532CBD;
	Tue, 27 Jan 2015 17:20:20 -0500 (EST)
In-Reply-To: <54C7B115.7020405@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 27 Jan 2015 16:39:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE6ACF72-A672-11E4-B7A5-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263093>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>  # When the tests are run as root, permission tests will report that
>  # things are writable when they shouldn't be.

This no longer is relevant, I think.

> +# Special check for CYGWIN (or Windows in general):

Misleading comment in the end result, as your new test drops SANITY
correctly on POSIX for the root user, too.  In a commit log message
it is correct to say "This adds special check for Cygwin", but the
resulting code is sensible with or without Cygwin, I would think,
with the justification to "test by checking what we really want, not
by inferring from the result of indirectly testing something else".

> +# A file can be deleted, even if the containing directory does'nt
> +# have write permissions

We also rely on SANITY to make sure that "chmod -rx directory" makes
"directory/file" undiscoverable.

How about extending it like this (not tested)?

-- >8 --
=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>
Date: Tue, 27 Jan 2015 16:39:01 +0100
Subject: [PATCH] test-lib.sh: set prerequisite SANITY by testing what w=
e really need

What we wanted out of the SANITY precondition is that the filesystem
behaves sensibly with permission bits settings.

 - You should not be able to remove a file in a read-only directory,

 - You should not be able to tell if a file in a directory exists if
   the directory lacks read or execute permission bits.

We used to cheat by approximating that condition with "is the /
writable?" test and/or "are we running as root?" test.  Neither test
is sufficient or appropriate in more exotic environments like
Cygwin.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b2b2ec7..446d8d5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -997,9 +997,28 @@ test_lazy_prereq NOT_ROOT '
 	test "$uid" !=3D 0
 '
=20
-# When the tests are run as root, permission tests will report that
-# things are writable when they shouldn't be.
-test -w / || test_set_prereq SANITY
+# On a filesystem that lacks SANITY, a file can be deleted even if
+# the containing directory doesn't have write permissions, or a file
+# can be accessed even if the containing directory doesn't have read
+# or execute permissions, causing our tests that validate that Git
+# works sensibly in such situations.
+test_lazy_prereq SANITY '
+	mkdir SANETESTD.1 SANETESTD.2 &&
+
+	chmod +w SANETESTD.1 SANETESTD.2 &&
+	>SANETESTD.1/x 2>SANETESTD.2/x &&
+	chmod -w SANETESTD.1 &&
+	chmod -rx SANETESTD.2 ||
+	error "bug in test sript: cannot prepare SANETESTD"
+
+	! rm SANETESTD.1/x && ! test -f SANETESTD.2/x
+	status=3D$?
+
+	chmod +rwx SANETESTD.1 SANETESTD.2 &&
+	rm -rf SANETESTD.1 SANETESTD.2 ||
+	error "bug in test sript: cannot clean SANETESTD"
+	return $status
+'
=20
 GIT_UNZIP=3D${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
--=20
2.3.0-rc1-180-g1a69fe5
