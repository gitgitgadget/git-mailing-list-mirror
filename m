From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] push: use remote.$name.push as a refmap
Date: Tue,  3 Dec 2013 16:39:53 -0800
Message-ID: <1386117594-22062-3-git-send-email-gitster@pobox.com>
References: <1386117594-22062-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 01:40:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo0Vl-0005CP-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 01:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab3LDAkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 19:40:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721Ab3LDAkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 19:40:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1373D58EFB
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Itj0
	fIastDVBQdH/LsQILYq1drM=; b=GlxTSNkmRLiMaWZ9Y9NIj2iXvAGdU+JLEA4u
	CeTh96yFVNBJ02QoHdtklwhUy27dx458qdVGj3/ZZaZgSq6SzYf5itquXDGtYhYy
	wC3rjrpPQqagHc770vLz1V4AdbXr1wWaMHtwQVieKvHE5AW+iLtlA5K/ckDtP2Wy
	nBeG4Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HNRx9b
	Ik0vHzDrCePr0BgaXfgNrx5A/0D6T78tbab/WEHyDpaO4PBZJw9/nhgsvWkTHNWI
	f1/4wZ4E1XGuNUlwpIYmlVbb9Vw/G3o3PirNwuNHcGJtxo5/XocortGYV3MjTb7x
	8faQt/96RX18a3VS6mnrrvWblvlsuPcwiELw0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E4B858EFA
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAE1A58EF4
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:40:07 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-400-gbc1da41
In-Reply-To: <1386117594-22062-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9FEBA66A-5C7C-11E3-8775-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238746>

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
command line via the remote.$name.push refspec.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-push.txt |  9 +++++++--
 builtin/push.c             | 35 ++++++++++++++++++++++++++++++++---
 remote.c                   |  8 ++++----
 remote.h                   |  2 ++
 t/t5516-fetch-push.sh      | 45 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 9 deletions(-)

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
index 76e4400..bdc1fc1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -35,7 +35,34 @@ static void add_refspec(const char *ref)
 	refspec[refspec_nr-1] = ref;
 }
 
-static void set_refspecs(const char **refs, int nr)
+static const char *map_refspec(const char *ref,
+			       struct remote *remote, struct ref *local_refs)
+{
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
+static void set_refspecs(const char **refs, int nr,
+			 struct remote *remote, struct ref *local_refs)
 {
 	int i;
 	for (i = 0; i < nr; i++) {
@@ -56,7 +83,8 @@ static void set_refspecs(const char **refs, int nr)
 				die(_("--delete only accepts plain target ref names"));
 			strbuf_addf(&delref, ":%s", ref);
 			ref = strbuf_detach(&delref, NULL);
-		}
+		} else if (!strchr(ref, ':'))
+			ref = map_refspec(ref, remote, local_refs);
 		add_refspec(ref);
 	}
 }
@@ -487,7 +515,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	if (argc > 0) {
 		repo = argv[0];
-		set_refspecs(argv + 1, argc - 1);
+		set_refspecs(argv + 1, argc - 1,
+			     remote_get(repo), get_local_heads());
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
1.8.5.1-400-gbc1da41
