From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v3 4/4] make poll() work on platforms that can't recv() on a non-socket
Date: Fri, 7 Sep 2012 14:57:16 +0200
Message-ID: <003d01cd8cf8$4f931630$eeb94290$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:57:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9y7q-00019A-0j
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 14:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab2IGM51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 08:57:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:59154 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2IGM50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 08:57:26 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0McWI4-1SsIkP2CLA-00HhK2; Fri, 07 Sep 2012 14:57:25 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2M+EVDTcfqg0VGQmm98BuopNgN8g==
Content-Language: de
X-Provags-ID: V02:K0:7JNrisUwhpAVYkJCKe8QJgkEX8RZMtePY2j732vxAzP
 4tSIjCw3bP63a8x834ppHEMBtYyx5JaP95JPW82WiiF7P7kpQE
 7q9PnimetYPBz+B6D7AB7IbdnpfOpTdKHSHtQkaMh+Zy+p273x
 EuQDuZmRQkZ5WJrnGQWR3aVuX5ler9aoLkK0jV0X4tilhaRC2b
 9XiUhdOiDAO8pZjiiFqks9Jid4M9eX2XE5m0F9Yt6BTaq+Na/x
 l7V8wSO2KY1Xf239z1isCbsL7RNwB95XQnRZwqvBiaBZeJragd
 d4n5NBx2YiwDVNmowynhjG795hAIobcR32LMJQMSQjVOtuSOU/
 G+42EpHhalRYJi27DJ9gqFKdQmL+Ro5VpGzax/940N/TxeqWnB
 HXmIcJ4vH5yKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204964>

HP NonStop can't recv() on a non-socket, this commit cates for this.
So far for HP NonStop only, via #ifdef __TANDEM, but it may be usefull
for others too. A similar patch got sent to gnulib.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index e4b8319..10a204e 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -306,6 +306,11 @@ compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
 	       || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
 	happened |= POLLHUP;
 
+#ifdef __TANDEM /* can't use recv() on non-socket */
+      else if (/* (r == -1) && */ socket_errno == ENOTSOCK)
+	happened |= (POLLIN | POLLRDNORM) & sought;
+#endif
+
       else
 	happened |= POLLERR;
     }
-- 
1.7.12
