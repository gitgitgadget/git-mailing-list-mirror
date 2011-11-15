From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/10] merge: do not point "branch" to a resolve_ref()'s static buffer
Date: Tue, 15 Nov 2011 13:07:49 +0700
Message-ID: <1321337276-17803-3-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:05:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9F-0005VW-Na
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab1KOGF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:05:29 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46627 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab1KOGF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:05:26 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so14544202pzk.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GHV635r0HzIA8oPPbypdcH9RCBVlduRs0ZVvtAbfuow=;
        b=vTmSH4IZS9DrUBnD94cvoZNMtCubplUj0rUSC83SjFSJ++03TgPH+jkc7JF8Gob7PO
         mv5l4JuO7H23JWduZphNk6FJl7mmxLl2gbuawtLU+W44+TDRRGP2I8DXXyOKUmjZWTLt
         gVWKJjt4cFbQUd5e7wNkbUF/mQ+Z4czpeFmGE=
Received: by 10.68.4.200 with SMTP id m8mr56056147pbm.50.1321337126360;
        Mon, 14 Nov 2011 22:05:26 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id c3sm62399376pbt.12.2011.11.14.22.05.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:05:25 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:11 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185425>

resolve_ref() may return a pointer to a static buffer. Callers that
use this value longer than a couple of statements should copy the
value to avoid some hidden resolve_ref() call that may change the
static buffer's value.

The bug found by Tony Wang <wwwjfy@gmail.com> in builtin/merge.c
demonstrates this. The first call is in cmd_merge()

branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);

Then deep in lookup_commit_or_die() a few lines after, resolve_ref()
may be called again and destroy "branch".

lookup_commit_or_die
 lookup_commit_reference
  lookup_commit_reference_gently
   parse_object
    lookup_replace_object
     do_lookup_replace_object
      prepare_replace_object
       for_each_replace_ref
        do_for_each_ref
         get_loose_refs
          get_ref_dir
           get_ref_dir
            resolve_ref

Ask resolve_ref() to allocate a new buffer instead of returning static
buffer.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 1be6f3b..1a3095f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1087,6 +1087,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	struct commit_list *common =3D NULL;
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
 	struct commit_list **remotes =3D &remoteheads;
+	char *branch_ref;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_merge_usage, builtin_merge_options);
@@ -1095,7 +1096,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch =3D resolve_ref("HEAD", head_sha1, 0, &flag, 0);
+	branch =3D branch_ref =3D resolve_ref("HEAD", head_sha1, 0, &flag, 1)=
;
 	if (branch && !prefixcmp(branch, "refs/heads/"))
 		branch +=3D 11;
 	if (!branch || is_null_sha1(head_sha1))
@@ -1497,5 +1498,6 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		ret =3D suggest_conflicts(option_renormalize);
=20
 done:
+	free(branch_ref);
 	return ret;
 }
--=20
1.7.4.74.g639db
