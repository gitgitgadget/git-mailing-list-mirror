From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 6/9] receive-pack: Prepare for addition of the new 'limit-*'
 family of capabilities
Date: Sun, 15 May 2011 23:37:17 +0200
Message-ID: <1305495440-30836-7-git-send-email-johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLj10-0000ID-23
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab1EOViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:38:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55744 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623Ab1EOViB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:38:01 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009PCAQV0Y80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:46 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A6A2E1EA5FC8_DD047AAB	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 66E6F1EA3153_DD047AAF	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:46 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900KSQAQK8000@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:46 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1305495440-30836-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173675>

This adds some technical documentation on the 'limit-*' family of
capabilities that will be added in the following commits.

Also refactor the generation of the capabilities declaration in receive-pack.
This will also be further expanded in the following commits.

Finally, change the return type of server_supports() to allow the caller to
more closely examine the found capability, e.g. by calling
server_supports("limit-foo="), and then use the return value to parse the
value following the '='.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/technical/pack-protocol.txt         |    6 ++--
 Documentation/technical/protocol-capabilities.txt |   22 +++++++++++++++++++++
 builtin/receive-pack.c                            |   16 +++++++++++---
 cache.h                                           |    2 +-
 connect.c                                         |    7 +++--
 5 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 4a68f0f..ddc0d0e 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -167,7 +167,7 @@ MUST peel the ref if it's an annotated tag.
   other-peeled     =  obj-id SP refname "^{}" LF
 
   capability-list  =  capability *(SP capability)
-  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
+  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
   LC_ALPHA         =  %x61-7A
 ----
 
@@ -391,8 +391,8 @@ The reference discovery phase is done nearly the same way as it is in the
 fetching protocol. Each reference obj-id and name on the server is sent
 in packet-line format to the client, followed by a flush-pkt.  The only
 real difference is that the capability listing is different - the only
-possible values are 'report-status', 'delete-refs', 'side-band-64k' and
-'ofs-delta'.
+possible values are 'report-status', 'delete-refs', 'side-band-64k',
+'ofs-delta' and 'limit-*'.
 
 Reference Update Request and Packfile Transfer
 ----------------------------------------------
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index b732e80..11849a3 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -21,6 +21,9 @@ NOT advertise capabilities it does not understand.
 The 'report-status' and 'delete-refs' capabilities are sent and
 recognized by the receive-pack (push to server) process.
 
+Any 'limit-*' capabilities may only be sent by the receive-pack
+process. It is never requested by client.
+
 The 'side-band-64k' and 'ofs-delta' capabilities are sent and
 recognized by both upload-pack and receive-pack protocols.
 
@@ -185,3 +188,22 @@ it is capable of accepting a zero-id value as the target
 value of a reference update.  It is not sent back by the client, it
 simply informs the client that it can be sent zero-id values
 to delete references.
+
+limit-*
+-------
+
+If the server sends one or more capabilities that start with "limit-",
+it means that there are certain limits to what kind of pack the server
+will receive. More specifically, these capabilities must be of the form
+"limit-<what>=<num>" where "<what>" (a sequence of lower-case letters,
+digits and "-") describes which property of the pack is limited, and
+"<num>" (a sequence of decimal digits) specifies the limit value.
+Capabilities of this type are not sent back by the client; instead the
+client must verify that the created packfile does not exceed the given
+limits. This check should happen prior to transferring the packfile to
+the server. If the check fails, the client must abort the upload, and
+report the reason for the aborted push back to the user.
+The following "limit-*" capabilites are recognized:
+
+More "limit-*" capabilities may be added in the future. The client
+is free to ignore any "limit-*" capabilities it does not understand.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e1ba4dc..c55989d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -106,15 +106,23 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static const char *capabilities()
+{
+	static char buf[1024];
+	int ret = snprintf(buf, sizeof(buf),
+			   " report-status delete-refs side-band-64k%s",
+			   prefer_ofs_delta ? " ofs-delta" : "");
+	assert(ret < sizeof(buf));
+	return buf;
+}
+
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
-		packet_write(1, "%s %s%c%s%s\n",
-			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k",
-			     prefer_ofs_delta ? " ofs-delta" : "");
+		packet_write(1, "%s %s%c%s\n",
+			     sha1_to_hex(sha1), path, 0, capabilities());
 	sent_capabilities = 1;
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 2b34116..db97097 100644
--- a/cache.h
+++ b/cache.h
@@ -981,7 +981,7 @@ struct extra_have_objects {
 	unsigned char (*array)[20];
 };
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
-extern int server_supports(const char *feature);
+extern const char *server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
diff --git a/connect.c b/connect.c
index 57dc20c..015c570 100644
--- a/connect.c
+++ b/connect.c
@@ -102,10 +102,11 @@ struct ref **get_remote_heads(int in, struct ref **list,
 	return list;
 }
 
-int server_supports(const char *feature)
+const char *server_supports(const char *feature)
 {
-	return server_capabilities &&
-		strstr(server_capabilities, feature) != NULL;
+	if (server_capabilities)
+		return strstr(server_capabilities, feature);
+	return NULL;
 }
 
 int path_match(const char *path, int nr, char **match)
-- 
1.7.5.rc1.3.g4d7b
