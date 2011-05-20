From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] wrapper: Introduce xclose to restart close on EINTR
Date: Fri, 20 May 2011 08:30:23 +0000
Message-ID: <1305880223-7542-3-git-send-email-artagnon@gmail.com>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
 <1305880223-7542-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 10:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNL6a-0005pS-AQ
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 10:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934852Ab1ETIac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 04:30:32 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47304 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934846Ab1ETIa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 04:30:28 -0400
Received: by mail-qy0-f181.google.com with SMTP id 14so1988937qyg.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hqoAut7wYOM2s9VgPH87NUbyOuQ2liw/LPoFvdR+bxE=;
        b=YCRruvRGXiGp8o5f4MpDOgyCkI3JHhplvlugQGJwbwLt/sjrwHkBylb28WmIxh1Ij4
         DR306QcNbLzPjOrrMrt8cfSdMySJzcTcx8IcRQmuQcDQe6xSSKhjlOvPBANobaLC9qmu
         jvGJ5+59uTtlK6ishLIhc6dNW8RLn0NP7qgPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tdrevycGEmzbxQwAZi1m9fPGRJUulRg8wZaY8QdlvE1/g1gIpHNS/HZ0tfOKPVcnkD
         QsZu8jldMstdSACm3FcjOFDrkq20kFhzo6WkeQnhEZVe84dXGey3FCl1SiECIcAt2CXA
         Q81d7muCtLM2UKO44G2Uq8CGrw+KKlSLRZRO0=
Received: by 10.229.107.21 with SMTP id z21mr3092165qco.187.1305880228219;
        Fri, 20 May 2011 01:30:28 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id m9sm2128759qcu.15.2011.05.20.01.30.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 01:30:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1305880223-7542-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174052>

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-compat-util.h |    1 +
 wrapper.c         |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 40498b3..6e06ad4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -428,6 +428,7 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
+extern int xclose(int fd);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
diff --git a/wrapper.c b/wrapper.c
index 2829000..717e989 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -141,6 +141,21 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }
 
+/*
+ * xclose() is the same a close(), but it automatically restarts close()
+ * operations with a recoverable error (EINTR).
+ */
+int xclose(int fd)
+{
+	int ret;
+	while (1) {
+		ret = close(fd);
+		if ((ret < 0) && errno == EINTR)
+			continue;
+		return ret;
+	}
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
-- 
1.7.5.GIT
