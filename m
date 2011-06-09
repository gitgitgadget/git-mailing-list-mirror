From: Dave Zarzycki <zarzycki@apple.com>
Subject: [PATCH] Only print an error for the last connect() failure
Date: Thu, 09 Jun 2011 09:18:10 -0700
Message-ID: <13539E82-3E8D-4210-9A3A-DD83F0CA6F85@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 18:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhwT-0007Bp-L0
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 18:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab1FIQSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 12:18:40 -0400
Received: from mail-out.apple.com ([17.151.62.49]:32876 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab1FIQSj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 12:18:39 -0400
Received: from relay12.apple.com ([17.128.113.53])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LMJ007JB6LICO60@mail-out.apple.com> for git@vger.kernel.org;
 Thu, 09 Jun 2011 09:18:12 -0700 (PDT)
X-AuditID: 11807135-b7b76ae000001169-2f-4df0f28a1b18
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay12.apple.com (Apple SCV relay)
 with SMTP id 42.CA.04457.A82F0FD4; Thu, 09 Jun 2011 09:19:22 -0700 (PDT)
Received: from [17.153.30.81] (unknown [17.153.30.81])
 by cardamom.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPSA id <0LMJ00GBT6MA2U90@cardamom.apple.com> for git@vger.kernel.org;
 Thu, 09 Jun 2011 09:18:12 -0700 (PDT)
X-Mailer: Apple Mail (2.1237.1)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsUiON1OVbfr0wdfg9MvzC26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJUx/cA59oKl7BWzVh9kbmA8ydrFyMEhIWAisXQjYxcjJ5ApJnHh
	3nq2LkYuDiGBViaJ1X/2sIIkeAUEJX5MvscCUs8sIC9x8LwsSJhZQEvi+6NWFoj6+UwSt2Z9
	YgdJsAloSHw6dZcZxBYWcJZ4u+IbmM0ioCqxa+s6JoiZNhKPbv0BWywiIC7x9vhMdogj5CW2
	bXrJPIGRdxaS1bMQVs9CsnoBI/MqRsGi1JzESkMjvcSCgpxUveT83E2MoGBpKDTdwfhoofoh
	RgEORiUe3o7F732FWBPLiitzDzFKcDArifCWXgQK8aYkVlalFuXHF5XmpBYfYpTmYFES5317
	39NXSCA9sSQ1OzW1ILUIJsvEwSnVwBjGebArK8w12mB6773sJCsX2W77Yw+il/vxyDgfLf+i
	1VzQNf8uy9bJBxIvfd0VFBb0cOeaWtGJTJws564oHs2Wm+of49YV7VxZHNVz1mrBCbNJGY3O
	4T/Wdf1c5G4scyTzZUyhrarFfq9/3cyJMmpKLTf0nY+lLmbc4Hj9UsVjv+veXnsXK7EUZyQa
	ajEXFScCAMdzB1wSAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175546>

IPv6 hosts are often unreachable on the primarily IPv4 Internet and
therefore we shouldn't print an error if there are still other hosts we
can try to connect() to. This helps "git fetch --quiet" stay quiet.
---
 connect.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 2119c3f..7f70ce7 100644
--- a/connect.c
+++ b/connect.c
@@ -225,11 +225,13 @@ static int git_tcp_connect_sock(char *host, int flags)
 		}
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
-				host,
-				cnt,
-				ai_name(ai),
-				strerror(saved_errno));
+			if (ai->ai_next == NULL) {
+				fprintf(stderr, "%s[%d: %s]: errno=%s\n",
+					host,
+					cnt,
+					ai_name(ai),
+					strerror(saved_errno));
+			}
 			close(sockfd);
 			sockfd = -1;
 			continue;
-- 
1.7.6.rc1.1.g2e27
