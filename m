From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9902: protect test from stray build artifacts
Date: Thu, 24 Jan 2013 15:07:42 -0800
Message-ID: <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 00:08:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyVtw-00036f-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 00:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268Ab3AXXHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 18:07:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755899Ab3AXXHp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 18:07:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E56E6C066;
	Thu, 24 Jan 2013 18:07:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9I7deZAu6UWVE+/Pc8YpZIWsNuk=; b=i4JMgk
	lWxB37phPrX9usb8V1+1n5TXZJ7SdSIEX/jzaF+vfkmScYAjivRx2NEtJDFYCIo6
	M5Tqezd7tjq7TWRI9YD7KfON6rZEEl2/uTLuX2gSDmxYFuIH3lumOdK91BTD16HM
	0l9vajTmqEryEmpoPsoGMuzYPSyaoqGnzje2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Udz1yhgs3i34BH65Bqp8ihfehKkavif/
	Z0aEiVzqH9U04u52WEXFzwcPGT6v3n0O28mQ2xsLrQpRQG10Z9xghScbh2BInbkN
	mxK9kn+kEBzZyUkP2C8spw2dA5WX92wONzY6KKIiEt70GhPtNAVIvXSbkNDy5/41
	Efvyjm6FAwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9371C065;
	Thu, 24 Jan 2013 18:07:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14E7DC061; Thu, 24 Jan 2013
 18:07:43 -0500 (EST)
In-Reply-To: <20130122003954.GA23297@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 Jan 2013 19:39:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC336AAC-667A-11E2-A85B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214469>

When you have random build artifacts in your build directory, left
behind by running "make" while on another branch, the "git help -a"
command run by __git_list_all_commands in the completion script that
is being tested does not have a way to know that they are not part
of the subcommands this build will ship.  Such extra subcommands may
come from the user's $PATH.  They will interfere with the tests that
expect a certain prefix to uniquely expand to a known completion.

Instrument the completion script and give it a way for us to tell
what (subset of) subcommands we are going to ship.

Also add a test to "git --help <prefix><TAB>" expansion.  It needs
to show not just commands but some selected documentation pages.

Based on an idea by Jeff King.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 11 ++++++++++-
 t/t9902-completion.sh                  | 25 ++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..6139b50 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -531,10 +531,19 @@ __git_complete_strategy ()
 	return 1
 }
 
+__git_commands () {
+	if test -n "${GIT_TESTING_COMMAND_COMPLETION:-}"
+	then
+		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
+	else
+		git help -a|egrep '^  [a-zA-Z0-9]'
+	fi
+}
+
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	for i in $(__git_commands)
 	do
 		case $i in
 		*--*)             : helper pattern;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..adc1372 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -13,6 +13,25 @@ complete ()
 	return 0
 }
 
+# Be careful when updating this list:
+#
+# (1) The build tree may have build artifact from different branch, or
+#     the user's $PATH may have a random executable that may begin
+#     with "git-check" that are not part of the subcommands this build
+#     will ship, e.g.  "check-ignore".  The tests for completion for
+#     subcommand names tests how "check" is expanded; we limit the
+#     possible candidates to "checkout" and "check-attr" to make sure
+#     "check-attr", which is known by the filter function as a
+#     subcommand to be thrown out, while excluding other random files
+#     that happen to begin with "check" to avoid letting them get in
+#     the way.
+#
+# (2) A test makes sure that common subcommands are included in the
+#     completion for "git <TAB>", and a plumbing is excluded.  "add",
+#     "filter-branch" and "ls-files" are listed for this.
+
+GIT_TESTING_COMMAND_COMPLETION='add checkout check-attr filter-branch ls-files'
+
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
 
 # We don't need this function to actually join words or do anything special.
@@ -196,7 +215,6 @@ test_expect_success 'general options plus command' '
 	test_completion "git --paginate check" "checkout " &&
 	test_completion "git --git-dir=foo check" "checkout " &&
 	test_completion "git --bare check" "checkout " &&
-	test_completion "git --help des" "describe " &&
 	test_completion "git --exec-path=foo check" "checkout " &&
 	test_completion "git --html-path check" "checkout " &&
 	test_completion "git --no-pager check" "checkout " &&
@@ -207,6 +225,11 @@ test_expect_success 'general options plus command' '
 	test_completion "git --no-replace-objects check" "checkout "
 '
 
+test_expect_success 'git --help completion' '
+	test_completion "git --help ad" "add " &&
+	test_completion "git --help core" "core-tutorial "
+'
+
 test_expect_success 'setup for ref completion' '
 	echo content >file1 &&
 	echo more >file2 &&
