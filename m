From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] am -i: fix "v"iew
Date: Wed, 17 Feb 2016 11:15:16 -0800
Message-ID: <1455736516-13466-4-git-send-email-gitster@pobox.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
 <1455736516-13466-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 20:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7dZ-0004yd-5d
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965396AbcBQTTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:19:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423644AbcBQTPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:15:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C17B5423ED;
	Wed, 17 Feb 2016 14:15:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gYyi
	Ug/bNSEtt27rGP6t6Os8Ifw=; b=le2kXml21o3MrXpciZ0QtTc+BznhkGTIc6wB
	ORNvt21+ILmchIu5byN57gHL0mJJ1XX2h2FBOF+538RbrniZRpj8L1XCYeS4x8rH
	NZL6w3+H2yKlJhoLjmGFXGlNRIuJgvuxlpFDxbRTxjq33XZFC4lQTrD3HendYVGU
	vxtE/TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	pII5ShMuUdKFfD5Yi6bcwG/30DWHgi8yq8fqkK9YGuWVQ0FLx2thznF+ftKkDUWQ
	5GIMfV3OTaht3U767HFYWOQFG+khkd58jYXCw0Qi5FljqX3Sf5QJD49GFiGUSFBn
	t/fdMbuAe75Yu0HGF4kjr3Ox6soTOfDHl/vIwWg88/0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2FF1423EC;
	Wed, 17 Feb 2016 14:15:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 335BD423EB;
	Wed, 17 Feb 2016 14:15:22 -0500 (EST)
X-Mailer: git-send-email 2.7.1-489-g20b2cbe
In-Reply-To: <1455736516-13466-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CA71244C-D5AA-11E5-B86C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286540>

The 'v'iew subcommand of the interactive mode of "git am -i" was
broken by the rewrite to C we did at around 2.6.0 timeframe at
7ff26832 (builtin-am: implement -i/--interactive, 2015-08-04); we
used to spawn the pager via the shell, accepting things like

	PAGER='less -S'

in the environment, but the rewrite forgot and tried to directly
spawn a command whose name is the entire string.

The previous refactoring of the new helper function makes it easier
for us to do the right thing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Essentially the same as v1, modulo adjustment for the change in 2/3

 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1399c8d..56cf26e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1740,7 +1740,7 @@ static int do_interactive(struct am_state *state)
 
 			if (!pager)
 				pager = "cat";
-			argv_array_push(&cp.args, pager);
+			prepare_pager_args(&cp, pager);
 			argv_array_push(&cp.args, am_path(state, "patch"));
 			run_command(&cp);
 		}
-- 
2.7.1-489-g20b2cbe
