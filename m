From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Tue, 19 Mar 2013 14:03:09 -0700
Message-ID: <7v620nhzle.fsf@alter.siamese.dyndns.org>
References: <201303192049.58755.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	j6t@kdbg.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 19 22:03:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI3hC-0005GT-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 22:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934229Ab3CSVDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 17:03:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932661Ab3CSVDR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 17:03:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10F4F66F7;
	Tue, 19 Mar 2013 17:03:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pl8bNneN1a+y
	UjXF6Fp2sE3k02Y=; b=yfom0mjc5vfyv7gaNX+pNpTwlSbJ7QGhJYdGJJa4dU/O
	UFVaGplQSTjYV4i1MqUFFyt6Iz6NwHIUZXW6UZrFff8wCRQyZRCtE6zqa3UeaMco
	GvRhfdySlaXIIToxiWu93p29u1cE8+2RmtyEDFIK+sINKUyBYPzw1VtTkTDZUpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mgbnuO
	+ecudnKOuBHXbylfcX3/2yj0TL97G5QdtWOP9bNcGVm2Wfn+prhazA7FSRSXfRO0
	c8vUtfRTBdRtb82hmf8g7wUO8BVeGUtQ4eCPetpK5wBFV1/KSH6WUkK7nk8+ctyE
	mKjB3yaGiKq9Wdkn7OwBoOzWxmnKs/ExNnluY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04EF666F5;
	Tue, 19 Mar 2013 17:03:17 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E36666EA; Tue, 19 Mar 2013
 17:03:16 -0400 (EDT)
In-Reply-To: <201303192049.58755.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Tue, 19 Mar 2013 20:49:58
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B6A14BE-90D8-11E2-AD43-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218555>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Use a compile switch IGNORECYGWINFSTRICKS to disable the usage
> of cygwin_lstat_fn() only in path.c

The analysis of the problem and the basic idea to disable the
fast-but-lying fstricks in the code that matters may be good, but
the implementation is questionable.

What if we later need to move functions around, etc., so that some
other calls in path.c still do want to use the fstricks bit while
the existing ones in the file want the real lstat() information?

Actually, that already is the case.  The call to lstat() in
validate_headref() only cares about the S_ISXXX() type and can
afford to use the fast-and-lying one, no?

How about doing something like this in the generic codepath, and
implement your own cygwin_true_mode_bits() function at the cygwin
compatibility layer, and add

    #define true_mode_bits cygwin_true_mode_bits

in the compat/cygwin.h file?  The change has the documentation value
to clarify what each lstat() is used for, too.

Ideally, the "#ifndef true_mode_bits" part may want to become a
generic helper function if there are lstat() calls in other files
that cygwin wants to use the real lstat() not the fast-but-lying
one, but one step at a time.

Hrm?

 path.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index d3d3f8b..d0b31e5 100644
--- a/path.c
+++ b/path.c
@@ -14,6 +14,21 @@
 #include "strbuf.h"
 #include "string-list.h"
=20
+#ifndef true_mode_bits
+/*
+ * The replacement lstat(2) we use on Cygwin is incomplete and
+ * lies about permission bits; most of the time we do not care,
+ * but the callsites of this wrpper do care.
+ */
+static int true_mode_bits(const char *path, int *mode)
+{
+	struct stat st;
+	if (lstat(path, &st) < 0)
+		return -1;
+	return st.st_mode;
+}
+#endif
+
 static char bad_path[] =3D "/bad-path/";
=20
 static char *get_pathname(void)
@@ -400,9 +415,8 @@ int set_shared_perm(const char *path, int mode)
 		return 0;
 	}
 	if (!mode) {
-		if (lstat(path, &st) < 0)
+		if (true_mode_bits(path, &mode) < 0)
 			return -1;
-		mode =3D st.st_mode;
 		orig_mode =3D mode;
 	} else
 		orig_mode =3D 0;
