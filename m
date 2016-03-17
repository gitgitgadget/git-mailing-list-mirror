From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] pretty-print: further abstract out pp_handle_indent()
Date: Thu, 17 Mar 2016 16:15:50 -0700
Message-ID: <xmqqshzoy9uh.fsf_-_@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	<xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:16:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agh9G-00027s-QW
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbcCQXP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 19:15:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030836AbcCQXPx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 19:15:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10A974CC9F;
	Thu, 17 Mar 2016 19:15:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oBfyZD2R1h2bXQ5NZJ+iKbDwv2A=; b=daqo1+
	+FmGv/cbQT1gLc7KTfveHT23PmLVy56xP0UsxvgSzM9W350TLSdYLbXAMewVRt9e
	VSyxPtwyBpAMcu9k88ETpMCZTSLuGzs++dix5NP42WakV0jI5t2zm+B+LAteGQ1+
	wAlz/3+V9gRD/SrHTxNgok6ZkubulHgPTTlEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iMaOMG1Ac8fcNBgpgqXtLtaeI7wL0hFW
	zxfYQfG5qrQaKkmcxNuMVG8kgdk2DPi7rUkbDkmN83kwKGnIYblSAzsOjjMawQwj
	Y1vCVVc7IKiykNYetKg2Wq3lHps7INU9yd/h5KXDQh4IPkoYj729XyyKfhdNQ9Kz
	2myDT34+/wI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F16E24CC9E;
	Thu, 17 Mar 2016 19:15:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4C7294CC9D;
	Thu, 17 Mar 2016 19:15:51 -0400 (EDT)
In-Reply-To: <xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Thu, 17 Mar 2016 16:13:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30D64440-EC96-11E5-A328-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289168>

Separate the call to add 4-space indent, and a new helper to add a
line after de-tabifying.

The new helper function strbuf_add_tabexpand() could later be moved
to strbuf.[ch] if other callers need to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6d657fc..717ceed 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1643,18 +1643,12 @@ static int pp_utf8_width(const char *start, const char *end)
 	return width;
 }
 
-/*
- * pp_handle_indent() prints out the intendation, and
- * the whole line (without the final newline), after
- * de-tabifying.
- */
-static void pp_handle_indent(struct strbuf *sb, int indent,
-			     const char *line, int linelen)
+
+static void strbuf_add_tabexpand(struct strbuf *sb,
+				 const char *line, int linelen)
 {
 	const char *tab;
 
-	strbuf_addchars(sb, ' ', indent);
-
 	while ((tab = memchr(line, '\t', linelen)) != NULL) {
 		int width = pp_utf8_width(line, tab);
 
@@ -1686,6 +1680,18 @@ static void pp_handle_indent(struct strbuf *sb, int indent,
 	strbuf_add(sb, line, linelen);
 }
 
+/*
+ * pp_handle_indent() prints out the intendation, and
+ * the whole line (without the final newline), after
+ * de-tabifying.
+ */
+static void pp_handle_indent(struct strbuf *sb, int indent,
+			     const char *line, int linelen)
+{
+	strbuf_addchars(sb, ' ', indent);
+	strbuf_add_tabexpand(sb, line, linelen);
+}
+
 void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
-- 
2.8.0-rc3-175-g64dcf62
