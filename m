From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] fetch: allow asking for an explicit commit object by
 name
Date: Tue, 13 Sep 2011 15:28:15 -0700
Message-ID: <1315952896-17258-2-git-send-email-gitster@pobox.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <1315952896-17258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3bSt-0004eG-Lc
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 00:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967Ab1IMW2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 18:28:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932958Ab1IMW2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 18:28:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57B6043EB
	for <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xnQU
	J4EyABLsTTFNwoN5vCkDpsE=; b=ic0OB1x2YjLeHpdoX11ZqiS/AeUCFrmURquq
	2YwUuJDaWhHD6T/wN6hTxZejR3JdDiC2jHR+OvdSzlxDtDDzAnC1TsjoYPF1hT6T
	dprDMFPH2XLR0FJcOsvCIkF+bIoZ09MuBFO5+4JGxCQISm7cWevceqm9Vf7GthUN
	sS94PTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DyjQpE
	9HW4BQH6zjOy+Sys1jhUuIYpuCD2VTD/Q1UZlf4EPvw1xVqCiBrS+fc/LBcL9W78
	NtqfK128s6qwpqbFFkDsOuWReRAAFgBgSlMUhm/eANPBdN8CyXH3JhP7jXXG+H2O
	QcTi0Rsu1rkGfhXXigszKCG6US3sv8P/JPFZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 500D743EA
	for <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D2D843E5 for
 <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:19 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc1.1.g1e5814
In-Reply-To: <1315952896-17258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AEC137A4-DE57-11E0-B30F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181317>

This teaches "git fetch" (hence "git pull") to accept an explicit commit
object name in the LHS of the refspec, as long as the named commit is at
the tip of an advertised ref. E.g.

    $ git pull origin 5738c9c21e53356ab5020912116e7f82fd2d428f
    $ git fetch origin 5738c9c21e53356ab5020912116e7f82fd2d428f:refs/remotes/origin

would behave exactly as if you asked

    $ git pull origin refs/heads/master
    $ git fetch origin refs/heads/master:refs/remotes/origin

when the output from "git ls-remote origin" said the remote side has the
commit object whose name is 5738c9c21e53356ab5020912116e7f82fd2d428f at
the tip of refs/heads/master branch ref.

This does not allow asking for a random object that may or may not exist
in the repository (this has been a longstanding security feature).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index ca42a12..76c2943 100644
--- a/remote.c
+++ b/remote.c
@@ -1387,6 +1387,25 @@ struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
 	return copy_ref(ref);
 }
 
+/*
+ * Allow fetching an explicitly-named commit from the command line,
+ * but only if it exactly matches the commit at the tip of one of the
+ * advertised refs.
+ */
+static struct ref *get_remote_commit(const struct ref *remote_refs, const char *hex)
+{
+	const struct ref *ref;
+	unsigned char sha1[20];
+
+	if (get_sha1_hex(hex, sha1) || hex[40])
+		return NULL;
+
+	for (ref = remote_refs; ref; ref = ref->next)
+		if (!strchr(ref->name, '^') && !hashcmp(sha1, ref->old_sha1))
+			return copy_ref(ref);
+	return NULL;
+}
+
 static struct ref *get_local_ref(const char *name)
 {
 	if (!name || name[0] == '\0')
@@ -1416,8 +1435,10 @@ int get_fetch_map(const struct ref *remote_refs,
 		const char *name = refspec->src[0] ? refspec->src : "HEAD";
 
 		ref_map = get_remote_ref(remote_refs, name);
-		if (!missing_ok && !ref_map)
-			die("Couldn't find remote ref %s", name);
+		if (!ref_map)
+			ref_map = get_remote_commit(remote_refs, name);
+		if (!ref_map && !missing_ok)
+			die("Couldn't find remote ref that matches %s", name);
 		if (ref_map) {
 			ref_map->peer_ref = get_local_ref(refspec->dst);
 			if (ref_map->peer_ref && refspec->force)
-- 
1.7.7.rc1.1.g1e5814
