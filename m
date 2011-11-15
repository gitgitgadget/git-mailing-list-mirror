From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/10] notes: request resolve_ref() to allocate new buffer
Date: Tue, 15 Nov 2011 13:07:54 +0700
Message-ID: <1321337276-17803-8-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9z-0005p2-7P
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab1KOGGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:06:00 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51083 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab1KOGF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:05:59 -0500
Received: by pzk36 with SMTP id 36so14545629pzk.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k4UnZT5HSFAmf2JKwK7qylKvu52bLrs6HwHg/yMGqrA=;
        b=x3vlxvUK/cXl6yTb8CIPqB59k7VMs7ao38WunuC0tMnDZCYCFWNSyTxFvmt2Sohz9X
         Bq63ZdlmPH4Y8ttHV/fKnEXDQ4psogiGt62riFCFEHVZB82WyJvlEjJq8yfK3fzOMkgx
         KpgDNHpZwSYJXlP/42w2J152dJuPeaiLcEY1M=
Received: by 10.68.32.99 with SMTP id h3mr56047225pbi.38.1321337158991;
        Mon, 14 Nov 2011 22:05:58 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id b8sm62396093pba.16.2011.11.14.22.05.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:05:58 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:43 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185433>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/notes.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9c70d8f..80c6e09 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -804,6 +804,8 @@ static int merge_commit(struct notes_merge_options =
*o)
 	struct notes_tree *t;
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
+	char *ref;
+	int ret;
=20
 	/*
 	 * Read partial merge result from .git/NOTES_MERGE_PARTIAL,
@@ -825,7 +827,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	t =3D xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
=20
-	o->local_ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL, 0);
+	o->local_ref =3D ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL=
, 1);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
=20
@@ -843,7 +845,9 @@ static int merge_commit(struct notes_merge_options =
*o)
=20
 	free_notes(t);
 	strbuf_release(&msg);
-	return merge_abort(o);
+	ret =3D merge_abort(o);
+	free(ref);
+	return ret;
 }
=20
 static int merge(int argc, const char **argv, const char *prefix)
--=20
1.7.4.74.g639db
