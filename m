From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 2/2] thread-utils.c: detect CPU count on older BSD-like systems
Date: Sat,  7 Mar 2015 23:14:37 -0800
Message-ID: <087595269450d378dbaf0188e8f65c5@74d39fa044aa309eaea14b9f57fe79c>
References: <e85cd4def375e8247ab210983e44e75@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 08:14:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUVQP-0004vc-LX
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbbCHHOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:14:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:45452 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbbCHHOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:14:47 -0400
Received: by pdjy10 with SMTP id y10so16950063pdj.12
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 23:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDMu06Q13uBCI1fMltyOWxukXzULPP+cnzdJNZYQcJ0=;
        b=YFH5QTXzZ/UXE4ym1PUbH6zqBlPb1AW5wAh/pG4XXFl9e6NnHJnBuHjDfG4v/AsZ1v
         vK7K7O1pEO59kUJToGtj/wLcEG1HPjm/PH2Gf56n6Ixu9G+kEKiDY6f0jTGatFW2YZlu
         7lnA/aPwEryMQumVGzQkuxPPAbME7ahVv6PkjGVwPx0TCsoh1aWvKr3Silz32YxTz9eh
         kiaLeTb+0Iez4e2kalhGqPhI4LMbBpgwDvanQLqbqQ1uUfnzI1p7ba9xYBnttE8XIwW0
         2voALL+meIebWWsTnpLW+Ke5oQPbmbB2QvicetIZMdt17G/6qFcGitozFBOhZm05+jlI
         q1ng==
X-Received: by 10.68.68.141 with SMTP id w13mr40322433pbt.97.1425798886590;
        Sat, 07 Mar 2015 23:14:46 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id rx1sm14067028pbc.5.2015.03.07.23.14.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 23:14:46 -0800 (PST)
In-Reply-To: <e85cd4def375e8247ab210983e44e75@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265032>

Not all systems support using sysconf to detect the number
of available CPU cores.  Older BSD and BSD-derived systems
only provide the information via the sysctl function.

If HAVE_BSD_SYSCTL is defined attempt to retrieve the number
of available CPU cores using the sysctl function.

If HAVE_BSD_SYSCTL is not defined or the sysctl function
fails, we still attempt to get the information via sysconf.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 thread-utils.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/thread-utils.c b/thread-utils.c
index 97396a75..a2135e07 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -35,7 +35,23 @@ int online_cpus(void)
 
 	if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0))
 		return (int)psd.psd_proc_cnt;
-#endif
+#elif defined(HAVE_BSD_SYSCTL) && defined(HW_NCPU)
+	int mib[2];
+	size_t len;
+	int cpucount;
+
+	mib[0] = CTL_HW;
+#  ifdef HW_AVAILCPU
+	mib[1] = HW_AVAILCPU;
+	len = sizeof(cpucount);
+	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
+		return cpucount;
+#  endif /* HW_AVAILCPU */
+	mib[1] = HW_NCPU;
+	len = sizeof(cpucount);
+	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
+		return cpucount;
+#endif /* defined(HAVE_BSD_SYSCTL) && defined(HW_NCPU) */
 
 #ifdef _SC_NPROCESSORS_ONLN
 	if ((ncpus = (long)sysconf(_SC_NPROCESSORS_ONLN)) > 0)
---
