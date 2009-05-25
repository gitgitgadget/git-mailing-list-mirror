From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] imap-send: add support for IPv6
Date: Mon, 25 May 2009 21:13:54 +0200
Message-ID: <4A1AEDF2.7060307@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mike@codeweavers.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 21:14:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fcc-0002di-31
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZEYTN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbZEYTN5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:13:57 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:33288 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbZEYTN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:13:56 -0400
Received: by bwz22 with SMTP id 22so3302074bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=5JQG5k2PtLlGPKqfULpumYu9CKVjUE/evh1F2TkSt7E=;
        b=SqqjPM77qTtN++XFurzAtbHpYFWUZdVf26Zq+QLFwIFI6h+XDJmAFN49pkSPvMUgTx
         4UD5rsjDcukKjiaq3KiIPd2UfYyhpravG5N2PGv9OOGQ1sZyZyAUwS4ZmJkg+f5welNj
         GHj0QQuplul8S+hd5mwSXHdUUryXQplpLJ7Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=cLbBPlwPFF4SoLoS4ODgdGiIAfmmnihXeCrT9GCY+tyjlfJSlarDVSMsvOZHBRFFpD
         lLPxgs0j5e4gVz/YC1zpyeIR2zit3TCwnwf392RHPgKWHRkEEV0/o9Q+TEBLnzLfwJNC
         jqjIUl9eXeaQvXRKuYGXb611CSScnK1ip4x1c=
Received: by 10.103.241.15 with SMTP id t15mr3887324mur.85.1243278836895;
        Mon, 25 May 2009 12:13:56 -0700 (PDT)
Received: from golden.local (p5B01C041.dip.t-dialin.net [91.1.192.65])
        by mx.google.com with ESMTPS id 7sm11502945mup.24.2009.05.25.12.13.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 12:13:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119952>

Add IPv6 support by implementing name resolution with the
protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
code is still available when git is compiled with NO_IPV6.

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
 imap-send.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 8154cb2..861268a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -982,9 +982,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	struct imap_store *ctx;
 	struct imap *imap;
 	char *arg, *rsp;
-	struct hostent *he;
-	struct sockaddr_in addr;
-	int s, a[2], preauth;
+	int s = -1, a[2], preauth;
 	pid_t pid;
 
 	ctx = xcalloc(sizeof(*ctx), 1);
@@ -1021,6 +1019,51 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 
 		imap_info("ok\n");
 	} else {
+#ifndef NO_IPV6
+		struct addrinfo hints, *ai0, *ai;
+		int gai;
+		char portstr[6];
+
+		snprintf(portstr, sizeof(portstr), "%hu", srvc->port);
+
+		memset(&hints, 0, sizeof(hints));
+		hints.ai_socktype = SOCK_STREAM;
+		hints.ai_protocol = IPPROTO_TCP;
+
+		imap_info("Resolving %s... ", srvc->host);
+		gai = getaddrinfo(srvc->host, portstr, &hints, &ai);
+		if (gai) {
+			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
+			goto bail;
+		}
+		imap_info("ok\n");
+
+		for (ai0 = ai; ai; ai = ai->ai_next) {
+			char addr[NI_MAXHOST];
+
+			s = socket(ai->ai_family, ai->ai_socktype,
+				   ai->ai_protocol);
+			if (s < 0)
+				continue;
+
+			getnameinfo(ai->ai_addr, ai->ai_addrlen, addr,
+				    sizeof(addr), NULL, 0, NI_NUMERICHOST);
+			imap_info("Connecting to [%s]:%s... ", addr, portstr);
+
+			if (connect(s, ai->ai_addr, ai->ai_addrlen) < 0) {
+				close(s);
+				s = -1;
+				perror("connect");
+				continue;
+			}
+
+			break;
+		}
+		freeaddrinfo(ai0);
+#else /* NO_IPV6 */
+		struct hostent *he;
+		struct sockaddr_in addr;
+
 		memset(&addr, 0, sizeof(addr));
 		addr.sin_port = htons(srvc->port);
 		addr.sin_family = AF_INET;
@@ -1040,7 +1083,12 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 		imap_info("Connecting to %s:%hu... ", inet_ntoa(addr.sin_addr), ntohs(addr.sin_port));
 		if (connect(s, (struct sockaddr *)&addr, sizeof(addr))) {
 			close(s);
+			s = -1;
 			perror("connect");
+		}
+#endif
+		if (s < 0) {
+			fputs("Error: unable to connect to server.\n", stderr);
 			goto bail;
 		}
 
-- 
1.6.3.1.153.g63801e
