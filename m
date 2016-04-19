From: tboegi@web.de
Subject: [PATCH v5 4/4] convert.c: ident + core.autocrlf didn't work
Date: Tue, 19 Apr 2016 15:26:03 +0200
Message-ID: <1461072363-2874-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:22:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVbZ-0004Mu-UB
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbcDSNWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 09:22:09 -0400
Received: from mout.web.de ([212.227.17.12]:52511 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbcDSNWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:22:06 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MfHfy-1b7Q5B0kNG-00Oq3P; Tue, 19 Apr 2016 15:22:03
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:S3p4FQAWotsD+Or8isEYssnrnv1XZz1qGsPxB8lefSw36JquVD1
 H03oJOdVdXjFEUal4Rs7GZpj3zUpjpV3302MjKBNutoS4DFBDkWQUIgwVuzjeBdHT0r66mH
 vp2anz7IJD0MAKIKiBfZgiWojnptpbbUb/Dhn+jtCJnLSOyWlkRuS4ElV1aFf3qBQQkRegp
 mkyshxYBeE1Fy9BmRuyOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c6yCxTKGM1M=:sbUMdUXvr05/TEsOzX5GEG
 T5rHhFP+HWTfK77g74PRMXF3w9bXhHu8vzVWtzzdCWChF05Ceja/L25p05FUjM1MJMWF0Qpdt
 4vAu/h7n48rEzbgJExmb5ixDKooFcOXNv0o2raKh/WCpciPHw8wabsz86++z3ZYcdB8do/kBZ
 sOyddV01iZKnkX5l1oC8M+kUmhS9wo6vomCoesvmpiPPMte0RKMTyGluLdHNU1Qfo16dWSgea
 9PsKTuGB165HDX6d/uZnloJivAlJJojxWh6ZX7eaDg71wWMPwsuJM2lor7jJoQoTT7PVpyXiT
 0BIBe3ulnklz/aQ+2oLivNZUmERIUNlsdKrTlGKWZVkU8q20aui0ueK93l013QJbxsmEuBxME
 whMFwKI8QVgnWFYhvxsiORdwI0Z/joG179jvoKMkeAgNfd2mEqjClB7TvCtXKSE6ri6PxuK0I
 imwobnKqsU/HCuFswhUIT6RByjLfubeFIQS4ezqNwNsVs3684I7nhqn0oe2az4+feI4UUzLSU
 VTMqDgiza7zYLqMph7YVkGHSCkZ2T9133MiNPjr6+J2dmgm8COrVgiu/+34WrRa48E6jtzmeu
 YeD5MgqA3QJnVEp9d6jtDj50yRKGzsg0uiCGVxdwfAyfwJSvz60nchxoXXhgjtMxiYqkouHOw
 XvhLcoyGv5t+ambza2984Tz4v8QAYn7gK+/1RsRJfWVC2tAdrUeJU6d5EZlCMRz29S3GpnBd+
 pqyqzXilYIANP7mq9F5TkDb2EMIehU5teE9bOYjhitMkc7sFVCQ8T5a9j+xek/SmpGG/7OXK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291862>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When the ident attributes is set, get_stream_filter() did not obey
core.autocrlf=3Dtrue, and the file was checked out with LF.

Change the rule when a streaming filter can be used:
- if an external filter is specified, don't use a stream filter.
- if the worktree eol is CRLF and "auto" is active, don't use a stream =
filter.
- Otherwise the stream filter can be used.

Add test cases in t0027.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c            | 18 ++++++------------
 t/t0027-auto-crlf.sh |  2 +-
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/convert.c b/convert.c
index f524b8d..e8b0187 100644
--- a/convert.c
+++ b/convert.c
@@ -1380,27 +1380,21 @@ static struct stream_filter *ident_filter(const=
 unsigned char *sha1)
 struct stream_filter *get_stream_filter(const char *path, const unsign=
ed char *sha1)
 {
 	struct conv_attrs ca;
-	enum crlf_action crlf_action;
 	struct stream_filter *filter =3D NULL;
=20
 	convert_attrs(&ca, path);
-
 	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
-		return filter;
+		return NULL;
=20
 	if (ca.ident)
 		filter =3D ident_filter(sha1);
=20
-	crlf_action =3D ca.crlf_action;
-
-	if ((crlf_action =3D=3D CRLF_BINARY) ||
-			crlf_action =3D=3D CRLF_AUTO_INPUT ||
-			(crlf_action =3D=3D CRLF_TEXT_INPUT))
-		filter =3D cascade_filter(filter, &null_filter_singleton);
-
-	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
-		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_CRLF=
))
+	if (output_eol(ca.crlf_action) =3D=3D EOL_CRLF) {
+		if (ca.crlf_action =3D=3D CRLF_AUTO || ca.crlf_action =3D=3D CRLF_AU=
TO_CRLF)
+			return NULL;
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
+	} else
+		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
 	return filter;
 }
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index fd5e326..9372589 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -493,7 +493,7 @@ fi
 export CRLF_MIX_LF_CR MIX NL
=20
 # Same handling with and without ident
-for id in ""
+for id in "" ident
 do
 	for ceol in lf crlf native
 	do
--=20
2.8.0.rc2.2.g1a4d45a.dirty
