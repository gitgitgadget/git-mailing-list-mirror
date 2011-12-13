From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] set_ref_status_for_push(): use transport-flags
 abstraction
Date: Tue, 13 Dec 2011 15:26:31 -0800
Message-ID: <7vsjkot5nc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 00:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rabk7-0003cL-EP
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab1LMX0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:26:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab1LMX0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:26:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED042760C;
	Tue, 13 Dec 2011 18:26:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	J43wQbqkeVo7vrmAK1shZRtk3s=; b=DA+cULaL7Jkku90L2o2TEB6tUXn/0qGcH
	0ZmbKHlNt2E4hngwQFpqbDHVyvPV8tumaITdEr4bWM8iFEEQB24Bb/0obl11f2Bh
	bEz5qo7xTtb3WMbftPzMv1a2kPWeb5/xFz3X6k37/WGERg+TQ/b/UnzK8QJpsowB
	W9SPZpapd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KQ4
	zvjSeCC+sTrElGEm76WCM0JOfu/Evqyw8KBCoDR19Kva02dtXf0V6/r7ZiBnHeqq
	cnzaNLj5wrmHrVhmvdSmTBOqRlThKoW0BFbQEEiIlB/wCuk3SJuN9C+yHIzcHrtj
	p1nh1ykiCMymlzlVY1VbdCjJsvo2awAAu6pp1+h4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44DC760B;
	Tue, 13 Dec 2011 18:26:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B318760A; Tue, 13 Dec 2011
 18:26:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E42CCA08-25E1-11E1-9907-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187078>

It does not make much sense to have separate "int" parameters to
this function with two callsites (why do we need to to begin with?
but that is a separate issue) and having to update them every time
we need to touch it.

Consolidate them into a single "flags" parameter to make it easier
to extend later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A preparatory step for the next one

 builtin/send-pack.c |   10 ++++++++--
 remote.c            |    6 ++++--
 remote.h            |    3 +--
 transport.c         |    4 +---
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e0b8030..ec107ed 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -404,6 +404,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int send_all = 0;
 	const char *receivepack = "git-receive-pack";
 	int flags;
+	unsigned transport_flags;
 	int nonfastforward = 0;
 
 	argv++;
@@ -512,8 +513,13 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	if (match_push_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
 		return -1;
 
-	set_ref_status_for_push(remote_refs, args.send_mirror,
-		args.force_update);
+	transport_flags = 0;
+	if (args.send_mirror)
+		transport_flags |= TRANSPORT_PUSH_MIRROR;
+	if (args.force_update)
+		transport_flags |= TRANSPORT_PUSH_FORCE;
+
+	set_ref_status_for_push(remote_refs, transport_flags);
 
 	ret = send_pack(&args, fd, conn, remote_refs, &extra_have);
 
diff --git a/remote.c b/remote.c
index 6655bb0..95d7f37 100644
--- a/remote.c
+++ b/remote.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "tag.h"
 #include "string-list.h"
+#include "transport.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -1223,10 +1224,11 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	return 0;
 }
 
-void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
-	int force_update)
+void set_ref_status_for_push(struct ref *remote_refs, unsigned flags)
 {
 	struct ref *ref;
+	int send_mirror = flags & TRANSPORT_PUSH_MIRROR;
+	int force_update = flags & TRANSPORT_PUSH_FORCE;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (ref->peer_ref)
diff --git a/remote.h b/remote.h
index b395598..0cf3c07 100644
--- a/remote.h
+++ b/remote.h
@@ -98,8 +98,7 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 
 int match_push_refs(struct ref *src, struct ref **dst,
 		    int nr_refspec, const char **refspec, int all);
-void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
-	int force_update);
+void set_ref_status_for_push(struct ref *remote_refs, unsigned flags);
 
 /*
  * Given a list of the remote refs and the specification of things to
diff --git a/transport.c b/transport.c
index 51814b5..95556da 100644
--- a/transport.c
+++ b/transport.c
@@ -1031,9 +1031,7 @@ int transport_push(struct transport *transport,
 			return -1;
 		}
 
-		set_ref_status_for_push(remote_refs,
-			flags & TRANSPORT_PUSH_MIRROR,
-			flags & TRANSPORT_PUSH_FORCE);
+		set_ref_status_for_push(remote_refs, flags);
 
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
-- 
1.7.8.249.gb1b73
