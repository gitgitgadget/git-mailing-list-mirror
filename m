From: 0xAX <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] git-config: git-config --list fixed when GIT_CONFIG value starts with ~/
Date: Sat, 15 Nov 2014 00:29:20 +0600
Message-ID: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com>
Cc: 0xAX <kuleshovmail@gmail.com>,
	Alex Kuleshov <kuleshovmail@gmial.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 19:29:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpLct-00046s-1A
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 19:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965580AbaKNS3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 13:29:39 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:62646 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaKNS3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 13:29:38 -0500
Received: by mail-la0-f44.google.com with SMTP id hz20so5425628lab.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 10:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HLFR5/Ge00b4LdZcbkITP3HhKRDhneYBidv3QVhgbYQ=;
        b=PbIVEfxsibzBLk2j0vLoxjK17a8JUnRw2B+LKSoVtIgB3EwkQrmdfpWnZqrt/ic/ed
         ZG4NO6FrNjEyD4VgNkzQoJTV0/6IvHeYl2WOh1L31S6hRb2oLOZI5q/jmP9sm1/n2msS
         jFETn6P/X+Jt2LSnGdGX2fZ2nMlMCLAMeFCj8lIDrfQKLrw5rQRdv2qUmpX7moF4TkOa
         aSwHXynmAVifkcRz9keZLzS+0dt4pCtQX/IJCmXg2p1MkU7REkmb/vwUSYOkkKeBNCbu
         of59KpwSv6Yqa+g4IoyPk+yuLMueFPkPmU+9JoMjwKcs1tf2KpZS6AcLQr+T4JmaUQkt
         shuw==
X-Received: by 10.112.225.225 with SMTP id rn1mr3061722lbc.98.1415989776480;
        Fri, 14 Nov 2014 10:29:36 -0800 (PST)
Received: from localhost.localdomain ([2.133.4.138])
        by mx.google.com with ESMTPSA id jq16sm8356026lab.14.2014.11.14.10.29.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Nov 2014 10:29:35 -0800 (PST)
X-Mailer: git-send-email 2.1.3.17.g7fa1365.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we execute git config --list and $GIT_CONFIG value starts with home
prefix - ~/ it produces folowing error - fatal: unable to read config
file '~/.gitconfig': No such file or directory. This patch fixed it with
expand_user_path for configuration file path before git-config --list
call.

Signed-off-by: Alex Kuleshov <kuleshovmail@gmial.com>
Signed-off-by: 0xAX <kuleshovmail@gmail.com>
---
 builtin/config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index 7bba516..df1bee0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -540,6 +540,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
+		const char* newpath = expand_user_path(given_config_source.file);
+		given_config_source.file = newpath;
 		if (git_config_with_options(show_all_config, NULL,
 					    &given_config_source,
 					    respect_includes) < 0) {
-- 
2.1.3.17.g7fa1365.dirty
