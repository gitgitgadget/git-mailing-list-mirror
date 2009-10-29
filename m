From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 10/19] Allow helpers to request marks for fast-import
Date: Thu, 29 Oct 2009 11:01:18 -0700
Message-ID: <1256839287-19016-11-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKm-0004ac-25
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbZJ2SCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZJ2SCc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:32 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:43668 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbZJ2SCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:30 -0400
Received: by mail-pz0-f188.google.com with SMTP id 26so1412783pzk.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3jSW3L5gCfkA8XPFv2RRWszxBJ7UYnX2/VMgTzF7zWc=;
        b=Sb1mR5zCYGSHpr00ECmDAXMCEKeUGmOAKEO35XOEAuruhJDP/kcLPfZVwZNINVK3Hn
         GxqXRqQihkDJVkAN8dBjj1IfIAjCq41vTgpREY0tf3fAKf3s383PuarsJaU/A7MPO1EB
         /7D7xnYa3apG2b/XNq+GTvbWt7PNlP71FAuio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bnD2QL1VAucDGumtYlIGMQ4Eekk9BYQNjumNkWO2Kc4UBVoVjFjDMIP4YjtelQZgPE
         lUrIG+gweAvFVs4PqF53+8YVrob8dXARTlTPJY9Xju0QWgIb3rpNqmAs1r9Urjtfsrrc
         ZX75wTAz/nsQ4hyBAN5Eu99AmanyShxZDno6k=
Received: by 10.115.133.39 with SMTP id k39mr274421wan.94.1256839355361;
        Thu, 29 Oct 2009 11:02:35 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131626>

From: Johan Herland <johan@herland.net>

The 'marks' capability is reported by the remote helper if it requires
the fast-import marks database to loaded/saved by any git-fast-import
process that is provided by the transport machinery. The feature is
advertised along with exactly one argument: the location of the file
containing the marks database.

Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	Unchanged.

 Documentation/git-remote-helpers.txt |    8 ++++++++
 transport-helper.c                   |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 2c5130f..9a3c5bc 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -67,6 +67,14 @@ CAPABILITIES
 'import'::
 	This helper supports the 'import' command.
 
+'marks' filename::
+	Helper requires the marks from a git-fast-import run to be
+	loaded from, and saved to, the given filename. When this
+	"feature" is advertised, each git-fast-import run must load
+	and save the internal marks database (see the --import-marks
+	and --export-marks option to git-fast-import for more details)
+	located at the given filename.
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/transport-helper.c b/transport-helper.c
index 36a265d..cd3f0df 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -10,6 +10,7 @@ struct helper_data
 {
 	const char *name;
 	struct child_process *helper;
+	char *marks_filename;
 	unsigned fetch : 1;
 	unsigned import : 1;
 };
@@ -51,6 +52,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "import"))
 			data->import = 1;
+		if (!prefixcmp(buf.buf, "marks "))
+			data->marks_filename = xstrdup(buf.buf + 6);
 	}
 	return data->helper;
 }
@@ -104,11 +107,21 @@ static int fetch_with_fetch(struct transport *transport,
 static int get_importer(struct transport *transport, struct child_process *fastimport)
 {
 	struct child_process *helper = get_helper(transport);
+	struct helper_data *data = transport->data;
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
 	fastimport->argv[0] = "fast-import";
 	fastimport->argv[1] = "--quiet";
+	if (data->marks_filename) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "--export-marks=%s", data->marks_filename);
+		fastimport->argv[2] = strbuf_detach(&buf, 0);
+		if (!access(data->marks_filename, R_OK)) {
+			strbuf_addf(&buf, "--import-marks=%s", data->marks_filename);
+			fastimport->argv[3] = strbuf_detach(&buf, 0);
+		}
+	}
 
 	fastimport->git_cmd = 1;
 	return start_command(fastimport);
@@ -137,6 +150,8 @@ static int fetch_with_import(struct transport *transport,
 	}
 	disconnect_helper(transport);
 	finish_command(&fastimport);
+	free((char *) fastimport.argv[2]);
+	free((char *) fastimport.argv[3]);
 
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
-- 
1.6.5.2.291.gf76a3
