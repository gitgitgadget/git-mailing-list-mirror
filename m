From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/10] add: do not rely on dtype being NULL behavior
Date: Mon, 15 Nov 2010 17:36:41 +0700
Message-ID: <1289817410-32470-2-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:38:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwSa-0001b0-As
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab0KOKi3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:38:29 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54021 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab0KOKi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:38:28 -0500
Received: by pzk28 with SMTP id 28so921988pzk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Y1vwSMG9kQSWUcnxjxz3tl6hPLAyclwV28zTJrf4QMk=;
        b=X8Xrqyn5g7R+FhrllIcH51Gfv5YAZ4HvFp7Bt9Qi1FBCN6RwS5nmvwYGquzfUL9M8e
         oaOzHidsafJ7rkza7ceSezggDGc+OH8R7aAQFKvIk70zcFRuBfuVlJ1K2oOTSdJGadgY
         V4B5Hpao2in/cLP3oolwvlFsKTbRKpYLhZ5Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TAJpi/thv56TuUkvwYwfVvY4RPoPAVFHFJkSJwE6ObDYUBIn9LGrOYt9b6r2rHvf1S
         RbdtyOd9ADcXn/WDMRJmqD7Xd8y8wLYVzn9NjRSEZqLGSzJHul/9klJXhhyfqppBAkXu
         Fbd2FhbpsifB5cLxqaRtX+LZFmWYht7PdkXo0=
Received: by 10.142.156.3 with SMTP id d3mr4762862wfe.202.1289817508475;
        Mon, 15 Nov 2010 02:38:28 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id z28sm1538628wfd.9.2010.11.15.02.38.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:38:27 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:37:07 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161478>

Commit c84de70 (excluded_1(): support exclude files in index -
2009-08-20) added support for excluded() where dtype can be NULL. It
was designed specifically for index matching because there was no
other way to extract dtype information from index. It did not support
wildcard matching (for example, "a*/" pattern would fail to match).

The code was probably misread when commit 108da0d (git add: Add the
"--ignore-missing" option for the dry run - 2010-07-10) was made
because DT_UNKNOWN happens to be zero (NULL) too.

Do not pass DT_UNKNOWN/NULL to excluded(), instead pass a pointer to a
variable that contains DT_UNKNOWN. The real dtype will be extracted
from worktree by excluded(), as expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..1a4672d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -446,7 +446,8 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 			if (!seen[i] && pathspec[i][0]
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
-					if (excluded(&dir, pathspec[i], DT_UNKNOWN))
+					int dtype =3D DT_UNKNOWN;
+					if (excluded(&dir, pathspec[i], &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die("pathspec '%s' did not match any files",
--=20
1.7.3.2.210.g045198
