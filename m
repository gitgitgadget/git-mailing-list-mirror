From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 09/15] Improve the mingw getaddrinfo stub to handle
 more use cases
Date: Fri, 22 Oct 2010 02:05:38 +0200
Message-ID: <1287705944-5668-9-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com,
	=?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCYq4PmBBoEv0WfhQ@googlegroups.com Fri Oct 22 02:07:13 2010
Return-path: <msysgit+bncCOPdven-DxCYq4PmBBoEv0WfhQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCYq4PmBBoEv0WfhQ@googlegroups.com>)
	id 1P95A8-0004SK-R7
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:12 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf128526wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=AGa45tl2UrB+iH3YIC9cF+TxylosH2/BdjLAuH0g00A=;
        b=JnM/svmllOBE6ANeXWUjVXUjj9idKztOqAB7ArbbtVQ5sK4WAtVJhUKPepNbACYcAy
         TQ8qNN0tsW61FYZ5Gbltf4CsCKpe25Sr/88Xq0M95BA0pFFDHtEbpj35l5E29mh5iRsE
         SZzki6X8jSd5c2Xb0bp1mA1yuSXJ0qTwKUK+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        b=I9YUYQgOXv3EG1TxsTWoYI0odwZ9WBZWTWTiGTi295VVMEymZKcbtjwqShDN+iSkHe
         FIZ2MCsw2SwhEZp0+4PgassNR0AEnoOQA6NCeB9LO4pZllR5YD3WHcW/jTRBEU/PxK9o
         FvA96dUx/Llz/Mv9VjMHI1HQNU38P0UO/VqHM=
Received: by 10.216.237.73 with SMTP id x51mr288756weq.4.1287706008876;
        Thu, 21 Oct 2010 17:06:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.24.73 with SMTP id w49ls268195eew.4.p; Thu, 21 Oct 2010
 17:06:48 -0700 (PDT)
Received: by 10.14.119.72 with SMTP id m48mr151146eeh.22.1287706008092;
        Thu, 21 Oct 2010 17:06:48 -0700 (PDT)
Received: by 10.14.119.72 with SMTP id m48mr151145eeh.22.1287706008053;
        Thu, 21 Oct 2010 17:06:48 -0700 (PDT)
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com [209.85.215.42])
        by gmr-mx.google.com with ESMTP id z6si1423413eeh.6.2010.10.21.17.06.47;
        Thu, 21 Oct 2010 17:06:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.42 as permitted sender) client-ip=209.85.215.42;
Received: by mail-ew0-f42.google.com with SMTP id 2so188231ewy.1
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:47 -0700 (PDT)
Received: by 10.14.37.10 with SMTP id x10mr1463769eea.33.1287706006918;
        Thu, 21 Oct 2010 17:06:46 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm2463962eeh.5.2010.10.21.17.06.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.42 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159600>

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
index 21d1c2c..d88c0d0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1035,19 +1035,22 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
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
@@ -1059,14 +1062,25 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
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
1.7.3.1.199.g72340
