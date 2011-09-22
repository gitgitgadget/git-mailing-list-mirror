From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] branch: add read_branch_desc() helper function
Date: Thu, 22 Sep 2011 15:09:17 -0700
Message-ID: <1316729362-7714-2-git-send-email-gitster@pobox.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:09:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rSW-0007F1-5E
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab1IVWJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:09:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955Ab1IVWJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:09:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62D9F6ECB
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fHEI
	2A+24mqT9424Z/PrscXMU6Y=; b=x40cz8jdVYpaKmao9nLbz+jrUPTCtwEKj36B
	BerI1OQkUQY6PPRaVvgJVY/OGlRcnH+xGMWBH8RFbPDaFMOITWdsFs3XJeSHero5
	CmiDXFKcpdIW5UPjI5Xvar9cdYysD17rDkzBY9xzw+Cqs6/eKar4Avc4SH1S9P0O
	BWIkcYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=EP3xHR
	f/x3thMXNJjWA9Fzk3YedtqwcSndkzd5lflCa6sa8dqIPvP7OjeDqVL5d9WY3EqD
	xptcdl9Ga6Y0KC3KdNzUMihv9CXiQo9NHiSTYJBGJ25tFWK/W932mbJlfzDVaP4I
	zn9+VAGDXiWZ5AJm3/PMr4AOc+rLQxvh8HpY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AFA66ECA
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEBBD6EC9 for
 <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82
In-Reply-To: <1316729362-7714-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 88B72C1E-E567-11E0-A6BA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181923>

This will be used by various callers that make use of the branch
description throughout the system, so that if we need to update
the implementation the callers do not have to be modified.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c |   31 +++++++++++++++++++++++++++++++
 branch.h |    5 +++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/branch.c b/branch.c
index fecedd3..88da275 100644
--- a/branch.c
+++ b/branch.c
@@ -135,6 +135,37 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
 	return 0;
 }
 
+struct branch_desc_cb {
+	const char *config_name;
+	const char *value;
+};
+
+static int read_branch_desc_cb(const char *var, const char *value, void *cb)
+{
+	struct branch_desc_cb *desc = cb;
+	if (strcmp(desc->config_name, var))
+		return 0;
+	free((char *)desc->value);
+	return git_config_string(&desc->value, var, value);
+}
+
+int read_branch_desc(struct strbuf *buf, const char *branch_name)
+{
+	struct branch_desc_cb cb;
+	struct strbuf name = STRBUF_INIT;
+	strbuf_addf(&name, "branch.%s.description", branch_name);
+	cb.config_name = name.buf;
+	cb.value = NULL;
+	if (git_config(read_branch_desc_cb, &cb)) {
+		strbuf_release(&name);
+		return -1;
+	}
+	if (cb.value)
+		strbuf_addstr(buf, cb.value);
+	strbuf_release(&name);
+	return 0;
+}
+
 int validate_new_branchname(const char *name, struct strbuf *ref,
 			    int force, int attr_only)
 {
diff --git a/branch.h b/branch.h
index 1285158..1493f73 100644
--- a/branch.h
+++ b/branch.h
@@ -46,4 +46,9 @@ void remove_branch_state(void);
 #define BRANCH_CONFIG_VERBOSE 01
 extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
 
+/*
+ * Read branch description
+ */
+extern int read_branch_desc(struct strbuf *, const char *branch_name);
+
 #endif
-- 
1.7.7.rc2.4.g5ec82
