From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] wt-status: extract the code to compute width for labels
Date: Wed, 12 Mar 2014 14:19:32 -0700
Message-ID: <1394659174-9143-3-git-send-email-gitster@pobox.com>
References: <1394659174-9143-1-git-send-email-gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqZB-00023o-UK
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbaCLVTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:19:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbaCLVTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:19:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6DB7497A;
	Wed, 12 Mar 2014 17:19:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0Tu5
	Oi07pK1aBzKjfDZZ8IjKa5A=; b=x+o6hys/qk+3vixEhEuvJOvs7mF97b8rSvqn
	cC+WiEVZP+b0q3JyTMQWnJFrfN22ApZ9FUrsBxKsP19x4VCBGLnuW9ZxZ++JJA3c
	w09TxVs4ZNODkRSDFN51toQ+a2iX04i2o8X1mXpm9FaXVAccSGkLanY5PpeaSkdM
	Sk3sLsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	kLhYzUi0Ifi9VnLzv4wS6+BrvRcmv132bq1JK33Ml5wO6j2DjIYNxslDHy+7h9tp
	HOXMj5z7j9OoRvUIqO79lqw0f7jKMUHxGo6BXZ4a9fSWuMaV3TCGzksyEx+7atVC
	UgzgjVC7288Vd8b1PPDQft/tcHdi5L+/tZUIYV2GqCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A351074979;
	Wed, 12 Mar 2014 17:19:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1A7174977;
	Wed, 12 Mar 2014 17:19:40 -0400 (EDT)
X-Mailer: git-send-email 1.9.0-293-gd838d6f
In-Reply-To: <1394659174-9143-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 060D1A80-AA2C-11E3-9D8E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243998>

From: Jonathan Nieder <jrnieder@gmail.com>

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Thu, 19 Dec 2013 11:43:19 -0800

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9cf7028..db98c52 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -292,6 +292,19 @@ static const char *wt_status_diff_status_string(int status)
 	}
 }
 
+static int maxwidth(const char *(*label)(int), int minval, int maxval)
+{
+	int result = 0, i;
+
+	for (i = minval; i <= maxval; i++) {
+		const char *s = label(i);
+		int len = s ? utf8_strwidth(s) : 0;
+		if (len > result)
+			result = len;
+	}
+	return result;
+}
+
 static void wt_status_print_change_data(struct wt_status *s,
 					int change_type,
 					struct string_list_item *it)
@@ -310,13 +323,8 @@ static void wt_status_print_change_data(struct wt_status *s,
 	int len;
 
 	if (!padding) {
-		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
-		for (status = 'A'; status <= 'Z'; status++) {
-			what = wt_status_diff_status_string(status);
-			len = what ? strlen(what) : 0;
-			if (len > label_width)
-				label_width = len;
-		}
+		/* If DIFF_STATUS_* uses outside the range [A..Z], we're in trouble */
+		label_width = maxwidth(wt_status_diff_status_string, 'A', 'Z');
 		label_width += strlen(" ");
 		padding = xmallocz(label_width);
 		memset(padding, ' ', label_width);
-- 
1.9.0-293-gd838d6f
