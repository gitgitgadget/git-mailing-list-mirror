From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] attr: skip UTF8 BOM at the beginning of the input file
Date: Thu, 16 Apr 2015 11:39:08 -0700
Message-ID: <1429209548-32297-5-git-send-email-gitster@pobox.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
 <1429209548-32297-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 20:39:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiohE-00072P-L0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbbDPSj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:39:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754700AbbDPSjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:39:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E1D4A391;
	Thu, 16 Apr 2015 14:39:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RJda
	JLnpztrnWQpRMCBjNU01J+0=; b=u/TJhjYap80nkQZrrQAzQj7xp+bPaaoRp+m7
	x7DnxuGMHI+9GHZPEsn0xAdM8wL9FUFJw3dL1NZhkPrqesOEPsp6SCLDOR6LJiZF
	YpSuEM1z84GdjiWn/TlipI631GCGMOpHH3edAe6p+diQApk4tKzvFXRXMI10GAnI
	TwH7AZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oRCCRO
	SkqvMMNx9OIKZWW8hvcFnyjEc2tx9IRxCSwDGJjNi4w02p3Cy3ZbmTZoy9lj05X/
	CZG84W1vGrWFxHKo+UY95v7fILUEnZNhUbqoCS5cTYwVFK7tYVXIUtFPvoM9xl8Z
	7vRa8auMdQdenve7oZRlXn2Lmi87KQejQVRH8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60F9A4A390;
	Thu, 16 Apr 2015 14:39:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27A7A4A388;
	Thu, 16 Apr 2015 14:39:15 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc2-171-g98ddf7f
In-Reply-To: <1429209548-32297-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E1F6CBCE-E467-11E4-ACB8-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267325>

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
