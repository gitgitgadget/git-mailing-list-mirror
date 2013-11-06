From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/2] receive-pack: advertise thin-pack
Date: Wed,  6 Nov 2013 16:04:22 +0100
Message-ID: <1383750263-32495-2-git-send-email-cmn@elego.de>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 06 16:04:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve4el-0007r5-6d
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 16:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab3KFPE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 10:04:27 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:60581 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756483Ab3KFPE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 10:04:26 -0500
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 15E92814CA;
	Wed,  6 Nov 2013 16:04:25 +0100 (CET)
Received: (nullmailer pid 32537 invoked by uid 1000);
	Wed, 06 Nov 2013 15:04:23 -0000
X-Mailer: git-send-email 1.8.4.652.g0d6e0ce
In-Reply-To: <1383750263-32495-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237352>

upload-pack has long advertised thin-pack, letting the clients request
these smaller packs. The client however unconditionally assumes that a
server is able to fix thin packs and there is no way of telling the
client that this is in fact not the case.

Make receive-pack advertise 'thin-pack' in anticipation of the client
toggling the assumption and document this capability when used by
receive-pack.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 Documentation/technical/protocol-capabilities.txt | 20 +++++++++++++++=
-----
 builtin/receive-pack.c                            |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index fd8ffa5..4e96d51 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -72,15 +72,25 @@ interleaved with S-R-Q.
 thin-pack
 ---------
=20
-This capability means that the server can send a 'thin' pack, a pack
-which does not contain base objects; if those base objects are availab=
le
-on client side. Client requests 'thin-pack' capability when it
-understands how to "thicken" it by adding required delta bases making
-it self-contained.
+A thin pack is one with deltas which reference base objects not
+contained within the pack (but are known to exist at the receiving
+end). This can reduce the network traffic significantly, but it
+requires the receiving end to know how to "thicken" these packs by
+adding the missing bases to the pack.
+
+The upload-pack server advertises 'thin-pack' when it can generate and
+send a thin pack. The receive-pack server advertises 'thin-pack' when
+it knows how to "thicken" the pack it receives.
+
+Likewise, the client requests the 'thin-pack' capability when it
+understands how to "thicken" it.
=20
 Client MUST NOT request 'thin-pack' capability if it cannot turn a thi=
n
 pack into a self-contained pack.
=20
+Client MUST NOT send a thin pack if the server does not advertise this
+capability.
+
=20
 side-band, side-band-64k
 ------------------------
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..0e35c02 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -132,7 +132,7 @@ static void show_ref(const char *path, const unsign=
ed char *sha1)
 	else
 		packet_write(1, "%s %s%c%s%s agent=3D%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k quiet",
+			     " report-status delete-refs side-band-64k quiet thin-pack",
 			     prefer_ofs_delta ? " ofs-delta" : "",
 			     git_user_agent_sanitized());
 	sent_capabilities =3D 1;
--=20
1.8.4.652.g0d6e0ce
