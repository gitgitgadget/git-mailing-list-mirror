From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 3/3] daemon: plug memory leak
Date: Sat, 31 Oct 2015 10:20:52 +0100
Message-ID: <563487F4.6080403@web.de>
References: <56348709.9080207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 10:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsSLT-0006tX-Jw
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 10:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbbJaJVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 05:21:03 -0400
Received: from mout.web.de ([212.227.17.12]:58449 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbbJaJVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 05:21:00 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M6V1T-1ahpZU1Wp9-00yTkf; Sat, 31 Oct 2015 10:20:55
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56348709.9080207@web.de>
X-Provags-ID: V03:K0:vS7HzSppdXQMaQ6SrjP4Wf/kCquIP9t0UDhFB+roA1Ya4rOJN1t
 coGwt37GQt87oxWcYcqjtDG3I2zRLLzAj+nUjEI2X8RWdI/UMxzUO2swcleNaOZg0ugNV9S
 P1td/cMYgp5+9NMGs7/N2qFB8p7LJd/BFDlFtpL0fk/T8sZihF1orehKSSndQnbd4Xmi9tg
 4nwiTN3VF8GCo7HXxwufw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8ZOX8uCCXWY=:5GBSnFaGxRvOv/5hWpZs5N
 CqBp49rBCBg5gJV7CLAWWBjKVxVXCwpMjZHdBCPBTvlUZvQNXJ1qgM+bygWQjqdV04/NAKen0
 o1g2GS5ItfBrsbqqrrr1UxJNB8cFdXvVBqUMVfhhZMtpI8XhoIIeCRAFslKfSLX53IO16S43A
 8yy9GPR+eO28SYBF5uNwICdm5i/+KgJBbmGV429jZ7vIgvM0QvNG4+WR7DVbrDVwoawIDHS2H
 I9c1nvkpF5t2NbLmQ9IpfdG6ncat9rtc6TnKpLB/Af2WDM1PndVEZDU/W0SAxxNv9XYPA8bBO
 UOQCm6eX66tyQkUvquMkj9EyKRd3NtS6VZ3CCx/jjIY92lY/kR+Co4b4q9uAVwgqG3Gr7pVLD
 NL6NGf2sRdJ7CfUTfCV+rSoFem7Bznl+AtxqzPSfzA/WIDHcDcZXDYHIoe7XCKJn1rh4BPfVC
 lxbX4gSJcf15Iy6NK0O+uGw9VlP9BTf1nvsiKWk9bBe6WqpDOLEt0ZahNnZJnEY764VNzO9j9
 1Jf2GGkp0ocNo9gGPE6iBj/VtUSSJDMU2w6sGY9m6iTpLhv1rvjAh2YZhu2p0j3i/WKBRkS5D
 nUCVEfplzY9Mdd9jkJYtvsuAuWGuI1i5pxVJnyGXRdYHpbor7aELwTCciXiW93U3ykjBSdw//
 nlKO6bz5QRfMXCO/G6gKNAXZ+U1AueyqK/hrd3G5p6j8SgKfQys77GvajAq4AGb5kKg35iIH5
 2np66G51cUa0U+3qpK2nZoKy6psb+I9Vh335cUXEL8bOEcqcwnntZsYxjugNQqJBKyeAIp3I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280574>

Call child_process_clear() when a child ends to release the memory
allocated for its environment.  This is necessary because unlike all
other users of start_command() we don't call finish_command(), which
would have taken care of that for us.

This leak was introduced by f063d38b (daemon: use cld->env_array
when re-spawning).

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/daemon.c b/daemon.c
index 56679a1..be70cd4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -802,6 +802,7 @@ static void check_dead_children(void)
 			/* remove the child */
 			*cradle = blanket->next;
 			live_children--;
+			child_process_clear(&blanket->cld);
 			free(blanket);
 		} else
 			cradle = &blanket->next;
-- 
2.6.2
