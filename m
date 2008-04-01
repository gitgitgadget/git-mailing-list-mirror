From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/4] contrib/hooks: add an example pre-auto-gc hook
Date: Tue, 1 Apr 2008 13:39:59 +0200
Message-ID: <52c671c64b2f203793ee88a84fee6f83cba2a4ff.1207049697.git.vmiklos@frugalware.org>
References: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgerg-0002SX-GR
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 13:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758735AbYDALkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 07:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758722AbYDALkD
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 07:40:03 -0400
Received: from virgo.iok.hu ([193.202.89.103]:18411 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757420AbYDALkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 07:40:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AAE911B25A3;
	Tue,  1 Apr 2008 13:39:59 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 45AAA44659;
	Tue,  1 Apr 2008 13:36:50 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8B89B1190A3B; Tue,  1 Apr 2008 13:39:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78650>

It disables git-gc --auto when you are running Linux and you are on
battery.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hooks/pre-auto-gc-battery |   45 +++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/pre-auto-gc-battery

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
new file mode 100644
index 0000000..4077111
--- /dev/null
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# An example hook script to verify if you are on battery, in case you
+# are running Linux. Called by git-gc --auto with no arguments. The hook
+# should exit with non-zero status after issuing an appropriate message
+# if it wants to stop the auto repacking.
+#
+# This hook is stored in the contrib/hooks directory. Your distribution
+# will have put this somewhere standard. You should make this script
+# executable then link to it in the repository you would like to use it
+# in.
+#
+# For example, if the hook is stored in
+# /usr/share/git-core/contrib/hooks/pre-auto-gc-battery:
+#
+# chmod a+x pre-auto-gc-battery
+# cd /path/to/your/repository.git
+# ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
+#	hooks/pre-auto-gc-battery
+
+defer=0
+
+if [ -e /sbin/on_ac_power ]; then
+	/sbin/on_ac_power
+	if [ $? = 1 ]; then
+		defer = 1
+	fi
+elif [ -e /sys/class/power_supply/AC/online ]; then
+	if [ "`cat /sys/class/power_supply/AC/online`" = 0 ]; then
+		defer=1
+	fi
+elif [ -e /proc/acpi/ac_adapter/AC/state ]; then
+	if grep -q 'off-line' /proc/acpi/ac_adapter/AC/state; then
+		defer=1
+	fi
+elif [ -e /proc/apm ]; then
+	if grep -q '0$' /proc/apm; then
+		defer=1
+	fi
+fi
+
+if [ "$defer" = 1 ]; then
+	echo "Auto packing deferred; on battery"
+	exit 1
+fi
-- 
1.5.5.rc2.4.gec07.dirty
