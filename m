From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] ref-filter.c: don't stomp on memory
Date: Sun, 7 Feb 2016 00:23:15 +0000
Message-ID: <56B68E73.2050303@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: karthik.188@gmail.com
X-From: git-owner@vger.kernel.org Sun Feb 07 01:23:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSD8q-0001Xi-Eb
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 01:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbcBGAXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 19:23:19 -0500
Received: from avasout04.plus.net ([212.159.14.19]:59819 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbcBGAXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 19:23:18 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id FCPF1s0014mu3xa01CPGqd; Sun, 07 Feb 2016 00:23:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=uj0x_TV9Z20QuLXhmHwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285708>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Karthik,

If you need to re-roll your 'kn/ref-filter-atom-parsing' branch, could
you please squash this (or something like it) into the relevant patch
(commit 6613d5f1, "ref-filter: introduce parsing functions for each valid
atom", 31-01-2016).

This evening, (by mistake!) I built the pu branch with -fsanitize=address
in my CFLAGS. This resulted in many test failures, which were all caused
by the memcmp() call below stomping all over memory.

Hmm, as I was writing this email, I had a vague recollection of another
email on the list recently mentioning this code. So, if this has already
been reported, sorry for the noise!

ATB,
Ramsay Jones

 ref-filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index d48e2a3..c98065e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -260,7 +260,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		 * table.
 		 */
 		arg = memchr(sp, ':', ep - sp);
-		if ((!arg || len == arg - sp) &&
+		if ((( arg && len == arg - sp)  ||
+		     (!arg && len == ep - sp )) &&
 		    !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
-- 
2.7.0
