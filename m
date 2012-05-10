From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/8] apply: accept --threeway command line option
Date: Wed,  9 May 2012 23:02:19 -0700
Message-ID: <1336629745-22436-3-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:02:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMSV-00025a-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab2EJGCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:02:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2EJGCb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BC0B5FC5
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0vTp
	9XU2dTF5E0auWGB19UoYDcY=; b=UVJWs7FYWDhrtHrCCBAYgAs1itoFkhtqPNMM
	cEJth7n0EomUDOcIYHbB8UPJAiPUrC/lUZYCBZ2q2J3EAJcnOhM262/sPs3e67UB
	Mc6/E4daXwSRZS1Eu7SvGFXYRJtbOwKYXrW1Lc0si99EiSKpu29uRcQtaQYSyGHg
	cYRYhcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=a6jiqf
	q1Unev68FAG0gNZWmDqOin65Uxt++3wIW6R3pKA1Wcq82pCgmH3B7l/wRsuSsTkY
	AbkkNhh9zx8xW/L3bIP33hcg6Ek9X1h0/pO4+chL8blcokDg/w/gcVATp21CxL9c
	aX4+8hwvs3AOFoOwUYzc+WuBHUfSjtszQeT/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 541915FBF
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA6AD5FBA for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BA7E5D04-9A65-11E1-B44A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197537>

This is the beginning of teaching the three-way merge fallback logic "git
am -3" uses to the underlying "git apply".  It only implements the command
line parsing part, and does not do anything interesting yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fc7f07b..cb6aad5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -46,6 +46,7 @@ static int apply_with_reject;
 static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
+static int threeway;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3024,6 +3025,11 @@ static void prepare_fn_table(struct patch *patch)
 	}
 }
 
+static int try_threeway_fallback(struct image *image, struct patch *patch)
+{
+	return -1; /* for now */
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -3068,7 +3074,8 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 
 	if (apply_fragments(&image, patch) < 0) {
 		/* Note: with --reject, the above call succeeds. */
-		return -1;
+		if (!threeway || try_threeway_fallback(&image, patch) < 0)
+			return -1;
 	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
@@ -3981,6 +3988,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			"apply a patch without touching the working tree"),
 		OPT_BOOLEAN(0, "apply", &force_apply,
 			"also apply the patch (use with --stat/--summary/--check)"),
+		OPT_BOOL(0, "threeway", &threeway,
+			 "attempt three-way merge if a patch does not apply"),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			"build a temporary index based on embedded index information"),
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-- 
1.7.10.1.562.gfc79b1c
