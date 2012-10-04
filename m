From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] log --grep: honor grep.patterntype etc. configuration
 variables
Date: Wed,  3 Oct 2012 18:33:39 -0700
Message-ID: <1349314419-8397-7-git-send-email-gitster@pobox.com>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:56:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtN2-0001DP-RV
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab2JDBeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:34:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194Ab2JDBdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:33:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 201168082
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5FvR
	xgJKKNilk6+KPClRSMoqWYA=; b=bohXNndgPJgUg1apYB17qHHFNnC4l3nERSk+
	U4JFo4FYpv7GWjQHZ0Dtezrji534tG/KUFiO4XFGdh0PqJ2zlL2H4oNniJkzB91l
	RnknlwCpXnGYObKT43pMyhHjB5JaCEViFh6L9s/aJoZDalKyLO7zWyyLelsn9ouT
	1w8AOWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wdzpRT
	neqW4JadECsx39WQqvMEWiLLgY2/mx67ZsCgv6SNgwwSey/NGm3IwbX1mnwpnp/6
	y0sMhlnTeS5NXrajn9dQJ7SsbI/DMwMIda2gOmivgt9pvNa3QnVQZqDZWszMK+80
	ALVHLMEHq23j8Mw/VstSQTowRn7X8MYIVpgJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6788081
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7994E8080 for
 <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:53 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.57.g712528f
In-Reply-To: <1349314419-8397-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8E7F7FAE-0DC3-11E2-8EAF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206942>

Read grep.extendedregexp, grep.patterntype, etc. from the
configuration so that "log --grep='<pcre>'" honors the user
preference without an explicit -P from the command line.

Now that the callback parameter, which was so far unused, to
git_log_config() has to be of type "struct rev_info *", stop passing
it down to git_diff_ui_config().  The latter does not currently take
any callback parameter, and when it does, we would need to make a
structure that has rev info and that parameter and pass it to
git_log_config() anyway, and until that happens, passing NULL will
be less error prone.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 07a0078..a38a6dd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -329,6 +329,8 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value, void *cb)
 {
+	struct rev_info *revs = cb;
+
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
@@ -352,7 +354,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
 
-	return git_diff_ui_config(var, value, cb);
+	grep_config(var, value, &revs->grep_filter);
+	return git_diff_ui_config(var, value, NULL);
 }
 
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
-- 
1.8.0.rc0.57.g712528f
