From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC] [submodule] Add depth to submodule update
Date: Sun, 23 Jun 2013 10:04:58 +0200
Message-ID: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Sun Jun 23 10:01:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqfEW-0000XA-7i
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 10:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955Ab3FWIBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 04:01:08 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:50518 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab3FWIBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 04:01:06 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so9083713lab.34
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=I77v/1NULGFpKRyhQQ0J1xDq8wGTJUznwJgrvH70VT4=;
        b=aup8qUmUdm7esbioQO2K6nCnhPKew9qC+eOnCgG3LLkr6hp/PujDYUHXXtedpd+6F6
         WGYz7Jn9o57CHaHH1sgP99CF/qjjw1TsLDQViSQtxnEI0s6u5+YHqAv156OwLcpWA77n
         t8f0+HgL/GnG+Yhxg0UNvzDdxMdHcjjspwWdaRr5TeTyYErSinbtc9lRZoKcJoPSb0wv
         KMKKnmiZfc2XCGZppir4iFgsqxPJhlI7PZfUgehBEPOO5lRh2l7piq+EMYF6G8NpqqAU
         pm/5d7DbYxmua9xNoEJIJG4isCW6SHo6FIrAAONdpL6JSp/o2+qCTnQ3L3FzRxLF/kI2
         W+DA==
X-Received: by 10.112.54.161 with SMTP id k1mr10661494lbp.21.1371974463756;
        Sun, 23 Jun 2013 01:01:03 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id et10sm4498279lbc.6.2013.06.23.01.01.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 23 Jun 2013 01:01:03 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UqfIF-0007TI-TK; Sun, 23 Jun 2013 10:05:03 +0200
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228729>

Used only when a clone is initialized. This is useful when the submodule(s)
are huge and you're not really interested in anything but the latest commit.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..b102fa8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -211,12 +211,18 @@ module_clone()
 	name=$2
 	url=$3
 	reference="$4"
+	depth=$5
 	quiet=
 	if test -n "$GIT_QUIET"
 	then
 		quiet=-q
 	fi
 
+	if test -n "$depth"
+	then
+		depth="--depth=$depth"
+	fi
+
 	gitdir=
 	gitdir_base=
 	base_name=$(dirname "$name")
@@ -233,7 +239,7 @@ module_clone()
 		mkdir -p "$gitdir_base"
 		(
 			clear_local_git_env
-			git clone $quiet -n ${reference:+"$reference"} \
+			git clone $quiet $depth -n ${reference:+"$reference"} \
 				--separate-git-dir "$gitdir" "$url" "$sm_path"
 		) ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
@@ -676,6 +682,9 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--depth)
+			depth=$2
+			;;
 		--)
 			shift
 			break
@@ -735,7 +744,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" || exit
+			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
1.8.0
