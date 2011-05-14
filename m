From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 2/2] receive-pack: Add receive.objectCountLimit to refuse
 push with too many objects
Date: Sat, 14 May 2011 04:03:09 +0200
Message-ID: <201105140403.09981.johan@herland.net>
References: <201105131854.31540.johan@herland.net>
 <7vpqnm7cim.fsf@alter.siamese.dyndns.org>
 <201105140343.48741.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 04:04:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QL4D6-00031v-T2
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 04:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968Ab1ENCDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 22:03:13 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51862 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab1ENCDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 22:03:12 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL5009HGXPBZI40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 04:03:11 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A85811EA561A_DCDE2DFB	for <git@vger.kernel.org>; Sat,
 14 May 2011 02:03:11 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 607E51EA2A6D_DCDE2DFF	for <git@vger.kernel.org>; Sat,
 14 May 2011 02:03:11 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL500A61XPAWR10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 04:03:11 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <201105140343.48741.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173571>

The new receive.objectCountLimit config variable defines an upper limit
on the number of objects to accept in a single push. If the number of
objects in a push exceeds this limit, the entire push is discarded
without storing the pushed objects on the server at all.

This is meant to prevent an unintended large push (typically a result
of the user not being aware of exactly what is being pushed,
e.g. pushing a large rewritten history) from entering the repo.

Usually, this kind of limit could be imposed by a pre-receive or update
hook, but both of those run _after_ the pack has been received and
stored by receive-pack, so they cannot prevent the pack from being
stored on the server.

Documentation and tests are included.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

Here is the re-roll with "receive-in-core-and-discard", plus the config
variable rename.


Have fun! :)

...Johan


 Documentation/config.txt |    9 +++++++++
 builtin/receive-pack.c   |   14 +++++++++++++-
 t/t5400-send-pack.sh     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 285c7f7..b356956 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1591,6 +1591,15 @@ receive.unpackLimit::
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
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e1ba4dc..f521c83 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -25,6 +25,7 @@ static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects;
+static int receive_object_count_limit;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
@@ -63,6 +64,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.objectcountlimit") == 0) {
+		receive_object_count_limit = git_config_int(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.unpacklimit") == 0) {
 		receive_unpack_limit = git_config_int(var, value);
 		return 0;
@@ -648,7 +654,13 @@ static const char *unpack(void)
 			"--pack_header=%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (receive_object_count_limit > 0 &&
+	    ntohl(hdr.hdr_entries) > receive_object_count_limit) {
+		char buf[1024];
+		while (xread(0, buf, 1024) > 0)
+			; /* nothing */
+		return "received pack exceeds configured receive.objectCountLimit";
+	} else if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i = 0;
 		const char *unpacker[4];
 		unpacker[i++] = "unpack-objects";
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0eace37..9198019 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -222,4 +222,48 @@ test_expect_success 'deny pushing to delete current branch' '
 	)
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
+test_expect_success 'increasing receive.objectCountLimit allows the push' '
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
