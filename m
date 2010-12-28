From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 16/31] rebase -i: support --stat
Date: Tue, 28 Dec 2010 10:30:33 +0100
Message-ID: <1293528648-21873-17-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYk-0005Wr-To
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797Ab0L1Pcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:55 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0L1Pcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:51 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EjVJ+NzBDPoyywJHYVeUC1cm1/L7S631TlObR6BAohc=;
        b=IY6fpABZHePwsCycmKaAQLNm6CoKhiEjm+KXdbHHRPPlZATgUf/SGuZhvLD62cL/nc
         x3o+p598AJQTjLbAmZQEXZUSvQp2Fawmmk6Nivq2CFEuRpTS+omJuQP4gu2MZWaJDwfH
         I23xz8W3A8L4sqODlNvrnUS2n+RZkOaVAsA74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I1rqeFVtwlbE02Srb8riO+ThE7c7tKPReX5hB8N9hu3nJ9C7b01HkhMXpriTarsAXv
         QaomC4gDHUhXHsWKGjNQmOoZMg7H3Hgre2YjM5UKOTldVISdE4zn6DUHW94ew4U63T7G
         NF+OJI/7JZPQBRAaM+h3OSICa5MdmYtIcyZqk=
Received: by 10.224.6.149 with SMTP id 21mr12896340qaz.321.1293550371276;
        Tue, 28 Dec 2010 07:32:51 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:50 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164251>

Move up the code that displays the diffstat if '--stat' is passed, so
that it will be executed before calling git-rebase--interactive.sh.

A side effect is that the diffstat is now displayed before "First,
rewinding head to replay your work on top of it...".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 229e8d2..0fc580a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -540,13 +540,6 @@ fi
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
@@ -557,6 +550,13 @@ then
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
1.7.3.2.864.gbbb96
