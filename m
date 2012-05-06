From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] index-pack: disable threading if NO_PREAD is defined
Date: Sun,  6 May 2012 19:31:56 +0700
Message-ID: <1336307516-1809-4-git-send-email-pclouds@gmail.com>
References: <7v8vh8c6mx.fsf@alter.siamese.dyndns.org>
 <1336307516-1809-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 14:36:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0h7-0007wc-HR
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab2EFMgE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 08:36:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55519 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab2EFMgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:36:03 -0400
Received: by pbbrp8 with SMTP id rp8so5621480pbb.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XehAwUAAmMLqzYjhGwYgp3vWh9+wvWwhPjxQ97bGLmo=;
        b=Rzf9iZmd/f/GQ7SNf6LMa9Fb7IC2hZ2VprnEqzZwuqWYBmRWtVf5WVncBjP+jxZ4mI
         qIZEz64HKFWV9PZRKYLBX0xcCqaJYyXTYoXlDGGdu4F3N5fnLgHDUz7l3p2W99yTRwdd
         eXnV6FhhjprPf9BUtJjF8KDu1nekYzoLEIP5P6wD2b3l04uTny/HlTltBldeENUkwPg4
         y7LqTXi07g+qBNTumB8BIg8OHfIzQqatvHBL744KY0PcpJ6pALO+5u2+wig+tJ/aHoHf
         BlfL3xUAh4KE0ilPx/IYgvjf06jnunSaJTwF8yoUXt8eblSVyRta15K1IwUMgkJcX20r
         lAvw==
Received: by 10.68.190.5 with SMTP id gm5mr17068143pbc.21.1336307762589;
        Sun, 06 May 2012 05:36:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.70])
        by mx.google.com with ESMTPS id rs3sm14842809pbc.47.2012.05.06.05.35.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 05:36:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 06 May 2012 19:32:27 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336307516-1809-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197177>

NO_PREAD simulates pread() as a sequence of seek, read, seek in
compat/pread.c. The simulation is not thread-safe because another
thread could move the file offset away in the middle of pread
operation. Do not allow threading in that case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d4685c5..807ee56 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -39,6 +39,11 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
=20
+#if !defined(NO_PTHREADS) && defined(NO_PREAD)
+/* NO_PREAD uses compat/pread.c, which is not thread-safe. Disable thr=
eading. */
+#define NO_PTHREADS
+#endif
+
 struct thread_local {
 #ifndef NO_PTHREADS
 	pthread_t thread;
--=20
1.7.8.36.g69ee2
