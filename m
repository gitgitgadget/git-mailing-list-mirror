From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] stash: add two more tests for --no-keep-index
Date: Thu,  7 Apr 2011 12:04:19 -0500
Message-ID: <1302195860-31053-1-git-send-email-dpmcgee@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 19:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7sdG-0006lE-3P
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab1DGRE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 13:04:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53849 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab1DGRE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 13:04:28 -0400
Received: by gwaa18 with SMTP id a18so923353gwa.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=rHcObqYjKxqpvNSkRTQC0PX7IpdgIxLprL+ijPP0ZS4=;
        b=gKnM2sZwSRkf8V8mbiCxz4IpQuXWBLFBzMlbxVssGvvkFhL6OfOX5SWJJamo1m07kR
         p+7z73CLiZw8EtRbt3qkuk2OoofMczPFQgXNoVJs6ZyjwGEd/DjQyI04dk4h2iDy2Bc7
         e0pks38lkqUmey+NDwY6bjM1d3CCrDHN9virA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tmWKhrWiTj5T3B01avTMgGt0mGkY/AMZGloQ1p4ptUunT+9xuc8T7MH1fbUGk4qQtd
         yKqbF0/JlqKT9S4p/piibmcEbpMi12gMeUDYqNVVFTW9CT/Np5gG/PK4Jyui+uGFJRJQ
         RCn065n6PdKVQKjjSkG5WPKU5Z5gv5/97bjnY=
Received: by 10.150.134.13 with SMTP id h13mr954187ybd.219.1302195867937;
        Thu, 07 Apr 2011 10:04:27 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id x34sm2003610ana.10.2011.04.07.10.04.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 10:04:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171067>

One of these passes just fine; the other one exposes a problem where
command line flag order matters for --no-keep-index and --patch
interaction.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 t/t3903-stash.sh       |    8 ++++++++
 t/t3904-stash-patch.sh |   12 ++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f62aaf5..bca2df1 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -218,6 +218,14 @@ test_expect_success 'stash -k' '
 	test bar,bar4 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash --no-keep-index' '
+	echo bar33 > file &&
+	echo bar44 > file2 &&
+	git add file2 &&
+	git stash --no-keep-index &&
+	test bar,bar2 = $(cat file),$(cat file2)
+'
+
 test_expect_success 'stash --invalid-option' '
 	echo bar5 > file &&
 	echo bar6 > file2 &&
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 1e7193a..4d58789 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -48,6 +48,18 @@ test_expect_success PERL 'git stash -p --no-keep-index' '
 	verify_state bar dummy bar_index
 '
 
+test_expect_failure PERL 'git stash --no-keep-index -p' '
+	set_state dir/foo work index &&
+	set_state bar bar_work bar_index &&
+	(echo n; echo y) | git stash save --no-keep-index -p &&
+	verify_state dir/foo head head &&
+	verify_state bar bar_work dummy &&
+	git reset --hard &&
+	git stash apply --index &&
+	verify_state dir/foo work index &&
+	verify_state bar dummy bar_index
+'
+
 test_expect_success PERL 'none of this moved HEAD' '
 	verify_saved_head
 '
-- 
1.7.4.4
