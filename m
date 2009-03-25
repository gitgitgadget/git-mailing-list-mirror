From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Tue, 24 Mar 2009 17:46:49 -0700
Message-ID: <7vvdpybf9i.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmHJ2-0000fA-Vx
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759787AbZCYAq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 20:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759758AbZCYAq5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:46:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759736AbZCYAq4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 20:46:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0AA489EC8;
	Tue, 24 Mar 2009 20:46:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 46A699EC4; Tue,
 24 Mar 2009 20:46:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6F7EC9E2-18D6-11DE-B029-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114529>

Johan Herland <johan@herland.net> writes:

>   core.sharedRepository
>     [...] When 0xxx, where 0xxx is an octal number, files in the repo=
sitory
>     will have this mode value. 0xxx will override user=E2=80=99s umas=
k value, and
>     thus, users with a safe umask (0077) can use this option. [...]

Traditionally, core.shreadrepository was used only to widen overtight
umask some paranoid users have that are antisocial in a group project
setting.  An object that happens to have created by a lenient member ma=
y
be readable by others, but another object created by a member with
stricter umask won't be, which means "core.sharedRepository =3D group" =
means
just that; it guarantees that it is at least usable by everybody in the
group even if there is somebody antisocial in the group, and it does no=
t
say anything about accessibility by others at all.

You might like to try a patch like this (untested).

 path.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/path.c b/path.c
index e332b50..fbc7011 100644
--- a/path.c
+++ b/path.c
@@ -314,7 +314,7 @@ char *enter_repo(char *path, int strict)
 int adjust_shared_perm(const char *path)
 {
 	struct stat st;
-	int mode;
+	int mode, tweak;
=20
 	if (!shared_repository)
 		return 0;
@@ -322,17 +322,10 @@ int adjust_shared_perm(const char *path)
 		return -1;
 	mode =3D st.st_mode;
=20
-	if (shared_repository) {
-		int tweak =3D shared_repository;
-		if (!(mode & S_IWUSR))
-			tweak &=3D ~0222;
-		mode |=3D tweak;
-	} else {
-		/* Preserve old PERM_UMASK behaviour */
-		if (mode & S_IWUSR)
-			mode |=3D S_IWGRP;
-	}
-
+	tweak =3D shared_repository;
+	if (!(mode & S_IWUSR))
+		tweak &=3D ~0222;
+	mode =3D (mode & ~0777) | tweak;
 	if (S_ISDIR(mode)) {
 		mode |=3D FORCE_DIR_SET_GID;
=20
