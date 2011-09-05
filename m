From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] transfer.fsckobjects: unify fetch/receive.fsckobjects
Date: Sun,  4 Sep 2011 19:21:36 -0700
Message-ID: <1315189297-19497-3-git-send-email-gitster@pobox.com>
References: <7vliu4yv8w.fsf@alter.siamese.dyndns.org>
 <1315189297-19497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 04:22:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Ooy-0004Bj-TM
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 04:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab1IECVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 22:21:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab1IECVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 22:21:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5601A4508
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xlzT
	YMPALZPUpJ5C6uOBx5ETpqU=; b=ltNqn/NHPM5dnqSuPPvOvoPHWMwdbPIQOykf
	B2F0EVmW+bqHjaJF9d+5ZP6JGhP+QhksDF6LLchcURadY0+7/L4eSztTFDZwP0uo
	yx8j9w/5VgApvkdfNGw5HukwJlxT2tVOErQTctpPNUYCTIneMEvKS3KS2fCaDG8V
	fgOXELA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WV4+ja
	/z2zjoSleru87pHcIcgBkhLRhRLyRXN8agta+M0/NroHs9wcbQLCh4gDxR9njRSE
	T7U7w4y8UUNW37HY7BNTgpjjz3FLojkQsPXZspaOeYj4GgH9E9vzfU27whBNybwO
	ozD+Qgp2yWvBt49mmY89bX0/fWbG9P6ZIClZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD634507
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B4304501 for
 <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.175.gb3212
In-Reply-To: <1315189297-19497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CB788382-D765-11E0-8DA9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180711>

This single variable can be used to set instead of setting fsckobjects
variable for fetch & receive independently.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |   11 +++++++++--
 builtin/fetch-pack.c     |   14 ++++++++++++--
 builtin/receive-pack.c   |   17 ++++++++++++++---
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4cbc4b9..d944403 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -824,7 +824,8 @@ fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
 	objects. It will abort in the case of a malformed object or a
 	broken link. The result of an abort are only dangling objects.
-	Defaults to false.
+	Defaults to false. If not set, the value of `transfer.fsckObjects`
+	is used instead.
 
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
@@ -1427,7 +1428,8 @@ receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
 	broken link. The result of an abort are only dangling objects.
-	Defaults to false.
+	Defaults to false. If not set, the value of `transfer.fsckObjects`
+	is used instead.
 
 receive.unpackLimit::
 	If the number of objects received in a push is below this
@@ -1616,6 +1618,11 @@ tar.umask::
 	archiving user's umask will be used instead.  See umask(2) and
 	linkgit:git-archive[1].
 
+transfer.fsckObjects::
+	When `fetch.fsckObjects` or `receive.fsckObjects` are
+	not set, the value of this variable is used instead.
+	Defaults to false.
+
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index df6a8dc..dac3038 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -14,7 +14,8 @@ static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
 static int prefer_ofs_delta = 1;
-static int fetch_fsck_objects;
+static int fetch_fsck_objects = -1;
+static int transfer_fsck_objects = -1;
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -664,7 +665,11 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 	if (*hdr_arg)
 		*av++ = hdr_arg;
-	if (fetch_fsck_objects)
+	if (fetch_fsck_objects >= 0
+	    ? fetch_fsck_objects
+	    : transfer_fsck_objects >= 0
+	    ? transfer_fsck_objects
+	    : 0)
 		*av++ = "--strict";
 	*av++ = NULL;
 
@@ -784,6 +789,11 @@ static int fetch_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "transfer.fsckobjects")) {
+		transfer_fsck_objects = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0559fcc..021ea65 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -23,7 +23,8 @@ static int deny_deletes;
 static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
-static int receive_fsck_objects;
+static int receive_fsck_objects = -1;
+static int transfer_fsck_objects = -1;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
@@ -77,6 +78,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "transfer.fsckobjects") == 0) {
+		transfer_fsck_objects = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "receive.denycurrentbranch")) {
 		deny_current_branch = parse_deny_action(var, value);
 		return 0;
@@ -586,6 +592,11 @@ static const char *unpack(void)
 	struct pack_header hdr;
 	const char *hdr_err;
 	char hdr_arg[38];
+	int fsck_objects = (receive_fsck_objects >= 0
+			    ? receive_fsck_objects
+			    : transfer_fsck_objects >= 0
+			    ? transfer_fsck_objects
+			    : 0);
 
 	hdr_err = parse_pack_header(&hdr);
 	if (hdr_err)
@@ -598,7 +609,7 @@ static const char *unpack(void)
 		int code, i = 0;
 		const char *unpacker[4];
 		unpacker[i++] = "unpack-objects";
-		if (receive_fsck_objects)
+		if (fsck_objects)
 			unpacker[i++] = "--strict";
 		unpacker[i++] = hdr_arg;
 		unpacker[i++] = NULL;
@@ -618,7 +629,7 @@ static const char *unpack(void)
 
 		keeper[i++] = "index-pack";
 		keeper[i++] = "--stdin";
-		if (receive_fsck_objects)
+		if (fsck_objects)
 			keeper[i++] = "--strict";
 		keeper[i++] = "--fix-thin";
 		keeper[i++] = hdr_arg;
-- 
1.7.7.rc0.175.gb3212
