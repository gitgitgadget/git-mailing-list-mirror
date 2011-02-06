From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 14/31] rebase: factor out clean work tree check
Date: Sun,  6 Feb 2011 13:43:43 -0500
Message-ID: <1297017841-20678-15-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eA-0005ZO-Fd
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691Ab1BFSqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:18 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab1BFSqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:11 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=9faFgno+nyMZzzvVo2p5XQz9USCO7wkbhEwHZLzVPpI=;
        b=HIXYOsesyd5jf38dSbHFnUdm2xIx5rBTQdK9VmaU8FouAbtL0Dl1nnPdrZElu2Is0H
         WcCxEFlVAb96iauo6hVYzxBw9lOWv23kRUcfQQsEJpyuRM8pimiMm4jIWOQbr2lCzAVZ
         46cET2nTIK7hstZoeKrNx0jqj/iS1trdvNLXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cFJZkREiy0k57j7rMhWRqdMzVv8BBEcV7EWdnM/DssS+l+KuyLfTdwKzmtRkkmq+MW
         MHKhSs7yABRevOv7g7gGD5kDY+wYyown4iK1BwYujz2RUzYx0zW3OgYa/iXHxJX9mlLu
         HPjdd3ZyL3MvIMcyoBXLG7Q1mSLEVsih5kCjY=
Received: by 10.229.43.74 with SMTP id v10mr12011205qce.293.1297017971149;
        Sun, 06 Feb 2011 10:46:11 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:10 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166175>

Remove the check for clean work tree from git-rebase--interactive.sh and
rely on the check in git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    2 --
 git-rebase.sh              |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fbe12a6..1ba98a2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -753,8 +753,6 @@ esac
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-require_clean_work_tree "rebase" "Please commit or stash them."
-
 run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
diff --git a/git-rebase.sh b/git-rebase.sh
index 0f5f5fb..265f01d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -511,10 +511,10 @@ case "$#" in
 esac
 orig_head=$branch
 
-test "$type" = interactive && run_interactive_rebase "$@"
-
 require_clean_work_tree "rebase" "Please commit or stash them."
 
+test "$type" = interactive && run_interactive_rebase "$@"
+
 # Now we are rebasing commits $upstream..$branch (or with --root,
 # everything leading up to $branch) on top of $onto
 
-- 
1.7.4.rc2.33.g8a14f
