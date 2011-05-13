From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] receive-pack: Add receive.denyObjectLimit to refuse push with too many objects
Date: Fri, 13 May 2011 18:54:31 +0200
Message-ID: <201105131854.31540.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 18:54:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvdU-0002xN-TQ
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 18:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759611Ab1EMQyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 12:54:40 -0400
Received: from smtp.opera.com ([213.236.208.81]:39305 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759258Ab1EMQyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 12:54:39 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p4DGsVfE018122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 13 May 2011 16:54:31 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173551>

The new receive.denyObjectLimit config variable defines an upper limit on the
number of objects to accept in a single push. If the number of objects in a
push exceeds this limit, the entire push is immediately aborted without
storing the pushed objects on the server at all.

This is meant to prevent an unintended large push (typically a result of the
user not being aware of exactly what is being pushed, e.g. pushing a large
rewritten history) from entering the repo.

Usually, this kind of limit could be imposed by a pre-receive or update hook,
but both of those run _after_ the pack has been received and stored by
receive-pack, so they cannot prevent the pack from being transferred in the
first place.

Documentation and tests are included.

Signed-off-by: Johan Herland <johan@herland.net>
---

There's something weird going on here: The included test case works as
intended, but when I try to test this in "real-world" conditions,
I don't get the expected error message in the output:

  # From inside my git.git repo:
  $ git init --bare foo.git
  $ (cd foo.git && git config receive.denyObjectLimit 100000)
  $ git push foo.git/ master
  Pushing to foo.git/
  Counting objects: 112383, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (27658/27658), done.
  error: pack-objects died of signal 13
  error: failed to push some refs to 'foo.git/'
  $

So the pack-objects on the local side dies of a broken pipe (as
expected), but the error message from the remote side:

  error: unpack failed: received pack exceeds configured receive.denyObjectLimit

is never printed, so the user gets no clue as to why the push failed.
This should be fixed before this patch can be considered for inclusion.


...Johan


 Documentation/config.txt |    9 +++++++++
 builtin/receive-pack.c   |   10 +++++++++-
 t/t5400-send-pack.sh     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 285c7f7..7c60146 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1591,6 +1591,15 @@ receive.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+receive.denyObjectLimit::
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
index e1ba4dc..856650f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -25,6 +25,7 @@ static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects;
+static int receive_deny_limit;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
@@ -63,6 +64,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.denyobjectlimit") == 0) {
+		receive_deny_limit = git_config_int(var, value);
+		return 0;
+	}
+
 	if (strcmp(var, "receive.unpacklimit") == 0) {
 		receive_unpack_limit = git_config_int(var, value);
 		return 0;
@@ -648,7 +654,9 @@ static const char *unpack(void)
 			"--pack_header=%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+	if (receive_deny_limit > 0 && ntohl(hdr.hdr_entries) > receive_deny_limit)
+		return "received pack exceeds configured receive.denyObjectLimit";
+	else if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i = 0;
 		const char *unpacker[4];
 		unpacker[i++] = "unpack-objects";
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0eace37..2fbe34b 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -222,4 +222,48 @@ test_expect_success 'deny pushing to delete current branch' '
 	)
 '
 
+test_expect_success 'deny pushing when receive.denyObjectLimit is exceeded' '
+	rewound_push_setup &&
+	(
+	    cd parent &&
+	    git config receive.denyObjectLimit 1
+	) &&
+	(
+	    cd child &&
+	    git reset --hard origin/master &&
+	    echo three > file && git commit -a -m three &&
+	    test_must_fail git send-pack ../parent master 2>errs &&
+	    grep -q "receive\\.denyObjectLimit" errs
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
+	    grep -q "receive\\.denyObjectLimit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" != "$child_head"
+'
+
+test_expect_success 'increasing receive.denyObjectLimit allows the push' '
+	(
+	    cd parent &&
+	    git config receive.denyObjectLimit 10
+	) &&
+	(
+	    cd child &&
+	    git send-pack ../parent master 2>errs &&
+	    test_must_fail grep -q "receive\\.denyObjectLimit" errs
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd child && git rev-parse --verify master) &&
+	test "$parent_head" = "$child_head"
+'
+
 test_done
-- 
1.7.5.1.354.g761178


-- 
Johan Herland, <johan@herland.net>
www.herland.net
