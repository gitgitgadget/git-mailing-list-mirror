From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds without blocking
Date: Mon, 14 Dec 2015 15:15:29 -0800
Message-ID: <xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-4-git-send-email-sbeller@google.com>
	<CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:15:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cLB-0000av-0D
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbbLNXPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:15:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753635AbbLNXPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:15:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B41D349B0;
	Mon, 14 Dec 2015 18:15:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+7gucW6+Z4L2/OuiqfoQThfWbSw=; b=Tv/8g3
	Emld0TV86koesskKorAsTL+am/EzEcgpIe/92ehRiH0IJkl7+VWvCeJ2SmqW+81v
	UftfMTP5oCDwhg9F6xsWdAtD0zBfsMVV+DkBEJIxtOREHcgLRRe5zHNtRLqps0nr
	81q2akbfK6VjwYi3WTK+kzLYoAAORAA9DXnLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQ7UltlhBbjv9M9IJNAKe2KkDpzfXi8R
	by0a4MkGzLzILiisFAGVuGru5Y0AbB7Cq8YqFg2G32ujAaO5bFZfjyEvi20KAZ/u
	bkS5e1qF4+OozuUGJF4cocyTe8kD/9uOtiqARsBd3hSheL1s9DHVzPseacJFsgcc
	RfPR/a1oLPU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54D0F349AF;
	Mon, 14 Dec 2015 18:15:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2C76349AE;
	Mon, 14 Dec 2015 18:15:30 -0500 (EST)
In-Reply-To: <CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 14 Dec 2015 18:03:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91C771E8-A2B8-11E5-8F36-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282450>

Eric Sunshine <ericsunshine@gmail.com> writes:

> The last sentence is confusing. From the commit message, we learn that
> this function doesn't care about EAGAIN or EWOULDBLOCK, yet the above
> comment seems to imply that it does. What it really ought to be saying
> is that "as a convenience, errno is transformed from EWOULDBLOCK to
> EAGAIN so that the caller only has to check for EAGAIN".

Let's do this for now, then.

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Mon, 14 Dec 2015 11:37:13 -0800
Subject: [PATCH] xread_nonblock: add functionality to read from fds without blocking

Provide a wrapper to read(), similar to xread(), that restarts on
EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
handle polling itself, possibly polling multiple sockets or performing
some other action.

Helped-by: Jacob Keller <jacob.keller@gmail.com>
Helped-by: Jeff King <peff@peff.net>,
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Acked-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |  1 +
 wrapper.c         | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8e39867..87456a3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -723,6 +723,7 @@ extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_
 extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern int xopen(const char *path, int flags, ...);
 extern ssize_t xread(int fd, void *buf, size_t len);
+extern ssize_t xread_nonblock(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
diff --git a/wrapper.c b/wrapper.c
index 1770efa..0b5b03d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -259,6 +259,30 @@ ssize_t xread(int fd, void *buf, size_t len)
 }
 
 /*
+ * xread_nonblock() automatically restarts interrupted operations
+ * (EINTR). xread_nonblock() DOES NOT GUARANTEE that "len" bytes is
+ * read.  For convenience to callers that mark the file descriptor
+ * non-blocking, EWOULDBLOCK is turned into EAGAIN to allow them to
+ * check only for EAGAIN (POSIX.1 allows either to be returned).
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
2.7.0-rc0-109-gb762328
