From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 07/13] Add support for "import" helper command
Date: Wed,  4 Nov 2009 20:48:12 +0100
Message-ID: <1257364098-1685-8-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrg-0000NL-VC
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbZKDTtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758090AbZKDTtN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:13 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55343 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083AbZKDTtL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:11 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490482ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ozMkXumJ4GBWOBIKeLAhwCwm0mRu4L8BSwiwM+SYX8U=;
        b=N7l1NsEym1aS64DSJCHLROPFxTWzbxB8VrPXzHg4dHhXYCtCOCNQZDRDjaVNvd3LjT
         KbWup9K5huZ1Ef3oIyZv/EDSlxwdWsURm84+VCQW6uSXPtk4PGCzmx7fSNDEohOncWzr
         j6fnF0Mi2HW7HXHfxIaumxTcl48mU/yGI/UJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tzzYA29aQTkGZlreZATynGfpsmy55g4JbOu1HEX6qrMcMyt2x2O+3QixFaguO6qKS3
         78PWgxlQKjJ6nYoMbq288UDftaQj7W1g9jk653hlzAzGAUlCz/ewxev5HhD2LhhgoXl2
         +y7a8ZMCIwdRhNdfQJfdv8S8cqYR+Y3FppbgM=
Received: by 10.213.107.131 with SMTP id b3mr2297845ebp.91.1257364155803;
        Wed, 04 Nov 2009 11:49:15 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:14 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132127>

From: Daniel Barkalow <barkalow@iabervon.org>

This command, supported if the "import" capability is advertized,
allows a helper to support fetching by outputting a git-fast-import
stream.

If both "fetch" and "import" are advertized, git itself will use
"fetch" (although other users may use "import" in this case).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Undid the change to the read_ref line, see patch 0009 for a
	suggested proper fix.

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
index 53d8f08..82caaae 100644
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
@@ -98,6 +101,52 @@ static int fetch_with_fetch(struct transport *transport,
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
+		read_ref(posn->name, posn->old_sha1);
+	}
+	return 0;
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
@@ -115,6 +164,9 @@ static int fetch(struct transport *transport,
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
+	if (data->import)
+		return fetch_with_import(transport, nr_heads, to_fetch);
+
 	return -1;
 }
 
-- 
1.6.5.2.295.g0d105
