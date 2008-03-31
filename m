From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/4] templates: add an example pre-auto-gc hook
Date: Mon, 31 Mar 2008 11:37:22 +0200
Message-ID: <283c63fb960d36a322b45fac97804af18a9e5abe.1206929014.git.vmiklos@frugalware.org>
References: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 11:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgGSw-00039g-GL
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 11:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbYCaJhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 05:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbYCaJhZ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 05:37:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:11278 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437AbYCaJhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 05:37:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 400B61B2586;
	Mon, 31 Mar 2008 11:37:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A433E44698;
	Mon, 31 Mar 2008 11:34:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B86661190547; Mon, 31 Mar 2008 11:37:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78578>

It disabled git-gc --auto when you are on battery.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 templates/hooks--pre-auto-gc |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 templates/hooks--pre-auto-gc

diff --git a/templates/hooks--pre-auto-gc b/templates/hooks--pre-auto-gc
new file mode 100644
index 0000000..40c4759
--- /dev/null
+++ b/templates/hooks--pre-auto-gc
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# An example hook script to verify if you are on battery.  Called by
+# git-gc --auto with no arguments.  The hook should exit with non-zero
+# status after issuing an appropriate message if it wants to stop the
+# auto repacking.
+#
+# To enable this hook, make this file executable.
+
+defer=0
+
+if [ -e /sys/class/power_supply/AC/online ]; then
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
1.5.5.rc2.4.g283c6
