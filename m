From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] Document limited recursion pathspec matching with wildcards
Date: Sat, 14 Jan 2012 16:23:22 +0700
Message-ID: <1326533003-19686-1-git-send-email-pclouds@gmail.com>
References: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 10:24:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlzqG-00015o-54
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 10:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab2ANJX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 04:23:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65263 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2ANJXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 04:23:53 -0500
Received: by iaby12 with SMTP id y12so533802iab.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 01:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oKy1Olfu927gF5OYnumInWjyUH0UltmkzXZW+e8XzrI=;
        b=XvcUF1504vh7+HHXWYgj+595r6EAYSEqJUnDsAFrny+iSVfjywfI+nRxI4QVOZy0Ix
         7MCFbCBz1g2kVINANoHo0/pM807NbrTvdLzhB3jzkEzsArL91OERBw9jFLSxljtf+PXJ
         W051XVmFNdO2nqkyuOlfhJrqM65PbpHQ00xSc=
Received: by 10.50.160.196 with SMTP id xm4mr3592411igb.12.1326533032856;
        Sat, 14 Jan 2012 01:23:52 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.201])
        by mx.google.com with ESMTPS id py9sm19662246igc.2.2012.01.14.01.23.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Jan 2012 01:23:51 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 14 Jan 2012 16:23:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188556>

It's actually unlimited recursion if wildcards are active regardless
--max-depth

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Regarding Junio's question earlier:

 >  - Shouldn't "onelevel_only" be the same as limiting to a single dep=
th
 >   with "max_depth"?

 Doing that would change the behavior of "git grep --max-depth=3D0 -- '=
a*'"
 from unlimited recursion currently to limited. We did not come to agre=
e
 how --max-depth should behave with wildcards last time it was discusse=
d,
 so it's best separating two flags (in the next patch) for now.

 Documentation/git-grep.txt |    3 +++
 tree-walk.c                |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 15d6711..6a8b1e3 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -79,6 +79,9 @@ OPTIONS
 --max-depth <depth>::
 	For each <pathspec> given on command line, descend at most <depth>
 	levels of directories. A negative value means no limit.
+	This option is ignored if <pathspec> contains active wildcards.
+	In other words if "a*" matches a directory named "a*",
+	"*" is matched literally so --max-depth is still effective.
=20
 -w::
 --word-regexp::
diff --git a/tree-walk.c b/tree-walk.c
index f82dba6..492c7cd 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -661,6 +661,9 @@ match_wildcards:
 		/*
 		 * Match all directories. We'll try to match files
 		 * later on.
+		 * max_depth is ignored but we may consider support it
+		 * in future, see
+		 * http://thread.gmane.org/gmane.comp.version-control.git/163757/foc=
us=3D163840
 		 */
 		if (ps->recursive && S_ISDIR(entry->mode))
 			return entry_interesting;
--=20
1.7.8.36.g69ee2
