From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH] imap-send: Code correctness flagged by clang
Date: Sat,  7 Aug 2010 12:12:16 +0000
Message-ID: <1281183136-10352-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike McCormack <mike@codeweavers.com>,
	Benjamin Kramer <benny.kra@googlemail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 07 14:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiHN-0004JG-VK
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099Ab0HGMMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 08:12:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43683 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab0HGMMc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 08:12:32 -0400
Received: by wwj40 with SMTP id 40so10069520wwj.1
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MwTu0B5hdCO+Fej5IyVco2S4eRLklEKQJvJr4AZpGy0=;
        b=XtpCasT7ydiIYr5FmMV1zf9+BCYRq/baCSD8xhzDvt4JUtleAWr9++pMYc1j3Y9LXh
         TBLPw+thuwuvrCZfQrwSZXw/d/ySWjiYKwExPSO0irevQEl8MV2dU4D4qtDKmx5dfX53
         U05bd/Dsxi7nuc8H225UVpZCoPcTaL3S+uH78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tDlQat1T5pIT+dR9X1ekiW279FLCj3ugGusUoOvWWDzjqTi0CaKqFa2iBGywBPYuKn
         DfqFTQ742bYK6SnKoaY9Tb1Wng/0Jre9bqT8ZwQL6aJjsZ4yk74zTdQQCOm2u+nRfNFI
         1eucMEbCA/ZUdz+enGlPGEpWm13+Mow9XwwjQ=
Received: by 10.216.185.72 with SMTP id t50mr11676365wem.77.1281183150852;
        Sat, 07 Aug 2010 05:12:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w46sm1446771weq.43.2010.08.07.05.12.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 05:12:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152853>

Clang 1.1 flagged the following issues in imap-send.c, this change
fixes the warnings by moving some code around:

    imap-send.c:548:27: warning: data argument not used by format strin=
g [-Wformat-extra-args]
                               cmd->tag, cmd->cmd, cmd->cb.dlen);
                                                   ^

Here the sprintf format didn't use the cmd->cb.dlen argument if
cmd->cb.data was false. Change the code to use a if/else instead of a
two-level ternary to work it. This code was introduced with imap-send
itself in f2561fda.

    imap-send.c:1089:41: warning: conversion specifies type 'unsigned s=
hort' but the argument has type 'int' [-Wformat]
                    snprintf(portstr, sizeof(portstr), "%hu", srvc->por=
t);
                                                        ~~^   ~~~~~~~~~=
~

Here sprintf is being given an int with a %hu format. Cast the
srvc->port to unsigned short to work it. This code was introduced in
94ad2437 to add IPv6 support.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 imap-send.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1a577a0..4b25375 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -543,9 +543,14 @@ static struct imap_cmd *v_issue_imap_cmd(struct im=
ap_store *ctx,
 	while (imap->literal_pending)
 		get_cmd_result(ctx, NULL);
=20
-	bufl =3D nfsnprintf(buf, sizeof(buf), cmd->cb.data ? CAP(LITERALPLUS)=
 ?
-			   "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
-			   cmd->tag, cmd->cmd, cmd->cb.dlen);
+	if (cmd->cb.data) {
+		bufl =3D nfsnprintf(buf, sizeof(buf),
+		                  CAP(LITERALPLUS) ? "%d %s{%d+}\r\n" : "%d %s{%d}\r=
\n",
+		                  cmd->tag, cmd->cmd, cmd->cb.dlen);
+	} else {
+		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cm=
d);
+	}
+
 	if (Verbose) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
@@ -1086,7 +1091,7 @@ static struct store *imap_open_store(struct imap_=
server_conf *srvc)
 		int gai;
 		char portstr[6];
=20
-		snprintf(portstr, sizeof(portstr), "%hu", srvc->port);
+		snprintf(portstr, sizeof(portstr), "%hu", (unsigned short)srvc->port=
);
=20
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_socktype =3D SOCK_STREAM;
--=20
1.7.1
