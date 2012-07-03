From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 04/25] sha1_name.c: get rid of get_sha1_with_mode()
Date: Tue,  3 Jul 2012 14:36:54 -0700
Message-ID: <1341351435-31011-5-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAoj-0007F5-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203Ab2GCViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756428Ab2GCVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 895D2862B
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=H+n+
	1c6KWgW3r6SH/r+X8HCkpww=; b=Nc1wioHxcW9ILgKY4SvHH4ups0MdIKCw6EGz
	4MM4imvhGPSdiPkg23kOPqXyVd8WVqkbeWyC99o3PfbFjZqOJgL/dp/4iYBMLosW
	eGx+mM1VqcR9AYO9cE6j/IKZ4YtCNPRrF3X7mA6cxoODqDtpmDUnjX6MRuIK6cbP
	t19SerU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wEc44F
	nkUuJCKdN7VBj4YbVAoLXwE9TPYdDgG+v92jpHhipBcxwT6OHjFbNKxN7LV8pv5D
	/Zq4TU6sVJ9j1UD/PkxfYon0DFOqcvIyI/Q627x8fv76cUlytV+FvYaZ67j3h8KN
	2eU7CHFFHG6gCld23K8k8EGubPSUXkvZDZxTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 811CC862A
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE34B8628 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 46E1E56A-C557-11E1-8101-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200968>

There are only two callers, and they will benefit from being able to
pass disambiguation hints to underlying get_sha1_with_context() API
once it happens.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |  1 -
 revision.c  | 12 ++++++------
 sha1_name.c |  8 --------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index beafa5b..2aa9fb6 100644
--- a/cache.h
+++ b/cache.h
@@ -812,7 +812,6 @@ struct object_context {
 };
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc);
 
diff --git a/revision.c b/revision.c
index 064e351..86a14c8 100644
--- a/revision.c
+++ b/revision.c
@@ -1097,7 +1097,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs,
 			int flags,
 			int cant_be_filename)
 {
-	unsigned mode;
+	struct object_context oc;
 	char *dotdot;
 	struct object *object;
 	unsigned char sha1[20];
@@ -1180,13 +1180,13 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs,
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1_with_mode(arg, sha1, &mode))
+	if (get_sha1_with_context(arg, sha1, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
-	add_pending_object_with_mode(revs, object, arg, mode);
+	add_pending_object_with_mode(revs, object, arg, oc.mode);
 	return 0;
 }
 
@@ -1794,11 +1794,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->def && !revs->pending.nr && !got_rev_arg) {
 		unsigned char sha1[20];
 		struct object *object;
-		unsigned mode;
-		if (get_sha1_with_mode(revs->def, sha1, &mode))
+		struct object_context oc;
+		if (get_sha1_with_context(revs->def, sha1, &oc))
 			die("bad default revision '%s'", revs->def);
 		object = get_reference(revs, revs->def, sha1, 0);
-		add_pending_object_with_mode(revs, object, revs->def, mode);
+		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
diff --git a/sha1_name.c b/sha1_name.c
index df583c2..e63459b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1139,14 +1139,6 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 	get_sha1_with_context_1(name, sha1, &oc, 1, prefix);
 }
 
-int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
-{
-	struct object_context oc;
-	int ret = get_sha1_with_context_1(str, sha1, &oc, 0, NULL);
-	*mode = oc.mode;
-	return ret;
-}
-
 int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc)
 {
 	return get_sha1_with_context_1(str, sha1, orc, 0, NULL);
-- 
1.7.11.1.229.g706c98f
