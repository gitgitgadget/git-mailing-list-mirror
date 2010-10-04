From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] hooks/pre-commit: check for deps repititions
Date: Mon,  4 Oct 2010 23:22:17 +0200
Message-ID: <1286227337-8934-1-git-send-email-bert.wesarg@googlemail.com>
References: <1286227130-8306-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sUO-0001IZ-AY
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab0JDVWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 17:22:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50327 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757256Ab0JDVWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 17:22:22 -0400
Received: by bwz11 with SMTP id 11so4025217bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=PLHzj6JHD9UAYrVZ26YXtY5LyyzKFxZEA1UsyCCQV3Y=;
        b=ALg3JhdTuHEQZ/TlvkaayXZiR4HfLJbIrx998ESBJRN5faEhdVPnuN4jbuXZS5jZ3I
         V0Je5VmRCsE8p1I7WtqpR1zMNjS7kkqGudrCVMatmb1f1czwMpzhLIaW8Y4viZR6TdHa
         eV5pZVMbyighfrgbNvfXmefkwyvYNZ5iVHQJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=yFofzfO/+ezYcIIdiTdbauciUcs+fZfZTnc0O0vxb0CWXjOeSHWjO07Q8/jszpiyqN
         D437YX74vOpPVYJnZNIuZ6lI0QLx2VirLbG0Mmyw4BVBB5FJKNJW+PXybhFPYwAm1WXm
         A3Vo69EgDS5oQQCVDMWkdC1xRAdyyT3l/HE5Y=
Received: by 10.204.56.143 with SMTP id y15mr7468326bkg.198.1286227340601;
        Mon, 04 Oct 2010 14:22:20 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id f18sm4198603bkf.3.2010.10.04.14.22.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 14:22:19 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286227130-8306-1-git-send-email-bert.wesarg@googlemail.com>
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158124>

A dep should only be listed once in .topdeps, force this.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index f6901e4..e8986d6 100644 hooks/pre-commit.sh
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -67,3 +67,15 @@ BEGIN      { in_hunk = 0; }
 		# therefore no endless loop in the cycle-check
 		no_remotes=1 recurse_deps check_cycle_name "$newly_added"
 	done
+
+# check for repititions of deps
+depdir="$(mktemp -t -d tg-depdir.XXXXXX)" ||
+	die "Can't check for mulitple occurrences of deps"
+trap "rm -rf '$depdir'" 0
+cat_file "(i):.topdeps" |
+	while read dep; do
+		[ ! -d "$depdir/$dep" ] ||
+			die "Mulitple occurrences of the same dep: $dep"
+		mkdir -p "$depdir/$dep" ||
+			die "Can't check for mulitple occurrences of deps"
+	done
-- 
tg: (a2bfc32..) bw/check-for-repetitions (depends on: bw/check-valid-deps)
