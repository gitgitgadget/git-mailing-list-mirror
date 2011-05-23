From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 10/10] receive-pack: Allow server to refuse pushes with too
 many objects
Date: Mon, 23 May 2011 02:52:03 +0200
Message-ID: <1306111923-16859-11-git-send-email-johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:53:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJOP-0000eg-PQ
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab1EWAww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:52:52 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53497 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878Ab1EWAwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:52:35 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM001QLIFB4YA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:25 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 753961EA6140_DD9AFC9B	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id EC5CF1EA3581_DD9AFC6F	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:22 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM005PMIF9TE20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:22 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1306111923-16859-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174217>

Add a new receive.objectCountLimit config variable which defines an upper
limit on the number of objects to accept in a single push. The server
aborts the transfer if the pack header received from the client indicates
a number of objects that exceeds this upper limit.

This limit is not advertised to clients, but is only enforced server-side.
When the limit is exceeded, the server sends a helpful error message to the
client, and then aborts the transfer, leaving the client with a broken pipe.

Server administrators might want to use this config variable to prevent
unintended large pushes from entering the repo (typically a result of the
user not being aware of exactly what is being pushed, e.g. pushing a large
rewritten history). Note that this config variable is not intended to protect
against DoS attacks, since there are countless other ways to attempt to DoS a
server without violating this limit.

Traditionally, this kind of limit would be imposed by a pre-receive or update
hook, but both of those run _after_ the pack has been received and stored by
receive-pack, so they cannot prevent the pack from being stored on the server.

Documentation and tests are included.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt |    9 +++++++++
 builtin/receive-pack.c   |   11 +++++++++--
 t/t5400-send-pack.sh     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 79d553a..8618979 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1610,6 +1610,15 @@ receive.commitCountLimit::
 	there is no upper limit on the number of commits transferred
 	in a single push.
 
+receive.objectCountLimit::
+	If the number of objects received in a push exceeds this limit,
+	then the entire push will be refused. This is meant to prevent
+	an unintended large push (typically a result of the user not
+	being aware of exactly what is being pushed, e.g. pushing a
+	large rewritten history) from entering the repo. If not set,
+	there is no upper limit on the number of objects transferred
+	in a single push.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49d29ad..e9e5521 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -28,7 +28,7 @@ static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
-static unsigned long limit_pack_size, limit_commit_count;
+static unsigned long limit_pack_size, limit_commit_count, limit_object_count;
 static int report_status;
 static int use_sideband;
 static int prefer_ofs_delta = 1;
@@ -84,6 +84,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.objectcountlimit") == 0) {
+		limit_object_count = git_config_ulong(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
@@ -673,7 +678,9 @@ static const char *unpack(void)
 			"--pack_header=%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (limit_object_count > 0 && ntohl(hdr.hdr_entries) > limit_object_count)
+		return "received pack exceeds configured receive.objectCountLimit";
+	else if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i = 0;
 		const char *unpacker[4];
 		unpacker[i++] = "unpack-objects";
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 4ed5ba1..b65d69d 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -349,4 +349,48 @@ test_expect_success 'push is allowed when pack size is not exceeded' '
 	test "$parent_head" = "$child_head"
 '
 
+test_expect_success 'deny pushing when receive.objectCountLimit is exceeded' '
+	rewound_push_setup &&
+	(
+	    cd parent &&
+	    git config receive.objectCountLimit 1
+	) &&
+	(
+	    cd child &&
+	    git reset --hard origin/master &&
+	    echo three > file && git commit -a -m three &&
+	    test_must_fail git send-pack ../parent master 2>errs &&
+	    grep -q "receive\\.objectCountLimit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" != "$child_head"
+'
+
+test_expect_success 'repeated push failure proves that objects were not stored remotely' '
+	(
+	    cd child &&
+	    test_must_fail git send-pack ../parent master 2>errs &&
+	    grep -q "receive\\.objectCountLimit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" != "$child_head"
+'
+
+test_expect_success 'push is allowed when object limit is increased' '
+	(
+	    cd parent &&
+	    git config receive.objectCountLimit 10
+	) &&
+	(
+	    cd child &&
+	    git send-pack ../parent master 2>errs &&
+	    test_must_fail grep -q "receive\\.objectCountLimit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" = "$child_head"
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
