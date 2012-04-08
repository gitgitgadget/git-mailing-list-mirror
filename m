From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun,  8 Apr 2012 06:07:48 +0300
Message-ID: <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiUo-00077H-8f
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2DHDI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:28 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53218 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232Ab2DHDIU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 23:08:20 -0400
Received: by lahj13 with SMTP id j13so2813271lah.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aCqEUS95BtVf5gloOmY4z8HGUYzfZRq9Muisai5ttJQ=;
        b=Eu/R0yGjUeFPuVXJqyjhVv9/w3eRdUSTSiDy+nKLy+xuA+YnwCeqHqGH3bE0luemc6
         RoBjHIH6qYh9xpS3n4sHiLflIZl20hBekKlBYWQXGDWwg5+52WDkG4TQ4vP3oCOMQ54e
         PN3quUnFdhHdXMx/TikOWx71yvfBiGQicEmIHOmDKnQ8GsfxuKwUwAt6989+i+3xHqaY
         +RKDKuLTkCI/U0WzY7MCC5DwAsDXpBtHUQA/CI5ARVoQbUxvbwwz2JQ+f02i0x0rs51x
         Sz/FygTu3AUKUUDNOY0i8BHxwRWntEtUopInaXyDh4m6HzWj5oi4O/gz8syAAHYjlS8i
         bXlA==
Received: by 10.152.103.134 with SMTP id fw6mr4758690lab.20.1333854498432;
        Sat, 07 Apr 2012 20:08:18 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id o6sm15521448lbo.4.2012.04.07.20.08.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194959>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh |  201 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100755 t/t9902-completion.sh

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
new file mode 100755
index 0000000..7eb80dd
--- /dev/null
+++ b/t/t9902-completion.sh
@@ -0,0 +1,201 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+
+if type bash >/dev/null 2>&1
+then
+	# execute inside bash
+	test -z "$BASH" && exec bash "$0" "$@"
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
+print_comp ()
+{
+	local IFS=$'\n'
+	echo "${COMPREPLY[*]}" > out
+}
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
+test_completion ()
+{
+	local -a COMPREPLY _words
+	local _cword
+	_words=( $1 )
+	test $# -gt 1 && echo "$2" > expected
+	(( _cword = ${#_words[@]} - 1 ))
+	_git && print_comp &&
+	test_cmp expected out
+}
+
+test_expect_success 'basic' '
+	cat >expected <<-\EOF &&
+	help 
+	add 
+	gc 
+	reflog 
+	get-tar-commit-id 
+	relink 
+	grep 
+	relink.perl 
+	am 
+	remote 
+	am.sh 
+	help 
+	annotate 
+	apply 
+	archimport.perl 
+	imap-send 
+	archive 
+	bisect 
+	init 
+	repack 
+	bisect.sh 
+	instaweb 
+	repack.sh 
+	blame 
+	instaweb.sh 
+	replace 
+	branch 
+	log 
+	bundle 
+	request-pull 
+	lost-found.sh 
+	request-pull.sh 
+	reset 
+	checkout 
+	cherry 
+	revert 
+	cherry-pick 
+	merge 
+	rm 
+	clean 
+	send-email 
+	clone 
+	send-email.perl 
+	commit 
+	config 
+	shortlog 
+	credential-cache 
+	show 
+	show-branch 
+	credential-store 
+	cvsexportcommit.perl 
+	stage 
+	stash 
+	cvsimport.perl 
+	stash.sh 
+	mergetool 
+	status 
+	cvsserver.perl 
+	mergetool.sh 
+	submodule 
+	describe 
+	submodule.sh 
+	diff 
+	mv 
+	svn 
+	name-rev 
+	svn.perl 
+	notes 
+	tag 
+	difftool 
+	difftool.perl 
+	fetch 
+	pull 
+	pull.sh 
+	filter-branch 
+	push 
+	filter-branch.sh 
+	quiltimport.sh 
+	format-patch 
+	rebase 
+	fsck 
+	rebase.sh 
+	whatchanged 
+	cccmd 
+	proxy 
+	send-pull 
+	EOF
+	test_completion "git" &&
+
+	cat >expected <<-\EOF &&
+	help 
+	help 
+	EOF
+	test_completion "git he"
+
+	cat >expected <<-\EOF &&
+	fetch 
+	filter-branch 
+	filter-branch.sh 
+	format-patch 
+	fsck 
+	EOF
+	test_completion "git f"
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
1.7.10.3.g5a738d
