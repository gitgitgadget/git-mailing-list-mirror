From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH v4] imap-send.c: fix compiler warnings for OpenSSL 1.0
Date: Sat, 31 Oct 2009 14:36:03 +0800
Message-ID: <1256970963-6345-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 07:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N47Yh-0000BS-90
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 07:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZJaGcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2009 02:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbZJaGcx
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 02:32:53 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:52054 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbZJaGcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 02:32:52 -0400
Received: by ywh40 with SMTP id 40so3305181ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 23:32:57 -0700 (PDT)
Received: by 10.150.171.17 with SMTP id t17mr4432978ybe.303.1256970777067;
        Fri, 30 Oct 2009 23:32:57 -0700 (PDT)
Received: from localhost.localdomain ([114.244.46.31])
        by mx.google.com with ESMTPS id 22sm1363052ywh.0.2009.10.30.23.32.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 23:32:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131835>

=46edora 12 has upgraded OpenSSL to 1.0.0-beta3 version.
When compiling git on Fedora 12, the following warning is displayed:

imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
imap-send.c:284: warning: assignment discards qualifiers from pointer t=
arget type
imap-send.c:286: warning: assignment discards qualifiers from pointer t=
arget type

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The relevant change in OpenSSL 1.0:

*) Let the TLSv1_method() etc. functions return a 'const' SSL_METHOD
     pointer and make the SSL_METHOD parameter in SSL_CTX_new,
     SSL_CTX_set_ssl_version and SSL_set_ssl_method 'const'.

Signed-off-by: Vietor Liu <vietor@vxwo.org>
---
 imap-send.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..f805c6e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -273,7 +273,11 @@ static int ssl_socket_connect(struct imap_socket *=
sock, int use_tls_only, int ve
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
 	return -1;
 #else
+#if (OPENSSL_VERSION_NUMBER >=3D 0x10000000L)
+	const SSL_METHOD *meth;
+#else
 	SSL_METHOD *meth;
+#endif
 	SSL_CTX *ctx;
 	int ret;
=20
--=20
1.6.5.2
