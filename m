From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/23] unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
Date: Mon, 14 Dec 2009 17:30:59 +0700
Message-ID: <1260786666-8405-17-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FM-0007wL-95
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260AbZLNKdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756229AbZLNKd3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:29 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34948 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbZLNKdM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:12 -0500
Received: by pwj9 with SMTP id 9so1839222pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YNX1X1BqoPk6lxvRzStjgOpd9bY4eKx+bt65K0lC9tI=;
        b=X7k9CCmnwZjvoDdYYeHQ3QGb2BDCQUqWEUSylMn6lpkLEJ9+AlmTpj9dAQ9nOdLtQt
         KhRFlxx2uFfnmZL+EAQYvAgeCbFF4/ttVr5op9i1+MUl30Hwr+EPubjTuQEZhgFkVYoV
         1M2HGXtoTPBaWEegRaFE9/Bvy7SJoom7x+6QA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BABpYfNgyFPdkJimq0lVHHWkwk0Hz/JEKp+97uFNwd/fwfFV8ggjQErP2ldRg16ROX
         zHuxKL2xaymhOWSAlr9HY81UaDbL9O80WMLsaKJCSfmo0oR0ac3TYtz84RAbmvBJa27U
         msLS34sr5NB1k6MEGFy/jkuidxPY/Vkd59Fbg=
Received: by 10.142.60.11 with SMTP id i11mr3001084wfa.270.1260786792347;
        Mon, 14 Dec 2009 02:33:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4904759pzk.3.2009.12.14.02.33.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:11 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:30 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135177>

CE_REMOVE now removes both worktree and index versions. Sparse
checkout must be able to remove worktree version while keep the
index intact when checkout area is narrowed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h        |    3 +++
 unpack-trees.c |    9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index f040f24..3a37469 100644
--- a/cache.h
+++ b/cache.h
@@ -177,6 +177,9 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
=20
+/* Only remove in work directory, not index */
+#define CE_WT_REMOVE (0x400000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/unpack-trees.c b/unpack-trees.c
index ac59fbe..eb1a818 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -78,7 +78,7 @@ static int check_updates(struct unpack_trees_options =
*o)
 	if (o->update && o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
+			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
 				total++;
 		}
=20
@@ -92,6 +92,13 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
+		if (ce->ce_flags & CE_WT_REMOVE) {
+			display_progress(progress, ++cnt);
+			if (o->update)
+				unlink_entry(ce);
+			continue;
+		}
+
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update)
--=20
1.6.5.2.216.g9c1ec
