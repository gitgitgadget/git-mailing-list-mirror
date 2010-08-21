From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 2/9] detached-stash: work around git rev-parse failure to detect bad log refs
Date: Sat, 21 Aug 2010 14:08:57 +1000
Message-ID: <1282363744-4924-3-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:09:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfP0-0006is-0Z
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0HUEJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:09:40 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37067 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab0HUEJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:09:39 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1481994pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=spue8lDURcUL5E7Ph5rpnASwYaMpUdv3gyzugSMPPJc=;
        b=mNuTVhkBfuFVyKHueQUccVIOdnJc4ZRDQT10kCvqc9H4IE7Jh6kVwpkJ0WYC/ByUkC
         SQXm2bRAwXtAnuh8L89/6bp+5H4SJwD/slLXqyc9zpuU1hqFdWZ+rUFyvcnLNxlNVvQB
         DkhJ/lfjAM9iAJdxIWKSAVat8h+FfICgokUeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZNYwLwoqwMnct+lqkH6m/RA/9q+59//AQO58P9IhOWva7t7rUlmlGR9edi81rP/jH8
         kfyyGqEQGMLFgbFGmexDrk8xUIZjceb/9jiLGCWbxSDbCOVMdqBQTndvYdwk1vf7AQ1D
         6jFw+Zsi51jajJCTmx/CfqcM/NsVoxh55YkKk=
Received: by 10.142.144.16 with SMTP id r16mr1733167wfd.312.1282363779439;
        Fri, 20 Aug 2010 21:09:39 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.09.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:09:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154101>

This commit is required because git rev-parse in 1.7.2 does not correctly
indicate invalid log references using a non-zero status code.

We use a proxy for the condition (non-empty error output) as
a substitute. This commit can be reverted when, and if, rev-parse
is fixed to indicate invalid log references with a status code.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index b424a50..42b0da2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -328,6 +328,16 @@ parse_flags_and_rev()
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
+}
 
 is_stash_like()
 {
-- 
1.7.2.1.110.g34f32
