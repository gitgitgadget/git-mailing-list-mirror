From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: fix misdirected redirections
Date: Tue, 05 Apr 2016 00:02:14 -0700
Message-ID: <xmqqshz035e1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 09:02:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anL0K-0001bY-Tl
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 09:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbcDEHCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 03:02:17 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753938AbcDEHCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 03:02:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04B814B68C;
	Tue,  5 Apr 2016 03:02:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	+nItXUh5CCjVVtC9UcTHBunww0=; b=n4Sf/HMnfRoehvG305BozGQB/GSCQXKei
	znvSIBYrMiIs6GIsaieIP06i2l8GHKbMbeSImLrcLY8ZQLRu/w7G5/cLlwR3XeE0
	mpGmaoJbVBodOWzg4fc8S/73r50uAYjLaxRt1D5M+fQMmaAhiksrkG0HtB3p3PHT
	FcQKzBfeLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=odC
	TnjlY9fi2TICVBawM2i22c/f1jxfJC8XAuZ8sOjuDIeRSoMbtWI/7nhuffx7iOVC
	7FT2LPOI2AF6GWGQhCncz0sZi+KlEvm3en6XyW+6H2ZD1V+kXiN+Doule3vCAv1T
	SI+xznoEPNNuppL4ZFTqeqQdEPaeXw/tNXSwlivY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF05B4B68B;
	Tue,  5 Apr 2016 03:02:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 725514B68A;
	Tue,  5 Apr 2016 03:02:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5420A5A2-FAFC-11E5-A4F3-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290766>

In general "echo 2>&1 $msg" to redirect a possible error message
that comes from 'echo' itself into the same standard output stream
$msg is getting written to does not make any sense; it is not like
we are expecting to see any errors out of 'echo' in these statements,
and even if it were the case, there is no reason to prevent the
error messages from being sent to the standard error stream.

These are clearly meant to send the argument given to echo to the
standard error stream as error messages.  Correctly redirect by
saying "send what is written to the standard output to the standard
error", i.e. "1>&2" aka ">&2".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There are two more uses of 2>&1 in the Makefile, and they are
   correct.

   - The one in dep_check one is used as

       dep_check = $(shell ... 2>&1; echo $$?)

     and it is an attempt to make sure that anything sent to the
     standard error is not leaked out of the shell substitution.  It
     does want to send whatever is written to the standard error
     instead written to the standard output.

   - The other is "cmp ... >/dev/null 2>&1", which is a typical way
     to squelch both the standard output and the standard error for
     any command.

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8700db8..296f175 100644
--- a/Makefile
+++ b/Makefile
@@ -2211,10 +2211,10 @@ sparse: $(SP_OBJ)
 check: common-cmds.h
 	@if sparse; \
 	then \
-		echo 2>&1 "Use 'make sparse' instead"; \
+		echo >&2 "Use 'make sparse' instead"; \
 		$(MAKE) --no-print-directory sparse; \
 	else \
-		echo 2>&1 "Did you mean 'make test'?"; \
+		echo >&2 "Did you mean 'make test'?"; \
 		exit 1; \
 	fi
 
