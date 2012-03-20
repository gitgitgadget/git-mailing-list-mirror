From: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
Subject: [PATCH] Use SSH key from `GIT_SSH_KEY` variable if supplied
Date: Tue, 20 Mar 2012 02:39:17 +0100
Message-ID: <1332207557-10965-1-git-send-email-me@mmalecki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 02:39:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9o2X-0003tj-CW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 02:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758288Ab2CTBjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 21:39:03 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64041 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab2CTBjC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 21:39:02 -0400
Received: by wibhq7 with SMTP id hq7so4566717wib.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 18:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=YjNTaONr39K9ROOenfqFg7dT6BD7Ge544AiAJjgL7ng=;
        b=Bo9V6i11DrjKXKU3QYN4Avc6l5TpYKDlwTxT4Z5UW26VV2QXcAM0oOpqc0xblMtApU
         M1JxU/qmtIxctSvSbx2aT/mzQFcFRhBK3xNSDW5wTVXzxbJUExRPC643Igq1HVnHJCEK
         sJdWJ8+La7PApXu/bG4TI7zStf+GNypLtw4yZ9eJ+gVOY/JoW+Fox3C3TipLgV31qxer
         taIdnJIoGKJtzso7BSWcYAA4mTnBEhxUM+ADhasQiaXxyWSIoAMl/CLrEW9OtAOo4H+P
         J8y83DiP4PYs56+C2KDVOwcZ9Hsrk0WY5dXvjJIcZYlF2O1mVqLHLHHl5Z1Qg+wPFo4m
         KxcQ==
Received: by 10.180.107.101 with SMTP id hb5mr23730549wib.3.1332207540048;
        Mon, 19 Mar 2012 18:39:00 -0700 (PDT)
Received: from PC05.lan (abx203.neoplus.adsl.tpnet.pl. [83.25.49.203])
        by mx.google.com with ESMTPS id fz9sm30075541wib.3.2012.03.19.18.38.58
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 18:38:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.6
X-Gm-Message-State: ALoCoQmISRU7rR52ywrvFFT8UUkOS3il9uq/5Q1H9DjaL3LIAMWEtXyhVJjCjkFiWdj0N96Mv+Cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193476>

Using a different SSH key for various SSH commands seems to be a
recurring theme. Allow user to supply path to the SSH key he wants to
use for operations that require it without need to use `GIT_SSH`
variable and a wrapper script.

Signed-off-by: Maciej Ma=C5=82ecki <me@mmalecki.com>
---
 connect.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 912cdde..dd3489d 100644
--- a/connect.c
+++ b/connect.c
@@ -575,8 +575,9 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 		die("command line too long");
=20
 	conn->in =3D conn->out =3D -1;
-	conn->argv =3D arg =3D xcalloc(7, sizeof(*arg));
+	conn->argv =3D arg =3D xcalloc(9, sizeof(*arg));
 	if (protocol =3D=3D PROTO_SSH) {
+		const char *key;
 		const char *ssh =3D getenv("GIT_SSH");
 		int putty =3D ssh && strcasestr(ssh, "plink");
 		if (!ssh) ssh =3D "ssh";
@@ -589,6 +590,13 @@ struct child_process *git_connect(int fd[2], const=
 char *url_orig,
 			*arg++ =3D putty ? "-P" : "-p";
 			*arg++ =3D port;
 		}
+
+		key =3D getenv("GIT_SSH_KEY");
+		if (key) {
+			*arg++ =3D "-i";
+			*arg++ =3D key;
+		}
+
 		*arg++ =3D host;
 	}
 	else {
--=20
1.7.7.4
