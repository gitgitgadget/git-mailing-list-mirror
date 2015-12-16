From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/17] grep: read -f file with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:17 -0800
Message-ID: <1450303398-25900-17-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAs-0001KG-1O
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967096AbbLPWDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967086AbbLPWDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76F63325F3;
	Wed, 16 Dec 2015 17:03:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=veTL
	8bUsfni0NwUqdlTY82SLUao=; b=KGHdZeH910E13hN2SvYnezAIJv1atSbKgTIy
	ca0d8Glxl3OOo4lNuMhWwXHkA7H0I8ABuWzCDNwA1CzYPHyd4QIyWd0XCja2pdWZ
	wYZOpPxf2SahW911pcqz4aFJDHAA4p3jfT882WP85h3a4cwIh5LxWGl15iupqedg
	/vOY0z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tK2iX9
	kgPCf6NB5APW+cO5DuVZwBGOEtp8wpZO5nQdGTLH2ecHLwksdedwNGvgUXxH3+0c
	XEMQxZ8ZQo8go54WPAyMhYGtof3tgwghN5hQTPbvHQqCuGi2OQ59ujGfwESPiRtS
	1tREzF3yiolK1Luy2ibAa4LJnjFS1ZJAkIx3k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EC62325F2;
	Wed, 16 Dec 2015 17:03:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA7EA325F0;
	Wed, 16 Dec 2015 17:03:45 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E0AEE640-A440-11E5-AE16-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282604>

List of patterns file could come from a DOS editor.

This is iffy; you may actually be trying to find a line with ^M in
it on a system whose line ending is LF.  You can of course work it
around by having a line that has "^M^M^J", let the strbuf_getline_crlf() eat
the last "^M^J", leaving just the single "^M" as the pattern.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..df162f1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -562,7 +562,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
-	while (strbuf_getline(&sb, patterns, '\n') == 0) {
+	while (strbuf_getline_crlf(&sb, patterns) == 0) {
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
 			continue;
-- 
2.7.0-rc1-83-ga8b6b9e
