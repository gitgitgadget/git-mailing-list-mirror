From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v7 4/4] make poll() work on platforms that can't recv() on a non-socket
Date: Mon, 17 Sep 2012 23:24:42 +0200
Message-ID: <004e01cd951a$daed3740$90c7a5c0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 23:25:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDioV-0006Ux-7M
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 23:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2IQVY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 17:24:59 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:56411 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab2IQVY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 17:24:58 -0400
Received: from DualCore (dsdf-4db53772.pool.mediaWays.net [77.181.55.114])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MSCaM-1T6gba0f7K-00TGtE; Mon, 17 Sep 2012 23:24:56 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2VGr+4t9HezhgvQkSSa5lkNrvHfQ==
Content-Language: de
X-Provags-ID: V02:K0:MB6J7Fl16WBXuCZeYGGYcS7HgEO+yNvYA58VQ39Be/3
 24D4a2XsKHhh6x/GKpcjEgYGOrkgmjDQah4qkss6tqTRc40Bfi
 A1imSRXC2A6Ka7rjIokGktGL2bpz96F1aLMKeXYXFo9+ArBfan
 FPw5zsqsYUkHqTOgBwGltiFVhg+KdikXZUf4qG6Y5QLwIn47A1
 mPUbDVZ/E1x+evcV+FA0mbo5tpowwmyQYhTE7K8Gb11vYPdZLX
 kKSYj9mNerW5xce+u4nNP48Cb9phUK8MEqYosyzpd/ENh7LmO5
 +d96m/adRoHq/D3wDVuroPD/E8P7g/1BAd3ZNo8t3EnDH6EZcp
 UsyqR19NoldMhC1ZMjYl/sCMiQtHpFBJB28/58ITUrXC2WnFPa
 P3WtB5OJ9K81Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205754>

This way it just got added to gnulib too the other day.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index e4b8319..10a204e 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -306,6 +306,10 @@ compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
 	       || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
 	happened |= POLLHUP;
 
+      /* some systems can't use recv() on non-socket, including HP NonStop */
+      else if (/* (r == -1) && */ socket_errno == ENOTSOCK)
+	happened |= (POLLIN | POLLRDNORM) & sought;
+
       else
 	happened |= POLLERR;
     }
-- 
1.7.12
