From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v3 6/8] Support remote helpers implementing smart transports
Date: Sun,  6 Dec 2009 18:28:49 +0200
Message-ID: <1260116931-16549-7-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 17:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJzM-0006Vu-MD
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933862AbZLFQ27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933844AbZLFQ26
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:28:58 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:33957 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932885AbZLFQ2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:28:55 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 8E21C8C64A
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:29:00 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A011F18B303; Sun, 06 Dec 2009 18:29:00 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 65D474035
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:28:59 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134673>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-helpers.txt |   25 ++++++++++-
 transport-helper.c                   |   84 +++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 20a05fe..b957813 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -93,6 +93,20 @@ Supported if the helper has the "push" capability.
 +
 Supported if the helper has the "import" capability.
 
+'connect' <service>::
+	Connects to given service. Stdin and stdout of helper are
+	connected to specified service (git prefix is included in service
+	name so e.g. fetching uses 'git-upload-pack' as service) on
+	remote side. Valid replies to this command are empty line
+	(connection established), 'fallback' (no smart transport support,
+	fall back to dumb transports) and just exiting with error message
+	printed (can't connect, don't bother trying to fall back). After
+	line feed terminating the positive (empty) response, the output
+	of service starts. After the connection ends, the remote
+	helper exits.
++
+Supported if the helper has the "connect" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -126,6 +140,9 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"
 
+'connect'::
+	This helper supports the 'connect' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
@@ -168,9 +185,15 @@ OPTIONS
 	but don't actually change any repository data.	For most
 	helpers this only applies to the 'push', if supported.
 
+'option servpath <c-style-quoted-path>'::
+	Set service path (--upload-pack, --receive-pack etc.) for
+	next connect. Remote helper MAY support this option. Remote
+	helper MUST NOT rely on this option being set before
+	connect request occurs.
+
 Documentation
 -------------
-Documentation by Daniel Barkalow.
+Documentation by Daniel Barkalow and Ilari Liusvaara
 
 GIT
 ---
diff --git a/transport-helper.c b/transport-helper.c
index 3d99fe1..e0254bc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -18,7 +18,8 @@ struct helper_data
 	unsigned fetch : 1,
 		import : 1,
 		option : 1,
-		push : 1;
+		push : 1,
+		connect : 1;
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
@@ -163,7 +164,10 @@ static struct child_process *get_helper(struct transport *transport)
 				   refspec_nr + 1,
 				   refspec_alloc);
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
-		} else if (mandatory) {
+		}
+		else if (!strcmp(capname, "connect"))
+			data->connect = 1;
+		else if (mandatory) {
 			fflush(stderr);
 			die("Unknown madatory capability %s. This remote "
 			    "helper probably needs newer version of Git.\n",
@@ -386,12 +390,78 @@ static int fetch_with_import(struct transport *transport,
 	return 0;
 }
 
+static int _process_connect(struct transport *transport,
+				      const char *name, const char *exec)
+{
+	struct helper_data *data = transport->data;
+	struct strbuf cmdbuf = STRBUF_INIT;
+	struct child_process *helper;
+	int r;
+
+	helper = get_helper(transport);
+
+	/* Handle --upload-pack and friends. This is fire and forget...
+	   just warn if it fails. */
+	if (strcmp(name, exec)) {
+		r = set_helper_option(transport, "servpath", exec);
+		if (r > 0)
+			fprintf(stderr, "Warning: Setting remote service path "
+				"not supported by protocol.\n");
+		else if (r < 0)
+			fprintf(stderr, "Warning: Invalid remote service "
+				"path.\n");
+	}
+
+	if (data->connect)
+		strbuf_addf(&cmdbuf, "connect %s\n", name);
+	else
+		return 0;
+
+	xchgline(data, &cmdbuf);
+	if (!strcmp(cmdbuf.buf, "")) {
+		if (debug)
+			fprintf(stderr, "Debug: Smart transport connection "
+				"ready.\n");
+		return 1;
+	} else if (!strcmp(cmdbuf.buf, "fallback")) {
+		if (debug)
+			fprintf(stderr, "Debug: Falling back to dumb "
+				"transport.\n");
+		return 0;
+	} else
+		die("Unknown response to connect: %s",
+			cmdbuf.buf);
+
+	return 0;	/* Shouldn't be here. */
+}
+
+static int process_connect(struct transport* transport,
+				     int for_push)
+{
+	struct helper_data *data = transport->data;
+	const char *name;
+	const char *exec;
+
+	name = for_push ? "git-receive-pack" : "git-upload-pack";
+	if (for_push)
+		exec = data->gitoptions.receivepack;
+	else
+		exec = data->gitoptions.uploadpack;
+
+	return _process_connect(transport, name, exec);
+}
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
+	if (process_connect(transport, 0)) {
+		transport_take_over(transport);
+		return transport->fetch(transport, nr_heads, to_fetch);
+	}
+
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
@@ -419,6 +489,11 @@ static int push_refs(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ref;
 
+	if (process_connect(transport, 1)) {
+		transport_take_over(transport);
+		return transport->push_refs(transport, remote_refs, flags);
+	}
+
 	if (!remote_refs)
 		return 0;
 
@@ -559,6 +634,11 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	helper = get_helper(transport);
 
+	if (process_connect(transport, for_push)) {
+		transport_take_over(transport);
+		return transport->get_refs_list(transport, for_push);
+	}
+
 	if (data->push && for_push)
 		write_str_in_full(helper->in, "list for-push\n");
 	else
-- 
1.6.6.rc1.300.gfbc27
