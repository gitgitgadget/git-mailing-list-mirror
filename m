From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v3] reflog-walk: don't segfault on non-commit sha1's in the
 reflog
Date: Thu, 31 Dec 2015 00:33:03 +0100
Message-ID: <20151230233301.GA9194@spirit>
References: <xmqqk2nvd0cz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 31 00:33:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEQEz-0003cp-Hx
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 00:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbbL3XdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2015 18:33:09 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36167 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbL3XdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 18:33:08 -0500
Received: by mail-wm0-f52.google.com with SMTP id l65so72862593wmf.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 15:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wGo+Lgs+s7pxNWzV32sXc7mUqLn1JvBswExMcqWix/I=;
        b=NzXXju3GW5BOlhyaltEDaMpRY0PAnvBf/Q5+jde0+JFnvx3AnLpE48b4KKQxqjXyry
         5Y3WdvLpivNEZFg75HGDCb85WCtLLxJe1zLlLRRBGMS1xuJAME/63/Ztt4evHi53w79y
         NKyF/L3W1IqHakUU0j/TJ4xyBnDc9HSKJ29+mkFeiQIiV1L2x/s+94wD4mMP/XF9qDtk
         9ulDSEyIynxHf1xOYmSwp4y18R7IdB3hBpOOTSvgtHFO9laHVbvcqIXoI2ZgWPNZJirY
         A8Nr/x74Q1dMtkv05YHjnmeOTBZfA9HVFlR1/eG7O10W/MkQTyJaQwWnRz4aBhMZCrim
         ygFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wGo+Lgs+s7pxNWzV32sXc7mUqLn1JvBswExMcqWix/I=;
        b=KFeay5KZRyPC0NfHGpTYi9mGhAaRduKfpF/8Qn9NOUVQ3GJFeVi/9J4pRvFj69gaat
         6OOekbfMVIpUPvlEug/aL2crUu5eM6AJxlIBPV+ifyHXFZFBoE/F+Cb3rX0z7POo7rny
         +0Q4vyqLa/8c6ZUi6tJks5FeeyW+xInlAHciTg8Etl+aDFAxR3LfJmW3cBxuVqsFCsZ4
         ZoVrdMuRSqUd6D8H3Edp4/bFcANivGrHH1tn6DajbQu/kA1AyOmAZWq5VYw8UF5f3Gin
         IIAZ4RJuqwXVOYnpmy5iSjHX1Sp4RTiRyn6oobWhqU0l3QZ4Ld40PYFzWHVs4vClIn44
         basQ==
X-Gm-Message-State: ALoCoQkBsAl6VSr1K0efZqKVnZACcrMYW41C9aTSbdtkS/3Q9ecbKbmFS4esAdy3lF+dettOFxw0h5u2Sqr+rTantCG5y3aXJw==
X-Received: by 10.28.138.6 with SMTP id m6mr75258370wmd.82.1451518386301;
        Wed, 30 Dec 2015 15:33:06 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id cv10sm16926818wjb.17.2015.12.30.15.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 15:33:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqk2nvd0cz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283217>

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
 reflog-walk.c     | 16 +++++++++++-----
 t/t1410-reflog.sh | 13 +++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

Junio C Hamano wrote:

> However, I see that there are one of two things that you could do to
> make this part of code do slightly better than stopping at the first
> non-commit object:
>=20
>  - pretend that the non-commit entry never existed in the first
>     place and return the commit that appears in the reflog next.

This turned out to be doable in the same code segment: just keep on
processing reflog entries until you hit a commit or run out of entries.
That (and the updated foremerly-failing test) are the only changes
between v2 and v3.

I'll try to actually implement the proper solution, but that'll take a
while. Until then, this at least stops a segfault :)

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
index b79049f..f97513c 100755
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
+test_expect_success 'reflog containing non-commit sha1s displays prope=
rly' '
+	git reflog refs/tests/tree-in-reflog >actual &&
+	test_line_count =3D 2 actual
+'
+
 test_done
--=20
2.7.0-rc1-207-ga35084c


--=20
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
