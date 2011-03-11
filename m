From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] refs_from_alternate: helper to use refs from alternates
Date: Fri, 11 Mar 2011 12:51:10 -0800
Message-ID: <1299876671-12838-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 21:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py9J0-0005T6-Pw
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 21:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab1CKUvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 15:51:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1CKUvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 15:51:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD0ED4021;
	Fri, 11 Mar 2011 15:52:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=WbMIeo/wAMUq7lC6A1bChTBIfUE
	=; b=GGmF0gTRzec8NZyn+YTWqWb5gkNIXSVrjKQUubDTfZ3NsLjZLfNQpbAR79i
	ZGerRAdWbn37IRHuZdO+u1PECw6cseRb6ko/REETOx4d+6S02GP/L/5BTNxGF+xi
	h5J/TPojzI5fX5rGybivegwgZ4GMJVXD+614ToDy+f52n5p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=xhiDXbIzcIrfSyYGmteH6
	CHE+8puy8ejEKetwv76NvGpwH16VFo0R8oN4DErHf1UoQwqz3iRCeC6HEvh4OV66
	0OiHweHMQaSLRgQs2gw/3PKV2Z5MfVB+b5t0Ba0LUdvmwsBvEOVHy7Krxw7tJcow
	yKENgAEwgt6/qCDZSgu2wk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BAF49401F;
	Fri, 11 Mar 2011 15:52:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A7E64401D; Fri, 11 Mar 2011
 15:52:42 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.404.g62d316
X-Pobox-Relay-ID: 839D33B6-4C21-11E0-9F78-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168926>

The receiving end of "git push" advertises the objects that the repository
itself does not use, but are at the tips of refs in other repositories
whose object databases are used as alternates for it. This helps it avoid
having to receive (and the pusher having to send) objects that are already
available to the receiving repository via the alternates mechanism.

Tweak the helper function that implements this feature, and move it to
transport.[ch] for future reuse by other programs.

The additional test demonstrates how this optimization is helping "git push",
and "git fetch" is ignorant about it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c           |   35 ++------------------
 t/t5501-fetch-push-alternates.sh |   66 ++++++++++++++++++++++++++++++++++++++
 transport.c                      |   34 +++++++++++++++++++
 transport.h                      |    3 ++
 4 files changed, 106 insertions(+), 32 deletions(-)
 create mode 100755 t/t5501-fetch-push-alternates.sh

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 760817d..a5b5fc2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -731,43 +731,14 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
-static int add_refs_from_alternate(struct alternate_object_database *e, void *unused)
+static void add_one_alternate_ref(const struct ref *ref, void *unused)
 {
-	char *other;
-	size_t len;
-	struct remote *remote;
-	struct transport *transport;
-	const struct ref *extra;
-
-	e->name[-1] = '\0';
-	other = xstrdup(make_absolute_path(e->base));
-	e->name[-1] = '/';
-	len = strlen(other);
-
-	while (other[len-1] == '/')
-		other[--len] = '\0';
-	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
-		return 0;
-	/* Is this a git repository with refs? */
-	memcpy(other + len - 8, "/refs", 6);
-	if (!is_directory(other))
-		return 0;
-	other[len - 8] = '\0';
-	remote = remote_get(other);
-	transport = transport_get(remote, other);
-	for (extra = transport_get_remote_refs(transport);
-	     extra;
-	     extra = extra->next) {
-		add_extra_ref(".have", extra->old_sha1, 0);
-	}
-	transport_disconnect(transport);
-	free(other);
-	return 0;
+	add_extra_ref(".have", ref->old_sha1, 0);
 }
 
 static void add_alternate_refs(void)
 {
-	foreach_alt_odb(add_refs_from_alternate, NULL);
+	foreach_alt_odb(refs_from_alternate_cb, add_one_alternate_ref);
 }
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
new file mode 100755
index 0000000..564ef7c
--- /dev/null
+++ b/t/t5501-fetch-push-alternates.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='fetch/push involving alternates'
+. ./test-lib.sh
+
+count_objects () {
+	(
+		echo 0 &&
+		git count-objects -v |
+		sed -n -e 's/^count: \(.*\)/\1 +/p' \
+		    -e 's/^in-pack: \(.*\)/\1 +/p' &&
+		echo p
+	) | dc
+}
+
+
+test_expect_success setup '
+	(
+		git init original &&
+		cd original &&
+		i=0 &&
+		while test $i -le 100
+		do
+			echo "$i" >count &&
+			git add count &&
+			git commit -m "$i" || exit
+			i=$(($i + 1))
+		done
+	) &&
+	(
+		git clone --reference=original "file:///$(pwd)/original" one &&
+		cd one &&
+		echo Z >count &&
+		git add count &&
+		git commit -m Z &&
+		count_objects >../one.count
+	) &&
+	A=$(pwd)/original/.git/objects &&
+	git init receiver &&
+	echo "$A" >receiver/.git/objects/info/alternates &&
+	git init fetcher &&
+	echo "$A" >fetcher/.git/objects/info/alternates
+'
+
+test_expect_success 'pushing into a repository with the same alternate' '
+	(
+		cd one &&
+		git push ../receiver master:refs/heads/it
+	) &&
+	(
+		cd receiver &&
+		count_objects >../receiver.count
+	) &&
+	test_cmp one.count receiver.count
+'
+
+test_expect_failure 'fetching from a repository with the same alternate' '
+	(
+		cd fetcher &&
+		git fetch ../one master:refs/heads/it &&
+		count_objects >../fetcher.count
+	) &&
+	test_cmp one.count fetcher.count
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 0078660..3dfbc6a 100644
--- a/transport.c
+++ b/transport.c
@@ -1189,3 +1189,37 @@ char *transport_anonymize_url(const char *url)
 literal_copy:
 	return xstrdup(url);
 }
+
+int refs_from_alternate_cb(struct alternate_object_database *e, void *cb)
+{
+	char *other;
+	size_t len;
+	struct remote *remote;
+	struct transport *transport;
+	const struct ref *extra;
+	alternate_ref_fn *ref_fn = cb;
+
+	e->name[-1] = '\0';
+	other = xstrdup(make_absolute_path(e->base));
+	e->name[-1] = '/';
+	len = strlen(other);
+
+	while (other[len-1] == '/')
+		other[--len] = '\0';
+	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
+		return 0;
+	/* Is this a git repository with refs? */
+	memcpy(other + len - 8, "/refs", 6);
+	if (!is_directory(other))
+		return 0;
+	other[len - 8] = '\0';
+	remote = remote_get(other);
+	transport = transport_get(remote, other);
+	for (extra = transport_get_remote_refs(transport);
+	     extra;
+	     extra = extra->next)
+		ref_fn(extra, NULL);
+	transport_disconnect(transport);
+	free(other);
+	return 0;
+}
diff --git a/transport.h b/transport.h
index e803c0e..efb1968 100644
--- a/transport.h
+++ b/transport.h
@@ -166,4 +166,7 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
+typedef void alternate_ref_fn(const struct ref *, void *);
+extern int refs_from_alternate_cb(struct alternate_object_database *e, void *cb);
+
 #endif
-- 
1.7.4.1.404.g62d316
