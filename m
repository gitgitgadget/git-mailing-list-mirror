From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 06/17] refs.c: add new function copy_reflog_into_strbuf
Date: Mon,  3 Nov 2014 11:02:08 -0800
Message-ID: <1415041339-18450-7-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMuG-0001m8-5j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbaKCTCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:50 -0500
Received: from mail-qg0-f73.google.com ([209.85.192.73]:56839 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbaKCTCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:25 -0500
Received: by mail-qg0-f73.google.com with SMTP id z107so763806qgd.4
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MQ2JVIlG6/EP/FuK5AV7yr18kc/16/TTy+P6hLnAAlQ=;
        b=Y/7qcHSsceeqzygihYfvvD3f4EPoXd4r4brjKYRuJy//EPgV5xMFmoFoH+bTt3e/I1
         kIs/FnACNxF5j1nGnO1qSB5q7HeMUXcmT/yGe0GSlCa4kmdOJD5NhUM4JFB2Aq9i5Gd6
         nErc/j2yS+Yyyw988kRJL12qMft21E+MruaIpfuwdx6V9VK01g0xJhVYYQbnN+E1bALS
         qJdbWvibQwLz7nIbs014rxa/r99bMBprr3Pu3M64QkPZKz6coVzULG+rs6Lx0VAyqVg6
         E4TPYXDKuE1RtlfC2KKnxfMjZnboppzmWztykqdRTjg6YD92RHg2t9QJVsR3o9JS/CYG
         wJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MQ2JVIlG6/EP/FuK5AV7yr18kc/16/TTy+P6hLnAAlQ=;
        b=RweJf2RMMf07rvqJ49Y4QMwMw6D5pzyIBMcSG29SR/RrmjdAbFONC+XjaKUHvAoxB2
         5zvZKl8Cyw5H27ZX0BDS7+OtFAey8MZyk4vXUM4s7RMDTxiL9DgSrhTnrk6gAPvHQ2aW
         gyBXMSTtbGArvtEaRxTHgu8b0YRj9bv0/tYecHqEazptTwUyxruLIPG4RVuAXwvPykeD
         sL0NXNY/ozQ+luyCjzfo11vvZktx4MXq8AMquZHpzgLs3KnXwcA5KBcmXz0almNtUP5D
         4AlB/wCvXbo7jbv5unv6Smo0bWH+7owF2lZh6hGtlIh43Viq0wqp+pBgEfdyCtAs//dC
         zhgQ==
X-Gm-Message-State: ALoCoQnYyrZiKd7qNP6fCL15qHorf8jl4TFY1MUXg9ahY3cti0mHNvGKVsT22mZkinl1bhetdTiX
X-Received: by 10.236.206.113 with SMTP id k77mr134771yho.56.1415041344097;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si973998yho.5.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 8XdCBcWq.1; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CCBFDE0F5D; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new function copy_reflog_into_strbuf() that is a backend specific
optimized way to read the whole reflog as is into a strbuf so we can
copy it elsewhere instead of having to iterate over all the entries using
the iterators.

For the current type of refs backend that use files we simple read_in_full
the whole file into a strbuf. When we add other types of backends for refs
we will need to implement similarly optimized versions of this functions for
them.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/refs.c b/refs.c
index 3d13624..1c968f5 100644
--- a/refs.c
+++ b/refs.c
@@ -2826,6 +2826,37 @@ static int rename_ref_available(const char *oldname, const char *newname)
 static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
 			  const char *logmsg);
 
+/*
+ * This is an optimized function to read the whole reflog as a blob
+ * into a strbuf. It is used during ref_rename so that we can use an
+ * efficient method to read the whole log and later write it back to a
+ * different file.
+ */
+static int copy_reflog_into_strbuf(const char *refname, struct strbuf *buf)
+{
+	struct stat st;
+	int fd;
+
+	if (lstat(git_path("logs/%s", refname), &st) == -1)
+		return 1;
+	if ((fd = open(git_path("logs/%s", refname), O_RDONLY)) == -1) {
+		error("failed to open reflog %s, %s",
+		      refname, strerror(errno));
+		return 1;
+	}
+	strbuf_init(buf, st.st_size);
+	strbuf_setlen(buf, st.st_size);
+	if (read_in_full(fd, buf->buf, st.st_size) != st.st_size) {
+		close(fd);
+		error("failed to read reflog %s, %s",
+		      refname, strerror(errno));
+		return 1;
+	}
+	close(fd);
+
+	return 0;
+}
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
-- 
2.1.0.rc2.206.gedb03e5
