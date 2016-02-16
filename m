From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] am -i: fix "v"iew
Date: Tue, 16 Feb 2016 15:06:57 -0800
Message-ID: <1455664017-27588-4-git-send-email-gitster@pobox.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:07:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoiC-00057H-88
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbcBPXHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:07:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756334AbcBPXHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:07:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8B50453BC;
	Tue, 16 Feb 2016 18:07:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MYD6
	es6TyHvRu8T0l28wkWOy6t4=; b=DF2K0tTx12AwphPDDcUeAghOuvHXfNyYqVSc
	hLVHlxzSG14WnRi9g0VzTRTX1CySKVc7tU9OgeHQtUAvVUFPGNx/2hgUwMhIVCue
	v/R8a8fUY7D4MzPtsOW5xPzgO2LR2YFnFTkeIMLLqFei1WEXhlTD1N0mDKcx7Bo8
	wuwnLSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	BhAvwOeX/oxo/A+lOu7mythx12r9SP7tvNfx5Q0TNY7HX6cX5FStWEbr8g5PDd6n
	P/NOaktqLU3TIz7viaQu2v/MrY7M4fhauBk2VgCJlhjskgeXGOVRlPZcFYnKfWHL
	V7eKBmG8aGbaqlEDxB4C2STA4W+bEYNs98vDcTxo6co=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B14D9453BB;
	Tue, 16 Feb 2016 18:07:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2033C453BA;
	Tue, 16 Feb 2016 18:07:04 -0500 (EST)
X-Mailer: git-send-email 2.7.1-460-gd45d0a4
In-Reply-To: <1455664017-27588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FE37EE5E-D501-11E5-A6D2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286451>

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
 builtin/am.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1399c8d..aecf917 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1740,8 +1740,9 @@ static int do_interactive(struct am_state *state)
 
 			if (!pager)
 				pager = "cat";
-			argv_array_push(&cp.args, pager);
-			argv_array_push(&cp.args, am_path(state, "patch"));
+
+			prepare_pager_args(&cp, pager,
+					   am_path(state, "patch"), NULL);
 			run_command(&cp);
 		}
 	}
-- 
2.7.1-460-gd45d0a4
