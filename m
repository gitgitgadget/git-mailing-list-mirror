From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] deprecate core.statinfo at Git 2.0 boundary
Date: Mon, 06 May 2013 22:31:10 -0700
Message-ID: <7v1u9jnyox.fsf_-_@alter.siamese.dyndns.org>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
	<1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
	<20130506232242.GA27393@sigill.intra.peff.net>
	<7va9o7o0dl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 07 07:31:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZaUg-0003hZ-V2
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 07:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab3EGFbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 01:31:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab3EGFbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 01:31:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DD2175B0;
	Tue,  7 May 2013 05:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KRuxVTrHHGFsU4lxV79DblcOgzE=; b=aZjyjQ
	bll5GEKYl/Xgqx6fGdZMjkYwvxLZUWZQ8Thyq1E5i35z1oqBSVw5DqWVvcsZJco8
	m4nD3kEbpHD0hrXRoBDiIl7rwLubKDuu7sHHzxcpaFqgqPG6fi104t0rNqlbijXX
	CdeCgDpdQamAJYz0sZY3qq4lP4j3tw16lQ5LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y7USiY4IR0NRuFNOLm7Opb6FF58amVvF
	ft0g3d/2SrEH9a2qf9umriKLLTnSo+LcTx/aoqRGsVNXYAjhkR9cX+ozsR7Y7Se1
	wXyLciC0A6jOuS8Pzw5Rq9dFXAPDzFchQAE7RLX5rIC28iOrTU5xtwc1q6Sl+or9
	zo7+iJfC6w4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B956E175AF;
	Tue,  7 May 2013 05:31:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34FB7175AE;
	Tue,  7 May 2013 05:31:12 +0000 (UTC)
In-Reply-To: <7va9o7o0dl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 May 2013 21:54:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5440CC0E-B6D7-11E2-B9F1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223552>

c08e4d5b5cfa (Enable minimal stat checking, 2013-01-22) advertised
the configuration variable core.checkstat in the documentation and
its log message, but the code expected core.statinfo instead.

For now, add core.checkstat, and warn people who have core.statinfo
in their configuration file that we will remove it in Git 2.0.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index aefd80b..7c55d05 100644
--- a/config.c
+++ b/config.c
@@ -566,7 +566,20 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "core.statinfo")) {
+	if (!strcmp(var, "core.statinfo") ||
+	    !strcmp(var, "core.checkstat")) {
+		/*
+		 * NEEDSWORK: statinfo was a typo in v1.8.2 that has
+		 * never been advertised.  we will remove it at Git
+		 * 2.0 boundary.
+		 */
+		if (!strcmp(var, "core.statinfo")) {
+			static int warned;
+			if (!warned++) {
+				warning("'core.statinfo' will be removed in Git 2.0; "
+					"use 'core.checkstat' instead.");
+			}
+		}
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
