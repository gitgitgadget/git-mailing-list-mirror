From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v3 3/3] t9903: add extra tests for bash.showDirtyState
Date: Wed, 13 Feb 2013 21:58:19 +0100
Message-ID: <1360789100-26285-2-git-send-email-martinerikwerner@gmail.com>
References: <7vmwv854ji.fsf@alter.siamese.dyndns.org>
 <1360789100-26285-1-git-send-email-martinerikwerner@gmail.com>
Cc: git@vger.kernel.org, trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 13 21:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5jQX-0001Lw-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934491Ab3BMU7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 15:59:14 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:62382 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934131Ab3BMU7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:59:13 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so1243224lbb.22
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LmYRv5TdRmUGtNhsVtJhUCREUK6wJbIqB35+hxTWmZg=;
        b=fAEfbL2bD9ZzebxUK4JeST2zrXmXicYbktidyt3nCZBxPb51zO5QglPzpniXRRNIOG
         alxR8G5eAYjfhEv8Mwg/QGAT+PN8ZA+85ikXKEfWztKUlGoPfRdICWpXD/jA9fTyCTJ3
         Gaz8hVQmo2PbWmPCSRg2tlx0jTIhovQ56RFjNXWS8hztcqrWxmWa2kYx5v2PRTBPBY+z
         u0ohGcpzfa6fKvso2ttzDCvUjocO3fGkqMi0fcvYkmZXQtCHRwJy0NtIVR8w2qgRMX+L
         x8bm+ExGsjnlE1+KsJBsRFuV8opVCb2HJxBU7GuaabsTa8a+gHZ+9V4op0u+85/rutHS
         DfLw==
X-Received: by 10.112.30.104 with SMTP id r8mr9448019lbh.82.1360789152025;
        Wed, 13 Feb 2013 12:59:12 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id fm8sm14580247lbb.17.2013.02.13.12.59.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 12:59:11 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5jPz-0006qd-Lf; Wed, 13 Feb 2013 21:59:03 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360789100-26285-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216288>

Add 3 extra tests for the bash.showDirtyState config option, the test
now cover all combinations of the shell var being set/unset and the
config option being missing/enabled/disabled, given a dirty file.

* Renamed test 'disabled by config' to 'shell variable set with config
  disabled' for consistency

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t9903-bash-prompt.sh |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index dd9ac6a..2101d91 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -360,12 +360,48 @@ test_expect_success 'prompt - dirty status indicator - before root commit' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - disabled by config' '
+test_expect_success 'prompt - dirty status indicator - shell variable unset with config disabled' '
 	printf " (master)" > expected &&
 	echo "dirty" > file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
 	(
+		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - shell variable unset with config enabled' '
+	printf " (master)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState true &&
+	(
+		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - shell variable set with config disabled' '
+	printf " (master)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState false &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - shell variable set with config enabled' '
+	printf " (master *)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState true &&
+	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		__git_ps1 > "$actual"
 	) &&
-- 
1.7.10.4
