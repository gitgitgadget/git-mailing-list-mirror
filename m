From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] merge: abort if fails to commit
Date: Thu, 15 Dec 2011 20:47:21 +0700
Message-ID: <1323956843-5326-1-git-send-email-pclouds@gmail.com>
References: <1323871699-8839-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 14:47:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbBee-0002nO-Ih
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 14:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab1LONrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 08:47:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33385 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab1LONrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 08:47:13 -0500
Received: by iaeh11 with SMTP id h11so2819700iae.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=O673+tJlIjxWB/e1yfPEBbpCwibxOLmtv0fDcyOgw0o=;
        b=JaA5dkcgGbJO13Yw0103prE78fCXE2eKFxQrxlApYgGTEtWE0EbISdDaO17fhnxYQO
         FiA+W3Ur704iLDs8gNFHXNgjb/cbSBsGLjJUWwFucOuiCnQ4lBLCAXgwKH3fk8W3uz0T
         Atbegfm+tmBV9fv0QmAlICM2GAa65VFXPNTyw=
Received: by 10.50.242.1 with SMTP id wm1mr3197537igc.30.1323956832963;
        Thu, 15 Dec 2011 05:47:12 -0800 (PST)
Received: from tre ([115.74.57.162])
        by mx.google.com with ESMTPS id r18sm21339731ibh.4.2011.12.15.05.47.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 05:47:11 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 15 Dec 2011 20:47:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323871699-8839-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187207>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/12/15 Junio C Hamano <gitster@pobox.com>:
 >> -     commit_tree(merge_msg.buf, merge_msg.len, result_tree, parent=
, result_commit, NULL);
 >> +     if (commit_tree(merge_msg.buf, merge_msg.len,
 >> +                     result_tree, parent, result_commit, NULL))
 >> +             die(_("failed to write commit object"));
 >>       finish(head, result_commit, "In-index merge");
 >>       drop_save();
 >>       return 0;
 >
 > Should we die immediately, or should we do some clean-ups after ours=
elves
 > before doing so?

 I'm not sure. I had a quick look over the command and it seems we do
 not need to do any clean-ups. But I'm not familiar with the command
 anyway..

 > In any case, this is a good change that shouldn't be taken hostage t=
o the
 > unrelated change in patch [1/3].

 Moved it up so it you can cherry-pick it independently.

 builtin/merge.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 2870a6a..27576c0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -913,7 +913,8 @@ static int merge_trivial(struct commit *head)
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
 	prepare_to_commit();
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
+	if (commit_tree(merge_msg.buf, result_tree, parent, result_commit, NU=
LL))
+		die(_("failed to write commit object"));
 	finish(head, result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -944,7 +945,8 @@ static int finish_automerge(struct commit *head,
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit();
 	free_commit_list(remoteheads);
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL)=
;
+	if (commit_tree(merge_msg.buf, result_tree, parents, result_commit, N=
ULL))
+		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, result_commit, buf.buf);
 	strbuf_release(&buf);
--=20
1.7.8.36.g69ee2
