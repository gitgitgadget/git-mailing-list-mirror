From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-clean: honor core.excludesfile
Date: Wed, 14 Nov 2007 01:54:43 -0800
Message-ID: <7vzlxhi23g.fsf@gitster.siamese.dyndns.org>
References: <30046e3b0711132340y2c503dd4laea24b9b1c79a160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "shunichi fuji" <palglowr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsExd-00038N-1C
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXKNJyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 04:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbXKNJyt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:54:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54999 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbXKNJys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 04:54:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C8E952EF;
	Wed, 14 Nov 2007 04:55:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 400E59463D;
	Wed, 14 Nov 2007 04:55:07 -0500 (EST)
In-Reply-To: <30046e3b0711132340y2c503dd4laea24b9b1c79a160@mail.gmail.com>
	(shunichi fuji's message of "Wed, 14 Nov 2007 16:40:33 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64975>

git-clean did not honor core.excludesfile configuration
variable, although some other commands such as git-add and
git-status did.  Fix this inconsistency.

Original report and patch from Shun'ichi Fuji.  Rewritten by me
and bugs and tests are mine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * How does this look?  It is customary here to add a test
   script to t/ to make sure a fix won't get broken in later
   changes, so I took the liberty of adding one myself.

 git-clean.sh     |    9 ++++++++-
 t/t7300-clean.sh |   11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/git-clean.sh b/git-clean.sh
index 4491738..931d1aa 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -75,15 +75,22 @@ esac
 
 if [ -z "$ignored" ]; then
 	excl="--exclude-per-directory=.gitignore"
+	excl_info= excludes_file=
 	if [ -f "$GIT_DIR/info/exclude" ]; then
 		excl_info="--exclude-from=$GIT_DIR/info/exclude"
 	fi
+	if cfg_excl=$(git config core.excludesfile) && test -f "$cfg_excl"
+	then
+		excludes_file="--exclude-from=$cfg_excl"
+	fi
 	if [ "$ignoredonly" ]; then
 		excl="$excl --ignored"
 	fi
 fi
 
-git ls-files --others --directory $excl ${excl_info:+"$excl_info"} -- "$@" |
+git ls-files --others --directory \
+	$excl ${excl_info:+"$excl_info"} ${excludes_file:+"$excludes_file"} \
+	-- "$@" |
 while read -r file; do
 	if [ -d "$file" -a ! -L "$file" ]; then
 		if [ -z "$cleandir" ]; then
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index eb0847a..0ed4ae2 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -177,4 +177,15 @@ test_expect_success 'clean.requireForce and -f' '
 
 '
 
+test_expect_success 'core.excludesfile' '
+
+	echo excludes >excludes &&
+	echo included >included &&
+	git config core.excludesfile excludes &&
+	output=$(git clean -n excludes included 2>&1) &&
+	expr "$output" : ".*included" >/dev/null &&
+	! expr "$output" : ".*excludes" >/dev/null
+
+'
+
 test_done
