From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v4] reflog-walk: don't segfault on non-commit sha1's in the
 reflog
Date: Tue, 5 Jan 2016 22:12:10 +0100
Message-ID: <20160105211206.GA12057@spirit>
References: <1451552227.11138.6.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 05 22:12:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGYu5-0000Zd-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 22:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbcAEVMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 16:12:23 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33143 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbcAEVMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 16:12:20 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so38326503wmf.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wr72QOP3MX0U3QfN9GanKxUiL2GPfcHOHh5l8Qz5gV4=;
        b=iYzpSG/daMDAbiFmmcUlNhpmihtsZpBgz+BkvtJMglhWpDEkyVNIYgSKfuJrVetcW7
         pwDWiD3UEDSocYis+v7RkDtPZcZfjKyxEdLU453rHIlWpIE80VK2o3PRfdgFRZWi2h2Z
         0zFd4JfkyBFA+AbLhi+yY47I1xqu0P/essoNDvRISMRVurcCiCCpmbRU4lYDdUX+U0nd
         OrkTFzimB1Hsl/cRoM/6149gn9HwrhprkVhE80qRpCWUW0CJjkz0Wxec4dD2CICtDQne
         rCV/9at1UYxoG2VIh2VDqv6t5tV9iPF8MKUHnyL07x11ofPkzpZdtMf1jC4vkdJScvf/
         mbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Wr72QOP3MX0U3QfN9GanKxUiL2GPfcHOHh5l8Qz5gV4=;
        b=AYpg9ho/DDHzTwfxBJRUwlf5Mhez8lS78ynNWnnkW6Qx3mhCw4gJyIhc+z2yIuF23W
         bgxBKtzeTuzUb5q3D3l4iSkFD3jYwL8abwG9QCqeOD83s0crTYy6If1+m25tQb1aQLgd
         /9wNsPfgy5nj+bocGeoV8h2QOPMgUVXXEaIhRV/0hZHnthvRM6Ee2U9q3/n9aPkUHNqR
         6w2VyHZC8+txl/2qnddLgOdR7mjPWBssEng5MYeX8UFZdm4dbrri2wn4WJKeXul/ca1C
         JTjwkIAfdJos2OUsEds0mndrFFXUJzKAp1T+JJC01pRUg7rMwZAbp0JRXUgTDc3ghjrf
         7EXw==
X-Gm-Message-State: ALoCoQnT464FBmtndqFmrrx4giPRb89mH0wYwoJzkTsMX3zu7muZr4SMig+LYHNyY/TdxbSowkvriv9EtbVSra3OGHvqbeAvfQ==
X-Received: by 10.194.86.71 with SMTP id n7mr97862185wjz.107.1452028338000;
        Tue, 05 Jan 2016 13:12:18 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id w17sm5317834wmw.15.2016.01.05.13.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 13:12:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451552227.11138.6.camel@kaarsemaker.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283401>

git reflog (ab)uses the log machinery to display its list of log
entries. To do so it must fake commit parent information for the log
walker.

=46or refs in refs/heads this is no problem, as they should only ever
point to commits. Tags and other refs however can point to anything,
thus their reflog may contain non-commit objects.

To avoid segfaulting, we check whether reflog entries are commits befor=
e
feeding them to the log walker and skip any non-commits. This means tha=
t
git reflog output will be incomplete for such refs, but that's one step
up from segfaulting. A more complete solution would be to decouple git
reflog from the log walker machinery.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
Changes since v3: tweaks to the second test.

 reflog-walk.c     | 16 +++++++++++-----
 t/t1410-reflog.sh | 13 +++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 85b8a54..0ebd1da 100644
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
@@ -232,15 +233,20 @@ void fake_reflog_parent(struct reflog_walk_info *=
info, struct commit *commit)
 		commit->parents =3D NULL;
 		return;
 	}
-
-	reflog =3D &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog =3D commit_reflog;
-	commit_reflog->recno--;
-	commit_info->commit =3D (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit) {
+
+	do {
+		reflog =3D &commit_reflog->reflogs->items[commit_reflog->recno];
+		commit_reflog->recno--;
+		logobj =3D parse_object(reflog->osha1);
+	} while (commit_reflog->recno && (logobj && logobj->type !=3D OBJ_COM=
MIT));
+
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
index b79049f..17a194b 100755
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
+test_expect_failure 'reflog with non-commit entries displays all entri=
es' '
+	git reflog refs/tests/tree-in-reflog >actual &&
+	test_line_count =3D 3 actual
+'
+
 test_done
--=20
2.7.0-rc3-219-g24972d4


--=20
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
