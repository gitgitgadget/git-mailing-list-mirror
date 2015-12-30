From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2] reflog-walk: don't segfault on non-commit sha1's in the
 reflog
Date: Wed, 30 Dec 2015 23:17:08 +0100
Message-ID: <20151230221705.GA4025@spirit>
References: <1451512152.9251.23.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 30 23:17:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEP3V-0006HV-3i
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 23:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbbL3WRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2015 17:17:13 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32851 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbbL3WRM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 17:17:12 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so78531339wmf.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=itvXUTWV2n1skohJIHp12zsADeswHhKHJ1PclDCJvVQ=;
        b=qjUi2reymLl0ziS043hWCTwbzPzhXEMT/t0n0efCLI9KaIw8BTPnzZDHhYTy64SQ8h
         lrQiSv3SpUMt07zwIS2MFbeaRELynggHtp3vZXn4Kz+AvflPgkgOGpTN8eEl7qec2SuN
         PhYq7bunSC6bAR8fqtfkl1asgxGooNBjn5VxI8CnkQ1OZ5GcOoqhOqxsEjWZEsRLCFB8
         FOqAGYyq6/qKPPlMUjZErkKwd/4WMl+PcqNWkNkvpB1aBcjQhk0s9dTltcooCW4UJDqv
         VNlV6PuYkRJcfG77hgQDmv0WYORFPmlAgtV6wc6v6khfDZ7C7GhBQf9rAA0vLOai+GDN
         Q9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=itvXUTWV2n1skohJIHp12zsADeswHhKHJ1PclDCJvVQ=;
        b=mr1O535pjQOlX3D6uHGBhbm1lP73y6H2+sFKW4FbufHDdNmAvcJOxW7OgglRi2SdmE
         SfN3dJxBgozY2ka955Swk8KfCqXmGv32ZW+1e166b/UYTkHAXLjWgF6ocpgGYS5AAeZN
         zwR1HipYF0EF4rN/dhyTKTGfYQxqHrXkx6/HK5XfGRrXreDctnniMW48X+i9iGRG53p5
         QlEABs1nW6AMcEEYZLr/6R3Ab7hsnZAeS9VTrIZUDhFNB5E/fC1Gk5YBPzAlwx8z4dNn
         /6yaXFl2E5wxzatNU/jIkI8x63M3uPQOMSwM41XN27xnUUNZ5dOIIS31uSsLhpkKFPyw
         m+Zw==
X-Gm-Message-State: ALoCoQm2lBudHbxdZ0YfSgSbH9vGzpqqooBvFt45h32W9mq23KEj7ybFa29xJ8+roOwnxtXfOXmKNzVU1VZIvb39nCZxLPCx1g==
X-Received: by 10.194.109.194 with SMTP id hu2mr70076911wjb.134.1451513830758;
        Wed, 30 Dec 2015 14:17:10 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id yz5sm15282695wjc.36.2015.12.30.14.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 14:17:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451512152.9251.23.camel@kaarsemaker.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283208>

Use lookup_commit instead of parse_object to look up commits mentioned
in the reflog. This avoids a segfault in save_parents if somehow a sha1
for something other than a commit ends up in the reflog.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 reflog-walk.c     |  7 +++++--
 t/t1410-reflog.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

This version implements Junio's way of doing this, to avoid spurious wa=
rnings
and to handle broken commit objects better.

I also added a failing test to show that git reflog still fails to disp=
lay the
full reflog when it encounters such non-commit objects (it just stops w=
hen it
seems them). I don't know how to fix that.

The really correct way of fixing this bug may actually be a level highe=
r, and
making git reflog not rely on information about parent commits, whether=
 they
are fake or not.

diff --git a/reflog-walk.c b/reflog-walk.c
index 85b8a54..861d7c4 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -221,6 +221,7 @@ void fake_reflog_parent(struct reflog_walk_info *in=
fo, struct commit *commit)
 	struct commit_info *commit_info =3D
 		get_commit_info(commit, &info->reflogs, 0);
 	struct commit_reflog *commit_reflog;
+	struct object *logobj;
 	struct reflog_info *reflog;
=20
 	info->last_commit_reflog =3D NULL;
@@ -236,11 +237,13 @@ void fake_reflog_parent(struct reflog_walk_info *=
info, struct commit *commit)
 	reflog =3D &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog =3D commit_reflog;
 	commit_reflog->recno--;
-	commit_info->commit =3D (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit) {
+	logobj =3D parse_object(reflog->osha1);
+	if (!logobj || logobj->type !=3D OBJ_COMMIT) {
+		commit_info->commit =3D NULL;
 		commit->parents =3D NULL;
 		return;
 	}
+	commit_info->commit =3D (struct commit *)logobj;
=20
 	commit->parents =3D xcalloc(1, sizeof(struct commit_list));
 	commit->parents->item =3D commit_info->commit;
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index b79049f..130d671 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -325,4 +325,17 @@ test_expect_success 'parsing reverse reflogs at BU=
=46SIZ boundaries' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'no segfaults for reflog containing non-commit sha=
1s' '
+	git update-ref --create-reflog -m "Creating ref" \
+		refs/tests/tree-in-reflog HEAD &&
+	git update-ref -m "Forcing tree" refs/tests/tree-in-reflog HEAD^{tree=
} &&
+	git update-ref -m "Restoring to commit" refs/tests/tree-in-reflog HEA=
D &&
+	git reflog refs/tests/tree-in-reflog
+'
+
+test_expect_failure 'reflog containing non-commit sha1s displays fully=
' '
+	git reflog refs/tests/tree-in-reflog > actual &&
+	test_line_count =3D 3 actual
+'
+
 test_done
--=20
2.7.0-rc1-207-ga35084c
