From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/17] grep: read -f file with strbuf_gets()
Date: Wed, 28 Oct 2015 15:26:00 -0700
Message-ID: <1446071161-15610-17-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZHf-0000HY-H0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbbJ1Wd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:26 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753217AbbJ1WdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:25 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2015 18:33:24 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED36126A59;
	Wed, 28 Oct 2015 18:26:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qP4q
	mZ+mwsyKcCzRE4gjmmMoT4s=; b=QiFWq/TV+tmbTSooLTtflDWVLA4tIX0fksY/
	7HeKsOui4slwtN0IGBFGXq2Adcq/OdIBuz4XLDi18TiSgTwtpOykoVL9y4vKNc4h
	gBpXAA4gUQo69QM0jXaTViLeIB8Kggzodz34nkCi0tiV+1hL1An17ovtIPaeNk4R
	Ubij6Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JNgI3j
	ln272Fw5u/20eJ8nuD1lq7wv28XI0nMLd1zgbRplgrCuBwsEaEzlzuMmy/PzipNB
	x9HLrl30IcXzrmaNxBmG9TEK25P7dlurHwVj5nPUee+W/05/s2IKT/1WVaOmJHN+
	vi+wHI1QiHRxSdWqHiidF1hmct+Vb1JRFU85U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6D3626A58;
	Wed, 28 Oct 2015 18:26:26 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 740DF26A57;
	Wed, 28 Oct 2015 18:26:26 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ED690068-7DC2-11E5-8D5B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280400>

List of patterns file could come from a DOS editor.

This is iffy; you may actually be trying to find a line with ^M in
it on a system whose line ending is LF.  You can of course work it
around by having a line that has "^M^M^J", let the strbuf_gets() eat
the last "^M^J", leaving just the single "^M" as the pattern.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..ac27690 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -562,7 +562,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
-	while (strbuf_getline(&sb, patterns, '\n') == 0) {
+	while (strbuf_gets(&sb, patterns) == 0) {
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
 			continue;
-- 
2.6.2-423-g5314b62
