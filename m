From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] check_aliased_update: strcpy() instead of strcat() to copy
Date: Thu, 10 Jun 2010 20:43:51 +0200
Message-ID: <f99f845d5d0aa77b0a95c35f9289f1b031897d43.1276195180.git.trast@student.ethz.ch>
References: <AANLkTimPCMbprIKQ__SfMej3oST5agPZ06hM2dkyiUfj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Erick Mattos <erick.mattos@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:44:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmjk-00073R-Oz
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759280Ab0FJSoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 14:44:15 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:31784 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758807Ab0FJSoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:44:14 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 20:44:13 +0200
Received: from localhost.localdomain (84.74.100.241) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 20:43:53 +0200
X-Mailer: git-send-email 1.7.1.561.g94582
In-Reply-To: <AANLkTimPCMbprIKQ__SfMej3oST5agPZ06hM2dkyiUfj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148908>

da3efdb (receive-pack: detect aliased updates which can occur with
symrefs, 2010-04-19) introduced two strcat() into uninitialized
strings.  The intent was clearly make a copy of the static buffer used
by find_unique_abbrev(), so use strcpy() instead.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---

> Actually I think my test failure is related to da3efdb17b, see the
> "[PATCH v2 2/2] receive-pack: detect aliased updates which can occur
> with symrefs" thread.

Indeed, there's another bug in this one.  (And valgrind catches it
too...  if only I had the patience to let it churn through t5516!)

Unlike the other bug, this one is already in master.

 builtin/receive-pack.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb34757..7e4129d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -515,9 +515,9 @@ static void check_aliased_update(struct command *cm=
d, struct string_list *list)
 	dst_cmd->skip_update =3D 1;
=20
 	strcpy(cmd_oldh, find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV));
-	strcat(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
+	strcpy(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
 	strcpy(dst_oldh, find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV=
));
-	strcat(dst_newh, find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV=
));
+	strcpy(dst_newh, find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV=
));
 	rp_error("refusing inconsistent update between symref '%s' (%s..%s) a=
nd"
 		 " its target '%s' (%s..%s)",
 		 cmd->ref_name, cmd_oldh, cmd_newh,
--=20
1.7.1.561.g94582
