From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] reflog-walk: don't segfault on non-commit sha1's in the
 reflog
Date: Wed, 30 Dec 2015 16:22:49 +0100
Message-ID: <20151230152245.GA30549@spirit>
References: <20151230131914.GA27241@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 30 16:22:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEIaX-0006TX-C2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 16:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbbL3PWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2015 10:22:54 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33512 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbbL3PWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 10:22:52 -0500
Received: by mail-wm0-f45.google.com with SMTP id f206so69303287wmf.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 07:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bERKbPCJVPUxM/Agw65uoXuWz+BkY6PK/96YMPvJfAY=;
        b=Fx3vGtpzcvXQPtf2vSqJ35KXaZtJj6+NmnzQBcpsOgb/BwHhH9lXTybTMyEjcgmbh1
         WpyScHZJBJX4/rPKvOYTteS4mDVCL5BMXYDpOaUHdH4S1waEQYAGYGrGv1Tx/8qbLlKb
         NzkcpYNq/J4437KviSIaSRFfw0gjVAkzO4wz77QL6CxScr8imd6McuPt/Dd5395U0nji
         YfIwQuqEA9eFdXF298BjJdK1VUz0XueaX6+dUbF/dYhZ8d/MT5pVwMX/3JRU1TGsYkWX
         c3APo+4woJCKjX7y9YfYNQtUBV4Vi7jmC1P6DkzNq9jSsZnP1PqcEVxObXAhLP4qDuAG
         pYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bERKbPCJVPUxM/Agw65uoXuWz+BkY6PK/96YMPvJfAY=;
        b=aJJcGJNaLhrY2MGA9hDTiPfZanQi/vhcGLfUDL0quej1n76sDCPgUY5zn86TE6cc4H
         4G3YT7Joi6Jziy/BIyAIztMMAyLttxF21ptFFgnQ/RHyOP4M9mevJ9U0oz1Y+Oa655y8
         fVhx6HIX2eDvA6PWUMtxbmEZaMyYb2RYptyDatVKNAenU0YrlbrmZ2lY/FhmbinX22LS
         bBg/TzcLqfKfofQZaOXSpGxjH+w2XWaUhPkSRQIGGe4TifcOG3amFWXxaRiR76RiFpb1
         KPOA5AzZsE6VUvVLFPa9dJuYgQOES+IdBECuzSP/VsEmfCJNcK3lSRFJ2nXfTvLv6ANe
         dnAA==
X-Gm-Message-State: ALoCoQnjC2zD6pvq3gPqCU+XzzhffyBk3dDU/Nazq6ErMHI2LYGjYkaC19N7QXvRYmQvFgeWBaGW06789XdWudkeectefhqedA==
X-Received: by 10.194.110.5 with SMTP id hw5mr82969441wjb.154.1451488971798;
        Wed, 30 Dec 2015 07:22:51 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id d2sm65916018wjy.16.2015.12.30.07.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 07:22:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151230131914.GA27241@lanh>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283186>

Use lookup_commit instead of parse_object to look up commits mentioned
in the reflog. This avoids a segfault in save_parents if somehow a sha1
for something other than a commit ends up in the reflog.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
---
Duy Nguyen wrote:

> I would go with something like this. The typecasting to "struct commi=
t
> *" is the bug because parse_object() can return any object type.

Yeah, that's much better. Here it is as a patch with a test.=20

 reflog-walk.c     | 4 ++--
 t/t1410-reflog.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 85b8a54..b85c8e8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -236,8 +236,8 @@ void fake_reflog_parent(struct reflog_walk_info *in=
fo, struct commit *commit)
 	reflog =3D &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog =3D commit_reflog;
 	commit_reflog->recno--;
-	commit_info->commit =3D (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit) {
+	commit_info->commit =3D lookup_commit(reflog->osha1);
+	if (!commit_info->commit || parse_commit(commit_info->commit)) {
 		commit->parents =3D NULL;
 		return;
 	}
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index b79049f..76ccbe5 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -325,4 +325,10 @@ test_expect_success 'parsing reverse reflogs at BU=
=46SIZ boundaries' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'reflog containing non-commit sha1s' '
+	git checkout -b broken-reflog &&
+	echo "$(git rev-parse HEAD^{tree}) $(git rev-parse HEAD) abc <xyz> 00=
00000001 +0000" >> .git/logs/refs/heads/broken-reflog &&
+	git reflog broken-reflog
+'
+
 test_done
--=20
2.7.0-rc1-207-ga35084c


--=20
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
