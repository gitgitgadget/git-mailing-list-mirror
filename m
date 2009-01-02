From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-apply: prevent non-explicit permission
 changes
Date: Fri, 02 Jan 2009 02:55:37 -0800
Message-ID: <7vwsdec6za.fsf@gitster.siamese.dyndns.org>
References: <20081230235357.GA12747@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 11:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIhiC-0006gw-W8
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 11:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183AbZABKzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 05:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757182AbZABKzq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 05:55:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123AbZABKzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 05:55:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E50298CBB6;
	Fri,  2 Jan 2009 05:55:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BCAF88CBB4; Fri,
  2 Jan 2009 05:55:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E689CB64-D8BB-11DD-9238-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104371>

A git patch that does not change the executable bit still records the mode
on its "index" line.  "git apply" used to interpret this mode exactly the
same way as it interprets the mode recorded on "new mode" line.  As the
wish by the patch submitter to set the mode to the one recorded on the
line.

The reason the mode does not agree between the submitter and the receiver
in the first place is because there is _another_ commit that only appears
on one side but not the other since their histories diverged, and that
commit changes the mode.  The patch has "index" line but not "new mode"
line because its change is about updating the contents without affecting
the mode.  The application of such a patch is an explicit wish by the
submitter to only cherry-pick the commit that updates the contents without
cherry-picking the commit that modifies the mode.  Viewed this way, the
current behaviour is problematic, even though the command does warn when
the mode of the path being patched does not match this mode, and a careful
user could detect this inconsistencies between the patch submitter and the
patch receiver.

This changes the semantics of the mode recorded on the "index" line;
instead of interpreting it as the submitter's wish to set the mode to the
recorded value, it merely informs what the mode submitter happened to
have, and the presense of the "index" line is taken as submitter's wish to
keep whatever the mode is on the receiving end.

This is based on the patch originally done by Alexander Potashev with a
minor fix; the tests are mine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Alexander Potashev <aspotashev@gmail.com> writes:

> Prevent 'git apply' from changing permissions without
> 'old mode'/'new mode' lines in patch.
> (WARNING: this changes the behaviour of 'git apply')
> ...
> Test cases are probably wanted, but I don't really know how to do them
> and I'll only give a chain of commands to reproduce the issue:

So here is what I sent earlier but with test cases.  I suspect your
version does not pass the latter half of the test suite, because it stomps
on the explicitly recorded mode changes in the patch.

 builtin-apply.c           |    4 ++-
 t/t4129-apply-samemode.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletions(-)

diff --git c/builtin-apply.c w/builtin-apply.c
index 07244b0..a8f75ed 100644
--- c/builtin-apply.c
+++ w/builtin-apply.c
@@ -630,7 +630,7 @@ static int gitdiff_index(const char *line, struct patch *patch)
 	memcpy(patch->new_sha1_prefix, line, len);
 	patch->new_sha1_prefix[len] = 0;
 	if (*ptr == ' ')
-		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
+		patch->old_mode = strtoul(ptr+1, NULL, 8);
 	return 0;
 }
 
@@ -2447,6 +2447,8 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (st_mode != patch->old_mode)
 		fprintf(stderr, "warning: %s has type %o, expected %o\n",
 			old_name, st_mode, patch->old_mode);
+	if (!patch->new_mode)
+		patch->new_mode = st_mode;
 	return 0;
 
  is_new:
diff --git c/t/t4129-apply-samemode.sh w/t/t4129-apply-samemode.sh
new file mode 100755
index 0000000..adfcbb5
--- /dev/null
+++ w/t/t4129-apply-samemode.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='applying patch with mode bits'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo original >file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git tag initial &&
+	echo modified >file &&
+	git diff --stat -p >patch-0.txt &&
+	chmod +x file &&
+	git diff --stat -p >patch-1.txt
+'
+
+test_expect_success 'same mode (no index)' '
+	git reset --hard &&
+	chmod +x file &&
+	git apply patch-0.txt &&
+	test -x file
+'
+
+test_expect_success 'same mode (with index)' '
+	git reset --hard &&
+	chmod +x file &&
+	git add file &&
+	git apply --index patch-0.txt &&
+	test -x file &&
+	git diff --exit-code
+'
+
+test_expect_success 'same mode (index only)' '
+	git reset --hard &&
+	chmod +x file &&
+	git add file &&
+	git apply --cached patch-0.txt &&
+	git ls-files -s file | grep "^100755"
+'
+
+test_expect_success 'mode update (no index)' '
+	git reset --hard &&
+	git apply patch-1.txt &&
+	test -x file
+'
+
+test_expect_success 'mode update (with index)' '
+	git reset --hard &&
+	git apply --index patch-1.txt &&
+	test -x file &&
+	git diff --exit-code
+'
+
+test_expect_success 'mode update (index only)' '
+	git reset --hard &&
+	git apply --cached patch-1.txt &&
+	git ls-files -s file | grep "^100755"
+'
+
+test_done
