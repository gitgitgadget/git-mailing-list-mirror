From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH] fetch: Print full url in header
Date: Wed,  8 Jan 2014 20:39:18 -0600
Message-ID: <1389235158-21902-1-git-send-email-jackerran@gmail.com>
Cc: gitster@pobox.com, Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 03:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W15XT-0003Md-0d
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 03:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaAICjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 21:39:48 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:46926 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaAICjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 21:39:46 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so686041yha.26
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 18:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kpQDVynwQ+CnCgvSVgbovDXX3Bmc1GKSzz5P2XCM5/4=;
        b=f3JMJWa27UEKk0XDODWsgvYC0xPgIju+DY17rSf2Y5YhHq5gLACMBDyka1WY4EOMsY
         dUsKWdihQll7RVLPEep2WwNj2C6q4Jw7i9kUbr8NX9SjQngYfGzoPhAlJzKbl8S9NuoL
         OO6SpgJlbTNHyCRHivn4Fzzh07rhGH81s5aVvDCneJ2T5kQ6d/+rQEA3/cZkyOtisE5I
         9G5mo0pSakrnwao5XoHBp7YkiZG5e4Xq8saDtCK9itoX9qTTD6W4+TtNK+0NZCctqyHa
         FFYxN9UlR/H2NwXlGpDaTJ7SuAm8ZumSrI9Dvo8yX3S2VjanpR/n2J5fjuVz/2R3Lst4
         b3Gg==
X-Received: by 10.236.190.100 with SMTP id d64mr837589yhn.76.1389235184171;
        Wed, 08 Jan 2014 18:39:44 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id m68sm4164725yhj.22.2014.01.08.18.39.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 18:39:43 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.374.ga7e4b90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240241>

Do not remove "/" and ".git" from the end of the header url when
fetching. This affects the output of "fetch" and "fetch --prune"
making the header url more consistent with "remote --verbose".

Add tests to verify that "fetch" and "fetch --prune" do not strip the
trailing characters from the header url.

Output before this patch:

    $ git fetch remote-with-dot-git-and-slash
    From https://github.com/git/git
       a155a5f..5512ac5  maint      -> upstream/maint

Output after this patch:

    $ git fetch remote-with-dot-git-and-slash
    From https://github.com/git/git.git/
       a155a5f..5512ac5  maint      -> upstream/maint

Signed-off-by: Tom Miller <jackerran@gmail.com>
---

This patch should be based on the tip of "next" because it is dependent
on the code from "tm/fetch-prune".

Initially I thought I would stop anonymizing the header url as well.
Then I ran across this commit.

	> commit 47abd85ba06ed7209d1caa3e5ac7cc6b232bece4
	> Author: Andreas Ericsson <ae@op5.se>
	> Date:   Fri Apr 17 10:20:11 2009 +0200
	>
	>     fetch: Strip usernames from url's before storing them
	>
	>     When pulling from a remote, the full URL including username
	>     is by default added to the commit message. Since it adds
	>     very little value but could be used by malicious people to
	>     glean valid usernames (with matching hostnames), we're far
	>     better off just stripping the username before storing the
	>     remote URL locally.
	>
	>     Note that this patch has no lasting visible effect when
	>     "git pull" does not create a merge commit. It simply
	>     alters what gets written to .git/FETCH_HEAD, which is used
	>     by "git merge" to automagically create its messages.
	>
	>     Signed-off-by: Andreas Ericsson <ae@op5.se>
	>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

After reading this and trying different things with the code. I believe
it would make sense to continue to anonymize the url for output to the
terminal. I found if someone is using HTTP basic authentication and has
the username and password in the url. Then, one could unexpectedly
compromise their credentials during a fetch. I do not believe that
anyone should store their credentials in this way, but it is better safe
than sorry.

I also chose to continue to strip the trailing characters for the
FETCH_HEAD file.  I wanted the input of the mailing list to see if we
should also stop striping the trailing characters off of the url written
to FETCH_HEAD? If so, I'll do it as a seperate patch.

 builtin/fetch.c  | 15 +++------------
 t/t5510-fetch.sh | 29 ++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 025bc3e..01df749 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -664,8 +664,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 					    *what ? what : "HEAD");
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
-					fprintf(stderr, _("From %.*s\n"),
-							url_len, url);
+					fprintf(stderr, _("From %s\n"), url);
 					shown_url = 1;
 				}
 				if (verbosity >= 0)
@@ -723,7 +722,7 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 		const char *raw_url)
 {
-	int url_len, i, result = 0;
+	int result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
 	char *url;
 	const char *dangling_msg = dry_run
@@ -735,19 +734,11 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 	else
 		url = xstrdup("foreign");
 
-	url_len = strlen(url);
-	for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
-		;
-
-	url_len = i + 1;
-	if (4 < i && !strncmp(".git", url + i - 3, 4))
-		url_len = i - 3;
-
 	for (ref = stale_refs; ref; ref = ref->next) {
 		if (!dry_run)
 			result |= delete_ref(ref->name, NULL, 0);
 		if (verbosity >= 0 && !shown_url) {
-			fprintf(stderr, _("From %.*s\n"), url_len, url);
+			fprintf(stderr, _("From %s\n"), url);
 			shown_url = 1;
 		}
 		if (verbosity >= 0) {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 12674ac..882bfa1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -614,15 +614,34 @@ test_expect_success 'all boundary commits are excluded' '
 	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
 '
 
-test_expect_success 'fetch --prune prints the remotes url' '
+test_expect_success 'fetch prints the remotes full url' '
+	git clone . fetch-url-repo.git &&
+	git clone --mirror fetch-url-repo.git/ fetch-full-url &&
+	(
+		cd fetch-url-repo.git &&
+		git branch hello
+	) &&
+	(
+		cd fetch-full-url &&
+		git fetch origin 2>&1 | head -n1 >../actual
+	) &&
+	echo "From ${D}/fetch-url-repo.git/" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch --prune prints the remotes full url' '
 	git branch goodbye &&
-	git clone . only-prunes &&
-	git branch -D goodbye &&
+	git clone --mirror . fetch-prune-url-repo.git &&
+	git clone fetch-prune-url-repo.git/ fetch-prune-full-url &&
+	(
+		cd fetch-prune-url-repo.git &&
+		git branch -D goodbye
+	) &&
 	(
-		cd only-prunes &&
+		cd fetch-prune-full-url &&
 		git fetch --prune origin 2>&1 | head -n1 >../actual
 	) &&
-	echo "From ${D}/." >expect &&
+	echo "From ${D}/fetch-prune-url-repo.git/" >expect &&
 	test_cmp expect actual
 '
 
-- 
1.8.5.2.374.ga7e4b90
