From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 16/31] rebase -i: support --stat
Date: Sun,  6 Feb 2011 13:43:45 -0500
Message-ID: <1297017841-20678-17-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:48:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eN-0005ZO-5a
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab1BFSrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:47:07 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab1BFSqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:15 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=fS1Ii84+LUI+xXkLLQMavfqb4IGAOO+knSZhcZveeUM=;
        b=O96DLODR9MuczFRXAQOTNaC/zFUnKjeStnjPG9hLEzv0L7HNuzONvAuQjwq+n+hbqk
         fOE2FlElPWMahP71hKVQUQtJ+NHNbbNJePUUuxFf1uNqnchVXv3NageJd5VzpRtYWROV
         neiVc6/IvZOdEc6xbPNg78vb3sK3E/OjQhzfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x212hcEHFN/28VvFfDviKV8T5DdnqtEFjMJdD8XcnpRRvo99/gDrkM8CuzbZ+WBUTp
         HECGP9Q+mzRep1Ipq9v/XZUUoLM6kVzrmPBuTUkc6ATQtnffOMY3PbvFpeARA7QMea3L
         OBwaZfUlzE7cUm4fntuE++hE3GUMVk37G56wo=
Received: by 10.229.95.67 with SMTP id c3mr12048984qcn.295.1297017974944;
        Sun, 06 Feb 2011 10:46:14 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:14 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166192>

Move up the code that displays the diffstat if '--stat' is passed, so
that it will be executed before calling git-rebase--interactive.sh.

A side effect is that the diffstat is now displayed before "First,
rewinding head to replay your work on top of it...".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 87d7fde..c8a7e4e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -539,13 +539,6 @@ fi
 # If a hook exists, give it a chance to interrupt
 run_pre_rebase_hook "$upstream_arg" "$@"
 
-test "$type" = interactive && run_interactive_rebase
-
-# Detach HEAD and reset the tree
-say "First, rewinding head to replay your work on top of it..."
-git checkout -q "$onto^0" || die "could not detach HEAD"
-git update-ref ORIG_HEAD $branch
-
 if test -n "$diffstat"
 then
 	if test -n "$verbose"
@@ -556,6 +549,13 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
+test "$type" = interactive && run_interactive_rebase
+
+# Detach HEAD and reset the tree
+say "First, rewinding head to replay your work on top of it..."
+git checkout -q "$onto^0" || die "could not detach HEAD"
+git update-ref ORIG_HEAD $branch
+
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast-forwarded.
 if test "$mb" = "$branch"
-- 
1.7.4.rc2.33.g8a14f
