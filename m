From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/4] pack-objects: do not get distracted by stale refs
Date: Thu, 24 Sep 2015 11:13:44 +0200
Organization: gmx
Message-ID: <a3a883ce9d7a8bf4220beb640caca5bed0f7d492.1443085919.git.johannes.schindelin@gmx.de>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 11:13:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf2bG-0004Hf-1t
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 11:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbbIXJNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 05:13:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:49782 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbbIXJNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 05:13:49 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lyi0B-1ajBYU1acx-016C6D; Thu, 24 Sep 2015 11:13:45
 +0200
In-Reply-To: <cover.1443085919.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:/LblwjSNVQ7FbgdjFjZyrPM7MrX1Zt4YeZfV4pCXdle37j6kcXI
 SH8A6thImh9lDC/tpPjO+MzjMz703OjTC4rF6ENqnV1dsHbVNuCqGSMpN9nEeygs7cRN7pw
 yiAjQCVF0UIbVtVMOpdnCZvc6b3S5P1wtiR999OuUYVZfQErOOveIqt3gLU7yV5oMJHbyvl
 UYyMlV0r7ionjhxEBVRXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BCof+jw5Its=:fxU0+C12e7Cv49I5pBUK6q
 dYuCVX6D+18IO0d6hdEWELYcv0UTQPJGR/HRtExqtKjL+AhXl7e7RONbFU68T0uCpic1FVj09
 8phQP59tukcTQ7U6ZW7/NnMJs7/VPjAz3hevlXNpYegYg7ISANxTIinpmYrVWs53AIQ9k1lfX
 N7ug8ZM/yzKZcS+wT4DTolfLY8BiFen5TGUWI8X+hJHh8wKblt6UEqp00n8myZpSKm9coX2hv
 kY1UoEqFVkGYqASAv1QgR7RhrcBrWK9vT+FYeletNHVuLoPcvfYYK8qf3nqpAm/Lw5J77f6/h
 4j0NWNN5kU4e1emZsV529E1hXk1xx4dZji4FSF0RFQBC96iXCOy3wLbEJKBQ7bIe/0tO2ausR
 03p856lKOh12TEvBexOov5HOX2OUG8UeAvGDbLTuqJyoXkUwZ/mJAkxZ4VF7YOl9lJj71OL8M
 Y8iUKj0ZOEDSgPic8irEK+dOFvuWt/fxyvnLb3+vM45/KpGH6s5EYuJj9sonXW3wYsSamOwyi
 ATM5w17EVkxrmcGkocGVmgi/WFONFjaF6I57Kpt6Rr1vGKu/coX0+/3mAHuBen+LSKJ1foF/5
 B5zWZ/L68tqsy8hMsEafmMgRJ1UgqP/f7QefLqAHBGznaZsavf0Jl10t/n/qO7nP5rkMQ+tA3
 8IW2Zr1Xoqfl4mdkB44QBS4WEa650Sg0n9Flu2UPNgvzTaXtHLIYEZc14sOvnU7YZJuOnPEFj
 AsAcQ2MtLl0nBPX0Zga74xdLxqiKu9ICnqeHNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278539>

It is quite possible for, say, a remote HEAD to become stale, e.g. when
the default branch was renamed.

We should still be able to pack our objects when such a thing happens;
simply ignore invalid refs (because they cannot matter for the packing
process anyway).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1c63f8f..ef2f794 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2499,6 +2499,7 @@ static void get_object_list(int ac, const char **av)
 	int flags = 0;
 
 	init_revisions(&revs, NULL);
+	revs.ignore_missing = 1;
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
-- 
2.5.2.windows.2
