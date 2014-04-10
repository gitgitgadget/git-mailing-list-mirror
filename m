From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/2] Add xpread()
Date: Thu, 10 Apr 2014 12:20:59 -0700
Message-ID: <xmqqtxa1vvms.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397156052-1247-1-git-send-email-yiannis.marangos@gmail.com>
	<5346ED16.3050607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKX8-0002wW-DU
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758673AbaDJTVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:21:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbaDJTVC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:21:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC2B7A518;
	Thu, 10 Apr 2014 15:21:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gr6KKKvpOQEBviKjggNzTCm65TA=; b=flLNIO
	bPnDWic1hpYL0VIIzDDXNXj25xfTEZLbZjxniu0VQU3xXhpOnY8QtLs0ahzDqf6h
	HSBzQ8KGzjMMGxqyjH4bmdrDov2w0MUL/M2O+XJGGlSfuqjcnThoO5wwyzVDQxKz
	aiaRIoKIO7Cj1kAwM8df9YSNr/98tt3nUpO3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5XcZ4/GrBCTIpKnMLVcBPlvsDqG8XYa
	zKZUZd9ai0jc20aIMKnZ8oOtR6sWU4RaYoqP1yDUtE6aZwJSq2QIE18TXcWV1Mw5
	GYtV53PyjC5XDk4QfbAWqHDxym5dLAcQyNDFk8oiuB7jP0QiDuI7Ew+XLa0i7y9g
	PHyFkHx1M0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E66DF7A517;
	Thu, 10 Apr 2014 15:21:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2EAB7A514;
	Thu, 10 Apr 2014 15:21:00 -0400 (EDT)
In-Reply-To: <5346ED16.3050607@kdbg.org> (Johannes Sixt's message of "Thu, 10
	Apr 2014 21:12:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 402E7A4A-C0E5-11E3-9F80-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246048>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 10.04.2014 20:54, schrieb Yiannis Marangos:
>> +ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
>> +{
>> +	ssize_t nr;
>> +	if (len > MAX_IO_SIZE)
>> +	    len = MAX_IO_SIZE;
>
> Odd indentation here.
>
> -- Hannes

Good eyes, even though this is copy&pasting an existing error from
surrounding code ;-)

I'll queue this instead (rebased on top of maint-1.8.5 even though I
doubt we would be issuing 1.8.5.6).

-- >8 --
From: Yiannis Marangos <yiannis.marangos@gmail.com>
Date: Thu, 10 Apr 2014 21:54:12 +0300
Subject: [PATCH] wrapper.c: add xpread() similar to xread()

It is a common mistake to call read(2)/pread(2) and forget to
anticipate that they may return error with EAGAIN/EINTR when the
system call is interrupted.

We have xread() helper to relieve callers of read(2) from having to
worry about it; add xpread() helper to do the same for pread(2).

Update the caller in the builtin/index-pack.c and the mmap emulation
in compat/.

Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c |  2 +-
 compat/mmap.c        |  4 +---
 git-compat-util.h    |  1 +
 wrapper.c            | 18 ++++++++++++++++++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9e9eb4b..e7a6b53 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -542,7 +542,7 @@ static void *unpack_data(struct object_entry *obj,
 
 	do {
 		ssize_t n = (len < 64*1024) ? len : 64*1024;
-		n = pread(pack_fd, inbuf, n, from);
+		n = xpread(pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno(_("cannot pread pack file"));
 		if (!n)
diff --git a/compat/mmap.c b/compat/mmap.c
index c9d46d1..7f662fe 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -14,7 +14,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	}
 
 	while (n < length) {
-		ssize_t count = pread(fd, (char *)start + n, length - n, offset + n);
+		ssize_t count = xpread(fd, (char *)start + n, length - n, offset + n);
 
 		if (count == 0) {
 			memset((char *)start+n, 0, length-n);
@@ -22,8 +22,6 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 		}
 
 		if (count < 0) {
-			if (errno == EAGAIN || errno == EINTR)
-				continue;
 			free(start);
 			errno = EACCES;
 			return MAP_FAILED;
diff --git a/git-compat-util.h b/git-compat-util.h
index 7776f12..9eec5fb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -534,6 +534,7 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
+extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..5b3c7fc 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -174,6 +174,24 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 	}
 }
 
+/*
+ * xpread() is the same as pread(), but it automatically restarts pread()
+ * operations with a recoverable error (EAGAIN and EINTR). xpread() DOES
+ * NOT GUARANTEE that "len" bytes is read even if the data is available.
+ */
+ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
+{
+	ssize_t nr;
+	if (len > MAX_IO_SIZE)
+		len = MAX_IO_SIZE;
+	while (1) {
+		nr = pread(fd, buf, len, offset);
+		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
+			continue;
+		return nr;
+	}
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
-- 
1.9.2-590-g468068b
