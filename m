From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] wt-status: i18n of section labels
Date: Wed, 12 Mar 2014 14:19:33 -0700
Message-ID: <1394659174-9143-4-git-send-email-gitster@pobox.com>
References: <1394659174-9143-1-git-send-email-gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqZC-00023o-Ep
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbaCLVTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:19:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735AbaCLVTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:19:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B3E7497E;
	Wed, 12 Mar 2014 17:19:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=BVEH
	IQAx/5hddSiSLKqo+KVibsk=; b=GYtrPt6BEfYlDHekWREzJ7d7mswQsFPbewOR
	8xyYPd70pN1VsWn3Og4CYaS7BYDdW0Elgj0WQ+66ae71uAoliSJgm+HuCk5D2bqo
	hr255BwLs/JFbLWuBcjWkujfeypmQhy9opFWsVPrBEpucz8dAmP0ijaxZlaS0xH6
	n8eGuEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	HoAeD52jOWMZ8pzlYzdCkmFGoP3L1DvDCwJ1zjG8kChxSt8ES/Hx4xhD5znveI6b
	g/kHlJ3GGnFLeCyEHSgfBZC0HL21i1aE0EjsBdcpFvPFiVC1ptpIJXK0FdqiCPZC
	6X6SVVYmjkK010XMH93TW0DKOy7HLwJsxPXLpI/Jppw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C21057497D;
	Wed, 12 Mar 2014 17:19:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E239F7497C;
	Wed, 12 Mar 2014 17:19:42 -0400 (EDT)
X-Mailer: git-send-email 1.9.0-293-gd838d6f
In-Reply-To: <1394659174-9143-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0751FECE-AA2C-11E3-828A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243997>

From: Jonathan Nieder <jrnieder@gmail.com>

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Thu, 19 Dec 2013 11:43:19 -0800

The original code assumes that:

 (1) the number of bytes written is the width of a string, so they
     can line up;

 (2) the "how" string is always <= 19 bytes.

Neither of which we should assume.

Using the same approach as the earlier 3651e45c (wt-status: take the
alignment burden off translators, 2013-11-05), compute the necessary
column width to hold the longest label and use that for alignment.

cf. http://bugs.debian.org/725777

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Sandy Carter
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 66 +++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index db98c52..b1b018e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -245,27 +245,26 @@ static void wt_status_print_trailer(struct wt_status *s)
 
 #define quote_path quote_path_relative
 
-static void wt_status_print_unmerged_data(struct wt_status *s,
-					  struct string_list_item *it)
+static const char *wt_status_unmerged_status_string(int stagemask)
 {
-	const char *c = color(WT_STATUS_UNMERGED, s);
-	struct wt_status_change_data *d = it->util;
-	struct strbuf onebuf = STRBUF_INIT;
-	const char *one, *how = _("bug");
-
-	one = quote_path(it->string, s->prefix, &onebuf);
-	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
-	switch (d->stagemask) {
-	case 1: how = _("both deleted:"); break;
-	case 2: how = _("added by us:"); break;
-	case 3: how = _("deleted by them:"); break;
-	case 4: how = _("added by them:"); break;
-	case 5: how = _("deleted by us:"); break;
-	case 6: how = _("both added:"); break;
-	case 7: how = _("both modified:"); break;
+	switch (stagemask) {
+	case 1:
+		return _("both deleted:");
+	case 2:
+		return _("added by us:");
+	case 3:
+		return _("deleted by them:");
+	case 4:
+		return _("added by them:");
+	case 5:
+		return _("deleted by us:");
+	case 6:
+		return _("both added:");
+	case 7:
+		return _("both modified:");
+	default:
+		die(_("bug: unhandled unmerged status %x"), stagemask);
 	}
-	status_printf_more(s, c, "%-20s%s\n", how, one);
-	strbuf_release(&onebuf);
 }
 
 static const char *wt_status_diff_status_string(int status)
@@ -305,6 +304,35 @@ static int maxwidth(const char *(*label)(int), int minval, int maxval)
 	return result;
 }
 
+static void wt_status_print_unmerged_data(struct wt_status *s,
+					  struct string_list_item *it)
+{
+	const char *c = color(WT_STATUS_UNMERGED, s);
+	struct wt_status_change_data *d = it->util;
+	struct strbuf onebuf = STRBUF_INIT;
+	static char *padding;
+	static int label_width;
+	const char *one, *how;
+	int len;
+
+	if (!padding) {
+		label_width = maxwidth(wt_status_unmerged_status_string, 1, 7);
+		label_width += strlen(" ");
+		if (label_width < 20)
+			label_width = 20;
+		padding = xmallocz(label_width);
+		memset(padding, ' ', label_width);
+	}
+
+	one = quote_path(it->string, s->prefix, &onebuf);
+	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
+
+	how = wt_status_unmerged_status_string(d->stagemask);
+	len = label_width - utf8_strwidth(how);
+	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
+	strbuf_release(&onebuf);
+}
+
 static void wt_status_print_change_data(struct wt_status *s,
 					int change_type,
 					struct string_list_item *it)
-- 
1.9.0-293-gd838d6f
