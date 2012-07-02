From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/18] sha1_name.c: get rid of get_sha1_with_mode()
Date: Mon,  2 Jul 2012 15:33:55 -0700
Message-ID: <1341268449-27801-5-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpD0-0003YV-5Y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303Ab2GBWeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071Ab2GBWeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 767C49072
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=X00F
	G4bqXj7x9H+9SsLyvs0qxU4=; b=JuEL4uTTFMJkryNMilrCW6VmiaNN5OZRow5h
	24Qv7T15Hq7DWd3KdB07ZAbHoUg1wmrXftif/ujggqu/juh+m+fl9Mm2mOB2nTjo
	GukOEdmtTuMIzFWYfrwSUutRWQemv7Vr/DEPps+cd7hk8YFcwg88EmB60dKAxtJi
	TIqo2lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=whFj5A
	pVQPFDJeXq0Ee/v8BnAIDng4Y1r3N4BgFUfpzGlKv16MBZKa4iN6g1u0hbSRGAg3
	OT7ldzwv2UEoUfRvvr6fhAroBSlxwQlyWIygWRYwy943w7ERmIFRHe748R/2ZsMA
	4Mk/2idfTr4f11EboPZxaHRbVTPz1Eozd00aU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D8899071
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1C7E9070 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:18 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0FDBD6B4-C496-11E1-8C88-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200870>

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
index 2200110..3066b03 100644
--- a/cache.h
+++ b/cache.h
@@ -812,7 +812,6 @@ struct object_context {
 };
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
 extern void die_on_misspelt_object_name(const char *name, const char *prefix);
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
index 01ed48b..de41177 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1139,14 +1139,6 @@ void die_on_misspelt_object_name(const char *name, const char *prefix)
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
1.7.11.1.212.g52fe12e
