From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] allow git-am to run in a subdirectory
Date: Sun, 02 Mar 2008 22:46:31 -0800
Message-ID: <7vlk50joe0.fsf_-_@gitster.siamese.dyndns.org>
References: <20080301062255.GA27538@coredump.intra.peff.net>
 <7vprue6ghc.fsf@gitster.siamese.dyndns.org>
 <20080301081235.GA31855@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:47:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4SE-0003SR-P6
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbYCCGql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYCCGql
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:46:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYCCGqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:46:40 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5CF2F2B5E;
	Mon,  3 Mar 2008 01:46:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 36F922B5C; Mon,  3 Mar 2008 01:46:33 -0500 (EST)
In-Reply-To: <20080301081235.GA31855@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 1 Mar 2008 03:12:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75889>

Jeff King <peff@peff.net> writes:

> The problem is that I need to turn the original "$@" into a new "$@"
> that is correctly prefixed, which requires proper quoting.

Perhaps like this?

---
 git-am.sh            |   19 +++++++++++++
 t/t4150-am-subdir.sh |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a2c6fea..de34636 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -24,6 +24,7 @@ r,resolved      to be used after a patch failure
 skip            skip the current patch"
 
 . git-sh-setup
+prefix=$(git rev-parse --show-prefix)
 set_reflog_action am
 require_work_tree
 cd_to_toplevel
@@ -206,6 +207,24 @@ else
 	# Start afresh.
 	mkdir -p "$dotest" || exit
 
+	if test -n "$prefix" && test $# != 0
+	then
+		first=t
+		for arg
+		do
+			test -n "$first" && {
+				set x
+				first=
+			}
+			case "$arg" in
+			/*)
+				set "$@" "$arg" ;;
+			*)
+				set "$@" "$prefix$arg" ;;
+			esac
+		done
+		shift
+	fi
 	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
 		rm -fr "$dotest"
 		exit 1
diff --git a/t/t4150-am-subdir.sh b/t/t4150-am-subdir.sh
new file mode 100755
index 0000000..929d2cb
--- /dev/null
+++ b/t/t4150-am-subdir.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='git am running from a subdirectory'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo hello >world &&
+	git add world &&
+	test_tick &&
+	git commit -m initial &&
+	git tag initial &&
+	echo goodbye >world &&
+	git add world &&
+	test_tick &&
+	git commit -m second &&
+	git format-patch --stdout HEAD^ >patchfile &&
+	: >expect
+'
+
+test_expect_success 'am regularly from stdin' '
+	git checkout initial &&
+	git am <patchfile &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from file' '
+	git checkout initial &&
+	git am patchfile &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from stdin in subdirectory' '
+	rm -fr subdir &&
+	git checkout initial &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am <../patchfile
+	) &&
+	git diff master>actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from file in subdirectory' '
+	rm -fr subdir &&
+	git checkout initial &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am ../patchfile
+	) &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from file in subdirectory with full path' '
+	rm -fr subdir &&
+	git checkout initial &&
+	P=$(pwd) &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am "$P/patchfile"
+	) &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_done
