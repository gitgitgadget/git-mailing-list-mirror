From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: resurrect XDF_NEED_MINIMAL with --minimal
Date: Sat, 01 Oct 2011 22:04:27 -0700
Message-ID: <7voby0j86c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 07:04:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAEE7-0001tm-Kw
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 07:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab1JBFEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Oct 2011 01:04:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab1JBFEa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2011 01:04:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B5F030F1;
	Sun,  2 Oct 2011 01:04:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=2Eb63mp01IKss7uDR0yHCrvMf
	jA=; b=ddy3mN66ULWpa7YrLsj8Ct74sNDLjSeJmjBtxA+WhuLblYOtXhNbuguZJ
	r8vbk8b6HQRxECb1F4nPg/x288X8Np/Q+KgWWxJEQ3NWDhXhuA7W8dKs2GhTc9kn
	GS0qP0Vs9T3MAN3MmB+EhoOUFlgZ8R1ufd6YSHsD90q0KcuJtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=kuHyGQEXwdO3Bz5yUfL
	P1qokNyXNHmK10C/EtqMEhJRvWowWb81N1urcO96hnfJKmZg9r05PvUP0DbfddVG
	HC6pwAGjQLWqWg3QJndszsOx363bLWkWdzNAXomoqVcs2ObgsKSre/LtN8Snb7sK
	J92tbgv2chYowkDxyU3WITj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2967430F0;
	Sun,  2 Oct 2011 01:04:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A724330EF; Sun,  2 Oct 2011
 01:04:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01A4A9AA-ECB4-11E0-B260-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182592>

Earlier, 582aa00 (git diff too slow for a file, 2010-05-02)
unconditionally dropped XDF_NEED_MINIMAL option from the internal xdiff
invocation to help performance on pathological cases, while hinting tha=
t a
follow-up patch could reintroduce it with "--minimal" option from the
command line.

Make it so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This together with Ren=C3=A9's c5aa906 (Revert removal of multi-matc=
h
   discard heuristic in 27af01, 2011-09-25) on top of v1.7.7 seems to g=
ive
   identical diff output as v1.7.1 (e.g. "git diff-tree -p v2.6.39 v3.0=
"
   in the kernel repository, with "--minimal").

 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 93ef9a2..34a88db 100644
--- a/diff.c
+++ b/diff.c
@@ -3511,6 +3511,10 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev =3D DEFAULT_ABBREV;
+	else if (!strcmp(arg, "--minimal"))
+		DIFF_XDL_SET(options, NEED_MINIMAL);
+	else if (!strcmp(arg, "--no-minimal"))
+		DIFF_XDL_CLR(options, NEED_MINIMAL);
 	else if (!prefixcmp(arg, "--abbrev=3D")) {
 		options->abbrev =3D strtoul(arg + 9, NULL, 10);
 		if (options->abbrev < MINIMUM_ABBREV)
--=20
1.7.7
