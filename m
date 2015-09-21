From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 03/13] xread_nonblock: add functionality to read from fds nonblockingly
Date: Mon, 21 Sep 2015 15:39:09 -0700
Message-ID: <1442875159-13027-4-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kJ-0006NK-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbbIUWjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:32 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36492 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692AbbIUWj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:28 -0400
Received: by padbj2 with SMTP id bj2so3592038pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uIRdVTpffA4AOPa38kRE3uBC5MI+JKj1uxgadFRdd4g=;
        b=hj3VuryV7Z4QJc+o5VF3gpayjg3hRBxXeg/Q450SdSTsThjtLmYSLJ2v3v5DSXADLG
         brhAcw5iLsWzxjk99h1PeX2Wmq9nPXsV66j7KxWA7H1XaGg+UE4gK9JHFre/JapDHhEf
         xTM81pRqt5l8yytEiNazsy+gssK6SxTnVpQ7hpy+F8yZHFd8OTFPsh/EyDb5LX9xWVda
         e3Vv0n44CtOUxKAu5EigyM0PX8BihBk9inJW4a+uDpEujZgrg1ojbA2EUw8L4oDu2iv8
         9mHeQFsSuS1aVvfsKCvi06tsHXbllj8yVzZhh+qamzHyHA5ADyWP6A3d/T5EgZstsVrk
         PJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uIRdVTpffA4AOPa38kRE3uBC5MI+JKj1uxgadFRdd4g=;
        b=EahFXZFrq8Huk8aNRt3s2+hXRepdyR9huFXuWDhADFrm/x5PGvoXgZPYGURJDk6o3U
         WUrjbe8B9bjrHA2f9z4RbfOUAAQmAkR7f8nHiNvkWNMXd5crchEcR5rRvSc4lpfdX4n4
         iFF6Yg2sFtgE32ncmy/ulA686/JoIeUnKDPub/KU0Y5aAriJS3qd5lvKGxuZHdoMvQHH
         l+w/6NNvWOLLJnCwqjXFMq2N1iSHFrIMnHfWFhruqTBvMRXG5c66cGgidvddayvx+z6E
         TdvIuzmMRzRifhgT2hFGeBovas6WXnfPUPjhy5fPDDGsdQcgA+Dj36B3XDEjiKKSVrF+
         7ncw==
X-Gm-Message-State: ALoCoQmI/0dnLBTHADRPN9V12Kesz9PnexGwRmDLhFeYg+8Qas+bpUEb+W9JZWQrh1u54m5xTlPP
X-Received: by 10.68.180.131 with SMTP id do3mr27572425pbc.133.1442875167379;
        Mon, 21 Sep 2015 15:39:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id ku8sm26619879pab.0.2015.09.21.15.39.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278337>

This wrapper just restarts on EINTR, but not on EAGAIN like xread
does. This gives less guarantees on the actual reading rather than
on returning fast.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index c6d391f..9ccea85 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -718,6 +718,7 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
+extern ssize_t xread_nonblock(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
diff --git a/wrapper.c b/wrapper.c
index 50267a4..54ce231 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -223,6 +223,28 @@ ssize_t xread(int fd, void *buf, size_t len)
 }
 
 /*
+ * xread_nonblock() is the same a read(), but it automatically restarts read()
+ * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
+ * "len" bytes is read even if the data is available.
+ */
+ssize_t xread_nonblock(int fd, void *buf, size_t len)
+{
+	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+	    len = MAX_IO_SIZE;
+	while (1) {
+		nr = read(fd, buf, len);
+		if (nr < 0) {
+			if (errno == EINTR)
+				continue;
+			if (errno == EWOULDBLOCK)
+				errno = EAGAIN;
+		}
+		return nr;
+	}
+}
+
+/*
  * xwrite() is the same a write(), but it automatically restarts write()
  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
  * GUARANTEE that "len" bytes is written even if the operation is successful.
-- 
2.5.0.275.ge015d2a
