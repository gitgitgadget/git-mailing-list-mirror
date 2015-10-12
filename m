From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 3/8] xread_nonblock: add functionality to read from fds without blocking
Date: Mon, 12 Oct 2015 11:47:16 -0700
Message-ID: <1444675641-14866-4-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:48:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8k-0006ca-9h
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbJLSr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:56 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34704 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbbJLSra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:30 -0400
Received: by padhy16 with SMTP id hy16so160545706pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KZGwxiyoY77tQxUW7ydmHMjvh0HvYqDGDpHM+9QlomI=;
        b=YNZl/sJaeOwlBcA/5oARCUXZXd8NhYDXxIosEbtY2sVF0rYFSIPql4WkaziAH73obV
         TkaEb4GBr+MvWdBLqX3fOB2d6dxyUq+fUWrY+sGCD65dA9ywopsWIHouDsE4upgixrPE
         XgiHfTxC2TaU1TC96MUVOoxKvSLh33LJ0B1byEAjxJLOrj2lmPTI9JW7kdEiHMFpUmv/
         0obHrMz+/iwhFRPAfsBSIUQKeN3BAbWfWxaX/OHwZ9HdaLrJBIgHTHfpUMVaLRzKLg7h
         cInIyl4bMU/ZCtT++1aeATK40vKKWGUfVXm1X+drmkVaM31g0vkYMcAUb2ZvQUu4uT3X
         nrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KZGwxiyoY77tQxUW7ydmHMjvh0HvYqDGDpHM+9QlomI=;
        b=XLtKBh3mloT3B6lnupm0kCG3qamUFQOF3YRN5MIuXw2flXIHcjr0DCU3kdxLUbmeiD
         L6O19dTR3baV81QmAd2ooLNj0hwda3BgBMLM2zuIcWCutnHT8lu7Bb80mrLUP9rBK0go
         2pxyNBIJaO0s3/13wnKIcps9+bL4lcykXU7dPLuWLQDiu6aCnfY7lVH0E3VtVAL6IEM7
         f5Eyv2nk+nYgvXdzZ2W2wBXrfx+a5jNJgF7GELIIITEBBB/18orI4XRj9/P1clDIvx/v
         Bm3b6QyQ//UdMmTUsOW8sWG3EvObkGYrWIDJ/GpQ1FLDlapXjjUE69SutL5J+dW3NVHp
         28EA==
X-Gm-Message-State: ALoCoQmC5Khd2BiO3qU7/XxG2AsYm6bvguSKpdXoe0cURrHO98uRca0z6TuZjTRPLXhaokVwR/+s
X-Received: by 10.68.244.34 with SMTP id xd2mr21597675pbc.0.1444675649899;
        Mon, 12 Oct 2015 11:47:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id or9sm18549409pbb.17.2015.10.12.11.47.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279401>

Provide a wrapper to read(), similar to xread(), that restarts on
EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
handle polling itself, possibly polling multiple sockets or performing
some other action.

Helped-by: Jacob Keller <jacob.keller@gmail.com>
Helped-by: Jeff King <peff@peff.net>,
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 5517928..41a21e1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -217,6 +217,28 @@ ssize_t xread(int fd, void *buf, size_t len)
 }
 
 /*
+ * xread_nonblock() is the same a read(), but it automatically restarts read()
+ * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
+ * "len" bytes is read. EWOULDBLOCK is turned into EAGAIN.
+ */
+ssize_t xread_nonblock(int fd, void *buf, size_t len)
+{
+	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+		len = MAX_IO_SIZE;
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
2.5.0.268.g453a26a
