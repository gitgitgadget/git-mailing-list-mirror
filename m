From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/3] contrib/hooks: add an example pre-auto-gc hook
Date: Wed, 2 Apr 2008 22:22:21 +0200
Message-ID: <96017502f7bca67a14f9a09d19c8ea42bde78949.1207167342.git.vmiklos@frugalware.org>
References: <cover.1207049697.git.vmiklos@frugalware.org> <7vhceldv12.fsf@gitster.siamese.dyndns.org> <20080402011447.GO3264@genesis.frugalware.org> <7vwsngaoqg.fsf@gitster.siamese.dyndns.org> <20080402190240.GV3264@genesis.frugalware.org> <7vtzik848t.fsf@gitster.siamese.dyndns.org> <cover.1207164676.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 22:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh9Uz-0002ax-8c
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 22:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763069AbYDBUWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 16:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763034AbYDBUW3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 16:22:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:25226 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763046AbYDBUW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 16:22:27 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 191A21B25C4;
	Wed,  2 Apr 2008 22:22:26 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AE71944696;
	Wed,  2 Apr 2008 22:19:10 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 619F01190543; Wed,  2 Apr 2008 22:22:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5jg82b7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78713>

It disables git-gc --auto when you are running Linux and you are on
battery.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Apr 02, 2008 at 12:49:32PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>
> > +if test -x /sbin/on_ac_power && /sbin/on_ac_power
> > +then
> > +   /sbin/on_ac_power
> > +   if [ $? = 1 ]; then
> > +           exit 0
> > +   fi
>
> Shouldn't the above be:
>
>       if test -x /sbin/on_ac_power && /sbin/on_ac_power
>         then
>               exit 0
>
> That is, you checked if you have the command to check
> on-ac-power-ness,
> and the command says yes, so you happily let "gc --auto" do its thing.

Hm, I must be crazy when I wrote this. It has three exit codes:

0 if on AC power
1 if not on AC power
255 if can't tell

So IMHO the right think to do is to check if the return value is != 1,
and if that's true, then do an exit 0.

Here is try4.

 contrib/hooks/pre-auto-gc-battery |   40 +++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/pre-auto-gc-battery

diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
new file mode 100644
index 0000000..c6af057
--- /dev/null
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -0,0 +1,40 @@
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
+if test -x /sbin/on_ac_power
+then
+	/sbin/on_ac_power
+	if test $? -ne 1
+	then
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
