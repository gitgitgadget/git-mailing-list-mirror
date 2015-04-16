From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] attr: skip UTF8 BOM at the beginning of the input file
Date: Thu, 16 Apr 2015 10:52:54 -0700
Message-ID: <1429206774-10087-4-git-send-email-gitster@pobox.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
 <1429206774-10087-1-git-send-email-gitster@pobox.com>
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 19:53:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YinyU-0006AY-J3
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 19:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbbDPRxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 13:53:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753397AbbDPRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 13:53:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC6664A218;
	Thu, 16 Apr 2015 13:53:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RJda
	JLnpztrnWQpRMCBjNU01J+0=; b=jSfrT/cK8xyjnJc4BiDNqPQ2vuV71SnYInx7
	HWhL6a+Wrk+f4Kb5nbjUS9GA8nWScrLmvcDjH2FvNj8T/W6dPJ1onr35Ww4DjrYc
	2JK1DzHTG7Mat4drGnyVC8G3hB2fdiON96fCaFG3ETDYWZVk6JoLaCUairqU/FJl
	KwXvj3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	cHdF3OXWbZvn7uTyFbdZmHnCX8cAFOHIrhqNXX2gkfKJh9K8dBbrUI5+Kw4MwvsT
	Cc3/f/BVaArrquYM+/ZBIRPig8cBW6s5/B/VG+ldF3JRUltpcI8Vtalw5g+VxGTG
	LDasLimF3b4hLn77JA/TantLtoHJIxkkMFEFkd0mJ4w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4C9C4A217;
	Thu, 16 Apr 2015 13:53:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E39A4A20D;
	Thu, 16 Apr 2015 13:52:59 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc2-171-g98ddf7f
In-Reply-To: <1429206774-10087-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6B78B24C-E461-11E4-8CBF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267316>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index cd54697..7c530f4 100644
--- a/attr.c
+++ b/attr.c
@@ -12,6 +12,7 @@
 #include "exec_cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "utf8.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -369,8 +370,12 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 		return NULL;
 	}
 	res = xcalloc(1, sizeof(*res));
-	while (fgets(buf, sizeof(buf), fp))
-		handle_attr_line(res, buf, path, ++lineno, macro_ok);
+	while (fgets(buf, sizeof(buf), fp)) {
+		char *bufp = buf;
+		if (!lineno)
+			skip_utf8_bom(&bufp, strlen(bufp));
+		handle_attr_line(res, bufp, path, ++lineno, macro_ok);
+	}
 	fclose(fp);
 	return res;
 }
-- 
2.4.0-rc2-171-g98ddf7f
