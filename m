From: tboegi@web.de
Subject: [PATCH v6b 04/10] convert.c: ident + core.autocrlf didn't work
Date: Sun, 24 Apr 2016 17:11:22 +0200
Message-ID: <1461510683-21005-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 17:07:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auLdD-00065p-7K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 17:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbcDXPHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 11:07:20 -0400
Received: from mout.web.de ([212.227.15.4]:63885 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbcDXPHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 11:07:10 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LlFOY-1bSrhE40uM-00b2AP; Sun, 24 Apr 2016 17:07:07
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:k/wPAKkv5jMDVHCqickWODTSRLHfcEk8pYV3iA4NPgTuDNBjPSf
 SmXnAxDvzar4oUTD0qxvjXxnWNo2+HtOU3SNQIIMe53s2urExkJLjdo4ihxWAqvJbJmin1Z
 N7vAHxmwB8eXeY39Az52YvOkJcOm2gT8APSNnYK/g7QNYq7uu6YiBZJuCOzl4XGyPEtMub/
 e986m/MyKBFWflXkJ6Zhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q/WlhELHtqQ=:GxZGQmsJtjuFYt9Pzci897
 JuUutR7WT/cbE3b+0A415/W0LMEAA0J1m75oCdxmY4KqcvjxdRpHGbHwnpAtDmXHgFO2UhIQD
 tNtoJ391JgvQFfkVHY34aIvPk70wb3Vvu70p3UE+pk4f8vhz9fFOyN8IwBi3kuMkhoO6L33In
 hSO5nM5WzRkqz8MsQVbmHDFQGETg4Ua3cZaLXLy0ChbrXRMt8XrsfCL0enzJEOeFDDGyzXhJk
 9WPXjuOODlVJ6n0JrR2UbZW5FbzxAURMnGz6DUFvYQe3/iSKlqaM3zaDYex/fCCsxnJ10d41y
 lamqH3IP6B1NCtL0Bdte/7r/A8Txn6a3WWus1J5jh5TA1Lxexqb9FKGrcVppOvbMrJgX4ZGfv
 YTSiZmz+ARlfa1m8sRqUWFjEu+5j8UNozS7k6rioaQjr8yc3MOLNUPdYSM8NzS/E1cbkyYMaf
 SognqN090UV+9JZl/l8YomaRSG+whBUEcOMvaKOzm6An9jrKyfT7e40bNWX6PKl5fGHVsY/LK
 YyVWs9SJy0wIFRF5zpVxvOInl9xQ4B4q1KlFJQlaI9pjOeFrZIwqnyso8eEZQRlARWMef8lmg
 c1lcR/i/WHhHuvxByqHwpZhfDrOwS0KgC09jDvf+rTmuNvvH5/86jEKFTmNGJ5QsO4StKdhUi
 7tBxrnUH6VznOJ/aKujaoIdZmSivLPmvrvNNKek/HOXu99Vdy/yyfXvo90sjeZcoNIGPJAcXi
 MRC1F8P7rXFBiiZgW/wWZr8iNidzGxKNKFBJuvI3XWW3/itrUCMIteGfJw4v7ZC8N/4Hy0dT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292411>

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
2.8.0.rc2.2.g1a4d45a.dirty
