From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/3] contrib/hooks: add an example pre-auto-gc hook
Date: Wed, 2 Apr 2008 21:35:11 +0200
Message-ID: <502492c60a58bdf409b3f6400da25f4a9a97463d.1207164676.git.vmiklos@frugalware.org>
References: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8kw-00017y-HO
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084AbYDBTf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757979AbYDBTf3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:35:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:24903 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757894AbYDBTfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:35:12 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 60DC71B25AC;
	Wed,  2 Apr 2008 21:35:11 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7AB71446A7;
	Wed,  2 Apr 2008 21:32:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3D6CE1190A16; Wed,  2 Apr 2008 21:35:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzik848t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78708>

It disables git-gc --auto when you are running Linux and you are on
battery.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hooks/pre-auto-gc-battery |   39 +++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/pre-auto-gc-battery

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
new file mode 100644
index 0000000..0084a1f
--- /dev/null
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# An example hook script to verify if you are on battery, in case you
+# are running Linux. Called by git-gc --auto with no arguments. The hook
+# should exit with non-zero status after issuing an appropriate message
+# if it wants to stop the auto repacking.
+#
+# This hook is stored in the contrib/hooks directory. Your distribution
+# may have put this somewhere else. If you want to use this hook, you
+# should make this script executable then link to it in the repository
+# you would like to use it in.
+#
+# For example, if the hook is stored in
+# /usr/share/git-core/contrib/hooks/pre-auto-gc-battery:
+#
+# chmod a+x pre-auto-gc-battery
+# cd /path/to/your/repository.git
+# ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
+#	hooks/pre-auto-gc
+
+if test -x /sbin/on_ac_power && /sbin/on_ac_power
+then
+	/sbin/on_ac_power
+	if [ $? = 1 ]; then
+		exit 0
+	fi
+elif test "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = 1
+then
+	exit 0
+elif grep -q 'on-line' /proc/acpi/ac_adapter/AC/state 2>/dev/null
+then
+	exit 0
+elif grep -q '0x01$' /proc/apm 2>/dev/null
+then
+	exit 0
+fi
+
+echo "Auto packing deferred; on battery"
+exit 1
-- 
1.5.5.rc2.4.gec07.dirty
