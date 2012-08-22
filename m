From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH] Prefer sysconf(_SC_OPEN_MAX) over getrlimit(RLIMIT_NOFILE,...)
Date: Wed, 22 Aug 2012 18:00:50 +0200
Message-ID: <002301cd807f$4e19ad80$ea4d0880$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4DRl-0000kI-3P
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704Ab2HVQGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:06:15 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:61212 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab2HVQGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:06:13 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MGi7V-1SqnDV1SiX-00DWCa; Wed, 22 Aug 2012 18:00:57 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2AfwKnkUxmjjdGTJiI2Bck2Bg1Lg==
Content-Language: de
X-Provags-ID: V02:K0:V4oA1Y8W0M/MXBZQSYYAI3njYo3NMPeKQcQvJmXIy4T
 e3xLfh3xC/1Fb0yDEDcF5wfsFwKGok7P2A85nQFCs1gmzoHgIk
 o0BnFSdA0SIQevPxAmqaUDsxcQ/+gZFOXOI9yaMc/tHf0tCo9Z
 AZdQeW1gKSQAOkwA5DsSJ7ppiV/QVEdoyD+mnuqV2oFzSNI5Qb
 nPu8RHCZzeI4HKpW6EQp2ofUkDtCmmi+TgzArh3J3bh0jvV6Gc
 ft2p6Czyb/Ltt+NwRktFxLugNNlMNxq5NIfV1uXFt6ItTkipez
 KS7c6TYCi1LZ4Hu9tjYKIIqSBgYoLjRywcePIFYWw78YC0Nhb2
 2rdqPXno00HcVVH5UtQx7V9jHGVXfuNcI+2x3rNl7ZzLWUOYLM
 xGEsro0lgvGnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204023>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index af5cfbd..76714ad 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -747,6 +747,9 @@ static int open_packed_git_1(struct packed_git *p)
                return error("packfile %s index unavailable", p->pack_name);

        if (!pack_max_fds) {
+#ifdef _SC_OPEN_MAX
+               unsigned int max_fds = sysconf(_SC_OPEN_MAX);
+#else
                struct rlimit lim;
                unsigned int max_fds;

@@ -754,6 +757,7 @@ static int open_packed_git_1(struct packed_git *p)
                        die_errno("cannot get RLIMIT_NOFILE");

                max_fds = lim.rlim_cur;
+#endif

                /* Save 3 for stdin/stdout/stderr, 22 for work */
                if (25 < max_fds)
--
1.7.12
