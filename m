From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: Bugs with detection of renames that are also overwrites
Date: Tue, 23 Feb 2010 14:08:36 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1002231336310.14055@dr-wily.mit.edu>
References: <alpine.DEB.2.00.1002131820150.14055@dr-wily.mit.edu> <20100223122257.GA1735@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:08:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk07l-0003mR-2W
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 20:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab0BWTIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 14:08:41 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:44058 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753492Ab0BWTIk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 14:08:40 -0500
X-AuditID: 1209190c-b7cfcae00000096b-13-4b8427b728a7
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 98.00.02411.7B7248B4; Tue, 23 Feb 2010 14:08:39 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o1NJ8cVe006425;
	Tue, 23 Feb 2010 14:08:39 -0500
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o1NJ8vpc016329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Feb 2010 14:08:58 -0500 (EST)
In-Reply-To: <20100223122257.GA1735@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140824>

On Tue, 23 Feb 2010, Jeff King wrote:
> > Therefore, the patch can=E2=80=99t be applied to its own source tre=
e.
> >=20
> > $ git checkout foo
> > $ git diff -M -B foo bar | git apply
> > error: b: already exists in working directory
>=20
> Hmm. I think this is a conflict between what the user wants to see an=
d
> what apply wants to see. From the user's perspective, thinking about =
the
> diff representing a change, "b" was not really deleted. It was simply
> overwritten. But from apply's perspective, the diff is a set of
> instructions, and those instructions do not mention that "b" previous=
ly
> existed and was overwritten. So it is right to be cautious and declar=
e a
> conflict.

I agree; git apply has no choice given that input.

> I'm not sure just throwing a "delete" line in there would be the best
> thing, though. The instructions for apply really need to be "if 'b' h=
as
> this sha1, then it is safe to delete and rename a into place. Otherwi=
se
> it is a conflict". And I'm not sure how we would represent that (I gu=
ess
> with a full diff and an "index" line).

Yeah, a full diff is the only sane solution, just like it is for plain=20
deletes.  Otherwise the patch could not be reverse-applied.  (If the us=
er=20
really doesn=E2=80=99t want to see the deletion, they can use --diff-fi=
lter.)

diff --git a/b b/b
deleted file mode 100644
index 3d47ea7..0000000
--- a/b
+++ /dev/null
@@ -1,101 +0,0 @@
-300
-301
=E2=80=A6
-399
-400
diff --git a/a b/b
similarity index 100%
rename from a
rename to b

This patch is already handled correctly by git apply (and git apply -R)=
,=20
as long as the rename is listed after the delete.

Anders
