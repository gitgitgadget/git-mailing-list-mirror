From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 7/9] stash: teach git stash show to always tolerate stash-like arguments.
Date: Sun,  8 Aug 2010 14:46:09 +1000
Message-ID: <1281242771-24764-8-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:48:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohxns-0007vl-Qe
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab0HHEsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:48:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64812 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0HHEsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:48:00 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so408951pvg.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mMmOFKGsP0PFAK6/IZMErBiOgPm04dNBDwlNLwjyRdw=;
        b=I9u+pUcB8BQFXGhb7FyTT7gNxBWLBib29RgOHKBqAU9SFo/0WZzWJErla6mH/Tz6eI
         Ew5gX6JIAZQBtgDzjqxSkYib7rIMSpq0UZeQ9ZYQFsKSAm2Z5q8zZsJy6wyZgpuKJ2MI
         cAyOI0fW8I63kpteq8ryheH1AMWJMs/rCwIUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jiyg4QY2NE+I/HRZcOLpaSxxmpxr+eDV3bFgqZovbrRSLKi+VBjubuCpstDeC5tCHi
         1Nchz+lhD9U+W/1V5x2v5Z2N7xCmI5AXstgwcwhgaKM/T8virIr9Uehq14dMT/cCrqgW
         lmJo30cCE7LAf1GM06Tx762H4KHHkmZGSGqqE=
Received: by 10.142.156.16 with SMTP id d16mr12022381wfe.120.1281242880511;
        Sat, 07 Aug 2010 21:48:00 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152889>

Previously, git stash show would accept stash-like arguments, but
only if there was a stash on the stack.

Now, git stash accepts stash-like arguments always and only fails
if no stash-like argument is specified and there is no stash stack.


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 97e3749..5b875ea 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -210,14 +210,19 @@ list_stash () {
 }
 
 show_stash () {
-	have_stash || die 'No stash found'
-
 	flags=$(git rev-parse --no-revs --flags "$@")
 	if test -z "$flags"
 	then
 		flags=--stat
 	fi
 
+	revs=$(git rev-parse --revs-only "$@")
+	if test -z "$revs"
+	then
+		have_stash || die "No stash found"
+		set -- ${ref_stash}@{0}
+	fi
+
 	assert_stash_like "$@"
 
 	git diff $flags $b_commit $w_commit
-- 
1.7.2.1.51.g82c0c0
