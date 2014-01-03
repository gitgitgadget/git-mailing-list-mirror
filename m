From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH V3 1/2] fetch --prune: Always print header url
Date: Thu,  2 Jan 2014 20:28:51 -0600
Message-ID: <1388716132-71437-1-git-send-email-jackerran@gmail.com>
Cc: gitster@pobox.com, Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 03 03:29:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyuW5-0000yx-TH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 03:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaACC3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 21:29:17 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:53349 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaACC3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 21:29:16 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so36687qac.7
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 18:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DxCGWdikqK7GoVOW+UH2/PGHIbpXfpCl40rXs207iLc=;
        b=kVhqr54RY2650ZlpCZDeUk+0RZL8Iz13+cKBaIvMsEZFweujhq4Hd4srxJGwpZNhZc
         pdjIaNKFjJh6llY54qzZqLplQcqq8vCloxQqCMJNSVSGav1wN61enORcRCU7Ai51bM8P
         MApyfmqZ7oCYLDY9lBylRIyR3JOldmthExfDqpH7+DA76mzwiHf+ErIoLMl44Kc3Du1I
         S2/Bw+XZEqK50pwzhJbhNETnflICxIZglEVaUtVjPJWzcd2fIqoR6RHKpjGQJwnFFof1
         YZFysEKkDrUBUmYRcQNVEYWiwd6ekz5voeTgCcfHGq9RaKKIqiDj8pDnNf7UoaFyhyad
         NS3w==
X-Received: by 10.229.249.66 with SMTP id mj2mr142337238qcb.4.1388716156060;
        Thu, 02 Jan 2014 18:29:16 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id l17sm77375236qej.13.2014.01.02.18.29.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 18:29:15 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.231.g4834e63.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239902>

If "fetch --prune" is run with no new refs to fetch, but it has refs
to prune. Then, the header url is not printed as it would if there were
new refs to fetch.

Output before this patch:

	$ git fetch --prune remote-with-no-new-refs
	 x [deleted]         (none)     -> origin/world

Output after this patch:

	$ git fetch --prune remote-with-no-new-refs
	From https://github.com/git/git
	 x [deleted]         (none)     -> origin/test

Signed-off-by: Tom Miller <jackerran@gmail.com>
---

I decided it is not worth writing a function to format the header url
that is printed by fetch. Instead, I will duplicate the formatting logic
for now because I plan on following up this patch set with another patch
to stop striping the trailing "/" and ".git" from the url. When that
patch is finished it will remove the majority of the duplicated logic.

 builtin/fetch.c  | 32 +++++++++++++++++++++++++++-----
 t/t5510-fetch.sh | 12 ++++++++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1e7d617..1b81cf9 100644
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
@@ -708,17 +709,36 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	return ret;
 }
 
-static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
+static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
+		const char *raw_url)
 {
-	int result = 0;
+	int url_len, i, result = 0;
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
+	url_len = strlen(url);
+	for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
+		;
+
+	url_len = i + 1;
+	if (4 < i && !strncmp(".git", url + i - 3, 4))
+		url_len = i - 3;
+
 	for (ref = stale_refs; ref; ref = ref->next) {
 		if (!dry_run)
 			result |= delete_ref(ref->name, NULL, 0);
+		if (verbosity >= 0 && !shown_url) {
+			fprintf(stderr, _("From %.*s\n"), url_len, url);
+			shown_url = 1;
+		}
 		if (verbosity >= 0) {
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
 				TRANSPORT_SUMMARY(_("[deleted]")),
@@ -726,6 +746,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
+	free(url);
 	free_refs(stale_refs);
 	return result;
 }
@@ -854,11 +875,12 @@ static int do_fetch(struct transport *transport,
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
index 5d4581d..87e896d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -614,4 +614,16 @@ test_expect_success 'all boundary commits are excluded' '
 	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
 '
 
+test_expect_success 'fetch --prune prints the remotes url' '
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
1.8.5.2.231.g4834e63.dirty
