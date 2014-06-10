From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v3] t9001: avoid not portable '\n' with sed
Date: Tue, 10 Jun 2014 06:07:59 +0200
Message-ID: <5396849F.7060206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 06:08:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuDLy-0000Wx-N3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 06:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbaFJEIC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 00:08:02 -0400
Received: from mout.web.de ([212.227.17.12]:63159 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaFJEIB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 00:08:01 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MUF50-1XKAV3229y-00R4Dg; Tue, 10 Jun 2014 06:07:59
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:C/K83h+jksJZ0xEbF1jFvCGQjANd2bBoJPCY9s62yUiY2GaasGc
 R6fy3wwQN02M8zihhUGb/OUiQJZOc6xJX78AsEoSHJFWRHRmuBf/0UvWFyxk2adpdUI1Usx
 5YXZ9Pn71iCL5uC3xL1EDqu6OwARBLhyejVrjiydeOILt9zbMTQDbJVV0bEZX1NnHJA3sZF
 RHV6ZQEtZHdWLK9EpM3xg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251155>

t9001 used a '\n' in a sed expression to split one line into two lines,
but the usage of '\n' in the "replacement string" is not portable.

The '\n' can be used to match a newline in the "pattern space",
but otherwise the meaning of '\n' is unspecified in POSIX.

- Gnu versions of sed will treat '\n' as a newline character.
- Other versions of sed (like /usr/bin/sed under Mac OS X)
  simply ignore the '\' before the 'n', treating '\n' as 'n'.

=46or reference see:
pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
http://www.gnu.org/software/sed/manual/sed.html

As the test already requires perl as a prerequisite, use perl instead o=
f sed.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Sending a V3 patch seems "spammish", but after re-reading all
the comments I think that the commit msg should point out the differenc=
e
between POSIX sed and gnu sed somewhat better.

 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64d9434..19a3ced 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1342,7 +1342,7 @@ test_cover_addresses () {
 	git format-patch --cover-letter -2 -o outdir &&
 	cover=3D`echo outdir/0000-*.patch` &&
 	mv $cover cover-to-edit.patch &&
-	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch=
 >"$cover" &&
+	perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover-to-edit=
=2Epatch >"$cover" &&
 	git send-email \
 	  --force \
 	  --from=3D"Example <nobody@example.com>" \
--=20
2.0.0.553.ged01b91
