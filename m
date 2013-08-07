From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] fetch: refactor code that prepares a transport
Date: Wed,  7 Aug 2013 16:30:40 -0700
Message-ID: <1375918242-4655-4-git-send-email-gitster@pobox.com>
References: <1375918242-4655-1-git-send-email-gitster@pobox.com>
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 01:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7DCF-0005Nz-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 01:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696Ab3HGXaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 19:30:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933609Ab3HGXaw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 19:30:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1641E37FA0;
	Wed,  7 Aug 2013 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nxay
	uzVGWBRSTUG7luZ8s6TusmE=; b=Qz6wD0/95H8jVVidXLWzGTpeZrC7oN23zDnC
	+N+kG4Ub8yWyYEDwhMt4mwFvvrb/fvieb0iyhdBM/zy9EdixF4kKDM5F7cuBKxo1
	aQSbMZTZf5lI7ayocOj+e3VRcdBDP6HFwIHeMsJWpPOPWIuBWWq3HDB2TfWcnEhK
	MP4lWtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	jUb/ABno2Gq7ScHwHx9V+GwsaoqcuW2KpaUxAN5iEoKSFceLtvJrKAbQUPHNUA5+
	D48U/tucPoo9impItY2OFfz9mgphEAVuCy7ZBPNg+bW0Bsx84/F8syFC07KiuJJ/
	C2LJkMtpS9cbooYptvDeyc4W2ElyRIFEU/K2N1TP2zI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C73437F9F;
	Wed,  7 Aug 2013 23:30:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2916037F9D;
	Wed,  7 Aug 2013 23:30:51 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375918242-4655-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6584C83C-FFB9-11E2-B1C7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231849>

Make a helper function prepare_transport() that returns a transport
to talk to a given remote.

The set_option() helper that used to always affect the file-scope
global "gtransport" now takes a transport as its parameter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 636b47f..39a3fc8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -720,6 +720,31 @@ static int truncate_fetch_head(void)
 	return 0;
 }
 
+static void set_option(struct transport *transport, const char *name, const char *value)
+{
+	int r = transport_set_option(transport, name, value);
+	if (r < 0)
+		die(_("Option \"%s\" value \"%s\" is not valid for %s"),
+		    name, value, transport->url);
+	if (r > 0)
+		warning(_("Option \"%s\" is ignored for %s\n"),
+			name, transport->url);
+}
+
+struct transport *prepare_transport(struct remote *remote)
+{
+	struct transport *transport;
+	transport = transport_get(remote, NULL);
+	transport_set_verbosity(transport, verbosity, progress);
+	if (upload_pack)
+		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
+	if (keep)
+		set_option(transport, TRANS_OPT_KEEP, "yes");
+	if (depth)
+		set_option(transport, TRANS_OPT_DEPTH, depth);
+	return transport;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
@@ -816,17 +841,6 @@ static int do_fetch(struct transport *transport,
 	return retcode;
 }
 
-static void set_option(const char *name, const char *value)
-{
-	int r = transport_set_option(gtransport, name, value);
-	if (r < 0)
-		die(_("Option \"%s\" value \"%s\" is not valid for %s"),
-		    name, value, gtransport->url);
-	if (r > 0)
-		warning(_("Option \"%s\" is ignored for %s\n"),
-			name, gtransport->url);
-}
-
 static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
@@ -949,15 +963,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die(_("No remote repository specified.  Please, specify either a URL or a\n"
 		    "remote name from which new revisions should be fetched."));
 
-	gtransport = transport_get(remote, NULL);
-	transport_set_verbosity(gtransport, verbosity, progress);
-	if (upload_pack)
-		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
-	if (keep)
-		set_option(TRANS_OPT_KEEP, "yes");
-	if (depth)
-		set_option(TRANS_OPT_DEPTH, depth);
-
+	gtransport = prepare_transport(remote);
 	if (argc > 0) {
 		int j = 0;
 		refs = xcalloc(argc + 1, sizeof(const char *));
-- 
1.8.4-rc1-210-gf6d87e2
