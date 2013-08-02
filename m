From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 9/6] push: teach --force-with-lease to smart-http transport
Date: Fri, 02 Aug 2013 16:14:48 -0700
Message-ID: <7v4nb7ptw7.fsf@alter.siamese.dyndns.org>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 01:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5OYh-000517-SY
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 01:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab3HBXOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 19:14:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab3HBXOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 19:14:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA95235B26;
	Fri,  2 Aug 2013 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJ2T9GKXncCZ+Mg3umnsckA8hNs=; b=yMaUXl
	P+IDk7AWVDSSEdtbNbVXfk1/IRVMFoqv/2UA+Dux7TIytxAI297JTakX9FV/2vZn
	DoiwsFBFQmS6CpETywTIoaduukQ598eUGWEub1bbeZpVSKSE4GaHltb88QZcD+59
	N0DzFN8BFrXBXqDA0nPVEra1VmjSNLruO446s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hs2i1MnP+OWqqJmEEdYW2sn+5IihyISc
	5d3sRL27GcK6sHMJ3o3Km7nrgaGGNuJqIXeh/8UDOg3hxvPywKw/ki1m4NJWMMaW
	W5xrcuFUH6SbrVVkx+t2VYJbHHNzaKPNJ6ZHXvZ+JWBnQDqj+Lt1wluRPI6TIR1I
	dseXB270oLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EF7F35B25;
	Fri,  2 Aug 2013 23:14:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACA1635B24;
	Fri,  2 Aug 2013 23:14:49 +0000 (UTC)
In-Reply-To: <1374561800-938-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 22 Jul 2013 23:43:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5460C4C8-FBC9-11E2-AF5F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231543>

We have been passing enough information to enable the
compare-and-swap logic down to the transport layer, but the
transport helper was not passing it to smart-http transport.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I didn't bother with the dumb commit walker push for obvious
   reasons, but if somebody is inclined to add one, it shouldn't be
   too hard to add.

 remote-curl.c        | 16 +++++++++++++++-
 t/lib-httpd.sh       |  3 ++-
 t/t5541-http-push.sh |  2 +-
 transport-helper.c   | 24 ++++++++++++++++++++++--
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 60eda63..53c8a3d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "pkt-line.h"
+#include "string-list.h"
 #include "sideband.h"
 
 static struct remote *remote;
@@ -20,6 +21,7 @@ struct options {
 		thin : 1;
 };
 static struct options options;
+static struct string_list cas_options = STRING_LIST_INIT_DUP;
 
 static int set_option(const char *name, const char *value)
 {
@@ -66,6 +68,13 @@ static int set_option(const char *name, const char *value)
 			return -1;
 		return 0;
 	}
+	else if (!strcmp(name, "cas")) {
+		struct strbuf val = STRBUF_INIT;
+		strbuf_addf(&val, "--" CAS_OPT_NAME "=%s", value);
+		string_list_append(&cas_options, val.buf);
+		strbuf_release(&val);
+		return 0;
+	}
 	else {
 		return 1 /* unsupported */;
 	}
@@ -789,8 +798,9 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	struct rpc_state rpc;
 	const char **argv;
 	int argc = 0, i, err;
+	struct string_list_item *cas_option;
 
-	argv = xmalloc((10 + nr_spec) * sizeof(char*));
+	argv = xmalloc((10 + nr_spec + cas_options.nr) * sizeof(char *));
 	argv[argc++] = "send-pack";
 	argv[argc++] = "--stateless-rpc";
 	argv[argc++] = "--helper-status";
@@ -803,6 +813,10 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	else if (options.verbosity > 1)
 		argv[argc++] = "--verbose";
 	argv[argc++] = options.progress ? "--progress" : "--no-progress";
+
+	for_each_string_list_item(cas_option, &cas_options)
+		argv[argc++] = cas_option->string;
+
 	argv[argc++] = url;
 	for (i = 0; i < nr_spec; i++)
 		argv[argc++] = specs[i];
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index e2eca1f..dab405d 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -141,10 +141,11 @@ stop_httpd() {
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
 }
 
-test_http_push_nonff() {
+test_http_push_nonff () {
 	REMOTE_REPO=$1
 	LOCAL_REPO=$2
 	BRANCH=$3
+	EXPECT_CAS_RESULT=${4-failure}
 
 	test_expect_success 'non-fast-forward push fails' '
 		cd "$REMOTE_REPO" &&
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index beb00be..470ac54 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -153,7 +153,7 @@ test_expect_success 'used receive-pack service' '
 '
 
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
-	"$ROOT_PATH"/test_repo_clone master
+	"$ROOT_PATH"/test_repo_clone master 		success
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
 	# create a dissimilarly-named remote ref so that git is unable to match the
diff --git a/transport-helper.c b/transport-helper.c
index 95d22f8..e3a60d7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -742,13 +742,15 @@ static void push_update_refs_status(struct helper_data *data,
 }
 
 static int push_refs_with_push(struct transport *transport,
-		struct ref *remote_refs, int flags)
+			       struct ref *remote_refs, int flags)
 {
 	int force_all = flags & TRANSPORT_PUSH_FORCE;
 	int mirror = flags & TRANSPORT_PUSH_MIRROR;
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref;
+	struct string_list cas_options = STRING_LIST_INIT_DUP;
+	struct string_list_item *cas_option;
 
 	get_helper(transport);
 	if (!data->push)
@@ -784,11 +786,29 @@ static int push_refs_with_push(struct transport *transport,
 		strbuf_addch(&buf, ':');
 		strbuf_addstr(&buf, ref->name);
 		strbuf_addch(&buf, '\n');
+
+		/*
+		 * The "--force-with-lease" options without explicit
+		 * values to expect have already been expanded into
+		 * the ref->old_sha1_expect[] field; we can ignore
+		 * transport->smart_options->cas altogether and instead
+		 * can enumerate them from the refs.
+		 */
+		if (ref->expect_old_sha1) {
+			struct strbuf cas = STRBUF_INIT;
+			strbuf_addf(&cas, "%s:%s",
+				    ref->name, sha1_to_hex(ref->old_sha1_expect));
+			string_list_append(&cas_options, strbuf_detach(&cas, NULL));
+		}
 	}
-	if (buf.len == 0)
+	if (buf.len == 0) {
+		string_list_clear(&cas_options, 0);
 		return 0;
+	}
 
 	standard_options(transport);
+	for_each_string_list_item(cas_option, &cas_options)
+		set_helper_option(transport, "cas", cas_option->string);
 
 	if (flags & TRANSPORT_PUSH_DRY_RUN) {
 		if (set_helper_option(transport, "dry-run", "true") != 0)
-- 
1.8.4-rc1-129-g1f3472b
