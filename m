From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Windows: only add a no-op pthread_sigmask() when needed
Date: Tue, 10 May 2016 15:00:35 +0200 (CEST)
Message-ID: <26c2fb5560246fc7f980da24a239edc333864527.1462885167.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 15:00:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b07HQ-0004V7-JA
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 15:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbcEJNAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 09:00:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:60462 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbcEJNAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 09:00:48 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnfuZ-1bYKMZ2ajv-00hs4E; Tue, 10 May 2016 15:00:40
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:YnGSUc+EntHxLTTO4B9wmOPcAJC29yk3brtL9QXPQDr8/2fXZvC
 CBw6k0AS3L18sbiSQ0Vah6YnobPdeAllw1rh92q9b3fAWHAUHv7MdBlrI8GGV/oqQZVJBJ1
 s9xXukWMqPQr/Ol4XnXZteOwM/1F63nDHvsWSuehvm7wO4p59dejLzynqPOpQ00Cd6Qxd0B
 LYiiIZg0CEQ3X6808lQ9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FUmcQHu815k=:/TDn9DhJstmnfVInkBXThP
 6LTePxeBqLrunnv5SLVplq5tuH7zyy9V0epbsW3VPw4J9Sei+JkAkO72MVOc0MTDgD5ZANfgs
 rm17+VdYLjGXemySw+4/uG72oSX1pwECEQ1Og94H27yZhhMc4eAS9z4VYmHksFH1EWhw/lWbV
 5XonFgFNonaySZ+4RZojf7L24PHryTwJgdFRHudZeADJCx1k5gEN45hzf4latFrja4EAOF/Uo
 INNPUKHrR/cba0eZv52dIzGPxotsJ8WPvUPASD8rld4uyFZUXVe9nu2Nq/E4N/kcY9W+G14Dd
 3XTUqy+hd6mRK8GDKG2ZdtxjiBw8THdBjjSrV8PStRBO8tnRyprcJjK9uEnSr4P6QIha+sN+z
 C5UR7dpytdLBq/OPIoIkJdiLtmI3+8YJyCkqZxRcveduCcJWTnPQmdSgxkS+mFkGcoQm7Ig2F
 hre+esd9bNngE5BxoiI4FEeDCt8tQwa6gXhh65bJV5xo/hj2qQvpH79BzOabby6Puoc1jdpht
 dwjuwFtoKSUkB9A4WQMdiNIkWRjg9CwOmulWwxSXc2f+XNbyUJI5PiFTzuscNkGWrTBVeyyE8
 CI2/tFwLe2XHyOmrsC6QImpeF2kzQwWxFHf05YblLaXg0AInYfe7s9surIfINJUrbU9Eejt3J
 FUlWB5HmVCVBg9jGlvzP/LN5QldlqHUNdYhCov8HI5HNFu3Hu1Q74d/5REgCQf2yC84ssUL/X
 mtlxYvE9TlgYUC9uOnYYt9y/sis/4kABDzrj70blOFVKMv3ySC1biYa96DvWHQHQEGv3Tsls 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294129>

In f924b52 (Windows: add pthread_sigmask() that does nothing,
2016-05-01), we introduced a no-op for Windows. However, this breaks
building Git in Git for Windows' SDK because pthread_sigmask() is
already a no-op there, #define'd in the pthread_signal.h header in
/mingw64/x86_64-w64-mingw32/include/.

Let's guard the definition of pthread_sigmask() in #ifndef...#endif to
make the code compile both with modern MinGW-w64 as well as with the
previously common MinGW headers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch is obviously based on 'next' (because 'master' does not
	have the referenced commit yet).

Published-As: https://github.com/dscho/git/releases/tag/mingw-sigmask-v1
 compat/win32/pthread.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index d336451..8df702c 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -104,9 +104,11 @@ static inline void *pthread_getspecific(pthread_key_t key)
 	return TlsGetValue(key);
 }
 
+#ifndef pthread_sigmask
 static inline int pthread_sigmask(int how, const sigset_t *set, sigset_t *oset)
 {
 	return 0;
 }
+#endif
 
 #endif /* PTHREAD_H */
-- 
2.8.2.463.g99156ee
