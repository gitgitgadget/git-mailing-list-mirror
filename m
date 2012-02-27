From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] Factor out and export large blob writing code to
 arbitrary file handle
Date: Mon, 27 Feb 2012 13:50:10 -0800
Message-ID: <7vaa4454kt.fsf@alter.siamese.dyndns.org>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330329315-11407-3-git-send-email-pclouds@gmail.com>
 <7v4nucb2xl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28Sc-0006nE-63
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab2B0VuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:50:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46127 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847Ab2B0VuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:50:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7EB97545;
	Mon, 27 Feb 2012 16:50:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CrU58nyQm2guRJgHtL2C0oozjEM=; b=RTgjuG
	lVzcHuzLrKD6EyFQCzbxcc9+FNwMSHobOSJbytQt1oq/JM6YBvc57n5bGgw4XMqM
	yDi2kSgjQ5E79xxymbzwKeJicpC4v4M/Xi831nhuzn0R/vAUBJRXPOiWDHxnq8e0
	gPMp8RzrH99E7yOyxCDmbIKt8PaX8HrJ3c4zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9K0vPk+Q5KEZMdgAWA/iXwy+iBLdJb4
	mnF/BN4+YKUXGqN1IsixYoDUHsQYSsOiATpKFPWKMO5zg+vBfQbu01YM3YAma4ij
	SrI+59CXzzT41BCYgqpt+/tO4+/Cjh+XnramBh+Vmx6x9IDE4Cda5qcFY0ZDtlE8
	GlHWPJ2SKQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E7BC7544;
	Mon, 27 Feb 2012 16:50:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C50A47541; Mon, 27 Feb 2012
 16:50:11 -0500 (EST)
In-Reply-To: <7v4nucb2xl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 27 Feb 2012 09:29:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 061579C6-618D-11E1-96D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191679>

Junio C Hamano <gitster@pobox.com> writes:

> So I think the external declaration and the definition should move to a
> more generic place, namely streaming.[ch].  It does not belong to entry.c
> anymore.
>
> Thanks for working on this.

In other words, I think the result should look more like this.

The original logic in entry.c is that the caller should try to get a
filter and call streaming_write_entry(), but either of them is allowed to
return a failure when the blob is not suitable for the streaming codepath
to tell the caller to try their traditional codepath.

We might want to add another helper function for callers to use to decide
if they should use the streaming interface, or the traditional one, before
actually making a call to streaming_write_entry().  With the original (and
current) API, they have to retry even when the streaming codepath truly
failed (e.g. no such blob object), in which case it is very likely that
the traditional codepath in the caller will fail the same way. Retrying is
a wasted effort in such a case.

-- >8 --
Subject: [PATCH] streaming: make streaming-write-entry to be more reusable

The static function in entry.c takes a cache entry and streams its blob
contents to a file in the working tree.  Refactor the logic to a new API
function stream_blob_to_fd() that takes an object name and an open file
descriptor, so that it can be reused by other callers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 entry.c     |   53 +++++------------------------------------------------
 streaming.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 streaming.h |    2 ++
 3 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/entry.c b/entry.c
index 852fea1..17a6bcc 100644
--- a/entry.c
+++ b/entry.c
@@ -120,58 +120,15 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 				 const struct checkout *state, int to_tempfile,
 				 int *fstat_done, struct stat *statbuf)
 {
-	struct git_istream *st;
-	enum object_type type;
-	unsigned long sz;
 	int result = -1;
-	ssize_t kept = 0;
-	int fd = -1;
-
-	st = open_istream(ce->sha1, &type, &sz, filter);
-	if (!st)
-		return -1;
-	if (type != OBJ_BLOB)
-		goto close_and_exit;
+	int fd;
 
 	fd = open_output_fd(path, ce, to_tempfile);
-	if (fd < 0)
-		goto close_and_exit;
-
-	for (;;) {
-		char buf[1024 * 16];
-		ssize_t wrote, holeto;
-		ssize_t readlen = read_istream(st, buf, sizeof(buf));
-
-		if (!readlen)
-			break;
-		if (sizeof(buf) == readlen) {
-			for (holeto = 0; holeto < readlen; holeto++)
-				if (buf[holeto])
-					break;
-			if (readlen == holeto) {
-				kept += holeto;
-				continue;
-			}
-		}
-
-		if (kept && lseek(fd, kept, SEEK_CUR) == (off_t) -1)
-			goto close_and_exit;
-		else
-			kept = 0;
-		wrote = write_in_full(fd, buf, readlen);
-
-		if (wrote != readlen)
-			goto close_and_exit;
-	}
-	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
-		     write(fd, "", 1) != 1))
-		goto close_and_exit;
-	*fstat_done = fstat_output(fd, state, statbuf);
-
-close_and_exit:
-	close_istream(st);
-	if (0 <= fd)
+	if (0 <= fd) {
+		result = stream_blob_to_fd(fd, ce->sha1, filter, 1);
+		*fstat_done = fstat_output(fd, state, statbuf);
 		result = close(fd);
+	}
 	if (result && 0 <= fd)
 		unlink(path);
 	return result;
diff --git a/streaming.c b/streaming.c
index 71072e1..7e7ee2b 100644
--- a/streaming.c
+++ b/streaming.c
@@ -489,3 +489,58 @@ static open_method_decl(incore)
 
 	return st->u.incore.buf ? 0 : -1;
 }
+
+
+/****************************************************************
+ * Users of streaming interface
+ ****************************************************************/
+
+int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *filter,
+		      int can_seek)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+	ssize_t kept = 0;
+	int result = -1;
+
+	st = open_istream(sha1, &type, &sz, filter);
+	if (!st)
+		return result;
+	if (type != OBJ_BLOB)
+		goto close_and_exit;
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t wrote, holeto;
+		ssize_t readlen = read_istream(st, buf, sizeof(buf));
+
+		if (!readlen)
+			break;
+		if (can_seek && sizeof(buf) == readlen) {
+			for (holeto = 0; holeto < readlen; holeto++)
+				if (buf[holeto])
+					break;
+			if (readlen == holeto) {
+				kept += holeto;
+				continue;
+			}
+		}
+
+		if (kept && lseek(fd, kept, SEEK_CUR) == (off_t) -1)
+			goto close_and_exit;
+		else
+			kept = 0;
+		wrote = write_in_full(fd, buf, readlen);
+
+		if (wrote != readlen)
+			goto close_and_exit;
+	}
+	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
+		     write(fd, "", 1) != 1))
+		goto close_and_exit;
+	result = 0;
+
+ close_and_exit:
+	close_istream(st);
+	return result;
+}
diff --git a/streaming.h b/streaming.h
index 589e857..3e82770 100644
--- a/streaming.h
+++ b/streaming.h
@@ -12,4 +12,6 @@ extern struct git_istream *open_istream(const unsigned char *, enum object_type
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, char *, size_t);
 
+extern int stream_blob_to_fd(int fd, const unsigned char *, struct stream_filter *, int can_seek);
+
 #endif /* STREAMING_H */
-- 
1.7.9.2.312.g1abc3
