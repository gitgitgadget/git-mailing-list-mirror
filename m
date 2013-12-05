From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] push: use remote.$name.push as a refmap
Date: Wed,  4 Dec 2013 17:27:28 -0800
Message-ID: <1386206849-6503-3-git-send-email-gitster@pobox.com>
References: <1386117594-22062-1-git-send-email-gitster@pobox.com>
 <1386206849-6503-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 02:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoNjC-00043c-N3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 02:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab3LEB1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 20:27:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756269Ab3LEB1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 20:27:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 820B458741
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TBo8
	jAQkWGnYwru2+i+I6/E0ykE=; b=pYWO37mbSBZuUKg+lDUXqofgwizi9czAoO0I
	yW6ZL3MYTohyjWpCxlcT1iStT+J5EEkfiz1tBoe41oBU1KYxF+glOdEs0CNN9IcN
	pGF61URwGrbORniGlViqQEqTprbKclAyDcsU6DTkOwsrss5k7Jxv+Aefl8cH2eIC
	q+6yLwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jm02p3
	DKK2I3dWNVgGAcQtWW7nzFOYK+Igu+kYxavtQ2qHjCXSTj3D1jPAIz/L1xTxIbRK
	GgytNgNaBir7Z8zSxjxY8s+567rQ7i4Rt3SjXpc1/2yig/BeC3jMSvapxNM7eEDW
	HWWPVicLt1Dxc5w5+wAp5Hw/BCHWLJPdCS3AM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73EDF58740
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E7345873F
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:35 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-402-gdd8f092
In-Reply-To: <1386206849-6503-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6BA1FF32-5D4C-11E3-8452-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238833>

Since f2690487 (fetch: opportunistically update tracking refs,
2013-05-11), we stopped taking a non-storing refspec given on the
command line of "git fetch" literally, and instead started mapping
it via remote.$name.fetch refspecs.  This allows

    $ git fetch origin master

from the 'origin' repository, which is configured with

    [remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*

to update refs/remotes/origin/master with the result, as if the
command line were

    $ git fetch origin +master:refs/remotes/origin/master

to reduce surprises and improve usability.  Before that change, a
refspec on the command line without a colon was only to fetch the
history and leave the result in FETCH_HEAD, without updating the
remote-tracking branches.

When you are simulating a fetch from you by your mothership with a
push by you into your mothership, instead of having:

    [remote "satellite"]
        fetch = +refs/heads/*:refs/remotes/satellite/*

on the mothership repository and running:

    mothership$ git fetch satellite

you would have:

    [remote "mothership"]
        push = +refs/heads/*:refs/remotes/satellite/*

on your satellite machine, and run:

    satellite$ git push mothership

Because we so far did not make the corresponding change to the push
side, this command:

    satellite$ git push mothership master

does _not_ allow you on the satellite to only push 'master' out but
still to the usual destination (i.e. refs/remotes/satellite/master).

Implement the logic to map an unqualified refspec given on the
command line via the remote.$name.push refspec.  This will bring a
bit more symmetry between "fetch" and "push".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-push.txt |  9 +++++++--
 builtin/push.c             | 40 ++++++++++++++++++++++++++++++++++++++--
 remote.c                   |  8 ++++----
 remote.h                   |  2 ++
 t/t5516-fetch-push.sh      | 45 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 9eec740..2b7f4f9 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -56,8 +56,13 @@ it can be any arbitrary "SHA-1 expression", such as `master~4` or
 +
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
-be named. If `:`<dst> is omitted, the same ref as <src> will be
-updated.
+be named.
+If `git push [<repository>]` without any `<refspec>` argument is set to
+update some ref at the destination with `<src>` with
+`remote.<repository>.push` configuration variable, `:<dst>` part can
+be omitted---such a push will update a ref that `<src>` normally updates
+without any `<refspec>` on the command line.  Otherwise, missing
+`:<dst>` means to update the same ref as the `<src>`.
 +
 The object referenced by <src> is used to update the <dst> reference
 on the remote side.  By default this is only allowed if <dst> is not
diff --git a/builtin/push.c b/builtin/push.c
index 76e4400..857f76d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -35,9 +35,38 @@ static void add_refspec(const char *ref)
 	refspec[refspec_nr-1] = ref;
 }
 
-static void set_refspecs(const char **refs, int nr)
+static const char *map_refspec(const char *ref,
+			       struct remote *remote, struct ref *local_refs)
 {
+	struct ref *matched = NULL;
+
+	/* Does "ref" uniquely name our ref? */
+	if (count_refspec_match(ref, local_refs, &matched) != 1)
+		return ref;
+
+	if (remote->push) {
+		struct refspec query;
+		memset(&query, 0, sizeof(struct refspec));
+		query.src = matched->name;
+		if (!query_refspecs(remote->push, remote->push_refspec_nr, &query) &&
+		    query.dst) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "%s%s:%s",
+				    query.force ? "+" : "",
+				    query.src, query.dst);
+			return strbuf_detach(&buf, NULL);
+		}
+	}
+
+	return ref;
+}
+
+static void set_refspecs(const char **refs, int nr, const char *repo)
+{
+	struct remote *remote = NULL;
+	struct ref *local_refs = NULL;
 	int i;
+
 	for (i = 0; i < nr; i++) {
 		const char *ref = refs[i];
 		if (!strcmp("tag", ref)) {
@@ -56,6 +85,13 @@ static void set_refspecs(const char **refs, int nr)
 				die(_("--delete only accepts plain target ref names"));
 			strbuf_addf(&delref, ":%s", ref);
 			ref = strbuf_detach(&delref, NULL);
+		} else if (!strchr(ref, ':')) {
+			if (!remote) {
+				/* lazily grab remote and local_refs */
+				remote = remote_get(repo);
+				local_refs = get_local_heads();
+			}
+			ref = map_refspec(ref, remote, local_refs);
 		}
 		add_refspec(ref);
 	}
@@ -487,7 +523,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	if (argc > 0) {
 		repo = argv[0];
-		set_refspecs(argv + 1, argc - 1);
+		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
 	rc = do_push(repo, flags);
diff --git a/remote.c b/remote.c
index 9f1a8aa..6ffa149 100644
--- a/remote.c
+++ b/remote.c
@@ -821,7 +821,7 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
-static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *query)
+int query_refspecs(struct refspec *refs, int ref_count, struct refspec *query)
 {
 	int i;
 	int find_src = !query->src;
@@ -955,9 +955,9 @@ void sort_ref_list(struct ref **l, int (*cmp)(const void *, const void *))
 	*l = llist_mergesort(*l, ref_list_get_next, ref_list_set_next, cmp);
 }
 
-static int count_refspec_match(const char *pattern,
-			       struct ref *refs,
-			       struct ref **matched_ref)
+int count_refspec_match(const char *pattern,
+			struct ref *refs,
+			struct ref **matched_ref)
 {
 	int patlen = strlen(pattern);
 	struct ref *matched_weak = NULL;
diff --git a/remote.h b/remote.h
index 131130a..f7d43b4 100644
--- a/remote.h
+++ b/remote.h
@@ -128,6 +128,7 @@ struct ref *alloc_ref(const char *name);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
 void sort_ref_list(struct ref **, int (*cmp)(const void *, const void *));
+extern int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref);
 int ref_compare_name(const void *, const void *);
 
 int check_ref_type(const struct ref *ref, int flags);
@@ -158,6 +159,7 @@ struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
 void free_refspec(int nr_refspec, struct refspec *refspec);
 
+extern int query_refspecs(struct refspec *specs, int nr, struct refspec *query);
 char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 		     const char *name);
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 99c32d7..6d7f102 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1126,6 +1126,51 @@ test_expect_success 'fetch follows tags by default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
+	mk_test testrepo heads/master &&
+	rm -fr src dst &&
+	git init src &&
+	git init --bare dst &&
+	(
+		cd src &&
+		git pull ../testrepo master &&
+		git branch next &&
+		git config remote.dst.url ../dst &&
+		git config remote.dst.push "+refs/heads/*:refs/remotes/src/*" &&
+		git push dst master &&
+		git show-ref refs/heads/master |
+		sed -e "s|refs/heads/|refs/remotes/src/|" >../dst/expect
+	) &&
+	(
+		cd dst &&
+		test_must_fail git show-ref refs/heads/next &&
+		test_must_fail git show-ref refs/heads/master &&
+		git show-ref refs/remotes/src/master >actual
+	) &&
+	test_cmp dst/expect dst/actual
+'
+
+test_expect_success 'with no remote.$name.push, it is not used as refmap' '
+	mk_test testrepo heads/master &&
+	rm -fr src dst &&
+	git init src &&
+	git init --bare dst &&
+	(
+		cd src &&
+		git pull ../testrepo master &&
+		git branch next &&
+		git config remote.dst.url ../dst &&
+		git push dst master &&
+		git show-ref refs/heads/master >../dst/expect
+	) &&
+	(
+		cd dst &&
+		test_must_fail git show-ref refs/heads/next &&
+		git show-ref refs/heads/master >actual
+	) &&
+	test_cmp dst/expect dst/actual
+'
+
 test_expect_success 'push does not follow tags by default' '
 	mk_test testrepo heads/master &&
 	rm -fr src dst &&
-- 
1.8.5.1-402-gdd8f092
