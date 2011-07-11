From: Dave Zarzycki <zarzycki@apple.com>
Subject: Resend: [PATCH] Do not log unless all connect() attempts fail
Date: Mon, 11 Jul 2011 11:06:15 -0700
Message-ID: <A3C89B89-4E31-400E-9DF8-C0F289D72D81@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 20:06:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgKsL-00012k-RO
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 20:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758424Ab1GKSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 14:06:29 -0400
Received: from crispin.apple.com ([17.151.62.50]:65462 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758404Ab1GKSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 14:06:28 -0400
Received: from relay16.apple.com ([17.128.113.55])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTP id <0LO600B6HKGI1061@mail-out.apple.com> for git@vger.kernel.org;
 Mon, 11 Jul 2011 11:06:17 -0700 (PDT)
X-AuditID: 11807137-b7c4bae0000013e5-b3-4e1b3c018ef0
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay16.apple.com (Apple SCV relay)
 with SMTP id 31.D0.05093.10C3B1E4; Mon, 11 Jul 2011 11:08:01 -0700 (PDT)
Received: from davez.apple.com (davez.apple.com [17.226.34.35])
 by cardamom.apple.com
 (Oracle Communications Messaging Exchange Server 7u4-20.01 64bit (built Nov 21
 2010)) with ESMTPSA id <0LO600KI2KYFOD00@cardamom.apple.com> for
 git@vger.kernel.org; Mon, 11 Jul 2011 11:06:17 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsUiON1OVZfRRtrP4O1EfouuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGWcmfGPtWAWf8XGY0fYGhgfcXYxcnJICJhI9DTuZoewxSQu3FvP
	1sXIxSEk0MokcWbFaxaQBK+AoMSPyfeAbA4OZgF5iYPnZUHCzAJaEt8ftbJA1K9gkvjy7CUj
	SIJNQEPi06m7zCC2sICbxNQP/xlBelkEVCWWPlKEGGkj8fLJHbByEQFxibfHZ0LdIC+xuOUz
	4wRG3llINs9C2DwLyeYFjMyrGAWLUnMSKw3N9BILCnJS9ZLzczcxgoKlodB8B+P2v3KHGAU4
	GJV4eBnlpP2EWBPLiitzDzFKcDArifDuZgcK8aYkVlalFuXHF5XmpBYfYpTmYFES512dye0n
	JJCeWJKanZpakFoEk2Xi4JRqYGxsdDvfnbBCqmFlnovA/sT35Uc09IXiz3y68iboGAfz/Rce
	27dzC6Q8uy2o0rk1XnLiu8B9JcX6U1Ov1m8+xxiyzXzrymmnj07o+qww677b/v9PJ+vtMZI+
	ubFGfIrBrAPW4jxzb+9r3fOydDPnr8kTNHRtyy3i32uwFRX3nOrxe3ilXPHRjYdKLMUZiYZa
	zEXFiQCaQCYYEgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176884>

IPv6 hosts are often unreachable on the primarily IPv4 Internet and
therefore we shouldn't print an error if there are still other hosts we
can try to connect() to. This helps "git fetch --quiet" stay quiet.
---
 connect.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 2119c3f..8eb9f44 100644
--- a/connect.c
+++ b/connect.c
@@ -192,6 +192,7 @@ static const char *ai_name(const struct addrinfo *ai)
  */
 static int git_tcp_connect_sock(char *host, int flags)
 {
+       struct strbuf error_message = STRBUF_INIT;
        int sockfd = -1, saved_errno = 0;
        const char *port = STR(DEFAULT_GIT_PORT);
        struct addrinfo hints, *ai0, *ai;
@@ -225,11 +226,8 @@ static int git_tcp_connect_sock(char *host, int flags)
                }
                if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
                        saved_errno = errno;
-                       fprintf(stderr, "%s[%d: %s]: errno=%s\n",
-                               host,
-                               cnt,
-                               ai_name(ai),
-                               strerror(saved_errno));
+                       strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+                               host, cnt, ai_name(ai), strerror(saved_errno));
                        close(sockfd);
                        sockfd = -1;
                        continue;
@@ -242,11 +240,13 @@ static int git_tcp_connect_sock(char *host, int flags)
        freeaddrinfo(ai0);

        if (sockfd < 0)
-               die("unable to connect a socket (%s)", strerror(saved_errno));
+               die("unable to connect to %s:\n%s", host, error_message.buf);

        if (flags & CONNECT_VERBOSE)
                fprintf(stderr, "done.\n");

+       strbuf_release(&error_message);
+
        return sockfd;
 }

-- 
1.7.6.135.g8cdba
