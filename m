From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-remote rename: support branches->config
 migration
Date: Tue, 11 Nov 2008 20:22:38 -0800
Message-ID: <7viqqtshdd.fsf@gitster.siamese.dyndns.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226349595.git.vmiklos@frugalware.org> <033bc63195299e494791e4e6d8a41f142d848bba.1226349595.git.vmiklos@frugalware.org> <cover.1226349595.git.vmiklos@frugalware.org> <b32cf68df41e417079a49dc02e46ffc0c571029b.1226349595.git.vmiklos@frugalware.org> <7v63mtvkdx.fsf@gitster.siamese.dyndns.org> <20081112020158.GK24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 05:24:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L07HY-0002Tp-Vm
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 05:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYKLEXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 23:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYKLEXY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 23:23:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYKLEXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 23:23:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78BAB7C609;
	Tue, 11 Nov 2008 23:23:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D8597C5FD; Tue,
 11 Nov 2008 23:22:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A27C2BAA-B071-11DD-A63B-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100714>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Nov 11, 2008 at 04:49:14PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> There is something fishy going on between 2/4 and 3/4.  2/4 was advertised
>> to migrate remotes to config and had a call to migrate_file() for that
>> purpose.  Here this one now allows to convert branches but there is no
>> change to the callsite of migrate_file().
>> 
>> Which would mean that 2/4 would convert branches/foo too.  And this one is
>> only to remove the leftover branches/foo file.
>> 
>> Or am I utterly confused?
>
> The trick is that 2/4 already added support for remotes/foo as it uses
> remote_get() and that detects remotes/foo as well, but that is
> completely unintentional.

That is not a trick; it merely is a broken code.

The function migrate_file() introduced by [2/4] is called for any remote
definition that did not come from config (by definition, it either came
from remotes/foo or branches/foo).  The function adds the entries for the
given remote definition to the config file, and then removes remotes/foo
file if the remote definition came from it.  So it is a logically
consistent change if you only called this function only for remote
definitions that came from remotes/foo.

But the function is called for a remote definition that originally came
from branches/foo as well.  It happily adds the definition to the config,
even though it *fails to remove* branches/foo file.

Do you still think 2/4 is a logically contained good change?

If you apply this to 5505 (taken from 3/4, but removing the check for
branches/origin file), and look at resulting t/trash*/six/.git/config
file, you will see you have already migrated the remote definition to the
config.

diff --git i/t/t5505-remote.sh w/t/t5505-remote.sh
index 1567631..60bb9e5 100755
--- i/t/t5505-remote.sh
+++ w/t/t5505-remote.sh
@@ -364,4 +364,15 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
 '
 
-test_done
+test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
+	git clone one six &&
+	origin_url=$(pwd)/one &&
+	(cd six &&
+	 git remote rm origin &&
+	 echo "$origin_url" > .git/branches/origin &&
+	 git remote rename origin origin &&
+	 test "$(git config remote.origin.url)" = "$origin_url" &&
+	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
+'
+
+: test_done
