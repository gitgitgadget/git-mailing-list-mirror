From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 05/19] Add support for "import" helper command
Date: Thu, 29 Oct 2009 11:01:13 -0700
Message-ID: <1256839287-19016-6-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKo-0004ac-43
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZJ2SCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbZJ2SCY
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:24 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48301 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbZJ2SCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:18 -0400
Received: by mail-pw0-f42.google.com with SMTP id 9so194495pwj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lDdBwuu8GH9Ovq4/HY8l8QDur+wqFZvByclKZVp6Xn4=;
        b=IgMzlOG48925QFRFFqqZ7r7vUvw1ThlVT1InWjAdAEWrij28Sx07SYtYHHFs53uKnj
         jqO3sxmzz7wbL3S98DCuU1da+TFcBJ2UyM4f6B/EWHMkbb+DP6QGuv6AzcH4OhCPmuYw
         OVBnndcLDAa1QC6rBZwxJn1prDXbOBW5fEojk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dQ9d4LKmqABT+om0VqmB2ukB3zYFaNQM5hWv5F1e5hy8Pxlvlz50Oc8I4d45X9OvRq
         8LEPwQt00Bvr7Abb/eIuAuJd2Kpr4V/i9pxk2LWDBibjKZbJZ1H1CRR2GQjulet9v9a8
         Q578mXegfUAJD2aAZygwsKciHLKCdUX5jFlrA=
Received: by 10.115.116.37 with SMTP id t37mr270214wam.79.1256839343821;
        Thu, 29 Oct 2009 11:02:23 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131628>

From: Daniel Barkalow <barkalow@iabervon.org>

This command, supported if the "import" capability is advertized,
allows a helper to support fetching by outputting a git-fast-import
stream.

If both "fetch" and "import" are advertized, git itself will use
"fetch" (although other users may use "import" in this case).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	This has my symref patch squashed in.

 Documentation/git-remote-helpers.txt |   10 ++++++
 transport-helper.c                   |   52 ++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 173ee23..e9aa67e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -43,6 +43,13 @@ Commands are given by the caller on the helper's standard input, one per line.
 +
 Supported if the helper has the "fetch" capability.
 
+'import' <name>::
+	Produces a fast-import stream which imports the current value
+	of the named ref. It may additionally import other refs as
+	needed to construct the history efficiently.
++
+Supported if the helper has the "import" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -57,6 +64,9 @@ CAPABILITIES
 'fetch'::
 	This helper supports the 'fetch' command.
 
+'import'::
+	This helper supports the 'import' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/transport-helper.c b/transport-helper.c
index a0e4219..f840842 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -11,6 +11,7 @@ struct helper_data
 	const char *name;
 	struct child_process *helper;
 	unsigned fetch : 1;
+	unsigned import : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -48,6 +49,8 @@ static struct child_process *get_helper(struct transport *transport)
 			break;
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
+		if (!strcmp(buf.buf, "import"))
+			data->import = 1;
 	}
 	return data->helper;
 }
@@ -91,6 +94,52 @@ static int fetch_with_fetch(struct transport *transport,
 	return 0;
 }
 
+static int get_importer(struct transport *transport, struct child_process *fastimport)
+{
+	struct child_process *helper = get_helper(transport);
+	memset(fastimport, 0, sizeof(*fastimport));
+	fastimport->in = helper->out;
+	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
+	fastimport->argv[0] = "fast-import";
+	fastimport->argv[1] = "--quiet";
+
+	fastimport->git_cmd = 1;
+	return start_command(fastimport);
+}
+
+static int fetch_with_import(struct transport *transport,
+			     int nr_heads, struct ref **to_fetch)
+{
+	struct child_process fastimport;
+	struct child_process *helper = get_helper(transport);
+	int i;
+	struct ref *posn;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (get_importer(transport, &fastimport))
+		die("Couldn't run fast-import");
+
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+
+		strbuf_addf(&buf, "import %s\n", posn->name);
+		write_in_full(helper->in, buf.buf, buf.len);
+		strbuf_reset(&buf);
+	}
+	disconnect_helper(transport);
+	finish_command(&fastimport);
+
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		read_ref(posn->symref ? posn->symref : posn->name, posn->old_sha1);
+	}
+	return 0;
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
@@ -108,6 +157,9 @@ static int fetch(struct transport *transport,
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
+	if (data->import)
+		return fetch_with_import(transport, nr_heads, to_fetch);
+
 	return -1;
 }
 
-- 
1.6.5.2.291.gf76a3
