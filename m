From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= 
	<4ux6as402@sneakemail.com>
Subject: [PATCH] Teach git log --check to return an appropriate error code
Date: Sat,  9 Aug 2008 08:57:34 +0200
Message-ID: <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
References: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 09:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRiV0-0007iq-FQ
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 09:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYHIG5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 02:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYHIG5p
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 02:57:45 -0400
Received: from morch.com ([193.58.255.207]:46543 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbYHIG5o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 02:57:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by morch.com (Postfix) with ESMTP id B292A290D
	for <git@vger.kernel.org>; Sat,  9 Aug 2008 09:00:16 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.6.gcd432.dirty
In-Reply-To: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91744>

=46rom: Peter Valdemar M=C3=B8rch <peter@morch.com>


Signed-off-by: Peter Valdemar M=C3=B8rch <peter@morch.com>
---

	Ok. I take on the callenge. Thanks for a very helpful writeup!
	The patch in the end is very short. And since it doesn't
	follow your writeup, let me explain my rationale:
=09
	Whether or not a check fails is stored in the
	DIFF_OPT_CHECK_FAILED field of flags in struct diff_options.
	This flag-field is only set (diff.c:1644), never cleared.
	Since the same diff_options is used throughout, it is enough
	to check that field at the end - it already does the
	accumulation because it never gets cleared.
=09
	diff_result_code: The second argument to it is never used
	since (opt->output_format & DIFF_FORMAT_CHECKDIFF), so the
	value doesn't matter (0 would have been fine as you suggest).
	The return value is a bitfield, with |=3D 1 if HAS_CHANGES
	(clearly log has changes "always" - except e.g. "git log
	HEAD..HEAD") and |=3D 2 if CHECK_FAILED.
=09
	Therefore I was left with either:
=09
	* Return the value of diff_result_code ("always" |=3D1,
	sometimes |=3D2 if a check failed. This would put the burden
	on the caller to check different values of $?.
=09
	* Return value of (diff_result_code & 02). Then I would
	suggest adding the constant 02 to a header file.
=09
	* Pick out the logic from diff_result_code with respect to
	CHECK_FAILED. I chose this path. (I return 02 here too, and
	perhaps that *should* go in a header file. I decided not
	to.)


 builtin-log.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f4975cf..45ce8ea 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -227,6 +227,10 @@ static int cmd_log_walk(struct rev_info *rev)
 		free_commit_list(commit->parents);
 		commit->parents =3D NULL;
 	}
+	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
+	    DIFF_OPT_TST(&rev->diffopt, CHECK_FAILED)) {
+		return 02;
+	}
 	return 0;
 }
=20
--=20
1.6.0.rc2.6.gcd432.dirty
