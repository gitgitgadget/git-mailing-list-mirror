From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6a 2/9] detached-stash: work around git rev-parse failure to detect bad log refs
Date: Sat, 21 Aug 2010 14:48:05 +1000
Message-ID: <1282366085-11196-1-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-3-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omg0U-0008Vh-2p
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab0HUEse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:48:34 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34317 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab0HUEsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:48:32 -0400
Received: by pxi10 with SMTP id 10so1491909pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gmOqR/u30j/YCQ2zZVZbRQiL4J2X5vJMGcm/7kLQw2Y=;
        b=N6GmjyU/QQMjuC5A7jDM8p1z1eK5RcvMr/7ENZ5FePNEokbzLEUvDckUCCmgDBc4My
         0lbcCy0yluNI9YhV8xScklHiVKQ48DDGXgTdjCwYwotLzRG58EFkUi00+89rse8Z+fdB
         y9J/P9Lb8zX3KbZRfXrdD0GCbPOBZRRkDvWg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JBhLtjNDei3vTMwhlsAx/Dn5hOovAiaiMIymd3XhKEYe/TI1eW8KVduKGioSOcTBOC
         VlgthO9Uufkw2N58a9uzKluDnN8QtA4LDJwZVCCdyFMj30LeNoZm60ICUb6yzvEb2Qj/
         30SjJyPn3/rt98By8JB8e7aeZenxsYtZ095wU=
Received: by 10.143.8.7 with SMTP id l7mr1808046wfi.187.1282366112371;
        Fri, 20 Aug 2010 21:48:32 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id n2sm4250544wfl.13.2010.08.20.21.48.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:48:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.178.g949b
In-Reply-To: <1282363744-4924-3-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154109>

| amended to include trailing } in 1/9

This commit is required because git rev-parse in 1.7.2 does not correctly
indicate invalid log references using a non-zero status code.

We use a proxy for the condition (non-empty error output) as
a substitute. This commit can be reverted when, and if, rev-parse
is fixed to indicate invalid log references with a status code.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 836d6e6..42b0da2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -328,6 +328,15 @@ parse_flags_and_rev()
 	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
 	IS_STASH_REF=t
 
+	if test "${REV}" != "${REV%{*\}}"
+	then
+		# maintainers: it would be better if git rev-parse indicated
+		# this condition with a non-zero status code but as of 1.7.2.1 it
+		# it did not. So, we use non-empty stderr output as a proxy for the
+		# condition of interest.
+		test -z "$(git rev-parse "$REV" 2>&1 >/dev/null)" || die "$REV does not exist in the stash log"
+	fi
+
 }
 
 is_stash_like()
-- 
1.7.2.2.178.g949b
