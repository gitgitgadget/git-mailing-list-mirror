From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] link_alt_odb_entry: fix read over array bounds reported by
	valgrind
Date: Sat, 28 Jul 2012 17:46:36 +0200
Message-ID: <20120728154635.GB98893@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Torsten =?iso-8859-1?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 17:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv9E9-0003sR-SU
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 17:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab2G1Pqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 11:46:44 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:57798 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab2G1Pqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 11:46:43 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sv9Dw-0003a3-VP; Sat, 28 Jul 2012 17:46:37 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202446>

pfxlen can be longer than the path in objdir when relative_base contains
the path to gits object directory.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 sha1_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4ccaf7a..631d0dd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -251,7 +251,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
 	struct alternate_object_database *alt;
-	int pfxlen, entlen;
+	int pfxlen, entlen, objdirlen;
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
@@ -298,7 +298,8 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 			return -1;
 		}
 	}
-	if (!memcmp(ent->base, objdir, pfxlen)) {
+	objdirlen = strlen(objdir);
+	if (!memcmp(ent->base, objdir, pfxlen > objdirlen ? objdirlen : pfxlen)) {
 		free(ent);
 		return -1;
 	}
-- 
1.7.12.rc0.23.gc9a5ac4
