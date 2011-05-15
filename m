From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 8/9] send-pack/receive-pack: Allow server to refuse pushing
 too large packs
Date: Sun, 15 May 2011 23:37:19 +0200
Message-ID: <1305495440-30836-9-git-send-email-johan@herland.net>
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
	id 1QLj11-0000ID-4Y
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 23:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab1EOViL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 17:38:11 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55744 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329Ab1EOViF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 17:38:05 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL9009QBAQZ0Y80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 15 May 2011 23:37:47 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 969271EA5FCC_DD047ABB	for <git@vger.kernel.org>; Sun,
 15 May 2011 21:37:47 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4E4331EA316A_DD047ABF	for <git@vger.kernel.org>; Sun,
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173676>

Add a new receive.packSizeLimit config variable which defines an upper
limit on the pack size to accept in a single push.

This limit is advertised to clients, using the new "limit-pack-size=<num>"
capability. The client side - aka. send-pack - parses this capability and
forwards it to pack-objects, using the --max-pack-size option.
pack-objects then checks the generated pack against the limit and aborts
the pack transmission if the pack becomes too large.

However, older clients that do not understand the capability will not check
their pack against the limit, and will end up pushing the pack to the server.
Currently there is no extra check on the server to detect a push that exceeds
receive.packSizeLimit. However, such a check could be done in a pre-receive
or update hook.

Documentation and tests are included.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt                          |    9 +++
 Documentation/technical/protocol-capabilities.txt |    1 +
 builtin/receive-pack.c                            |   10 +++-
 builtin/send-pack.c                               |   14 ++++-
 send-pack.h                                       |    1 +
 t/t5400-send-pack.sh                              |   62 +++++++++++++++++++++
 6 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fd6c130..acc1ef2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1599,6 +1599,15 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.packSizeLimit::
+	If the pack file transferred in a push exceeds this limit,
+	then the entire push will be refused. This is meant to prevent
+	an unintended large push (typically a result of the user not
+	being aware of exactly what is being pushed, e.g. pushing a
+	large rewritten history) from entering the repo. If not set,
+	there is no upper limit on the size of the pack transferred
+	in a single push.
+
 receive.objectCountLimit::
 	If the number of objects received in a push exceeds this limit,
 	then the entire push will be refused. This is meant to prevent
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index aac66af..d3921a9 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -205,6 +205,7 @@ the server. If the check fails, the client must abort the upload, and
 report the reason for the aborted push back to the user.
 The following "limit-*" capabilites are recognized:
 
+ - limit-pack-size=<num>    (Maximum size (in bytes) of uploaded pack)
  - limit-object-count=<num> (Maximum number of objects in a pack)
 
 More "limit-*" capabilities may be added in the future. The client
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d919e17..97c154b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -28,7 +28,7 @@ static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
-static unsigned long limit_object_count;
+static unsigned long limit_pack_size, limit_object_count;
 static int report_status;
 static int use_sideband;
 static int prefer_ofs_delta = 1;
@@ -74,6 +74,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.packsizelimit") == 0) {
+		limit_pack_size = git_config_ulong(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.objectcountlimit") == 0) {
 		limit_object_count = git_config_ulong(var, value);
 		return 0;
@@ -118,6 +123,9 @@ static const char *capabilities()
 	int ret = snprintf(buf, sizeof(buf),
 			   " report-status delete-refs side-band-64k%s",
 			   prefer_ofs_delta ? " ofs-delta" : "");
+	if (limit_pack_size > 0)
+		ret += snprintf(buf + ret, sizeof(buf) - ret,
+				" limit-pack-size=%lu", limit_pack_size);
 	if (limit_object_count > 0)
 		ret += snprintf(buf + ret, sizeof(buf) - ret,
 				" limit-object-count=%lu", limit_object_count);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4103116..e7c82ce 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -50,10 +50,11 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
-	char buf[40];
+	char buf1[40], buf2[40];
 
 	i = 4;
 	if (args->use_thin_pack)
@@ -64,10 +65,15 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "-q";
 	if (args->progress)
 		argv[i++] = "--progress";
+	if (args->max_pack_size > 0) {
+		snprintf(buf1, sizeof(buf1), "--max-pack-size=%lu",
+			 args->max_pack_size);
+		argv[i++] = buf1;
+	}
 	if (args->max_object_count > 0) {
-		snprintf(buf, sizeof(buf), "--max-object-count=%lu",
+		snprintf(buf2, sizeof(buf2), "--max-object-count=%lu",
 			 args->max_object_count);
-		argv[i++] = buf;
+		argv[i++] = buf2;
 	}
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
@@ -271,6 +277,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_ofs_delta = 1;
 	if (server_supports("side-band-64k"))
 		use_sideband = 1;
+	if ((p = server_supports("limit-pack-size=")))
+		args->max_pack_size = strtoul(p + 16, NULL, 10);
 	if ((p = server_supports("limit-object-count=")))
 		args->max_object_count = strtoul(p + 19, NULL, 10);
 
diff --git a/send-pack.h b/send-pack.h
index eaacb20..1c6c202 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -12,6 +12,7 @@ struct send_pack_args {
 		use_ofs_delta:1,
 		dry_run:1,
 		stateless_rpc:1;
+	unsigned long max_pack_size;
 	unsigned long max_object_count;
 };
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index f1f8f80..26fd1b4 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,4 +288,66 @@ test_expect_success 'push is allowed when object limit is not exceeded' '
 	test "$parent_head" = "$child_head"
 '
 
+test_expect_success 'verify that limit-pack-size capability is not advertised by default' '
+	rewound_push_setup &&
+	(
+	    cd parent &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    test_must_fail grep -q "limit-pack-size" output
+	)
+'
+
+test_expect_success 'verify that receive.packSizeLimit triggers limit-pack-size capability' '
+	(
+	    cd parent &&
+	    git config receive.packSizeLimit 10 &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    grep -q "limit-pack-size=10" output
+	)
+'
+
+test_expect_success 'deny pushing when receive.packSizeLimit is exceeded' '
+	(
+	    cd child &&
+	    git reset --hard origin/master &&
+	    echo three > file && git commit -a -m three &&
+	    test_must_fail git send-pack ../parent master 2>errs &&
+	    grep -q "pack size limit" errs
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
+	    grep -q "pack size limit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" != "$child_head"
+'
+
+test_expect_success 'increase receive.packSizeLimit' '
+	(
+	    cd parent &&
+	    git config receive.packSizeLimit 1000000 &&
+	    test_might_fail git receive-pack . <../pkt-flush >output &&
+	    grep -q "limit-pack-size=1000000" output
+	)
+'
+
+test_expect_success 'push is allowed when pack size is not exceeded' '
+	(
+	    cd child &&
+	    git send-pack ../parent master 2>errs &&
+	    test_must_fail grep -q "pack size limit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" = "$child_head"
+'
+
 test_done
-- 
1.7.5.rc1.3.g4d7b
