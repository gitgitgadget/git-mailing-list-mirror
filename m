From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/16] pack-objects: do not cache delta for v4 trees
Date: Mon,  9 Sep 2013 20:58:00 +0700
Message-ID: <1378735087-4813-10-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1wp-0003Hx-L3
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3IIN4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:56:06 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47075 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab3IIN4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:56:05 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so6139720pbc.22
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XAd/bEIM/bEBZc3yJwDeOKU38K2Pvba1m4s4eu07KTg=;
        b=PCAm0F4SwkwFdITTmiCdhoVIJy++JnlAgAv/NMzN/XKSrsFWXFVvpa9XNzm7J0xG4j
         kDyg/gaE4AOyQ/Un0uSuaQELNP14auSEBFZr73jekIoDtcfbVSgY/04GC8gD5L+oXFuS
         rVWjkO8QU02nIV2yn4qQhqdeIbHN4M330cT4rICqzxecUnlGu7m6GRyKO1U73ODdXD7+
         SAtRc+JQ5x4JMoJJ0Z4M56Q6ESeTkMFfZSf32S9TSr65GU3bOztS6n0zEwciKATZwMLT
         8dzXn3cHF4y8bm8eikjCipe0HN00K3JpXgzCP4/xsf5zIHc4p2E1+ERXSatpZHP2onTI
         29wg==
X-Received: by 10.68.200.100 with SMTP id jr4mr19598021pbc.0.1378734964968;
        Mon, 09 Sep 2013 06:56:04 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id wd6sm17809534pab.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:56:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:59:14 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234337>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b38d3dc..9613732 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1756,8 +1756,12 @@ static void find_deltas(struct object_entry **li=
st, unsigned *list_size,
 		 * and therefore it is best to go to the write phase ASAP
 		 * instead, as we can afford spending more time compressing
 		 * between writes at that moment.
+		 *
+		 * For v4 trees we'll need to delta differently anyway
+		 * so no cache. v4 commits simply do not delta.
 		 */
-		if (entry->delta_data && !pack_to_stdout) {
+		if (entry->delta_data && !pack_to_stdout &&
+		    (pack_version < 4 || entry->type =3D=3D OBJ_BLOB)) {
 			entry->z_delta_size =3D do_compress(&entry->delta_data,
 							  entry->delta_size);
 			cache_lock();
--=20
1.8.2.83.gc99314b
