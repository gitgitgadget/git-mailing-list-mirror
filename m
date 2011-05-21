From: Kazuki Tsujimoto <kazuki@callcc.net>
Subject: Re: [BUG] realloc failed
Date: Sat, 21 May 2011 14:50:58 +0900
Message-ID: <20110521145056.E3F5.BA9123DE@callcc.net>
References: <20110521100126.E3CD.BA9123DE@callcc.net> <7vhb8o25tt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 07:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNfAu-0002Ob-CW
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 07:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab1EUFu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 01:50:58 -0400
Received: from callcc.net ([173.230.149.188]:53435 "EHLO mx01.callcc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435Ab1EUFu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 01:50:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx01.callcc.net (Postfix) with ESMTP id C1A8D26B19
	for <git@vger.kernel.org>; Sat, 21 May 2011 14:50:56 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at callcc.net
Received: from mx01.callcc.net ([127.0.0.1])
	by localhost (mx01.callcc.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QR6OAZ1iJ0hd for <git@vger.kernel.org>;
	Sat, 21 May 2011 14:50:56 +0900 (JST)
Received: from [192.168.0.128] (p6eb203.tkyoac00.ap.so-net.ne.jp [218.110.178.3])
	by mx01.callcc.net (Postfix) with ESMTPSA id A52E326B13
	for <git@vger.kernel.org>; Sat, 21 May 2011 14:50:55 +0900 (JST)
In-Reply-To: <7vhb8o25tt.fsf@alter.siamese.dyndns.org>
X-Mailer: Becky! ver. 2.56.04 [ja]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174091>

From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 20 May 2011 18:35:58 -0700

> Care to send a patch with test (see Documentation/SubmittingPatches)?

Thanks for your comment.
Here is a patch with test.


[PATCH] Avoid "realloc failed" error in alias expansion including -c option

When the -c option is specified, setenv will be called.
Therefore, set envchanged flag to true so that git exits with
"alias '%s' changes environment variables" error.

Signed-off-by: Kazuki Tsujimoto <kazuki@callcc.net>
---
 git.c                   |    2 ++
 t/t1020-subdirectory.sh |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index a5ef3c6..e04e4d4 100644
--- a/git.c
+++ b/git.c
@@ -153,6 +153,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				usage(git_usage_string);
 			}
 			git_config_push_parameter((*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else {
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index ddc3921..94fed9c 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -119,6 +119,21 @@ test_expect_success 'alias expansion' '
 	)
 '
 
+test_expect_success 'alias expansion including "-c <name>=<value>" option' '
+	printf "%s\n%s\n" \
+	       "fatal: alias '"'ss'"' changes environment variables" \
+	       "You can use '"'!git'"' in the alias to do this.">expect &&
+	(
+		cat > .git/config <<EOF &&
+[alias]
+ss = -c name=value status
+EOF
+		cd dir &&
+		test_must_fail git ss 2> ../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success '!alias expansion' '
 	pwd >expect &&
 	(


-- 
Kazuki Tsujimoto
