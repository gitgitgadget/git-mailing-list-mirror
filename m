From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/10] merge: force edit mode when merging a tag object
Date: Fri,  4 Nov 2011 23:01:40 -0700
Message-ID: <1320472900-6601-11-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKn-0005jr-Ph
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab1KEGCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:02:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab1KEGCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:02:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2239C3C32
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:02:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tuY7
	GTOOpH5gA6MQqbnXAZg4b+A=; b=iOuEbXRRMAhhHjp1Tod2rr1N+LKPse5pUKe/
	h2oqoQj6gM1OQQMP6PhZOSrAOoPBP6H7UsET5nGhdLyYxMv8FMG4czR7ICjzoP+h
	8eBGHUej1/OSrgyPqPNQym/WB3qTSRgTy8V/BhTz8lOQhKpvk5DapO9AoBw9VRNn
	eDSaJog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=w0nVzC
	PUopWNNJ//8cOUtU7QlCDP+zgVMgBRFwDkseGcX/iWaR99OPA9YyUhdqGlH8HIsb
	to+8kQPUgoqCgE8499XpZKCRwoY96YiTjVTixK33e5F/njbdw/GFzFpvtuD4yuZj
	U7sDoGPlYoUWmwppiV/TeYp5P2a9atVIOEEko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06B773C31
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:02:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E32D3C30 for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:02:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AE2CFCB6-0773-11E1-861B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184829>

Now that we allow pulling a tag from the remote site to validate the
authenticity, we should give the user the final chance to verify and
edit the merge message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * ... and finally.  Obviously this makes it necessary for the series to
   be applied on 3dfbe68 (Merge branch 'js/merge-edit-option', 2011-10-19)
   or newer.

 builtin/merge.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 48e7f00..6b63bbd 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -406,13 +406,15 @@ static void finish(struct commit *head_commit,
 	strbuf_release(&reflog_message);
 }
 
-static struct object *want_commit(const char *name)
+static struct object *want_commit(const char *name, enum object_type *real_type)
 {
 	struct object *obj;
 	unsigned char sha1[20];
 	if (get_sha1(name, sha1))
 		return NULL;
 	obj = parse_object(sha1);
+	if (real_type)
+		*real_type = obj->type;
 	return peel_to_type(name, 0, obj, OBJ_COMMIT);
 }
 
@@ -431,7 +433,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	remote = bname.buf;
 
 	memset(branch_head, 0, sizeof(branch_head));
-	remote_head = want_commit(remote);
+	remote_head = want_commit(remote, NULL);
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
@@ -1204,7 +1206,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!allow_fast_forward)
 			die(_("Non-fast-forward commit does not make sense into "
 			    "an empty head"));
-		remote_head = want_commit(argv[0]);
+		remote_head = want_commit(argv[0], NULL);
 		if (!remote_head)
 			die(_("%s - not something we can merge"), argv[0]);
 		read_empty(remote_head->sha1, 0);
@@ -1253,8 +1255,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		struct object *o;
 		struct commit *commit;
+		enum object_type real_type;
 
-		o = want_commit(argv[i]);
+		o = want_commit(argv[i], &real_type);
 		if (!o)
 			die(_("%s - not something we can merge"), argv[i]);
 		commit = lookup_commit(o->sha1);
@@ -1264,6 +1267,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, "GITHEAD_%s", sha1_to_hex(o->sha1));
 		setenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
+		if (real_type == OBJ_TAG)
+			option_edit = 1;
 	}
 
 	if (!use_strategies) {
@@ -1321,7 +1326,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (have_message)
 			strbuf_addstr(&msg,
 				" (no commit created; -m option ignored)");
-		o = want_commit(sha1_to_hex(remoteheads->item->object.sha1));
+		o = want_commit(sha1_to_hex(remoteheads->item->object.sha1), NULL);
 		if (!o)
 			return 1;
 
-- 
1.7.8.rc0.108.g71b5ec
