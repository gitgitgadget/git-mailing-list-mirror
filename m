From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] fetch: rename file-scope global "transport" to "gtransport"
Date: Wed,  7 Aug 2013 16:30:39 -0700
Message-ID: <1375918242-4655-3-git-send-email-gitster@pobox.com>
References: <1375918242-4655-1-git-send-email-gitster@pobox.com>
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 01:31:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7DCi-0005l6-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 01:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933323Ab3HGXav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 19:30:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757520Ab3HGXau (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 19:30:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC93A37F9B;
	Wed,  7 Aug 2013 23:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Esle
	07wvW5+UzcNQqx2WUZy2M/E=; b=pvKCG399rhSqGUU0gz7WNi0DiD99ej4C/Rsh
	xwnQKsIaiH0C+oU88xejARvkedg4OHT+kUEXSWYd1lbiTAhub2BpYk9FNRw6t6De
	paCJJiOOSA+PchMKrVj8rWVWyzLAjtimEBX6DDfuuAphUC9hHuE64+1n/vbx8pXk
	TZzENyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	h8JWVpS0q09+0+t5wk1fhmHRoxDgnZA2N0LCcNlgxRPfyLQo9eb9iFElZ4iy2l+c
	3AHjmp/6PEwkg/m5hag3FvSz5CV5xaTtZQJPDUYodxxANOkIXw6elNVWqqply3W8
	exILJx7bz2odaIQMKjM8NImUYG7NYUnvsR/MojNSYMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B410237F9A;
	Wed,  7 Aug 2013 23:30:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBB7637F98;
	Wed,  7 Aug 2013 23:30:48 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375918242-4655-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 642A70EA-FFB9-11E2-A6EE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231852>

Although many functions in this file take a "struct transport" as a
parameter, "fetch_one()" assigns to the global singleton instance
which is a file-scope static, in order to allow a parameterless
signal handler unlock_pack() to access it.

Rename the variable to gtransport to make sure these uses stand out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d784b2e..636b47f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -36,7 +36,7 @@ static int tags = TAGS_DEFAULT, unshallow;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
-static struct transport *transport;
+static struct transport *gtransport;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
 
@@ -95,8 +95,8 @@ static struct option builtin_fetch_options[] = {
 
 static void unlock_pack(void)
 {
-	if (transport)
-		transport_unlock_pack(transport);
+	if (gtransport)
+		transport_unlock_pack(gtransport);
 }
 
 static void unlock_pack_on_signal(int signo)
@@ -818,13 +818,13 @@ static int do_fetch(struct transport *transport,
 
 static void set_option(const char *name, const char *value)
 {
-	int r = transport_set_option(transport, name, value);
+	int r = transport_set_option(gtransport, name, value);
 	if (r < 0)
 		die(_("Option \"%s\" value \"%s\" is not valid for %s"),
-			name, value, transport->url);
+		    name, value, gtransport->url);
 	if (r > 0)
 		warning(_("Option \"%s\" is ignored for %s\n"),
-			name, transport->url);
+			name, gtransport->url);
 }
 
 static int get_one_remote_for_fetch(struct remote *remote, void *priv)
@@ -949,8 +949,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die(_("No remote repository specified.  Please, specify either a URL or a\n"
 		    "remote name from which new revisions should be fetched."));
 
-	transport = transport_get(remote, NULL);
-	transport_set_verbosity(transport, verbosity, progress);
+	gtransport = transport_get(remote, NULL);
+	transport_set_verbosity(gtransport, verbosity, progress);
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
@@ -983,10 +983,10 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
 	refspec = parse_fetch_refspec(ref_nr, refs);
-	exit_code = do_fetch(transport, refspec, ref_nr);
+	exit_code = do_fetch(gtransport, refspec, ref_nr);
 	free_refspec(ref_nr, refspec);
-	transport_disconnect(transport);
-	transport = NULL;
+	transport_disconnect(gtransport);
+	gtransport = NULL;
 	return exit_code;
 }
 
-- 
1.8.4-rc1-210-gf6d87e2
