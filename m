From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] pager: lose a separate argv[]
Date: Wed, 17 Feb 2016 11:15:14 -0800
Message-ID: <1455736516-13466-2-git-send-email-gitster@pobox.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
 <1455736516-13466-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 20:15:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7ZY-0001dP-I7
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbcBQTP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:15:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423725AbcBQTPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:15:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A44D8423E2;
	Wed, 17 Feb 2016 14:15:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gZ2X
	UlIGwz258yDj9bumXyJpXz4=; b=TTjGhikPxcK83SnfApwccQN0aKzdWOmKWSQ+
	e47RsELaM8Jv+vrYeTXbRwZRgkzpuaM/o1kGIAziv8wD8xybtZw75surGD3t7QT9
	W3kWYD3YXwHLp7ByC2kOBE6kdKfD75Uqsavt6FVe7VLfOkHyvL4kEziyyLqoIlUd
	QjmyFiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Nu2LsDX20Q/PE4lnwrgNUyZmZr4LmZn3yyynNWDIyNoh1+Qnc45SyPhGKRZbZLJx
	7iqnZM8mZj7KXY854mps34y2vezfkXI9BeEhXaNf6/iZ+vUyoEEpaubB5hfWd/Nn
	gWgQSEv66kBwAunOymh0BsDO80leTAaw7OpdX6W9SWE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C22A423DD;
	Wed, 17 Feb 2016 14:15:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 223C5423DC;
	Wed, 17 Feb 2016 14:15:19 -0500 (EST)
X-Mailer: git-send-email 2.7.1-489-g20b2cbe
In-Reply-To: <1455736516-13466-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C89CDBB6-D5AA-11E5-AFB6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286536>

These days, using the embedded args array in the child_process
structure is the norm.  Follow that practice.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Same as v1

 pager.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/pager.c b/pager.c
index 070dc11..5dbcc5a 100644
--- a/pager.c
+++ b/pager.c
@@ -11,7 +11,6 @@
  * something different on Windows.
  */
 
-static const char *pager_argv[] = { NULL, NULL };
 static struct child_process pager_process = CHILD_PROCESS_INIT;
 
 static void wait_for_pager(void)
@@ -70,9 +69,8 @@ void setup_pager(void)
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 
 	/* spawn the pager */
-	pager_argv[0] = pager;
+	argv_array_push(&pager_process.args, pager);
 	pager_process.use_shell = 1;
-	pager_process.argv = pager_argv;
 	pager_process.in = -1;
 	if (!getenv("LESS"))
 		argv_array_push(&pager_process.env_array, "LESS=FRX");
-- 
2.7.1-489-g20b2cbe
