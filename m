From: Johannes Sixt <j6t@kdbg.org>
Subject: difftool--helper: exit when reading a prompt answer fails
Date: Sun, 26 Oct 2014 09:09:20 +0100
Message-ID: <544CAC30.7000607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 09:09:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiItK-0003wK-6n
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 09:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbaJZIJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 04:09:27 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:24014 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbaJZIJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 04:09:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jQWz26vmQz5tlF;
	Sun, 26 Oct 2014 09:08:46 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B191D19F571;
	Sun, 26 Oct 2014 09:09:20 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An attempt to quit difftool by hitting Ctrl-D (EOF) at its prompt does
not quit it, but is treated as if 'yes' was answered to the prompt and
all following prompts, which is contrary to the user's intent. Fix the
error check.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Found while reviewing your latest patch.

 I chose the 'foo || return' idiom for the error check, but left the
 'if' for the interesting check, because I feel it is more readable
 than 'test ... && return'.

 -- Hannes

 git-difftool--helper.sh | 3 ++-
 t/t7800-difftool.sh     | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 7ef36b9..aca0413 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -49,7 +49,8 @@ launch_merge_tool () {
 		else
 			printf "Launch '%s' [Y/n]: " "$merge_tool"
 		fi
-		if read ans && test "$ans" = n
+		read ans || return
+		if test "$ans" = n
 		then
 			return
 		fi
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index dc30a51..9cf5dc9 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -301,6 +301,14 @@ test_expect_success PERL 'say no to the second file' '
 	! grep br2 output
 '
 
+test_expect_success PERL 'ending prompt input with EOF' '
+	git difftool -x cat branch </dev/null >output &&
+	! grep master output &&
+	! grep branch output &&
+	! grep m2 output &&
+	! grep br2 output
+'
+
 test_expect_success PERL 'difftool --tool-help' '
 	git difftool --tool-help >output &&
 	grep tool output
-- 
2.0.0.12.gbcf935e
