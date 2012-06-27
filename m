From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 13:39:30 -0700
Message-ID: <7vzk7o7am5.fsf@alter.siamese.dyndns.org>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
 <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
 <7vbok48pfu.fsf@alter.siamese.dyndns.org>
 <7v4npw8pdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 22:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjz1V-00081l-Ra
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab2F0Ujd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:39:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab2F0Ujc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:39:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 315F69485;
	Wed, 27 Jun 2012 16:39:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=66fvjOHKq1h3fgC/ZBznNZ2Ui48=; b=VRVdkh
	IB/4UCQSpnDen/2lznz6u7Uwa4hP0biRrqor1ZAxMafUvmU7OI20D55ISLrgn1YT
	HFWDBAyPJCK1pGTRHNPWj52xLbuTRZ7YsDHAAPpEh6ALjOvQmav+KBbKpisJ8m5Q
	wb13vLbUU36pm4JSnszb10GBgF875V9GScRmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dJxCbrVX2jVTFHrGsaA8Tjo6YIOSUMEz
	K/Z76cuHSleWEFwAJkqCfflsLeTRQ9EPLlWyRROfTKkBcBa+99BLhutM7cVD3RRI
	kl93VmLH0AoV+EPcvkT3/VaLa4hlUiTRddvlnI5ySv7BkG73taam798EPySp+QF2
	lLIxLfNsSnY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27F459484;
	Wed, 27 Jun 2012 16:39:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74F209483; Wed, 27 Jun 2012
 16:39:31 -0400 (EDT)
In-Reply-To: <7v4npw8pdo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Jun 2012 13:35:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32A28064-C098-11E1-ABF4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200745>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> but that code path should be fixed properly (with a use_stdin flag in
>>>> the filespec).
>>>
>>> Yes, just as I said; I am finding more and more issues with the
>>> no-index hack that I have been fixing a bit by bit since I send the
>>> message you responded to.
>>
>> It is not ready yet, but here are a few patches WIP.
>
> And this is the second clean-up

And this is the third one.

-- >8 --
Subject: [PATCH 3/?] diff-index.c: "git diff" has no need to read blob from the standard input

Only "diff --no-index -" does.  Bolting the logic into the low-level
function diff_populate_filespec() was a layering violation from day
one.  Move populate_from_stdin() function out of the generic diff.c
to its only user, diff-index.c.

Also make sure "-" from the command line stays a special token "read
from the standard input", even if we later decide to sanitize the
result from prefix_filename() function in a few obvious ways,
e.g. removing unnecessary "./" prefix, duplicated slashes "//" in
the middle, etc.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c | 33 +++++++++++++++++++++++++++++++--
 diff.c          | 21 +--------------------
 diffcore.h      |  1 +
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index a5c1e3e..9385d53 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -32,6 +32,12 @@ static int read_directory(const char *path, struct string_list *list)
 	return 0;
 }
 
+/*
+ * This should be "(standard input)", but it will probably expose many
+ * more breakages.
+ */
+static const char file_from_standard_input[] = "-";
+
 static int get_mode(const char *path, int *mode)
 {
 	struct stat st;
@@ -42,7 +48,7 @@ static int get_mode(const char *path, int *mode)
 	else if (!strcasecmp(path, "nul"))
 		*mode = 0;
 #endif
-	else if (!strcmp(path, "-"))
+	else if (path == file_from_standard_input)
 		*mode = create_ce_mode(0666);
 	else if (lstat(path, &st))
 		return error("Could not access '%s'", path);
@@ -51,6 +57,23 @@ static int get_mode(const char *path, int *mode)
 	return 0;
 }
 
+static int populate_from_stdin(struct diff_filespec *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t size = 0;
+
+	if (strbuf_read(&buf, 0, 0) < 0)
+		return error("error while reading from stdin %s",
+				     strerror(errno));
+
+	s->should_munmap = 0;
+	s->data = strbuf_detach(&buf, &size);
+	s->size = size;
+	s->should_free = 1;
+	s->nongit_stdin = 1;
+	return 0;
+}
+
 static int queue_diff(struct diff_options *o,
 		      const char *name1, const char *name2)
 {
@@ -143,8 +166,14 @@ static int queue_diff(struct diff_options *o,
 			name2 = "/dev/null";
 		d1 = alloc_filespec(name1);
 		d2 = alloc_filespec(name2);
+
 		fill_filespec(d1, null_sha1, mode1);
+		if (name1 == file_from_standard_input)
+			populate_from_stdin(d1);
+
 		fill_filespec(d2, null_sha1, mode2);
+		if (name2 == file_from_standard_input)
+			populate_from_stdin(d2);
 
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
@@ -240,7 +269,7 @@ void diff_no_index(struct rev_info *revs,
 			 * stdin should be spelled as "-"; if you have
 			 * path that is "-", spell it as "./-".
 			 */
-			p = p;
+			p = file_from_standard_input;
 		else if (prefixlen)
 			p = xstrdup(prefix_filename(prefix, prefixlen, p));
 		paths[i] = p;
diff --git a/diff.c b/diff.c
index 1a594df..0c73c84 100644
--- a/diff.c
+++ b/diff.c
@@ -2619,22 +2619,6 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	return 0;
 }
 
-static int populate_from_stdin(struct diff_filespec *s)
-{
-	struct strbuf buf = STRBUF_INIT;
-	size_t size = 0;
-
-	if (strbuf_read(&buf, 0, 0) < 0)
-		return error("error while reading from stdin %s",
-				     strerror(errno));
-
-	s->should_munmap = 0;
-	s->data = strbuf_detach(&buf, &size);
-	s->size = size;
-	s->should_free = 1;
-	return 0;
-}
-
 static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 {
 	int len;
@@ -2684,9 +2668,6 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		struct stat st;
 		int fd;
 
-		if (!strcmp(s->path, "-"))
-			return populate_from_stdin(s);
-
 		if (lstat(s->path, &st) < 0) {
 			if (errno == ENOENT) {
 			err_empty:
@@ -3048,7 +3029,7 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->sha1_valid) {
 			struct stat st;
-			if (!strcmp(one->path, "-")) {
+			if (one->nongit_stdin) {
 				hashcpy(one->sha1, null_sha1);
 				return;
 			}
diff --git a/diffcore.h b/diffcore.h
index 8f32b82..ef4fe17 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -42,6 +42,7 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
+	unsigned nongit_stdin : 1; /* data is from a nongit source */
 	unsigned dirty_submodule : 2;  /* For submodules: its work tree is dirty */
 #define DIRTY_SUBMODULE_UNTRACKED 1
 #define DIRTY_SUBMODULE_MODIFIED  2
-- 
1.7.11.1.184.g3ee8f69
