From: =?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
Subject: [RFC/PATCH] MSVC: Windows-native implementation of pthread_cond_broadcast
Date: Fri, 29 Jan 2010 20:26:53 +0100
Message-ID: <1264793213-8805-1-git-send-email-zfuzesi@eaglet.hu>
References: <4B62CEAB.5050608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j.sixt@viscovery.net,
	=?UTF-8?q?Zolt=C3=A1n=20F=C3=BCzesi?= <zfuzesi@eaglet.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 20:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nawb6-0002rv-H7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 20:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab0A2Tdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 14:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039Ab0A2Tdf
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 14:33:35 -0500
Received: from mail.icell.hu ([80.99.238.252]:53786 "EHLO mail.icell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881Ab0A2Tde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 14:33:34 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2010 14:33:34 EST
Received: from source.ifleet (unknown [10.1.1.250])
	by mail.icell.hu (Postfix) with ESMTP id AC49939C;
	Fri, 29 Jan 2010 20:23:36 +0100 (CET)
Received: from fuge by source.ifleet with local (Exim 4.69)
	(envelope-from <zoltan.fuzesi@icell.hu>)
	id 1NawUZ-0002IT-C0; Fri, 29 Jan 2010 20:26:55 +0100
X-Mailer: git-send-email 1.7.0.rc0.48.gdace5
In-Reply-To: <4B62CEAB.5050608@viscovery.net>
In-Reply-To: <4B62CEAB.5050608@viscovery.net>
References: <4B62CEAB.5050608@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138341>

Threaded grep feature relies on this function, but its implementation w=
as
missing from the Win32 Pthreads API.

Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
---
Johannes, how about this? I haven't tested it.

 compat/win32/pthread.c |   12 ++++++++++++
 compat/win32/pthread.h |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 631c0a4..498b552 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -108,3 +108,15 @@ int pthread_cond_signal(pthread_cond_t *cond)
 	else
 		return 0;
 }
+
+int pthread_cond_broadcast(pthread_cond_t *cond)
+{
+	LONG prev_count;
+	while (cond->waiters) {
+		if (!ReleaseSemaphore(cond->sema, 1, &prev_count))
+			return err_win_to_posix(GetLastError());
+		if (prev_count =3D=3D LONG_MAX - 1)
+			break;
+	}
+	return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index b8e1bcb..11426f5 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -44,6 +44,8 @@ extern int pthread_cond_wait(pthread_cond_t *cond, CR=
ITICAL_SECTION *mutex);
=20
 extern int pthread_cond_signal(pthread_cond_t *cond);
=20
+extern int pthread_cond_broadcast(pthread_cond_t *cond);
+
 /*
  * Simple thread creation implementation using pthread API
  */
--=20
1.7.0.rc0.48.gdace5.dirty
