From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 7/9] send-pack/receive-pack: Allow server to refuse pushes
 with too many objects
Date: Sun, 15 May 2011 23:37:18 +0200
Message-ID: <1305495440-30836-8-git-send-email-johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:38:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLj10-0000ID-K9
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab1EOViK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:38:10 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55744 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683Ab1EOViD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:38:03 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009Q7AQZ0Y80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:47 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5538E1EA5FB2_DD047ABB	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:47 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 067C11EA3167_DD047ABF	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:47 +0000 (GMT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173674>

Add a new receive.objectCountLimit config variable which defines an upper
limit on the number of objects to accept in a single push.

This limit is advertised to clients, using the new "limit-object-count=<num>"
capability. The client side - aka. send-pack - parses this capability and
forwards it to pack-objects, using the recently added --max-object-count
option. pack-objects then checks the generated pack against the limit and
aborts the pack generation if the pack would have too many objects.

Additionally - for older clients that do not understand the capability - the
server aborts the transfer if the number of objects in the transferred pack
exceeds the limit. This is a suboptimal fallback solution, as it leaves the
client with a broken pipe, and likely a confused user.

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
 Documentation/config.txt                          |    9 +++
 Documentation/technical/protocol-capabilities.txt |    2 +
 builtin/receive-pack.c                            |   13 ++++-
 builtin/send-pack.c                               |   10 +++
 send-pack.h                                       |    1 +
 t/t5400-send-pack.sh                              |   66 +++++++++++++++++++++
 6 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 056e01f..fd6c130 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1599,6 +1599,15 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
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
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 11849a3..aac66af 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -205,5 +205,7 @@ the server. If the check fails, the client must abort the upload, and
 report the reason for the aborted push back to the user.
 The following "limit-*" capabilites are recognized:
 
+ - limit-object-count=<num> (Maximum number of objects in a pack)
+
 More "limit-*" capabilities may be added in the future. The client
 is free to ignore any "limit-*" capabilities it does not understand.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c55989d..d919e17 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -28,6 +28,7 @@ static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
+static unsigned long limit_object_count;
 static int report_status;
 static int use_sideband;
 static int prefer_ofs_delta = 1;
@@ -73,6 +74,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
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
@@ -112,6 +118,9 @@ static const char *capabilities()
 	int ret = snprintf(buf, sizeof(buf),
 			   " report-status delete-refs side-band-64k%s",
 			   prefer_ofs_delta ? " ofs-delta" : "");
+	if (limit_object_count > 0)
+		ret += snprintf(buf + ret, sizeof(buf) - ret,
+				" limit-object-count=%lu", limit_object_count);
 	assert(ret < sizeof(buf));
 	return buf;
 }
@@ -656,7 +665,9 @@ static const char *unpack(void)
 			"--pack_header=%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (limit_object_count > 0 && ntohl(hdr.hdr_entries) > limit_object_count)
+		return "received pack exceeds configured receive.objectCountLimit";
+	else if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i = 0;
 		const char *unpacker[4];
 		unpacker[i++] = "unpack-objects";
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f571917..4103116 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -49,9 +49,11 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
+	char buf[40];
 
 	i = 4;
 	if (args->use_thin_pack)
@@ -62,6 +64,11 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "-q";
 	if (args->progress)
 		argv[i++] = "--progress";
+	if (args->max_object_count > 0) {
+		snprintf(buf, sizeof(buf), "--max-object-count=%lu",
+			 args->max_object_count);
+		argv[i++] = buf;
+	}
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
@@ -253,6 +260,7 @@ int send_pack(struct send_pack_args *args,
 	unsigned cmds_sent = 0;
 	int ret = 0;
 	struct async demux;
+	const char *p;
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
@@ -263,6 +271,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
+	if ((p = server_supports("limit-object-count=")))
+		args->max_object_count = strtoul(p + 19, NULL, 10);
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
diff --git a/send-pack.h b/send-pack.h
index 05d7ab1..eaacb20 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -12,6 +12,7 @@ struct send_pack_args {
 		use_ofs_delta:1,
 		dry_run:1,
 		stateless_rpc:1;
+	unsigned long max_object_count;
 };
 
 int send_pack(struct send_pack_args *args,
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0eace37..f1f8f80 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -222,4 +222,70 @@ test_expect_success 'deny pushing to delete current branch' '
 	)
 '
 
+echo "0000" > pkt-flush
+
+test_expect_success 'verify that limit-object-count capability is not advertised by default' '
+	rewound_push_setup &&
+	(
+	    cd parent &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    test_must_fail grep -q "limit-object-count" output
+	)
+'
+
+test_expect_success 'verify that receive.objectCountLimit triggers limit-object-count capability' '
+	(
+	    cd parent &&
+	    git config receive.objectCountLimit 1 &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    grep -q "limit-object-count=1" output
+	)
+'
+
+test_expect_success 'deny pushing when receive.objectCountLimit is exceeded' '
+	(
+	    cd child &&
+	    git reset --hard origin/master &&
+	    echo three > file && git commit -a -m three &&
+	    test_must_fail git send-pack ../parent master 2>errs &&
+	    grep -q "object count limit" errs
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
+	    grep -q "object count limit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" != "$child_head"
+'
+
+test_expect_success 'increase receive.objectCountLimit' '
+	(
+	    cd parent &&
+	    git config receive.objectCountLimit 10 &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    grep -q "limit-object-count=10" output
+	)
+'
+
+test_expect_success 'push is allowed when object limit is not exceeded' '
+	(
+	    cd child &&
+	    git send-pack ../parent master 2>errs &&
+	    test_must_fail grep -q "object count limit" errs &&
+	    # Also no error message from remote receive-pack
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
