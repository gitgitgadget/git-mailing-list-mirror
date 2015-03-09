From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] diff-files: mark i-t-a paths as "new"
Date: Mon,  9 Mar 2015 21:14:05 +0700
Message-ID: <1425910445-27383-3-git-send-email-pclouds@gmail.com>
References: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 15:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUySG-0005S8-GN
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 15:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbbCIOO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 10:14:27 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:45507 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338AbbCIOOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 10:14:24 -0400
Received: by pdjy10 with SMTP id y10so25423099pdj.12
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u7QD8XTNKKhELiyWYwKQ9YMI+zzS0V7JYDY9bsSTGPQ=;
        b=Dx7Dlhnr677K4sWozi8IMM6llYSMPbMM4qtxwfSQ5Mxb6InQd5AIDaaJHUu0wat/Ut
         iN0D6AbJdNVR7iPXsd4enq9PKq4cb3ENsnyrwY7Nr3RgJJrw77A6q9ZE9mr6Eol3ikUj
         /8Fpqdb8zFlG5f8IQa4b3I25R1mKMG26CN1Lbe0yvLFvSPYpJhrekgLDB632AO9TMYL1
         zwYzLyhVeQwtDfSAqOJY3PmmnNGoDfozityu2AJqR1Kh9L8a0IIwD6P0elYnp7EDxQzf
         QBVPh5ae9a5cD3t6TkJZNmnsJAb2Nu59uSVE6TfDfITBNKRNxyb5ckgO8KDdJT7TgWx8
         vOTw==
X-Received: by 10.70.43.72 with SMTP id u8mr33205458pdl.107.1425910463459;
        Mon, 09 Mar 2015 07:14:23 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id ci17sm19468291pdb.70.2015.03.09.07.14.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 07:14:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 21:14:20 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265168>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 1 +
 diff-lib.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 3390933..ee370b0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -63,6 +63,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
+		case DIFF_STATUS_ADDED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
diff --git a/diff-lib.c b/diff-lib.c
index db0e6f8..5f1afa4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -212,6 +212,11 @@ int run_diff_files(struct rev_info *revs, unsigned=
 int option)
 					       ce->sha1, !is_null_sha1(ce->sha1),
 					       ce->name, 0);
 				continue;
+			} else if (ce->ce_flags & CE_INTENT_TO_ADD) {
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       EMPTY_BLOB_SHA1_BIN, 0,
+					       ce->name, 0);
+				continue;
 			}
=20
 			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
--=20
2.3.0.rc1.137.g477eb31
