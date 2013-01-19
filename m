From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] upload-pack: allow hiding ref hiearchies
Date: Fri, 18 Jan 2013 16:37:06 -0800
Message-ID: <1358555826-11883-3-git-send-email-gitster@pobox.com>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Cc: spearce@spearce.org, mfick@codeaurora.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 01:37:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwMRS-0002Po-AP
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 01:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab3ASAhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 19:37:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753890Ab3ASAhO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 19:37:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A676A0B7;
	Fri, 18 Jan 2013 19:37:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+e9a
	OHWz9LcPUO9b0HOXCzhizpU=; b=kpj0+pswoUcaNbziUHNQWtdHov7galfQ5yDk
	GdEY4gHyH8wxoYZXINrP2FVa7IzTGkZm/Kwlx0HEgLtxtJ1mcqFGcHLkI/I3r9nh
	p6OaN5wlC3Zde6H+oeiB9MwfwFyyMUGoX7lzT2kr5JQ6Dc/CvPq0O/IJ4XfnYyy4
	wO6GyjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	UUJPWYlh5b6sSenhqLgkwpKWLMGUzWuGm6sfZCvU7NeJ6KnjqnNN2lkJs9gqgxKg
	585/Rs33JXqCr5/XwW0x60KrgjPQpNneN7MZ5Gto2cEyTMagzLIsXTaKJJg5OPyP
	TEawn1Yj2PjiPh/8QjF2nyAYreioGUJgH4+hFytL2LA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD5BA0B6;
	Fri, 18 Jan 2013 19:37:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 982E9A0B3; Fri, 18 Jan 2013
 19:37:12 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.454.g48d39c0
In-Reply-To: <1358555826-11883-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5D9E8C52-61D0-11E2-9BFE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213953>

Teach upload-pack to omit some refs from the initial advertisement
by introducing the uploadPack.hiderefs multivalued configuration
variable.  Any ref that is under the hierarchies listed on the value
of this variable is excluded from responses to "ls-remote", "fetch"
or "clone" requests.  One typical use case may be

	[uploadPack]
		hiderefs = refs/changes

Note that the underlying protocol allows a request to fetch objects
at the tip of any ref, including the hidden ones, but on the client
side (e.g. fetch-pack), the requests are checked against the
ls-remote response, so it cannot ask for refs/changes/72/41672/1, or
for the object name (which is what eventually goes over the wire on
"want" line) the user may obtain out of band (e.g. Gerrit
dashboard).  A new capability "allow-tip-sha1-in-want" is returned
by upload-pack to signal updated clients that it may be OK to ask
for objects that were not advertised.

If we want to allow fetching refname that is hidden, e.g.

	$ git fetch $there refs/changes/72/41672/1

we need to further update the server side to understand a message
that has the refname instead of object name on "want" line.  The
necessary change to the server side to support that is not in this
step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5512-ls-remote.sh |  9 ++++++++
 upload-pack.c        | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index d16e5d3..9ee3d2a 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -126,4 +126,13 @@ test_expect_success 'Report match with --exit-code' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Hide some refs' '
+	test_config uploadPack.hiderefs refs/tags &&
+	git ls-remote . >actual &&
+	test_unconfig uploadPack.hiderefs &&
+	git ls-remote . |
+	sed -e "/	refs\/tags\//d" >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 3dd220d..54c304d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "version.h"
+#include "string-list.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
@@ -28,10 +29,13 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<
 
 static unsigned long oldest_have;
 
-static int multi_ack, nr_our_refs;
+static int multi_ack;
+static int nr_our_refs; /* This counts both advertised and unadvertised */
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
+static struct string_list *hide_refs;
+static int allow_tip_sha1_in_want;
 static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
@@ -722,6 +726,23 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
+static int ref_is_hidden(const char *refname)
+{
+	struct string_list_item *item;
+
+	if (!hide_refs)
+		return 0;
+	for_each_string_list_item(item, hide_refs) {
+		int len;
+		if (prefixcmp(refname, item->string))
+			continue;
+		len = strlen(item->string);
+		if (!refname[len] || refname[len] == '/')
+			return 1;
+	}
+	return 0;
+}
+
 static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *o = lookup_unknown_object(sha1);
@@ -743,11 +764,14 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	unsigned char peeled[20];
 
 	mark_our_ref(refname, sha1, flag, cb_data);
+	if (allow_tip_sha1_in_want && ref_is_hidden(refname))
+		return 0;
 
 	if (capabilities)
-		packet_write(1, "%s %s%c%s%s agent=%s\n",
+		packet_write(1, "%s %s%c%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
+			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     git_user_agent_sanitized());
 	else
@@ -758,11 +782,21 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
+static int check_hidden_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	if (!ref_is_hidden(refname))
+		return 0;
+	allow_tip_sha1_in_want = 1;
+	return 1; /* terminate iteration over refs early */
+}
+
 static void upload_pack(void)
 {
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
 		head_ref_namespaced(send_ref, NULL);
+		if (hide_refs)
+			for_each_namespaced_ref(check_hidden_ref, NULL);
 		for_each_namespaced_ref(send_ref, NULL);
 		packet_flush(1);
 	} else {
@@ -779,6 +813,28 @@ static void upload_pack(void)
 	}
 }
 
+static int upload_pack_config(const char *var, const char *value, void *unused)
+{
+	if (!strcmp("uploadpack.hiderefs", var)) {
+		char *ref;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		ref = xstrdup(value);
+		len = strlen(ref);
+		while (len && ref[len - 1] == '/')
+			ref[--len] = '\0';
+		if (!hide_refs) {
+			hide_refs = xcalloc(1, sizeof(*hide_refs));
+			hide_refs->strdup_strings = 1;
+		}
+		string_list_append(hide_refs, ref);
+		return 0;
+	}
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	char *dir;
@@ -830,6 +886,7 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
+	git_config(upload_pack_config, NULL);
 	if (getenv("GIT_DEBUG_SEND_PACK"))
 		debug_fd = atoi(getenv("GIT_DEBUG_SEND_PACK"));
 	upload_pack();
-- 
1.8.1.1.454.g48d39c0
