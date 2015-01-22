From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] apply: detect and mark whitespace errors in context lines when fixing
Date: Thu, 22 Jan 2015 14:58:25 -0800
Message-ID: <1421967505-16879-5-git-send-email-gitster@pobox.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
 <1421967505-16879-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 23:59:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQiI-00083h-Cf
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbbAVW6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:58:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752964AbbAVW6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:58:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 885D23136C;
	Thu, 22 Jan 2015 17:58:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=eBeq
	XwrODpQL6U7OESn1BQl5vcE=; b=RISIf7/3hLc9vWhmHrEkIpyUdHoY66NAv+L2
	tEr26Qkr/LlJB7+McWJvus150v6CUxtJh7gEuFEwJEpvQ4mYRftSMQ6h55yo2weN
	rpwOGfknGVzcrXSHRTrzzptQK/SbsmPcGprnIb/5qrrsb9tEYAIKbWBtC4kbm4Om
	bHbwfrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AXENvv
	8scBh3XtKsxeDfHRSYRbYl+4l0K7j5X87Clcal+8vTDShxxeSu+tkvnNUTar5/ml
	UB1xGjdzlkPMyBaAxcOfzXmbLgu46aK7GvCdYabHRPr40r+uJdjJE7PyOG6wp06e
	mtYSJQha5QB2PBeilHsQhS2Td6aWpRFq2lX5Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 800FB3136B;
	Thu, 22 Jan 2015 17:58:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C25B3134A;
	Thu, 22 Jan 2015 17:58:32 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc1-150-gaf32ea2
In-Reply-To: <1421967505-16879-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 307C8C86-A28A-11E4-B460-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262885>

When the incoming patch has whitespace errors in a common context
line (i.e. a line that is expected to be found and is not modified
by the patch), "apply --whitespace=fix" corrects the whitespace
errors the line has, in addition to the whitespace error on a line
that is updated by the patch.  However, we did not count and report
that we fixed whitespace errors on such lines.

[jc: This is iffy.  What if the whitespace error has been fixed in
the target since the patch was written?  A common context line we
see in the patch has errors, and it matches a line in the target
that has the errors already corrected, resulting in no change, which
we may not want to count after all.  On the other hand, we are
reporting whitespace errors _in_ the incoming patch, so...]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index e895340..a51a1b0 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1606,6 +1606,9 @@ static int parse_fragment(const char *line, unsigned long size,
 			if (!deleted && !added)
 				leading++;
 			trailing++;
+			if (!apply_in_reverse &&
+			    ws_error_action == correct_ws_error)
+				check_whitespace(line, len, patch->ws_rule);
 			break;
 		case '-':
 			if (apply_in_reverse &&
-- 
2.3.0-rc1-116-g84c5016
