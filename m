From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] push --lockref: implement logic to populate old_sha1_expect[]
Date: Thu, 11 Jul 2013 15:26:18 -0700
Message-ID: <1373581580-13651-5-git-send-email-gitster@pobox.com>
References: <1373581580-13651-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 00:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPKE-0002ZM-DH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab3GKW0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:26:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488Ab3GKW0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:26:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 035C9303FA
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=HhGL
	9RxSXYBJ01qZf6S/9Aj6Lz4=; b=k9Uki0YjfLFVf67zA2ryvJBlrygINeFrIGl4
	7NyCX/CTD5m2FtKsqNAdOHTjJJCEpACmSUHe1oQlP0AzxObeqdSAFBoqSuXeuv2B
	K7psCpYnr6HrxVvXIT/IsdbWzXnWDBx+/3CZORARo2cYS2QT5pFYMwfSaU6SUtVp
	0cvv4DE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BvKSGd
	d0d3T5UI14TosMtwPq/aKPKMw9sbsrxiGLRWM+vuba0/yRRAuPW0GpUq7SNprULO
	x+w8Ou5cJ2bdlsoPSpnLAW7jlcg7UVbWssuGcxWGl/rUElpteR5ifggoaOUc0cJW
	XnxeX7FmGmx2bqwI8boAPo8rbdXFaQp4OPypU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE44A303F9
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0949A303F4
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:29 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373581580-13651-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EEF396A8-EA78-11E2-95C1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230141>

This plugs the push_cas_option data collected by the command line
option parser to the transport system with a new function
apply_push_cas(), which is called after match_push_refs() has
already been called.

At this point, we know which remote we are talking to, and what
remote refs we are going to update, so we can fill in the details
that may have been missing from the command line, such as

 (1) what abbreviated refname the user gave us matches the actual
     refname at the remote; and

 (2) which remote tracking branch in our local repository to read the
     value of the object to expect at the remote.

to populate the old_sha1_expect[] field of each of the remote ref.

Still nobody uses this information, which is the topic of the next
patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c      |  6 ++++++
 builtin/send-pack.c |  3 +++
 remote.c            | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h            |  6 ++++++
 transport.c         |  6 ++++++
 transport.h         |  4 ++++
 6 files changed, 86 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 31a5ba0..b0e3691 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -299,6 +299,12 @@ static int push_with_options(struct transport *transport, int flags)
 	if (thin)
 		transport_set_option(transport, TRANS_OPT_THIN, "yes");
 
+	if (!is_empty_cas(&cas)) {
+		if (!transport->smart_options)
+			die("underlying transport does not support --lockref option");
+		transport->smart_options->cas = &cas;
+	}
+
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index a23b26d..6027ead 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -242,6 +242,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	if (match_push_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
 		return -1;
 
+	if (!is_empty_cas(&cas))
+		apply_push_cas(&cas, remote, remote_refs);
+
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
 
diff --git a/remote.c b/remote.c
index 6014acd..93e5b65 100644
--- a/remote.c
+++ b/remote.c
@@ -1978,3 +1978,64 @@ int parseopt_push_cas_option(const struct option *opt, const char *arg, int unse
 {
 	return parse_push_cas_option(opt->value, arg, unset);
 }
+
+int is_empty_cas(const struct push_cas_option *cas)
+{
+	return !cas->use_tracking_for_rest && !cas->nr;
+}
+
+/*
+ * Look at remote.fetch refspec and see if we have a remote
+ * tracking branch for the refname there.  Fill its current
+ * value in sha1[].
+ * If we cannot do so, return negative to signal an error.
+ */
+static int remote_tracking(struct remote *remote, const char *refname,
+			   unsigned char sha1[20])
+{
+	char *dst;
+
+	dst = apply_refspecs(remote->fetch, remote->fetch_refspec_nr, refname);
+	if (!dst)
+		return -1; /* no tracking ref for refname at remote */
+	if (read_ref(dst, sha1))
+		return -1; /* we know what the tracking ref is but we cannot read it */
+	return 0;
+}
+
+static void apply_cas(struct push_cas_option *cas,
+		      struct remote *remote,
+		      struct ref *ref)
+{
+	int i;
+
+	/* Find an explicit --lockref=<name>[:<value>] entry */
+	for (i = 0; i < cas->nr; i++) {
+		struct push_cas *entry = &cas->entry[i];
+		if (!refname_match(entry->refname, ref->name, ref_rev_parse_rules))
+			continue;
+		ref->expect_old_sha1 = 1;
+		if (!entry->use_tracking)
+			hashcpy(ref->old_sha1_expect, cas->entry[i].expect);
+		else if (remote_tracking(remote, ref->name, ref->old_sha1_expect))
+			ref->expect_old_no_trackback = 1;
+		return;
+	}
+
+	/* Are we using "--lockref" to cover all? */
+	if (!cas->use_tracking_for_rest)
+		return;
+
+	ref->expect_old_sha1 = 1;
+	if (remote_tracking(remote, ref->name, ref->old_sha1_expect))
+		ref->expect_old_no_trackback = 1;
+}
+
+void apply_push_cas(struct push_cas_option *cas,
+		    struct remote *remote,
+		    struct ref *remote_refs)
+{
+	struct ref *ref;
+	for (ref = remote_refs; ref; ref = ref->next)
+		apply_cas(cas, remote, ref);
+}
diff --git a/remote.h b/remote.h
index 8070303..4c564c5 100644
--- a/remote.h
+++ b/remote.h
@@ -77,10 +77,13 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
+	unsigned char old_sha1_expect[20]; /* used by expect-old */
 	char *symref;
 	unsigned int
 		force:1,
 		forced_update:1,
+		expect_old_sha1:1,
+		expect_old_no_trackback:1,
 		deletion:1,
 		matched:1;
 
@@ -248,4 +251,7 @@ extern int parseopt_push_cas_option(const struct option *, const char *arg, int
 extern int parse_push_cas_option(struct push_cas_option *, const char *arg, int unset);
 extern void clear_cas_option(struct push_cas_option *);
 
+extern int is_empty_cas(const struct push_cas_option *);
+void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
+
 #endif
diff --git a/transport.c b/transport.c
index b84dbf0..5dd92b7 100644
--- a/transport.c
+++ b/transport.c
@@ -1142,6 +1142,12 @@ int transport_push(struct transport *transport,
 			return -1;
 		}
 
+		if (transport->smart_options &&
+		    transport->smart_options->cas &&
+		    !is_empty_cas(transport->smart_options->cas))
+			apply_push_cas(transport->smart_options->cas,
+				       transport->remote, remote_refs);
+
 		set_ref_status_for_push(remote_refs,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
diff --git a/transport.h b/transport.h
index b551f99..10f7556 100644
--- a/transport.h
+++ b/transport.h
@@ -14,6 +14,7 @@ struct git_transport_options {
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
+	struct push_cas_option *cas;
 };
 
 struct transport {
@@ -127,6 +128,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Transfer the data as a thin pack if not null */
 #define TRANS_OPT_THIN "thin"
 
+/* Check the current value of the remote ref */
+#define TRANS_OPT_CAS "cas"
+
 /* Keep the pack that was transferred if not null */
 #define TRANS_OPT_KEEP "keep"
 
-- 
1.8.3.2-912-g65cf5cf
