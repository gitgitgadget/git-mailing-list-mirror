From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] unpack-trees: do not check for conflict entries too early
Date: Sat, 31 Jul 2010 13:14:28 +0700
Message-ID: <1280556869-707-5-git-send-email-pclouds@gmail.com>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:15:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5M2-0002E1-6i
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab0GaGPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:15:23 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45174 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0GaGPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:15:21 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so799570pxi.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=K/UgJVqtER/5Wb1B+THNio4VEXCFEvRoY2/gaA4fEhE=;
        b=RZpWk2d4/hROA6afWdaFJmMGNMElwev/Iyv0c2xofpTud0vMwJLz0TmNfIlYjvsd01
         jfvKHGdNvhBU7mZqYaMMqWXpFWfGnn1dMT0v+CflApu9u0rrvOg525vG9YvZPrX7PuDO
         o/VYOM/vGohXO79iaOF+nI9qZPsL1NJUa8vsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pbyb+GwIkFrraTz7JMV08K1tn8GcivkAQ0BZvIn7Vn7lf6zpFHaNSORTutfA1VHG6y
         APMA1zuF+dHJizx5hzTsZwDyaQJw1oqYDBAUJtSCGN5nJyeZsLiWIJNUCkjlTWNzqnTB
         V16ltu0ks44xT1Bworzmd6G3dhs+VEFOicOts=
Received: by 10.114.124.1 with SMTP id w1mr3634891wac.96.1280556921225;
        Fri, 30 Jul 2010 23:15:21 -0700 (PDT)
Received: from dektop ([123.200.231.45])
        by mx.google.com with ESMTPS id d38sm5381630wam.8.2010.07.30.23.15.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 23:15:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 13:15:12 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152313>

The idea of sparse checkout is conflict entries should always stay
in worktree, regardless $GIT_DIR/info/sparse-checkout. Therefore,
ce_stage(ce) usually means no CE_SKIP_WORKTREE. This is true when all
entries have been merged into the index, and identical staged entries
collapsed.

However, will_have_skip_worktree() since f1f523e (unpack-trees():
ignore worktree check outside checkout area) is also used earlier in
verify_* functions, where entries have not been merged to index yet
and ce_stage() is not zero. Checking ce_stage() then may provoke
unnecessary verification on entries outside checkout area and error
out.

This fixes part of test case "read-tree adds to worktree, dirty case".
The error

error: Untracked working tree file 'sub/added' would be overwritten by =
merge.

is now gone and (unfortunately) replaced by another error, which will
be addressed in the next patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1413872..b34ef46 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -135,9 +135,6 @@ static int will_have_skip_worktree(const struct cac=
he_entry *ce, struct unpack_t
 {
 	const char *basename;
=20
-	if (ce_stage(ce))
-		return 0;
-
 	basename =3D strrchr(ce->name, '/');
 	basename =3D basename ? basename+1 : ce->name;
 	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, o=
->el) <=3D 0;
@@ -147,7 +144,7 @@ static int apply_sparse_checkout(struct cache_entry=
 *ce, struct unpack_trees_opt
 {
 	int was_skip_worktree =3D ce_skip_worktree(ce);
=20
-	if (will_have_skip_worktree(ce, o))
+	if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
 		ce->ce_flags |=3D CE_SKIP_WORKTREE;
 	else
 		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
--=20
1.7.1.rc1.69.g24c2f7
