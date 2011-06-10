From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/6] zlib: allow feeding more than 4GB in one go
Date: Fri, 10 Jun 2011 16:47:55 -0700
Message-ID: <7vei31uu38.fsf@alter.siamese.dyndns.org>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 01:49:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVBRm-0006r4-Js
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 01:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282Ab1FJXsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 19:48:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758284Ab1FJXsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 19:48:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3985C5B68;
	Fri, 10 Jun 2011 19:50:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HSOFdYGZCYXiWGduap7YRrEdvTk=; b=QB6NjF
	bNocGQ/3qCTUH8v6Dmm7j1XwoP/pNhsLJ66WL7w92GZ4bBzC+9wQXnmmL5UNw/5m
	XGGLbIJ1BOMFxGBojoKETNf4bqAOuRxJX8B3nY4JDz3NrJBMjC0mg9vDpct/q5KF
	bMhrvQkpI1No+9FDoFnQXFPh3YKJEBj7cf4T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w38mIsoRzEir3kMqb2esNc/q2JnBDIUc
	DET6BX5JQxQI6n1dhhlLVWNeFBiBOomIr4en7YOnbfdE0S6pA1Eb2YVsI6+nYPp1
	aMS6kKsbMPmuuwoVE9R9KehcKozl9ivrjhTMYlm9Xjl/8qCyBaUS0ZFHw5Jno98g
	AdG1mQ4uLGc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 270975B64;
	Fri, 10 Jun 2011 19:50:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B6DD5B62; Fri, 10 Jun 2011
 19:50:14 -0400 (EDT)
In-Reply-To: <1307736948-16956-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Fri, 10 Jun 2011 13:15:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6483048C-93BC-11E0-8553-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175635>

Junio C Hamano <gitster@pobox.com> writes:

> The next step would be to tweak zlib_post_call(), git_inflate() and
> git_deflate() functions to internally loop and call underlying inflate()
> and deflate() when the incoming buffers are larger than 4GB, but that
> part is not done in this series (yet).

And this is such a patch.

I had a draft of this one ready when I sent the previous 6-patch series,
but it took embarrassingly long time for me to figure out what went wrong
in this patch before I realized that Z_FINISH should not be relayed to the
underlying inflate/deflate if we are splitting the request into multiple
phases.

I consider it still rough, but with this on top of v1.7.5.4, together with
the previous 6 patches, it seems to pass a trivial "have a large blob,
add, commit, pack, verify, index-pack, fsck" tests, without using either
of the recent "let's pass large blob to fast-import" (in 'master') nor
"let's stream a blob out without expanding it in core first" (in 'next')
changes.

-- test script to be stored in /var/tmp/junk or somewhere --
#!/bin/sh

set -x

rm -fr .git && git init || exit

echo | dd bs=1M seek=4800 of=a.big
sleep 2
git add a.big

eval $(git ls-files -s a.big |
    sed -e 's/^[0-7]* \([0-9a-f][0-9a-f]\)\([0-9a-f]*\) .*/h=\1 a=\2/')
echo $h $a

ls -l .git/objects/$h/$a || exit

git commit -m initial || exit

git fsck || exit

git repack -a -d || exit

git fsck || exit

f=$(find .git/objects/?? -type f)
test -z "$f" || exit

p=$(find .git/objects/pack -type f -name '*.pack') &&
i=${p%.pack}.idx &&

test -f $p &&
test -f $i || exit

mv $p $i . &&
pp=$(basename $p) &&
ii=$(basename $i) &&
test -f $pp &&
test -f $ii || exit

git verify-pack $pp || exit

git unpack-objects <$pp || exit

ls -l .git/objects/$h/$a || exit

rm -fr .git/objects/?? || exit

git index-pack --stdin <$pp || exit
test -f "$i" || exit
cmp $i $ii || exit

git cat-file blob "$h$a" >b.big || exit
cmp a.big b.big

echo all done.
exit 0
-- test script ends here --

-- >8 --
Update zlib_post_call() that adjusts the wrapper's notion of avail_in and
avail_out to what came back from zlib, so that the callers can feed
buffers larger than than 4GB to the API.

When underlying inflate/deflate stopped processing because we fed a buffer
larger than 4GB limit, detect that case, update the state variables, and
let the zlib function work another round.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 zlib.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/zlib.c b/zlib.c
index fe537e3..3c63d48 100644
--- a/zlib.c
+++ b/zlib.c
@@ -27,12 +27,11 @@ static const char *zerr_to_string(int status)
  * limits the size of the buffer we can use to 4GB when interacting
  * with zlib in a single call to inflate/deflate.
  */
-#define ZLIB_BUF_MAX ((uInt)-1)
+/* #define ZLIB_BUF_MAX ((uInt)-1) */
+#define ZLIB_BUF_MAX ((uInt) 1024 * 1024 * 1024) /* 1GB */
 static inline uInt zlib_buf_cap(unsigned long len)
 {
-	if (ZLIB_BUF_MAX < len)
-		die("working buffer for zlib too large");
-	return len;
+	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
 }
 
 static void zlib_pre_call(git_zstream *s)
@@ -47,12 +46,22 @@ static void zlib_pre_call(git_zstream *s)
 
 static void zlib_post_call(git_zstream *s)
 {
+	unsigned long bytes_consumed;
+	unsigned long bytes_produced;
+
+	bytes_consumed = s->z.next_in - s->next_in;
+	bytes_produced = s->z.next_out - s->next_out;
+	if (s->z.total_out != s->total_out + bytes_produced)
+		die("BUG: total_out mismatch");
+	if (s->z.total_in != s->total_in + bytes_consumed)
+		die("BUG: total_in mismatch");
+
+	s->total_out = s->z.total_out;
+	s->total_in = s->z.total_in;
 	s->next_in = s->z.next_in;
 	s->next_out = s->z.next_out;
-	s->total_in = s->z.total_in;
-	s->total_out = s->z.total_out;
-	s->avail_in = s->z.avail_in;
-	s->avail_out = s->z.avail_out;
+	s->avail_in -= bytes_consumed;
+	s->avail_out -= bytes_produced;
 }
 
 void git_inflate_init(git_zstream *strm)
@@ -103,18 +112,32 @@ int git_inflate(git_zstream *strm, int flush)
 {
 	int status;
 
-	zlib_pre_call(strm);
-	status = inflate(&strm->z, flush);
-	zlib_post_call(strm);
+	for (;;) {
+		zlib_pre_call(strm);
+		/* Never say Z_FINISH unless we are feeding everything */
+		status = inflate(&strm->z,
+				 (strm->z.avail_in != strm->avail_in)
+				 ? 0 : flush);
+		if (status == Z_MEM_ERROR)
+			die("inflate: out of memory");
+		zlib_post_call(strm);
+
+		/*
+		 * Let zlib work another round, while we can still
+		 * make progress.
+		 */
+		if ((strm->avail_out && !strm->z.avail_out) &&
+		    (status == Z_OK || status == Z_BUF_ERROR))
+			continue;
+		break;
+	}
+
 	switch (status) {
 	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
 	case Z_BUF_ERROR:
 	case Z_OK:
 	case Z_STREAM_END:
 		return status;
-
-	case Z_MEM_ERROR:
-		die("inflate: out of memory");
 	default:
 		break;
 	}
@@ -192,18 +215,33 @@ int git_deflate(git_zstream *strm, int flush)
 {
 	int status;
 
-	zlib_pre_call(strm);
-	status = deflate(&strm->z, flush);
-	zlib_post_call(strm);
+	for (;;) {
+		zlib_pre_call(strm);
+
+		/* Never say Z_FINISH unless we are feeding everything */
+		status = deflate(&strm->z,
+				 (strm->z.avail_in != strm->avail_in)
+				 ? 0 : flush);
+		if (status == Z_MEM_ERROR)
+			die("deflate: out of memory");
+		zlib_post_call(strm);
+
+		/*
+		 * Let zlib work another round, while we can still
+		 * make progress.
+		 */
+		if ((strm->avail_out && !strm->z.avail_out) &&
+		    (status == Z_OK || status == Z_BUF_ERROR))
+			continue;
+		break;
+	}
+
 	switch (status) {
 	/* Z_BUF_ERROR: normal, needs more space in the output buffer */
 	case Z_BUF_ERROR:
 	case Z_OK:
 	case Z_STREAM_END:
 		return status;
-
-	case Z_MEM_ERROR:
-		die("deflate: out of memory");
 	default:
 		break;
 	}
-- 
1.7.6.rc1.118.ge175b4a
