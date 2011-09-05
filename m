From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] fetch.fsckobjects: verify downloaded objects
Date: Sun,  4 Sep 2011 19:21:35 -0700
Message-ID: <1315189297-19497-2-git-send-email-gitster@pobox.com>
References: <7vliu4yv8w.fsf@alter.siamese.dyndns.org>
 <1315189297-19497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 04:21:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Oom-00047d-F9
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 04:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1IECVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 22:21:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab1IECVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 22:21:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F1BD44FC
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LJGt
	cIa2aV17bVTX1H8CL7cZSmg=; b=AnesSyDfcjdYw7TPVV1loe656tfIJpKhXdyo
	6TuIduT07PS9Y1TNrnYGQC1W7Sem4UC8k5abfohGpz4S2pAAkEEFT1W0McsSeXqT
	UyTpIs4MEKi/c9c5U+LeXD3ZBE1vCo6MyJhuUm9tE9b7lGKPxzbaiWnoNGmr0deH
	oIQTbII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TugNKp
	Fg2/yT230QrKayHvlp5SbxqWKCmlcrYm4iDq5PQuPIj1kjC4+SJXbq3rQO4l1KTI
	yXNItEUZPuiSXaaP9AIFJNYWXyRqxVaJu19uZHCnqxxYA5DZ5ejQCqmFwM4J9un5
	iN0450VDGYziZUYB5RRlBJlcWOfU3SnJKGo1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4670C44FB
	for <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFD2744F9 for
 <git@vger.kernel.org>; Sun,  4 Sep 2011 22:21:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.175.gb3212
In-Reply-To: <1315189297-19497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CA5E2DDA-D765-11E0-85F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180708>

This corresponds to receive.fsckobjects configuration variable added (a
lot) earlier in 20dc001 (receive-pack: allow using --strict mode for
unpacking objects, 2008-02-25).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    6 ++++++
 builtin/fetch-pack.c     |    8 ++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 664de6b..4cbc4b9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -820,6 +820,12 @@ diff.wordRegex::
 	sequences that match the regular expression are "words", all other
 	characters are *ignorable* whitespace.
 
+fetch.fsckObjects::
+	If it is set to true, git-fetch-pack will check all fetched
+	objects. It will abort in the case of a malformed object or a
+	broken link. The result of an abort are only dangling objects.
+	Defaults to false.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..df6a8dc 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -14,6 +14,7 @@ static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
 static int prefer_ofs_delta = 1;
+static int fetch_fsck_objects;
 static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
@@ -663,6 +664,8 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	}
 	if (*hdr_arg)
 		*av++ = hdr_arg;
+	if (fetch_fsck_objects)
+		*av++ = "--strict";
 	*av++ = NULL;
 
 	cmd.in = demux.out;
@@ -776,6 +779,11 @@ static int fetch_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "fetch.fsckobjects")) {
+		fetch_fsck_objects = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
-- 
1.7.7.rc0.175.gb3212
