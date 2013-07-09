From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] remote.c: add command line option parser for --lockref
Date: Tue,  9 Jul 2013 12:53:27 -0700
Message-ID: <1373399610-8588-5-git-send-email-gitster@pobox.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
 <1373399610-8588-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 21:53:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdyt-0005y4-4V
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab3GITxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:53:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab3GITxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:53:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A68552F3CC
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rfqJ
	BnAzTNmH2iOSwkk1zwhj81E=; b=aXhUyHH6NJ4sl1MOo3FksdxsTAoV4LEGs9gJ
	kk6uPWh5t5PkW7S6uONluKjlMle9Z+5DCEDLY/nsSENNsxrZQAkK+GQkdt6w9NRy
	SjfUAIXU5lH/PSTWV2wEX8Nt0YA7C5hcEb9Smx0Au2QBydVUE0UXmSD4H2tYjCRr
	XF4BGOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lozCM9
	M1cbqEPjF0spfLLlFAARobCb2xhoSjJJChoSya2PthL/Vn3thkYD1jv6QPsDU7+A
	8Y5EinQNSCOw3G3NYbXTwsFl0t203AsvdHNmsgEOQHVkEpUaao+vkCBFpN3+5byj
	nLlcB4SxaHwoRXeM63jqusXuoybjtYuKoXN1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DC032F3CA
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA2362F3C8
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:39 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-875-g76c723c
In-Reply-To: <1373399610-8588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 40372DE4-E8D1-11E2-9070-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229988>

Update "git push" and "git send-pack" to parse this commnd line
option.

The intended sematics is:

 * "--lockref" alone, without specifying the details, will protect
   _all_ remote refs that are going to be updated by requiring their
   current value to be the same as the remote-tracking branch we
   have for them, unless otherwise specified;

 * "--lockref=refname", without specifying the expected value, will
   protect that refname, if it is going to be updated, by requiring
   its current value to be the same as the remote-tracking branch we
   have for it;

 * "--lockref=refname:value" will protect that refname, if it is
   going to be updated, by requiring its current value to be the
   same as the specified value (which is allowed to be different
   from the remote-tracking branch we have for the refname, or we do
   not even have to have such a remote-tracking branch when this
   form is used);

 * "--lockref=refname:" (empty value) is to expect that refname does
   not exist (yet); and

 * "--no-lockref" will cancel all the previous --lockref on the
   command line.

In any of the forms, when we try to use a remote-tracking branch for
the remote ref being updated, it is an error if there is no such
remote-tracking branch on our end.

Because the command line options are parsed _before_ we know which
remote we are pushing to, there needs further processing to the
parsed data after we instantiate the transport object to:

 * expand "refname" given by the user to a full refname to be
   matched with the list of "struct ref" used in match_push_refs()
   and set_ref_status_for_push(); and

 * learning the actual local ref that is the remote-tracking branch
   for the specified remote ref.

Further, some processing need to be deferred until we find the set
of remote refs and match_push_refs() returns in order to find the
ones that need to be checked after explicit ones have been processed
for "--lockref" (no specific details).

These post-processing will be the topic of the next patch.

Oh, of course, the option name is still not cast in stone.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c      |  6 ++++++
 builtin/send-pack.c | 17 +++++++++++++++
 remote.c            | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h            | 22 ++++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 342d792..31a5ba0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -21,6 +21,8 @@ static const char *receivepack;
 static int verbosity;
 static int progress = -1;
 
+static struct push_cas_option cas;
+
 static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
@@ -432,6 +434,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
+		{ OPTION_CALLBACK,
+		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
+		  N_("require old value of ref to be at this value"),
+		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c86c556..061e2b2 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -108,6 +108,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int flags;
 	unsigned int reject_reasons;
 	int progress = -1;
+	struct push_cas_option cas = {0};
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -170,6 +171,22 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				helper_status = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--" CAS_OPT_NAME)) {
+				if (parse_push_cas_option(&cas, NULL, 0) < 0)
+					exit(1);
+				continue;
+			}
+			if (!strcmp(arg, "--no-" CAS_OPT_NAME)) {
+				if (parse_push_cas_option(&cas, NULL, 1) < 0)
+					exit(1);
+				continue;
+			}
+			if (!prefixcmp(arg, "--" CAS_OPT_NAME "=")) {
+				if (parse_push_cas_option(&cas,
+							  strchr(arg, '=') + 1, 1) < 0)
+					exit(1);
+				continue;
+			}
 			usage(send_pack_usage);
 		}
 		if (!dest) {
diff --git a/remote.c b/remote.c
index 81bc876..e9b423a 100644
--- a/remote.c
+++ b/remote.c
@@ -1938,3 +1938,62 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	string_list_clear(&ref_names, 0);
 	return stale_refs;
 }
+
+/*
+ * Lockref aka CAS
+ */
+void clear_cas_option(struct push_cas_option *cas)
+{
+	int i;
+
+	for (i = 0; i < cas->nr; i++)
+		free(cas->entry->refname);
+	free(cas->entry);
+	memset(cas, 0, sizeof(*cas));
+}
+
+static struct push_cas *add_cas_entry(struct push_cas_option *cas,
+				      const char *refname,
+				      size_t refnamelen)
+{
+	struct push_cas *entry;
+	ALLOC_GROW(cas->entry, cas->nr + 1, cas->alloc);
+	entry = &cas->entry[cas->nr++];
+	memset(entry, 0, sizeof(*entry));
+	entry->refname = xmemdupz(refname, refnamelen);
+	return entry;
+}
+
+int parseopt_push_cas_option(const struct option *opt, const char *arg, int unset)
+{
+	return parse_push_cas_option(opt->value, arg, unset);
+}
+
+int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unset)
+{
+	const char *colon;
+	struct push_cas *entry;
+
+	if (unset) {
+		/* "--no-lockref" */
+		clear_cas_option(cas);
+		return 0;
+	}
+
+	if (!arg) {
+		/* just "--lockref" */
+		cas->use_tracking_for_rest = 1;
+		return 0;
+	}
+
+	/* "--lockref=refname" or "--lockref=refname:value" */
+	colon = strchrnul(arg, ':');
+	entry = add_cas_entry(cas, arg, colon - arg);
+	if (!*colon)
+		entry->use_tracking = 1;
+	else if (!colon[1])
+		hashclr(entry->expect);
+	else if (get_sha1(colon + 1, entry->expect))
+		return error("cannot parse expected object name '%s'", colon + 1);
+	return 0;
+}
diff --git a/remote.h b/remote.h
index 7ad37e6..28eb6a3 100644
--- a/remote.h
+++ b/remote.h
@@ -1,6 +1,8 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
+#include "parse-options.h"
+
 enum {
 	REMOTE_CONFIG,
 	REMOTE_REMOTES,
@@ -230,4 +232,24 @@ struct ref *guess_remote_head(const struct ref *head,
 /* Return refs which no longer exist on remote */
 struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map);
 
+/*
+ * Lockref aka CAS
+ */
+#define CAS_OPT_NAME "lockref"
+
+struct push_cas_option {
+	unsigned use_tracking_for_rest:1;
+	struct push_cas {
+		unsigned char expect[20];
+		unsigned use_tracking:1;
+		char *refname;
+	} *entry;
+	int nr;
+	int alloc;
+};
+
+extern int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
+extern int parse_push_cas_option(struct push_cas_option *, const char *arg, int unset);
+extern void clear_cas_option(struct push_cas_option *);
+
 #endif
-- 
1.8.3.2-875-g76c723c
