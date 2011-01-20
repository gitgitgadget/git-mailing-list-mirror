From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] Correctly report corrupted objects
Date: Thu, 20 Jan 2011 21:12:20 +0100
Message-ID: <20110120201220.GD12418@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 21:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg0ru-0000aX-0D
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 21:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab1ATUMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jan 2011 15:12:25 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:38894 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751833Ab1ATUMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 15:12:24 -0500
Received: (qmail invoked by alias); 20 Jan 2011 20:12:22 -0000
Received: from i59F5557E.versanet.de (EHLO atjola.homenet) [89.245.85.126]
  by mail.gmx.net (mp023) with SMTP; 20 Jan 2011 21:12:22 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+UKKRIve2UnC9hW1vY9QG1MDxDWGpvDme9Ypc8IL
	MgxLS9FDCPvSth
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165331>

The errno check added in commit 3ba7a06 "A loose object is not corrupt
if it cannot be read due to EMFILE" only checked for whether errno is
not ENOENT and thus incorrectly treated "no error" as an error
condition.

Because of that, it never reached the code path that would report that
the object is corrupted and instead caused funny errors like:

  fatal: failed to read object 333c4768ce595793fdab1ef3a036413e2a883853=
: Success

So we have to extend the check to cover the case in which the object
file was successfully read, but its contents are corrupted.

Reported-by: Will Palmer <wmpalmer@gmail.com>
Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1cafdfa..d86a8db 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2141,7 +2141,7 @@ void *read_sha1_file_repl(const unsigned char *sh=
a1,
 		return data;
 	}
=20
-	if (errno !=3D ENOENT)
+	if (errno && errno !=3D ENOENT)
 		die_errno("failed to read object %s", sha1_to_hex(sha1));
=20
 	/* die if we replaced an object with one that does not exist */
--=20
1.7.4.rc2.18.gb20e9
