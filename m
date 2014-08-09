From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] read-cache: check for leading symlinks when refreshing index
Date: Sat, 09 Aug 2014 19:43:29 +0200
Message-ID: <53E65DC1.4010502@web.de>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de>	<xmqqppgkw55g.fsf@gitster.dls.corp.google.com>	<53DCF14D.8040705@web.de>	<xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>	<53DEBEE7.6070009@web.de> <xmqqbns0tdqu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Nikolay Avdeev <avdeev@math.vsu.ru>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 19:44:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGAhC-0005vJ-R6
	for gcvg-git-2@plane.gmane.org; Sat, 09 Aug 2014 19:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbaHIRom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2014 13:44:42 -0400
Received: from mout.web.de ([212.227.15.4]:52897 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131AbaHIRoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 13:44:39 -0400
Received: from [192.168.178.27] ([79.253.137.193]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LnBTZ-1WmrE63MUP-00hPPC; Sat, 09 Aug 2014 19:44:35
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqbns0tdqu.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:17+PmQP1mq2nYtkVzeKNHzfBtNtXoKwwIf+7Up65hCIoxZZsF0f
 WdBXHcvWLHDXyJ70zsK3a6h0GpwAnb1YVOFP579JoMVCUM+WR+A43hocb9JNu+hqZWG6aKX
 XfKJPXG/jdoIoBBi28EXoY7ORLYTBOzKaNZMSR0s2zVa/5A5T6TdTLMI+DAI1NqtKPzlPN3
 KaaFaJ5gpR9LPRmboe01g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255074>

Don't add paths with leading symlinks to the index while refreshing; we
only track those symlinks themselves.  We already ignore them while
preloading (see read_index_preload.c).

Reported-by: Nikolay Avdeev <avdeev@math.vsu.ru>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 read-cache.c               |  8 ++++++++
 t/t7515-status-symlinks.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 t/t7515-status-symlinks.sh

diff --git a/read-cache.c b/read-cache.c
index 5d3c8bd..6f0057f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1064,6 +1064,14 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		return ce;
 	}
 
+	if (has_symlink_leading_path(ce->name, ce_namelen(ce))) {
+		if (ignore_missing)
+			return ce;
+		if (err)
+			*err = ENOENT;
+		return NULL;
+	}
+
 	if (lstat(ce->name, &st) < 0) {
 		if (ignore_missing && errno == ENOENT)
 			return ce;
diff --git a/t/t7515-status-symlinks.sh b/t/t7515-status-symlinks.sh
new file mode 100755
index 0000000..9f989be
--- /dev/null
+++ b/t/t7515-status-symlinks.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git status and symlinks'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo .gitignore >.gitignore &&
+	echo actual >>.gitignore &&
+	echo expect >>.gitignore &&
+	mkdir dir &&
+	echo x >dir/file1 &&
+	echo y >dir/file2 &&
+	git add dir &&
+	git commit -m initial &&
+	git tag initial
+'
+
+test_expect_success SYMLINKS 'symlink to a directory' '
+	test_when_finished "rm symlink" &&
+	ln -s dir symlink &&
+	echo "?? symlink" >expect &&
+	git status --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'symlink replacing a directory' '
+	test_when_finished "rm -rf copy && git reset --hard initial" &&
+	mkdir copy &&
+	cp dir/file1 copy/file1 &&
+	echo "changed in copy" >copy/file2 &&
+	git add copy &&
+	git commit -m second &&
+	rm -rf copy &&
+	ln -s dir copy &&
+	echo " D copy/file1" >expect &&
+	echo " D copy/file2" >>expect &&
+	echo "?? copy" >>expect &&
+	git status --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.0.2
