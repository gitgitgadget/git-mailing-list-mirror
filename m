From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/32] log-tree: use narrow version of diff_tree_sha1
Date: Wed, 25 Aug 2010 08:20:08 +1000
Message-ID: <1282688422-7738-19-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uL-00030j-HJ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342Ab0HXWW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58634 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab0HXWWy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:54 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2825136pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0AyV6QuOZ3T+w0Rfr67C0SGY2IDEJ6oV6HZ3FchKYhU=;
        b=mHCiKC8px7XUXBIBv3M//rfWcSJBywmhj1Ob0CcDPjadzuqrBvN0iTGt1KtJ/P0FCR
         nBEouvsIFIm7wiQildtNFT3GVsU3XJOu79oqxsWgV/sAKWdwQ61eMzcfxoonrHPgI4KA
         leBBnSc5Q5ucxxTU5Vty8YQEkK3aJGA/X/clA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FjvTCVl1m4l/KTjldSPwGnA+1vD9/TmnXUGFfT1W7kCJDUzVvBCVyjigKUng4id7KK
         RbAroj36huA6y+3mBGBKFVwBMyBsk67xM2rb5/VSzaG7fI7JeDqI6T7Yha0+2BZJrU6k
         bU+J5kVCVdV6ke68TzIbnWs5xOEPR8+FKxX3A=
Received: by 10.142.128.6 with SMTP id a6mr6325144wfd.31.1282688574383;
        Tue, 24 Aug 2010 15:22:54 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm634808wfg.21.2010.08.24.15.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:53 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:48 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154362>

This makes "git log" work in narrow repos.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index b46ed3b..693992a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -600,7 +600,10 @@ static int log_tree_diff(struct rev_info *opt, str=
uct commit *commit, struct log
 	parents =3D commit->parents;
 	if (!parents) {
 		if (opt->show_root_diff) {
-			diff_root_tree_sha1(sha1, "", &opt->diffopt);
+			if (get_narrow_prefix())
+				narrow_diff_root_tree_sha1(sha1, NULL, &opt->diffopt);
+			else
+				diff_root_tree_sha1(sha1, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 		}
 		return !opt->loginfo;
@@ -618,7 +621,14 @@ static int log_tree_diff(struct rev_info *opt, str=
uct commit *commit, struct log
 			 * parent, showing summary diff of the others
 			 * we merged _in_.
 			 */
-			diff_tree_sha1(parents->item->object.sha1, sha1, "", &opt->diffopt)=
;
+			if (get_narrow_prefix())
+				narrow_diff_tree_sha1(parents->item->object.sha1,
+						      sha1,
+						      NULL,
+						      &opt->diffopt);
+			else
+				diff_tree_sha1(parents->item->object.sha1, sha1,
+					       "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
 		}
@@ -631,7 +641,14 @@ static int log_tree_diff(struct rev_info *opt, str=
uct commit *commit, struct log
 	for (;;) {
 		struct commit *parent =3D parents->item;
=20
-		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
+		if (get_narrow_prefix())
+			narrow_diff_tree_sha1(parent->object.sha1,
+					      sha1,
+					      NULL,
+					      &opt->diffopt);
+		else
+			diff_tree_sha1(parent->object.sha1, sha1,
+				       "", &opt->diffopt);
 		log_tree_diff_flush(opt);
=20
 		showed_log |=3D !opt->loginfo;
--=20
1.7.1.rc1.69.g24c2f7
