From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/2] lock_packed_refs(): allow retries when acquiring the packed-refs lock
Date: Mon, 11 May 2015 12:35:26 +0200
Message-ID: <1431340526-24288-3-git-send-email-mhagger@alum.mit.edu>
References: <1431340526-24288-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 12:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrlAX-0000xx-W3
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 12:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbbEKKmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 06:42:38 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61540 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752863AbbEKKmh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 06:42:37 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2015 06:42:36 EDT
X-AuditID: 12074411-f79fa6d000006b8a-8b-555085f7bcc4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 75.D1.27530.7F580555; Mon, 11 May 2015 06:35:35 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BAZTPF021833
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 06:35:34 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431340526-24288-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqPu9NSDUYE8Pt0XXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi82b21kc2Dz+vv/A5LFgU6nHw1dd7B7Pevcwely8pOzxeZNcAFsU
	t01SYklZcGZ6nr5dAnfGypVnmAt2y1Z82X2MpYHxo3gXIweHhICJxJILEV2MnECmmMSFe+vZ
	uhi5OIQELjNK7DmxmgnCOc4ksWz5VXaQKjYBXYlFPc1MILaIgJrExLZDLCBFzALrGSWOXZsO
	lhAWiJXoXfMczGYRUJXY+2kzM4jNK+AiMXP6DlaIdXIS54//BItzCrhKvPnXC2YLAdW03FzL
	PoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2MkDAT3ME446TcIUYB
	DkYlHl6DC/6hQqyJZcWVuYcYJTmYlER526oCQoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8HI2
	AuV4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8cS1AjYJFqempFWmZ
	OSUIaSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoHaG8/SDtvcUFiLlAUovUUoy7Hj0uN
	i5mEWPLy81KlxHlXgBQJgBRllObBrYAllVeM4kAfC/O+A6niASYkuEmvgJYwAS1xjANbUpKI
	kJJqYFw8N/2+/Au5ed7+cw5XV+Z1im8TKG+c+LPVL1K/6qjry9vdz3WTXCaty/1xMjipRX7u
	0V1Nonxqd5a0mNxf9rdPOLHcfNXrj0L5ltbSmlNvaJ2fGLNyZ7W+QtIN7ovCjYam 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268769>

Currently, there is only one attempt to acquire any lockfile, and if
the lock is held by another process, the locking attempt fails
immediately.

This is not such a limitation for loose reference files. First, they
don't take long to rewrite. Second, most reference updates have a
known "old" value, so if another process is updating a reference at
the same moment that we are trying to lock it, then probably the
expected "old" value will not longer be valid, and the update will
fail anyway.

But these arguments do not hold for packed-refs:

* The packed-refs file can be large and take significant time to
  rewrite.

* Many references are stored in a single packed-refs file, so it could
  be that the other process was changing a different reference than
  the one that we are interested in.

Therefore, it is much more likely for there to be spurious lock
conflicts in connection to the packed-refs file, resulting in
unnecessary command failures.

So, if the first attempt to lock the packed-refs file fails, continue
retrying for a configurable length of time before giving up. The
default timeout is 1 second.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/config.txt |  6 ++++++
 refs.c                   | 12 +++++++++++-
 t/t3210-pack-refs.sh     | 17 +++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..3c24e10 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -622,6 +622,12 @@ core.commentChar::
 If set to "auto", `git-commit` would select a character that is not
 the beginning character of any line in existing commit messages.
 
+core.packedRefsTimeout::
+	The length of time, in milliseconds, to retry when trying to
+	lock the `packed-refs` file. Value 0 means not to retry at
+	all; -1 means to try indefinitely. Default is 1000 (i.e.,
+	retry for 1 second).
+
 sequence.editor::
 	Text editor used by `git rebase -i` for editing the rebase instruction file.
 	The value is meant to be interpreted by the shell when it is used.
diff --git a/refs.c b/refs.c
index 47e4e53..3f8ac63 100644
--- a/refs.c
+++ b/refs.c
@@ -2413,9 +2413,19 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 /* This should return a meaningful errno on failure */
 int lock_packed_refs(int flags)
 {
+	static int timeout_configured = 0;
+	static int timeout_value = 1000;
+
 	struct packed_ref_cache *packed_ref_cache;
 
-	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), flags) < 0)
+	if (!timeout_configured) {
+		git_config_get_int("core.packedrefstimeout", &timeout_value);
+		timeout_configured = 1;
+	}
+
+	if (hold_lock_file_for_update_timeout(
+			    &packlock, git_path("packed-refs"),
+			    flags, timeout_value) < 0)
 		return -1;
 	/*
 	 * Get the current packed-refs while holding the lock.  If the
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index aa9eb3a..e5e3204 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -187,4 +187,21 @@ test_expect_success 'notice d/f conflict with existing ref' '
 	test_must_fail git branch foo/bar/baz/lots/of/extra/components
 '
 
+test_expect_success 'timeout if packed-refs.lock exists' '
+	LOCK=.git/packed-refs.lock &&
+	>$LOCK &&
+	test_when_finished "rm -f $LOCK" &&
+	test_must_fail git pack-refs --all --prune
+'
+
+test_expect_success 'retry acquiring packed-refs.lock' '
+	LOCK=.git/packed-refs.lock &&
+	>$LOCK &&
+	test_when_finished "wait; rm -f $LOCK" &&
+	{
+		( sleep 1 ; rm -f $LOCK ) &
+	} &&
+	git -c core.packedrefstimeout=3000 pack-refs --all --prune
+'
+
 test_done
-- 
2.1.4
