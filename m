From: tboegi@web.de
Subject: [PATCH v7 04/10] convert.c: ident + core.autocrlf didn't work
Date: Mon, 25 Apr 2016 18:56:32 +0200
Message-ID: <1461603392-30756-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:52:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujkG-0000MA-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933146AbcDYQwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 12:52:18 -0400
Received: from mout.web.de ([212.227.17.12]:52152 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933131AbcDYQwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:52:15 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LshWf-1bsVBl2p4r-012Jl7; Mon, 25 Apr 2016 18:52:12
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:i6WSLwzG8+MHwV3TCMV04eqo7ExLf2pL9AgmL3M0ecLNNp2Dxll
 vOsn9J9htiqGNOIIa/5sRnsSsNxwZgd8QGoTfGw1A15eyZaacGGmScvcDbwarBHquB19o/x
 4VAsAz5+j1f0m1p5wLtCyXBRD+7fvsOL/94BsT/JEBirKH+Wz482idlqlbNjFhFsJuHkAKK
 Am9/lsfdUCM6Y0fD5ecQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6burZLbqx3M=:WCm0YUnNdI3tUbrvExgksV
 NRIsRakU/POObhxaRu6B+9ZAwSoxzM3LzMxZR5p9cNJMwevCAMWNGA9a9yAw9l/+R8Vvz/0xC
 cRbB6S098wzv6MI5iMDeLjAUD5taaa6GPJGDcolHVVlC6mZXsH5OCsqhWJMVJ/gfUv3XIDjaI
 I9vWXnQsI5hiaeMjSb/rYeXPPtiCeRFSU+1NIeubsCiQllwo7b3nWPhuxiYu8+AoE5kZFq+zd
 Sv70COGVgVbTrA2SYzZTG9nkhOz3FVBzYmmhVIv0uWLmDsVWyIh2tKQAXK5zMnlQPVKogShTb
 PGxBpD/xYawnVhTaxmML43hEafcUooPrWhJD6ihfQN0i+hB0SmC3cH4JTPscAvI6ykizT04aY
 ajV7XZWoI4yU/RzD4qn2P9JIQoE4fJj48aazXAVchdYqnRZnsgLCgIlug2MsvOX48Nvglyk29
 5yJ9hFjnc3MFzzA3nw8T59b8p83au8kB6dDcQ+MpRz8I0EL49GZdQIT4339fWa7yub05tdy3e
 16/gEQw4Hea1KANcp/48teZH6DbY0GKmYxB/GIFQ8x+Pgm6li1y7oChH2Ry0srCNnn1U4JNoS
 ccad+Ip93GCV9xU5O+Go6s1s3hbau99ERTE63BGXgGHdCQNfMasnXsCVBjEFwbY4wrOffFNdI
 T+UPrMH5yElIZHAXOHPoxiI0FQFaCkfuCmKvD4svmrTGgpMHLS38dHvb9/eAymtnI+/7vYJVw
 Tu4/fXw1OaQWzueET7mbacVms113MjAx+vYJNUl0zqN4wl3opTKQ5pdWNmC+f57OK+riFbti 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292514>

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
 convert.c            | 19 +++++++------------
 t/t0027-auto-crlf.sh |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/convert.c b/convert.c
index f524b8d..b1614bf 100644
--- a/convert.c
+++ b/convert.c
@@ -1380,27 +1380,22 @@ static struct stream_filter *ident_filter(const=
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
+
+	if (ca.crlf_action =3D=3D CRLF_AUTO || ca.crlf_action =3D=3D CRLF_AUT=
O_CRLF)
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
+	if (output_eol(ca.crlf_action) =3D=3D EOL_CRLF)
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
+	else
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
2.0.0.rc1.6318.g0c2c796
