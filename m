From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] add pre-auto-gc hook for git-gc --auto (try2)
Date: Tue, 01 Apr 2008 21:02:15 -0700
Message-ID: <7vwsngaoqg.fsf@gitster.siamese.dyndns.org>
References: <cover.1207049697.git.vmiklos@frugalware.org>
 <7vhceldv12.fsf@gitster.siamese.dyndns.org>
 <20080402011447.GO3264@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 06:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JguBu-0001gg-Ky
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 06:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbYDBECc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 00:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbYDBECc
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 00:02:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYDBECb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 00:02:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A26C266A;
	Wed,  2 Apr 2008 00:02:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9AA3F2669; Wed,  2 Apr 2008 00:02:22 -0400 (EDT)
In-Reply-To: <20080402011447.GO3264@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 2 Apr 2008 03:14:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78679>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Ok, let me explain. I think it would be logical to put it to stderr, as
> the other gc --auto messages are there, as well. See the fprintf() in
> cmd_gc().
>
> Though, I don't think it's that important, so I thought if you think
> it's unnecessary, I would not argue for it.

As I made it clear already, I do _not_ think when I kibitz.  *You* think,
convinced others will say "Yeah, that's a good idea", I get convinced and
the patch is applied.

> So may I put it back? :)

I agree that it makes sense to send the output to standard error for
consistency.  Many existing hooks called from scripted versions of tools
seem to contaminate the standard output, though.  That would be a good
post 1.5.5 clean-up, perhaps.

> Also, is the other parts of the series looks correct?

I do not think we would want empty templates/hooks--pre-gc-auto file.

+#!/bin/sh
+#
+# An example hook script to verify if you are on battery, in case you
+# are running Linux. Called by git-gc --auto with no arguments. The hook
+# should exit with non-zero status after issuing an appropriate message
+# if it wants to stop the auto repacking.
+#
+# This hook is stored in the contrib/hooks directory. Your distribution
+# will have put this somewhere standard. You should make this script

s/will/may/; s/standard/else/; s/You/If you want to use this hook, you/

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

s|\(/pre-auto-gc\)-battery|\1|;

+defer=0
+
+if [ -e /sbin/on_ac_power ]; then
+	/sbin/on_ac_power
+	if [ $? = 1 ]; then
+		defer = 1
+	fi

        if test -x /sbin/on_ac_power && /sbin/on_ac_power
        then
                exit 0

Variable assignment in Bourne shell does not allow SP around '='.

I suspect it would be cleaner to invert the logic and "exit 0" when you
know you are on AC, and fall through and err on the safer side
(i.e. decline) when you cannot tell for certain.  You can lose the
variable defer that way.

+elif [ -e /sys/class/power_supply/AC/online ]; then
+	if [ "`cat /sys/class/power_supply/AC/online`" = 0 ]; then
+		defer=1
+	fi

	elif test "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = 1
	then
        	exit 0

No need to have two separate tests.  I do not know if "= 1" is correct,
though.

+elif [ -e /proc/acpi/ac_adapter/AC/state ]; then
+	if grep -q 'off-line' /proc/acpi/ac_adapter/AC/state; then
+		defer=1
+	fi

	elif grep -q 'on-line' /proc/acpi/ac_adapter/AC/state 2>/dev/null
        then
        	exit 0

Likewise.

+elif [ -e /proc/apm ]; then
+	if grep -q '0$' /proc/apm; then
+		defer=1
+	fi
+fi

	elif grep -q '0x01$' /proc/apm 2>/dev/null
        then
        	exit 0

Likewise.
