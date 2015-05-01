From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the packed-refs lock
Date: Fri,  1 May 2015 16:52:57 +0200
Message-ID: <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 16:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCJa-0002qI-ID
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 16:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbbEAOxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 10:53:14 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53319 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817AbbEAOxJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 10:53:09 -0400
X-AuditID: 1207440f-f792a6d000001284-4f-554393549ad1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A3.E4.04740.45393455; Fri,  1 May 2015 10:53:08 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41Er33c011249
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 10:53:07 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqBsy2TnU4NBsU4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ7xqWMlSsF254s/9pewNjPNluhg5OSQETCR+zfjNDGGLSVy4t56ti5GLQ0jgMqPE9E2f
	mSGcE0wSKzp72UGq2AR0JRb1NDOB2CICahIT2w6xgBQxC3QwSlxYvg2sSFggSuL+9etACQ4O
	FgFViR+bFUHCvAIuEl3rZzBCbJOTOH/8J9hmTgFXiYMdn1lBbCGgmpdHN7JMYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMkpPh3MHatlznEKMDBqMTDy3HSKVSI
	NbGsuDL3EKMkB5OSKG9bnXOoEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHepxOAcrwpiZVVqUX5
	MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCd59E4EaBYtS01Mr0jJzShDSTBycIMO5
	pESKU/NSUosSS0sy4kGxEV8MjA6QFA/Q3l0g7bzFBYm5QFGI1lOMuhw/LjUuZhJiycvPS5US
	530AUiQAUpRRmge3ApZAXjGKA30szPsCpIoHmHzgJr0CWsIEtOT8LQeQJSWJCCmpBsYgmUnF
	nL+8f3hcez+HSdtjRcEn7zj9b7sObju9/kT2+UVHV8j6vr8kUKfRy9Z47hBbX8DeS/vE0iW2
	nvKNmXdHm3vJ+jVztk/PPyDOun5mkOEX02XBLcKs2+xSwgsYD5TpX7F3sDc4Mm/G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268138>

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

Notes (discussion):
    At first I wasn't going to make this setting configurable. After all,
    who could object to one second?
    
    But then I realized that making the length of the timeout configurable
    would make it easier to test. Since sleep(1) is only guaranteed to
    have a 1-second resolution, it is helpful to set the timeout longer
    than 1 second in the test. So I made it configurable, and documented
    the setting.
    
    I don't have a strong opinion either way.
    
    By the way, if anybody has a better idea for how to test this, please
    chime up. As written, the two new tests each take about one second to
    run (though they are mostly idle during that time, so they parallelize
    well with other tests).

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
index aa9eb3a..d18b726 100755
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
+	test_when_finished "rm -f $LOCK" &&
+	{
+		( sleep 1 ; rm -f $LOCK ) &
+	} &&
+	git -c core.packedrefstimeout=3000 pack-refs --all --prune
+'
+
 test_done
-- 
2.1.4
