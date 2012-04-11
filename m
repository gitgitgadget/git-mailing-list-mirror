From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] tests: add initial bash completion tests
Date: Thu, 12 Apr 2012 00:57:03 +0300
Message-ID: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 23:57:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5Xe-0002RF-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761338Ab2DKV50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:57:26 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49273 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761289Ab2DKV5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:57:25 -0400
Received: by lbbgm6 with SMTP id gm6so1109159lbb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wrwLtMhMeJsDFYUhuKl6NpQ/nQjdMV8Yn2lqfMoFmPM=;
        b=b3uBObMTbdtE9m+nE8MVGN3J2gMsdgtrjbOzrRQ/ryT5kOU/vPtRjWJLrN5rl/ziZd
         sM7zRtuF3GHnrhuwPqOMQKW1vDwrzZjJiFDmtJ6XdNo3GN/rktoZgk0rAS9/iIT/AYcr
         XQO3ts1WDTydEBe+lRiz9YoJ+3PnZYilIAm35hLsdtTB/U5eALZl3S+Pm4ynm7/HF4bR
         kefIAqa6lM83RpQGTmTnaiEjuB9r9m2rPUHYwjqmY5TcEIiqoDpoMhqRvzTSXlcKDsP2
         hpqlo4QjBfvcBAcmusoBH2aa3IZLO5kWd+AT96Bsbcsnn5YCyrmbmpjJduFciinS5p0N
         6yww==
Received: by 10.152.103.169 with SMTP id fx9mr15767lab.37.1334181443601;
        Wed, 11 Apr 2012 14:57:23 -0700 (PDT)
Received: from localhost (84-231-215-195.elisa-mobile.fi. [84.231.215.195])
        by mx.google.com with ESMTPS id mr15sm4009169lab.8.2012.04.11.14.57.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:57:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195271>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Since v1:

 * Check if we are running bash in posix mode
 * Don't check for all git porcelain commands

 t/t9902-completion.sh |  115 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100755 t/t9902-completion.sh

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
new file mode 100755
index 0000000..cbda6b5
--- /dev/null
+++ b/t/t9902-completion.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
+	# we are in full-on bash mode
+	true
+elif type bash >/dev/null 2>&1; then
+	# execute in full-on bash mode
+	unset POSIXLY_CORRECT
+	exec bash "$0" "$@"
+else
+	echo '1..0 #SKIP skipping bash completion tests; bash not available'
+	exit 0
+fi
+
+test_description='test bash completion'
+
+. ./test-lib.sh
+
+complete ()
+{
+	# do nothing
+	return 0
+}
+
+. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+
+_get_comp_words_by_ref ()
+{
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		cur)
+			cur=${_words[_cword]}
+			;;
+		prev)
+			prev=${_words[_cword-1]}
+			;;
+		words)
+			words=("${_words[@]}")
+			;;
+		cword)
+			cword=$_cword
+			;;
+		esac
+		shift
+	done
+}
+
+print_comp ()
+{
+	local IFS=$'\n'
+	echo "${COMPREPLY[*]}" > out
+}
+
+run_completion ()
+{
+	local -a COMPREPLY _words
+	local _cword
+	_words=( $1 )
+	(( _cword = ${#_words[@]} - 1 ))
+	_git && print_comp
+}
+
+test_completion ()
+{
+	test $# -gt 1 && echo "$2" > expected
+	run_completion "$@" &&
+	test_cmp expected out
+}
+
+test_expect_success 'basic' '
+	run_completion "git \"\"" &&
+	# built-in
+	grep -q "^add \$" out &&
+	# script
+	grep -q "^filter-branch \$" out &&
+	# plumbing
+	! grep -q "^ls-files \$" out
+
+	run_completion "git f" &&
+	! grep -q -v "^f" out
+'
+
+test_expect_success 'double dash' '
+	cat >expected <<-\EOF &&
+	--paginate 
+	--no-pager 
+	--git-dir=
+	--bare 
+	--version 
+	--exec-path 
+	--html-path 
+	--work-tree=
+	--namespace=
+	--help 
+	EOF
+	test_completion "git --"
+
+	cat >expected <<-\EOF &&
+	--quiet 
+	--ours 
+	--theirs 
+	--track 
+	--no-track 
+	--merge 
+	--conflict=
+	--orphan 
+	--patch 
+	EOF
+	test_completion "git checkout --"
+'
+
+test_done
-- 
1.7.10.1.g1f19b8.dirty
