From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 9/9] send-pack/receive-pack: Allow server to refuse pushes
 with too many commits
Date: Sun, 15 May 2011 23:37:20 +0200
Message-ID: <1305495440-30836-10-git-send-email-johan@herland.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 23:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLj11-0000ID-LG
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab1EOViO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:38:14 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55744 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829Ab1EOViG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:38:06 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009QKAR00Y80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:48 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 261881EA5FBE_DD047ACB	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:48 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D21191EA3179_DD047ABF	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:47 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL900KSQAQK8000@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:47 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1305495440-30836-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173673>

Add a new receive.commitCountLimit config variable which defines an upper
limit on the number of commits to accept in a single push.

This limit is advertised to clients, using the new "limit-commit-count=<num>"
capability. The client side - aka. send-pack - parses this capability and
forwards it to pack-objects, using the recently added --max-commit-count
option. pack-objects then checks the generated pack against the limit and
aborts the pack generation if the pack would have too many objects.

However, older clients that do not understand the capability will not check
their pack against the limit, and will end up pushing the pack to the server.
Currently there is no extra check on the server to detect a push that exceeds
receive.commitCountLimit. However, such a check could be done in a pre-receive
or update hook.

Documentation and tests are included.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt                          |    9 +++
 Documentation/technical/protocol-capabilities.txt |    1 +
 builtin/receive-pack.c                            |   10 +++-
 builtin/send-pack.c                               |   10 +++-
 send-pack.h                                       |    1 +
 t/t5400-send-pack.sh                              |   63 +++++++++++++++++++++
 6 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index acc1ef2..c63a224 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1617,6 +1617,15 @@ receive.objectCountLimit::
 	there is no upper limit on the number of objects transferred
 	in a single push.
 
+receive.commitCountLimit::
+	If the number of commits received in a push exceeds this limit,
+	then the entire push will be refused. This is meant to prevent
+	an unintended large push (typically a result of the user not
+	being aware of exactly what is being pushed, e.g. pushing a
+	large rewritten history) from entering the repo. If not set,
+	there is no upper limit on the number of commits transferred
+	in a single push.
+
 receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index d3921a9..c16240b 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -207,6 +207,7 @@ The following "limit-*" capabilites are recognized:
 
  - limit-pack-size=<num>    (Maximum size (in bytes) of uploaded pack)
  - limit-object-count=<num> (Maximum number of objects in a pack)
+ - limit-commit-count=<num> (Maximum number of commits in a pack)
 
 More "limit-*" capabilities may be added in the future. The client
 is free to ignore any "limit-*" capabilities it does not understand.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 97c154b..1d1170b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -28,7 +28,7 @@ static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
-static unsigned long limit_pack_size, limit_object_count;
+static unsigned long limit_pack_size, limit_object_count, limit_commit_count;
 static int report_status;
 static int use_sideband;
 static int prefer_ofs_delta = 1;
@@ -84,6 +84,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.commitcountlimit") == 0) {
+		limit_commit_count = git_config_ulong(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.fsckobjects") == 0) {
 		receive_fsck_objects = git_config_bool(var, value);
 		return 0;
@@ -129,6 +134,9 @@ static const char *capabilities()
 	if (limit_object_count > 0)
 		ret += snprintf(buf + ret, sizeof(buf) - ret,
 				" limit-object-count=%lu", limit_object_count);
+	if (limit_commit_count > 0)
+		ret += snprintf(buf + ret, sizeof(buf) - ret,
+				" limit-commit-count=%lu", limit_commit_count);
 	assert(ret < sizeof(buf));
 	return buf;
 }
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e7c82ce..0ef68ea 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -51,10 +51,11 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
-	char buf1[40], buf2[40];
+	char buf1[40], buf2[40], buf3[40];
 
 	i = 4;
 	if (args->use_thin_pack)
@@ -75,6 +76,11 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 			 args->max_object_count);
 		argv[i++] = buf2;
 	}
+	if (args->max_commit_count > 0) {
+		snprintf(buf3, sizeof(buf3), "--max-commit-count=%lu",
+			 args->max_commit_count);
+		argv[i++] = buf3;
+	}
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
@@ -281,6 +287,8 @@ int send_pack(struct send_pack_args *args,
 		args->max_pack_size = strtoul(p + 16, NULL, 10);
 	if ((p = server_supports("limit-object-count=")))
 		args->max_object_count = strtoul(p + 19, NULL, 10);
+	if ((p = server_supports("limit-commit-count=")))
+		args->max_commit_count = strtoul(p + 19, NULL, 10);
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
diff --git a/send-pack.h b/send-pack.h
index 1c6c202..9d28cc5 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -14,6 +14,7 @@ struct send_pack_args {
 		stateless_rpc:1;
 	unsigned long max_pack_size;
 	unsigned long max_object_count;
+	unsigned long max_commit_count;
 };
 
 int send_pack(struct send_pack_args *args,
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 26fd1b4..a71bc47 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -350,4 +350,67 @@ test_expect_success 'push is allowed when pack size is not exceeded' '
 	test "$parent_head" = "$child_head"
 '
 
+test_expect_success 'verify that limit-commit-count capability is not advertised by default' '
+	rewound_push_setup &&
+	(
+	    cd parent &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    test_must_fail grep -q "limit-commit-count" output
+	)
+'
+
+test_expect_success 'verify that receive.commitCountLimit triggers limit-commit-count capability' '
+	(
+	    cd parent &&
+	    git config receive.commitCountLimit 1 &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    grep -q "limit-commit-count=1" output
+	)
+'
+
+test_expect_success 'deny pushing when receive.commitCountLimit is exceeded' '
+	(
+	    cd child &&
+	    git reset --hard origin/master &&
+	    echo three > file && git commit -a -m three &&
+	    echo four > file && git commit -a -m four &&
+	    test_must_fail git send-pack ../parent master 2>errs &&
+	    grep -q "commit count limit" errs
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
+	    grep -q "commit count limit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" != "$child_head"
+'
+
+test_expect_success 'increase receive.commitCountLimit' '
+	(
+	    cd parent &&
+	    git config receive.commitCountLimit 2 &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    grep -q "limit-commit-count=2" output
+	)
+'
+
+test_expect_success 'push is allowed when commit limit is not exceeded' '
+	(
+	    cd child &&
+	    git send-pack ../parent master 2>errs &&
+	    test_must_fail grep -q "commit count limit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" = "$child_head"
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
