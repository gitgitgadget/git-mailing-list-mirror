From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH V2 1/2] fetch --prune: Always print header url
Date: Thu, 19 Dec 2013 16:57:11 -0600
Message-ID: <1387493832-13588-1-git-send-email-jackerran@gmail.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 23:57:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtmX4-0000dt-BR
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 23:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab3LSW50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 17:57:26 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:65381 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab3LSW5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 17:57:25 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so1678273qeb.22
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 14:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWP2GvoVYfS7KzXrfIp/yf+ZsBLJQvtA9sBRqMYObcA=;
        b=bm05wvL/FOORChU3qdI5SOQku8rA9LmR4C/uqR1pNWbd1fWf98WsoNLp7PIVZ9aonl
         usK7fm8NIWNEqMG3FfORkhKln6PjQxdvXs9PpeTOvhr56S/Kj4pL9Zlt+YMDnSrDyrxR
         qlH/EHfra0q9u35DUoed2TJgvGB6Taa1v9krC9KM/t1RPAZZ2heP249JYK8MbE3W9IEK
         QA/oSfHf5lrtde/OrS8QhSSkbbEQb47/K4/o6sVFzWd15KhGH1v/NV7e2VPj+XEvCMCM
         AYOsllQ0WYPghD7RFBLO9gB26Jr6FibjuGsms06K8ncu7xMlja9ClN7zon647/ifKwMo
         AURQ==
X-Received: by 10.224.24.194 with SMTP id w2mr8042169qab.48.1387493844782;
        Thu, 19 Dec 2013 14:57:24 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id c6sm3068737qev.15.2013.12.19.14.57.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 14:57:24 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.194.g00457d4
In-Reply-To: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239551>

If "fetch --prune" is run with no new refs to fetch, but it has refs
to prune. Then, the header url is not printed as it would if there were
new refs to fetch.

Output before this patch:

	$ git fetch --prune remote-with-no-new-refs
	 x [deleted]         (none)     -> origin/world

Output after this patch:

	$ git fetch --prune remote-with-no-new-refs
	From https://github.com/git/git.git
	 x [deleted]         (none)     -> origin/test

Signed-off-by: Tom Miller <jackerran@gmail.com>
---
 builtin/fetch.c  | 22 ++++++++++++++++++----
 t/t5510-fetch.sh | 12 ++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1e7d617..e6dc2d6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -44,6 +44,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
+static int shown_url = 0;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -535,7 +536,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 {
 	FILE *fp;
 	struct commit *commit;
-	int url_len, i, shown_url = 0, rc = 0;
+	int url_len, i, rc = 0;
 	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
@@ -708,17 +709,28 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	return ret;
 }
 
-static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
+static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
+		const char *raw_url)
 {
 	int result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
+	char *url;
 	const char *dangling_msg = dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
 
+	if (raw_url)
+		url = transport_anonymize_url(raw_url);
+	else
+		url = xstrdup("foreign");
+
 	for (ref = stale_refs; ref; ref = ref->next) {
 		if (!dry_run)
 			result |= delete_ref(ref->name, NULL, 0);
+		if (verbosity >= 0 && !shown_url) {
+			fprintf(stderr, _("From %s\n"), url);
+			shown_url = 1;
+		}
 		if (verbosity >= 0) {
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
 				TRANSPORT_SUMMARY(_("[deleted]")),
@@ -726,6 +738,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
+	free(url);
 	free_refs(stale_refs);
 	return result;
 }
@@ -854,11 +867,12 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (ref_count) {
-			prune_refs(refs, ref_count, ref_map);
+			prune_refs(refs, ref_count, ref_map, transport->url);
 		} else {
 			prune_refs(transport->remote->fetch,
 				   transport->remote->fetch_refspec_nr,
-				   ref_map);
+				   ref_map,
+				   transport->url);
 		}
 	}
 	free_refs(ref_map);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5d4581d..08a4841 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -614,4 +614,16 @@ test_expect_success 'all boundary commits are excluded' '
 	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
 '
 
+test_expect_success 'fetch --prune prints the remotes full url' '
+	git branch goodbye &&
+	git clone . only-prunes &&
+	git branch -D goodbye &&
+	(
+		cd only-prunes &&
+		git fetch --prune origin 2>&1 | head -n1 >../actual
+	) &&
+	echo "From ${D}/." >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.2.194.g00457d4
