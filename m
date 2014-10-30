From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Thu, 30 Oct 2014 11:07:39 -0700
Message-ID: <xmqqlhnxwhw4.fsf@gitster.dls.corp.google.com>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
	<xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:07:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xju8S-0006GC-9I
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 19:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759686AbaJ3SHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2014 14:07:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758972AbaJ3SHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 14:07:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D7BA199A3;
	Thu, 30 Oct 2014 14:07:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BZcMgeryuG2N
	3Z+802Is0ar9koA=; b=ElHaF4+P2+OpNI5oOh29nXdNjM3qaI1eVXRXRYaHIDDI
	r9fhN9VKJ74+AcHbvxV813USMVpfA/5qRT9Fyb2cwivnuQSm/R4hxTxBTnCnpsBy
	3YkU+rnUSUfCxu6e4MU5GYA5mwXN0l5F9ro5xOjgP3XjBWKg2l3OWLpnXhKPi7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cZmF6x
	5y9dFp5SxgGVDCdGOpl141nQ77GlCpsHPwJeQyIGcHLzl6VGQI6LEqz9hOgl/+e+
	mxwRM2xsyo/p/247Mxy03oG80ERSwrGLm6J5zSDUXGc3EUL8n5ekzZo8BM14HLcf
	FeYcd8o0/ca/KcJDwuYrCMwO3IyvUPr/9BAGY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AAC4199A2;
	Thu, 30 Oct 2014 14:07:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 686DB1999F;
	Thu, 30 Oct 2014 14:07:41 -0400 (EDT)
In-Reply-To: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Oct 2014 12:16:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3CFFF50-605F-11E4-9DFF-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Probably three helper functions:
>
>  - The first is to find tops and bottoms (this translates fuzzy
>    specifications such as "--since 30.days" into a more concrete
>    revision range "^A ^B ... Z" to establish bundle prerequisites),
>    which is done by running a "rev-list --boundary".
>
>  - The second is to show refs, while paying attention to things like
>    "--10 maint master" which may result in the tip of 'maint' not
>    being shown at all.  I am not sure if this part can/should take
>    advantage of revs.cmdline, though.
>
>  - The last is to create the actual pack data.
>
> I agree with your analysis on the change in column.c and trailer.c
>
> Thanks.

So here are a few patches on top of Ren=C3=A9's change.  This is the
third point in the above list.

-- >8 --
Subject: [PATCH] bundle: split out a helper function to create a pack d=
ata

The create_bundle() function, while it does one single logical thing
and tries to do it well, that single logical thing takes a rather
large implementation.

Let's start separating what it does into smaller steps to make it
easier what is going on.  This is a first step to separate out the
actual pack-data generation, after the earlier part of the function
figures out which part of the history to place in the bundle.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bundle.c | 64 +++++++++++++++++++++++++++++++++++++-------------------=
--------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/bundle.c b/bundle.c
index c846092..9c87532 100644
--- a/bundle.c
+++ b/bundle.c
@@ -235,6 +235,41 @@ out:
 	return result;
 }
=20
+static int write_pack_data(int bundle_fd, struct lock_file *lock, stru=
ct rev_info *revs)
+{
+	struct child_process pack_objects =3D CHILD_PROCESS_INIT;
+	int i;
+
+	argv_array_pushl(&pack_objects.args,
+			 "pack-objects", "--all-progress-implied",
+			 "--stdout", "--thin", "--delta-base-offset",
+			 NULL);
+	pack_objects.in =3D -1;
+	pack_objects.out =3D bundle_fd;
+	pack_objects.git_cmd =3D 1;
+	if (start_command(&pack_objects))
+		return error(_("Could not spawn pack-objects"));
+
+	/*
+	 * start_command closed bundle_fd if it was > 1
+	 * so set the lock fd to -1 so commit_lock_file()
+	 * won't fail trying to close it.
+	 */
+	lock->fd =3D -1;
+
+	for (i =3D 0; i < revs->pending.nr; i++) {
+		struct object *object =3D revs->pending.objects[i].item;
+		if (object->flags & UNINTERESTING)
+			write_or_die(pack_objects.in, "^", 1);
+		write_or_die(pack_objects.in, sha1_to_hex(object->sha1), 40);
+		write_or_die(pack_objects.in, "\n", 1);
+	}
+	close(pack_objects.in);
+	if (finish_command(&pack_objects))
+		return error(_("pack-objects died"));
+	return 0;
+}
+
 int create_bundle(struct bundle_header *header, const char *path,
 		  int argc, const char **argv)
 {
@@ -381,34 +416,9 @@ int create_bundle(struct bundle_header *header, co=
nst char *path,
 	write_or_die(bundle_fd, "\n", 1);
=20
 	/* write pack */
-	child_process_init(&rls);
-	argv_array_pushl(&rls.args,
-			 "pack-objects", "--all-progress-implied",
-			 "--stdout", "--thin", "--delta-base-offset",
-			 NULL);
-	rls.in =3D -1;
-	rls.out =3D bundle_fd;
-	rls.git_cmd =3D 1;
-	if (start_command(&rls))
-		return error(_("Could not spawn pack-objects"));
-
-	/*
-	 * start_command closed bundle_fd if it was > 1
-	 * so set the lock fd to -1 so commit_lock_file()
-	 * won't fail trying to close it.
-	 */
-	lock.fd =3D -1;
+	if (write_pack_data(bundle_fd, &lock, &revs))
+		return -1;
=20
-	for (i =3D 0; i < revs.pending.nr; i++) {
-		struct object *object =3D revs.pending.objects[i].item;
-		if (object->flags & UNINTERESTING)
-			write_or_die(rls.in, "^", 1);
-		write_or_die(rls.in, sha1_to_hex(object->sha1), 40);
-		write_or_die(rls.in, "\n", 1);
-	}
-	close(rls.in);
-	if (finish_command(&rls))
-		return error(_("pack-objects died"));
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
 			die_errno(_("cannot create '%s'"), path);
--=20
2.1.3-612-g493e79e
