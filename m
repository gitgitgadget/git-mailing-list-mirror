From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/2] daemon: plug memory leak
Date: Sat, 24 Oct 2015 14:23:20 +0200
Message-ID: <562B7838.8050009@web.de>
References: <562B756F.1020305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 14:24:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpxrf-0000bN-JZ
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 14:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbbJXMX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 08:23:27 -0400
Received: from mout.web.de ([212.227.17.12]:61395 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbbJXMX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 08:23:26 -0400
Received: from [192.168.178.36] ([79.253.137.83]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M4qWn-1ajpp81Ilx-00z24o; Sat, 24 Oct 2015 14:23:23
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <562B756F.1020305@web.de>
X-Provags-ID: V03:K0:Kzb9dsnM+Y29DxYvcssqDZRs2kPmECwRzdN3nChiaSFmkDfVQZu
 XqjzOxul8USI6D+oYvyDB9ZKjrczfWU6LA0eIWNCs4T6prrHlQhrKuVr+hBTR6MJMFm0o/+
 N3qVsm+MTMG4k/oVyR3mD+TIBH8wfk+p3qt/5azVxUuk0Us7rTFgH2msXGEpdhnqQ4c071S
 IwVGGE0W2uu0azIHl9fcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gHvuQwrAN1I=:u4z4M1TAVS4q34ZDhVBmPz
 qoGxhPzQqClOqnr0dBkWCCXpswFahhXKhgNid7H94/GgHG/wSfMOz9jWg0Pg74vDMJ+nRkpbn
 GAghGOQZLdG/H80RVwlWBMkhtteFN8TUqO1nX8A3IGsnTTzKUdWGdh+UFrHOpoXJa0kUtDcrB
 4v/+YZdihYOD+i3AHUX/8WK0QSV11F26SQDAaRJN526XwuZi7meX5KTz4NNxoXqkPbXS/lmMQ
 baPachaGAsBkFkG/SfAO55845AB17MrjqI3uoLLaSplGjo3aAiYoSiO2eoUfmTHvZIDhWlxtS
 mRS4lCyiBbUdxrMrvAtbhQmFU/0yJYoQqxQhratsJc+4PM3gJuQxJXnHG7EuGWt1nbn8rjaTm
 08C2fIo/eZjY7xRE27H1RYtTd0XWpkfHG8/OOWzD23Qn0cPH1rrPvJOJ/OdUVd3kC/1S3jbLC
 XHuB7kdkhZAH8UnR7gJJKDTmoSRwBo2XjfsIKjrgKwg/xdLWWKMMF5nxhByBbuJjYtWyCA0a1
 voFwoTxMaqEybT3kxmcJswbOmtfGegRzuRs3YbVAGLvPYO75wAq9+ha+84Tf94rIsBSIqvyw9
 G9iYpn0EFdKzKcVx+5Xajb2U8SSpHe0OQgyzzMfIIhkf17fsji3vn3UNJ0MRMFbsZDgoYE1NB
 rAnRfgBIIy0/MLA0xhfTgjEFxcyUZ0DbQEtmJAowvGjmVFfZ3MVDa7OLYGiUJm45oLn+syAAW
 CWwuf8UHIVKVq1nkob/F7omMErC8+wLM+GA20oDEWzFOHutOVshMtQvNtOPIOksCsAuNnAM1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280119>

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
