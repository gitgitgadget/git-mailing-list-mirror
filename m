From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 12/14] Improve the mingw getaddrinfo stub to 
	handle more use cases
Date: Fri, 15 Jan 2010 22:30:31 +0100
Message-ID: <1263591033-4992-13-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	=?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: msysgit@googlegroups.com
X-From: 31d5QSwkOB1A2CA4st0Bwy66y3w4s03.u644AGAy0By66y3wy96C7A.u64@listserv.bounces.google.com Fri Jan 15 22:32:28 2010
Return-path: <31d5QSwkOB1A2CA4st0Bwy66y3w4s03.u644AGAy0By66y3wy96C7A.u64@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtmI-00061S-EO
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 22:32:22 +0100
Received: by mail-yx0-f137.google.com with SMTP id 1sf1972493yxe.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=xGWp4878M+mOHMuA4lLBlsFlbJ+UAdI3DKy8o6RVqnI=;
        b=tW69nhdf7TEnKCcmfxMU/z0s7TfQhOUwmMQK99gwjlXsgaz/kz5YB1jFqpoVmgjRR8
         XOALyeIrxpQEWYY9oC2mSZXu45lNvWhgDKqaTEljPfytb4A+kc+pTO0MmZ6KlcKPdiUb
         W/OUnUQrftpcfjLEx+a/8XhDWE3+bTZjVNvuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references:mime-version
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=UGFMwX9eXjEy5r0GGK0aDGoxEwIquMzb5BMlKyP0NHoJGB4UIZN8/t+j0tA+kw+CY8
         AmQ2eZ7kU6DOzeLVSYnjv/U0bDcYh50QOnUVMy8F1zPO2TUCicqp2GpDG94BYTXBmk++
         qNJKQyeZVFVxhc6t1UITTCg4/N7tb0/ctthLg=
Received: by 10.101.131.28 with SMTP id i28mr225326ann.17.1263591125713;
        Fri, 15 Jan 2010 13:32:05 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.60.1 with SMTP id n1ls305114ebh.3.p; Fri, 15 Jan 2010 
	13:32:03 -0800 (PST)
Received: by 10.213.106.210 with SMTP id y18mr160519ebo.5.1263591123364;
        Fri, 15 Jan 2010 13:32:03 -0800 (PST)
Received: by 10.213.106.210 with SMTP id y18mr160518ebo.5.1263591123225;
        Fri, 15 Jan 2010 13:32:03 -0800 (PST)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
        by gmr-mx.google.com with ESMTP id 18si275397ewy.8.2010.01.15.13.32.02;
        Fri, 15 Jan 2010 13:32:02 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.147 as permitted sender) client-ip=74.125.78.147;
Received: by ey-out-1920.google.com with SMTP id 26so22733eyw.16
        for <msysgit@googlegroups.com>; Fri, 15 Jan 2010 13:32:02 -0800 (PST)
Received: by 10.213.39.203 with SMTP id h11mr238809ebe.0.1263591122083;
        Fri, 15 Jan 2010 13:32:02 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 14sm693609ewy.7.2010.01.15.13.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:32:00 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 74.125.78.147 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/7aada3f545623530
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137131>

From: Martin Storsjö <martin@martin.st>

Allow the node parameter to be null, which is used for getting
the default bind address.

Also allow the hints parameter to be null, to improve standard
conformance of the stub implementation a little.

Signed-off-by: Martin Storsjo <martin@martin.st>
---
 compat/mingw.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 89b9b89..02d411a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -932,19 +932,22 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 				   const struct addrinfo *hints,
 				   struct addrinfo **res)
 {
-	struct hostent *h = gethostbyname(node);
+	struct hostent *h = NULL;
 	struct addrinfo *ai;
 	struct sockaddr_in *sin;
 
-	if (!h)
-		return WSAGetLastError();
+	if (node) {
+		h = gethostbyname(node);
+		if (!h)
+			return WSAGetLastError();
+	}
 
 	ai = xmalloc(sizeof(struct addrinfo));
 	*res = ai;
 	ai->ai_flags = 0;
 	ai->ai_family = AF_INET;
-	ai->ai_socktype = hints->ai_socktype;
-	switch (hints->ai_socktype) {
+	ai->ai_socktype = hints ? hints->ai_socktype : 0;
+	switch (ai->ai_socktype) {
 	case SOCK_STREAM:
 		ai->ai_protocol = IPPROTO_TCP;
 		break;
@@ -956,14 +959,25 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 		break;
 	}
 	ai->ai_addrlen = sizeof(struct sockaddr_in);
-	ai->ai_canonname = strdup(h->h_name);
+	if (hints && (hints->ai_flags & AI_CANONNAME))
+		ai->ai_canonname = h ? strdup(h->h_name) : NULL;
+	else
+		ai->ai_canonname = NULL;
 
 	sin = xmalloc(ai->ai_addrlen);
 	memset(sin, 0, ai->ai_addrlen);
 	sin->sin_family = AF_INET;
+	/* Note: getaddrinfo is supposed to allow service to be a string,
+	 * which should be looked up using getservbyname. This is
+	 * currently not implemented */
 	if (service)
 		sin->sin_port = htons(atoi(service));
-	sin->sin_addr = *(struct in_addr *)h->h_addr;
+	if (h)
+		sin->sin_addr = *(struct in_addr *)h->h_addr;
+	else if (hints && (hints->ai_flags & AI_PASSIVE))
+		sin->sin_addr.s_addr = INADDR_ANY;
+	else
+		sin->sin_addr.s_addr = INADDR_LOOPBACK;
 	ai->ai_addr = (struct sockaddr *)sin;
 	ai->ai_next = 0;
 	return 0;
-- 
1.6.6.211.g26720
