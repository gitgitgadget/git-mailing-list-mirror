From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] pager: lose a separate argv[]
Date: Tue, 16 Feb 2016 15:06:55 -0800
Message-ID: <1455664017-27588-2-git-send-email-gitster@pobox.com>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:07:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVoi4-00050g-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338AbcBPXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:07:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756270AbcBPXHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:07:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09928453B0;
	Tue, 16 Feb 2016 18:07:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=XaCF
	T5zfYwbIFmv6VyPLtXEfoMQ=; b=jtqR1E0K6esXTUOLClwqPBRN2bbpx+3FHxC9
	l70mqI4KXLmyt71MZI5nkT/vjf8cybelU1NNnEC3IWIwy4PhOvpY0h2mEMXEU0Jk
	vYkDDbnyrwcUm7+xY++cNyKQk50ecmakDwV1IP/Xsfk2IySG2GndUSgGQSVZZtk7
	WEvEqes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	QFPcc5QDj7sUVJPOCUcBfogWhZnRgIRVw2gfeea1DM5Q7Myt5C6hqfzD2O+FEkqK
	ntsxI91SceohuiLT35VwhL5GnBaqC1yzoEgYgD/zET+ekHzHwz2Ewyr9mlrv7JUM
	ocectJtz4klKtWI8Gzoc7b582iW0cao3nSgBDIq60KY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E47E6453AF;
	Tue, 16 Feb 2016 18:07:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D5123453AE;
	Tue, 16 Feb 2016 18:07:00 -0500 (EST)
X-Mailer: git-send-email 2.7.1-460-gd45d0a4
In-Reply-To: <1455664017-27588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FC4753B4-D501-11E5-93E0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286449>

These days, using the embedded args array in the child_process
structure is the norm.  Follow that practice.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.7.1-460-gd45d0a4
