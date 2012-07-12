From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] date.c: Fix off by one error in object-header date parsing
Date: Thu, 12 Jul 2012 13:50:46 -0700
Message-ID: <7vsjcwael5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 22:50:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpQLf-0006lK-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 22:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824Ab2GLUuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 16:50:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094Ab2GLUut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 16:50:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0ADD8FC3;
	Thu, 12 Jul 2012 16:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	5ddP3u2hOsJAOtAfVyEpNSl1B0=; b=GfvBh8kQvRS+fUOiR4FAZtUYtwENr7Nzp
	AR0+9So3x/cASvw5RuSUW4mDRUWnhvuQsBd7Bni9TygJgeMg7sUfRl6ZelGiLq1s
	EdcULk9dUJrUMSVuiLH6CqAX3QtoZuNphpj2UyPgppoENf0kLUPTQqekzKGSOmYq
	OSyCqkOp/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=bin
	XfTCTzURZeQjn/Hs02BInkqxJfWTl70QNpg2BhqKWdhwWWT3RiHva/7CT/sEW7a+
	lcOUbb3NF2Y958CtH5DrDFW+ctUIh3x/DlOsLxEQ3zaqOdInQSw7nYsOb7Jm+jtT
	SuyaDwq/uhS3u/EIjdIeXLZXmvkiltfmRfpK9n8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE6178FC2;
	Thu, 12 Jul 2012 16:50:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2603F8FC1; Thu, 12 Jul 2012
 16:50:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4228E060-CC63-11E1-ABCC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201380>

It is perfectly OK for a valid decimal integer to begin with '9' but
116eb3a (parse_date(): allow ancient git-timestamp, 2012-02-02) did
not express the range correctly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/date.c b/date.c
index bf8e088..67b3d66 100644
--- a/date.c
+++ b/date.c
@@ -595,7 +595,7 @@ static int match_object_header_date(const char *date, unsigned long *timestamp,
 	unsigned long stamp;
 	int ofs;
 
-	if (*date < '0' || '9' <= *date)
+	if (*date < '0' || '9' < *date)
 		return -1;
 	stamp = strtoul(date, &end, 10);
 	if (*end != ' ' || stamp == ULONG_MAX || (end[1] != '+' && end[1] != '-'))
-- 
1.7.11.2
