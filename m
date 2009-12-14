From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/23] unpack-trees(): ignore worktree check outside checkout area
Date: Mon, 14 Dec 2009 17:31:03 +0700
Message-ID: <1260786666-8405-21-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Gn-0008VO-P8
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbZLNKeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756406AbZLNKd5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:57 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:56204 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbZLNKdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:31 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so2178509pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fst8ngXj44PqdeANTwhkvjsYhTv/t3PI4Jecp/GlM4U=;
        b=w5wWipSa5NBUjFgmyZeDQvlrRdknw36r3Xesoq2qGhQl3F8a8typT8CPqnwfIcDgtx
         YZydpdp+zRnOtKN+KOxzGnpAHmkBXaQWFEA1tppuAV0FOI6+Fw5tQ6bQG6BIa9Fo0Xjr
         SuOqyXuNQDa2z2vbWup3vexzVJAEoB+uihwVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MBkMYqaWMigXEYJWtcnSPt6XaNuoAJdptKPS3snDbqDYVSSC+UTJaBD3Av0LF2Dpbu
         OS1srVDi3wE5LGxscVxgDqYm9IHWrPN9G2G76vbXPhcGvKKIcQxcJQZpX3sSgqLdNehZ
         RUriHK6n80i6fIj1FaLNNEm3F9gk/2x2lnINM=
Received: by 10.142.4.12 with SMTP id 12mr1768958wfd.133.1260786811225;
        Mon, 14 Dec 2009 02:33:31 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4910948pzk.12.2009.12.14.02.33.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:48 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135191>

verify_absent() and verify_uptodate() are used to ensure worktree
is safe to be updated, then CE_REMOVE or CE_UPDATE will be set.
=46inally check_updates() bases on CE_REMOVE, CE_UPDATE and the
recently added CE_WT_REMOVE to update working directory accordingly.

The entries that are checked may eventually be left out of checkout
area (done later in apply_sparse_checkout()). We don't want to update
outside checkout area. This patch teaches Git to assume "good",
skip these checks when it's sure those entries will be outside checkout
area, and clear CE_REMOVE|CE_UPDATE that could be set due to this
assumption.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 6288385..aac9922 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -505,6 +505,14 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 				ret =3D -1;
 				goto done;
 			}
+			/*
+			 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
+			 * area as a result of ce_skip_worktree() shortcuts in
+			 * verify_absent() and verify_uptodate(). Clear them.
+			 */
+			if (ce_skip_worktree(ce))
+				ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
+
 		}
 	}
=20
@@ -577,6 +585,8 @@ static int verify_uptodate_1(struct cache_entry *ce=
,
 static int verify_uptodate(struct cache_entry *ce,
 			   struct unpack_trees_options *o)
 {
+	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
+		return 0;
 	return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodate_file));
 }
=20
@@ -776,6 +786,8 @@ static int verify_absent_1(struct cache_entry *ce, =
const char *action,
 static int verify_absent(struct cache_entry *ce, const char *action,
 			 struct unpack_trees_options *o)
 {
+	if (!o->skip_sparse_checkout && will_have_skip_worktree(ce, o))
+		return 0;
 	return verify_absent_1(ce, action, o, ERRORMSG(o, would_lose_untracke=
d));
 }
=20
--=20
1.6.5.2.216.g9c1ec
