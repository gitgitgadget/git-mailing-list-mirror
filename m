From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gittrack.sh accepts invalid branch names
Date: Wed, 20 Apr 2005 15:48:30 -0400
Message-ID: <1114026510.15186.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 20 21:44:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOL7Q-0000bl-CU
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 21:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVDTTsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 15:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVDTTsf
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 15:48:35 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:27308
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261743AbVDTTsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 15:48:32 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 3C242EFF27; Wed, 20 Apr 2005 15:48:30 -0400 (EDT)
To: git <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, Petr and everybody!

gittrack.sh allows abbreviated branch names, e.g. it's possible to run
"git track lin" when there is a branch called "linus".

I believe it's a bug, not a feature.  Please look at this line from
gittrack.sh:

grep -q $(echo -e "^$name\t" | sed 's/\./\\./g') .git/remotes

The result of command expansion is subjected to word splitting, which
means the trailing tab is removed as a space.  So grep doesn't see the
tab.

The way to avoid word splitting would be to quote "$()", but it would
make the shell code too hairy.  I'm not even sure all shells would
interpret "$("$name")" correctly.

So I decided to use tab directly in the sed expression.  I cannot think
of any portable way to avoid grep completely ("q" is a GNU sed
extension, and we want to support BSD, I think), so it's still there,
looking for any output from sed.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/gittrack.sh
+++ b/gittrack.sh
@@ -35,7 +35,7 @@ die () {
 mkdir -p .git/heads
 
 if [ "$name" ]; then
-	grep -q $(echo -e "^$name\t" | sed 's/\./\\./g') .git/remotes || \
+	sed -ne "/^$name\t/p" .git/remotes | grep -q . || \
 		[ -s ".git/heads/$name" ] || \
 		die "unknown branch \"$name\""
 

-- 
Regards,
Pavel Roskin

