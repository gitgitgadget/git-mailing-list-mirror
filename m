From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] write first for-merge ref to FETCH_HEAD first
Date: Tue, 03 Jan 2012 15:57:03 -0800
Message-ID: <7v7h18s5kg.fsf@alter.siamese.dyndns.org>
References: <20111225173901.GA668@gnu.kitenet.net>
 <7vd3bb929n.fsf@alter.siamese.dyndns.org>
 <20111226161656.GB29582@gnu.kitenet.net>
 <7v1urp97mp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 04 00:57:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiEEV-00065R-GA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 00:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab2ACX5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 18:57:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503Ab2ACX5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 18:57:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE2036DD6;
	Tue,  3 Jan 2012 18:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XEKzU9VHGiFIq3E2Pc2b7yIXBOE=; b=rmzEqD
	iIwr7a5DbCbVy2WZMDxkPixL+4E59mv0BtBI+OF94mE09TPK3mrA7gYGmXBJ61DV
	i2G2b1olmXZmyFojGcvMFBwB4lF/G/Qktd2gPsdHgWHAD/u+uSZwKehDp5yLp4v8
	bdPWR7y7u1qHBw37MibnO0NF+T4QBzhrxq0i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=umBbHuTnQ2plJqyCKLzp4NoekaHkZjGS
	80YdnQxLbnP8GelPmn+LJCvcldKjdBLHIbZZLNpaYti0extw0GahnD37MU8210/Y
	x6Ux4uQn9FYTe3XZvcPmxLWQNAmSewqwmmabMNaX2d4hzwjUuXO8f2i2x1lCPjfX
	W/bzwQwM6L0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3FE76DD5;
	Tue,  3 Jan 2012 18:57:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 718466DD1; Tue,  3 Jan 2012
 18:57:05 -0500 (EST)
In-Reply-To: <7v1urp97mp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Dec 2011 10:44:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3752BBE-3666-11E1-B7BA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187905>

Junio C Hamano <gitster@pobox.com> writes:

> Joey Hess <joey@kitenet.net> writes:
>
>> The FETCH_HEAD refname is supposed to refer to the ref that was fetched
>> and should be merged. However all fetched refs are written to
>> .git/FETCH_HEAD in an arbitrary order, and resolve_ref_unsafe simply
>> takes the first ref as the FETCH_HEAD, which is often the wrong one,
>> when other branches were also fetched.
>>
>> The solution is to write the for-merge ref(s) to FETCH_HEAD first.
>> ...
>
> Sign-off?

Ping? I think this is a good change to go in before 1.7.9.

The change broke quite a lot of tests, and I think I've fixed them all.

-- >8 --
From: Joey Hess <joey@kitenet.net>
Date: Mon, 26 Dec 2011 12:16:56 -0400
Subject: [PATCH] write first for-merge ref to FETCH_HEAD first

The FETCH_HEAD refname is supposed to refer to the ref that was fetched
and should be merged. However all fetched refs are written to
.git/FETCH_HEAD in an arbitrary order, and resolve_ref_unsafe simply
takes the first ref as the FETCH_HEAD, which is often the wrong one,
when other branches were also fetched.

The solution is to write the for-merge ref(s) to FETCH_HEAD first.
Then, unless --append is used, the FETCH_HEAD refname behaves as intended.
If the user uses --append, they presumably are doing so in order to
preserve the old FETCH_HEAD.

While we are at it, update an old example in the read-tree documentation
that implied that each entry in FETCH_HEAD only has the object name, which
is not true for quite a while.
---
 Documentation/git-read-tree.txt                    |    2 +-
 builtin/fetch.c                                    |  160 +++++++++++---------
 t/t5510-fetch.sh                                   |    2 +-
 t/t5515/fetch.br-branches-default-merge            |    2 +-
 ...etch.br-branches-default-merge_branches-default |    2 +-
 t/t5515/fetch.br-branches-default-octopus          |    2 +-
 ...ch.br-branches-default-octopus_branches-default |    2 +-
 t/t5515/fetch.br-branches-one-merge                |    2 +-
 t/t5515/fetch.br-branches-one-merge_branches-one   |    2 +-
 t/t5515/fetch.br-config-explicit-merge             |    2 +-
 .../fetch.br-config-explicit-merge_config-explicit |    2 +-
 t/t5515/fetch.br-config-explicit-octopus           |    2 +-
 ...etch.br-config-explicit-octopus_config-explicit |    2 +-
 t/t5515/fetch.br-config-glob-merge                 |    2 +-
 t/t5515/fetch.br-config-glob-merge_config-glob     |    2 +-
 t/t5515/fetch.br-config-glob-octopus               |    4 +-
 t/t5515/fetch.br-config-glob-octopus_config-glob   |    4 +-
 t/t5515/fetch.br-remote-explicit-merge             |    2 +-
 .../fetch.br-remote-explicit-merge_remote-explicit |    2 +-
 t/t5515/fetch.br-remote-explicit-octopus           |    2 +-
 ...etch.br-remote-explicit-octopus_remote-explicit |    2 +-
 t/t5515/fetch.br-remote-glob-merge                 |    2 +-
 t/t5515/fetch.br-remote-glob-merge_remote-glob     |    2 +-
 t/t5515/fetch.br-remote-glob-octopus               |    4 +-
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   |    4 +-
 25 files changed, 114 insertions(+), 102 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5375549..2d3ff23 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -342,7 +342,7 @@ since you pulled from him:
 
 ----------------
 $ git fetch git://.... linus
-$ LT=`cat .git/FETCH_HEAD`
+$ LT=`git rev-parse FETCH_HEAD`
 ----------------
 
 Your work tree is still based on your HEAD ($JC), but you have
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..0481c16 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -377,6 +377,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	int want_merge;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -393,84 +394,95 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		goto abort;
 	}
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		struct ref *ref = NULL;
-
-		if (rm->peer_ref) {
-			ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
-			strcpy(ref->name, rm->peer_ref->name);
-			hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
-			hashcpy(ref->new_sha1, rm->old_sha1);
-			ref->force = rm->peer_ref->force;
-		}
+	/*
+	 * The first pass writes objects to be merged and then the
+	 * second pass writes the rest, in order to allow using
+	 * FETCH_HEAD as a refname to refer to the ref to be merged.
+	 */
+	for (want_merge = 1; 0 <= want_merge; want_merge--) {
+		for (rm = ref_map; rm; rm = rm->next) {
+			struct ref *ref = NULL;
+
+			commit = lookup_commit_reference_gently(rm->old_sha1, 1);
+			if (!commit)
+				rm->merge = 0;
+
+			if (rm->merge != want_merge)
+				continue;
+
+			if (rm->peer_ref) {
+				ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
+				strcpy(ref->name, rm->peer_ref->name);
+				hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
+				hashcpy(ref->new_sha1, rm->old_sha1);
+				ref->force = rm->peer_ref->force;
+			}
 
-		commit = lookup_commit_reference_gently(rm->old_sha1, 1);
-		if (!commit)
-			rm->merge = 0;
 
-		if (!strcmp(rm->name, "HEAD")) {
-			kind = "";
-			what = "";
-		}
-		else if (!prefixcmp(rm->name, "refs/heads/")) {
-			kind = "branch";
-			what = rm->name + 11;
-		}
-		else if (!prefixcmp(rm->name, "refs/tags/")) {
-			kind = "tag";
-			what = rm->name + 10;
-		}
-		else if (!prefixcmp(rm->name, "refs/remotes/")) {
-			kind = "remote-tracking branch";
-			what = rm->name + 13;
-		}
-		else {
-			kind = "";
-			what = rm->name;
-		}
+			if (!strcmp(rm->name, "HEAD")) {
+				kind = "";
+				what = "";
+			}
+			else if (!prefixcmp(rm->name, "refs/heads/")) {
+				kind = "branch";
+				what = rm->name + 11;
+			}
+			else if (!prefixcmp(rm->name, "refs/tags/")) {
+				kind = "tag";
+				what = rm->name + 10;
+			}
+			else if (!prefixcmp(rm->name, "refs/remotes/")) {
+				kind = "remote-tracking branch";
+				what = rm->name + 13;
+			}
+			else {
+				kind = "";
+				what = rm->name;
+			}
 
-		url_len = strlen(url);
-		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
-			;
-		url_len = i + 1;
-		if (4 < i && !strncmp(".git", url + i - 3, 4))
-			url_len = i - 3;
-
-		strbuf_reset(&note);
-		if (*what) {
-			if (*kind)
-				strbuf_addf(&note, "%s ", kind);
-			strbuf_addf(&note, "'%s' of ", what);
-		}
-		fprintf(fp, "%s\t%s\t%s",
-			sha1_to_hex(rm->old_sha1),
-			rm->merge ? "" : "not-for-merge",
-			note.buf);
-		for (i = 0; i < url_len; ++i)
-			if ('\n' == url[i])
-				fputs("\\n", fp);
-			else
-				fputc(url[i], fp);
-		fputc('\n', fp);
-
-		strbuf_reset(&note);
-		if (ref) {
-			rc |= update_local_ref(ref, what, &note);
-			free(ref);
-		} else
-			strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
-				    TRANSPORT_SUMMARY_WIDTH,
-				    *kind ? kind : "branch",
-				    REFCOL_WIDTH,
-				    *what ? what : "HEAD");
-		if (note.len) {
-			if (verbosity >= 0 && !shown_url) {
-				fprintf(stderr, _("From %.*s\n"),
-						url_len, url);
-				shown_url = 1;
+			url_len = strlen(url);
+			for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
+				;
+			url_len = i + 1;
+			if (4 < i && !strncmp(".git", url + i - 3, 4))
+				url_len = i - 3;
+
+			strbuf_reset(&note);
+			if (*what) {
+				if (*kind)
+					strbuf_addf(&note, "%s ", kind);
+				strbuf_addf(&note, "'%s' of ", what);
+			}
+			fprintf(fp, "%s\t%s\t%s",
+				sha1_to_hex(rm->old_sha1),
+				rm->merge ? "" : "not-for-merge",
+				note.buf);
+			for (i = 0; i < url_len; ++i)
+				if ('\n' == url[i])
+					fputs("\\n", fp);
+				else
+					fputc(url[i], fp);
+			fputc('\n', fp);
+
+			strbuf_reset(&note);
+			if (ref) {
+				rc |= update_local_ref(ref, what, &note);
+				free(ref);
+			} else
+				strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
+					    TRANSPORT_SUMMARY_WIDTH,
+					    *kind ? kind : "branch",
+					    REFCOL_WIDTH,
+					    *what ? what : "HEAD");
+			if (note.len) {
+				if (verbosity >= 0 && !shown_url) {
+					fprintf(stderr, _("From %.*s\n"),
+							url_len, url);
+					shown_url = 1;
+				}
+				if (verbosity >= 0)
+					fprintf(stderr, " %s\n", note.buf);
 			}
-			if (verbosity >= 0)
-				fprintf(stderr, " %s\n", note.buf);
 		}
 	}
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e88dbd5..79ee913 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -70,8 +70,8 @@ test_expect_success "fetch test for-merge" '
 	master_in_two=`cd ../two && git rev-parse master` &&
 	one_in_two=`cd ../two && git rev-parse one` &&
 	{
-		echo "$master_in_two	not-for-merge"
 		echo "$one_in_two	"
+		echo "$master_in_two	not-for-merge"
 	} >expected &&
 	cut -f -2 .git/FETCH_HEAD >actual &&
 	test_cmp expected actual'
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
index e3a41ae..12ab08e 100644
--- a/t/t5515/fetch.br-branches-default-merge
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -1,6 +1,6 @@
 # br-branches-default-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b/t/t5515/fetch.br-branches-default-merge_branches-default
index 1f60561..5442752 100644
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -1,6 +1,6 @@
 # br-branches-default-merge branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
index f31e1b3..498a761 100644
--- a/t/t5515/fetch.br-branches-default-octopus
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -1,7 +1,7 @@
 # br-branches-default-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default b/t/t5515/fetch.br-branches-default-octopus_branches-default
index 7060bd9..0857f13 100644
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -1,7 +1,7 @@
 # br-branches-default-octopus branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
index aa1c8a9..54a7742 100644
--- a/t/t5515/fetch.br-branches-one-merge
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -1,6 +1,6 @@
 # br-branches-one-merge
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515/fetch.br-branches-one-merge_branches-one
index c93310a..b4d1bb0 100644
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -1,6 +1,6 @@
 # br-branches-one-merge branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge b/t/t5515/fetch.br-config-explicit-merge
index f6475b7..5ce764a 100644
--- a/t/t5515/fetch.br-config-explicit-merge
+++ b/t/t5515/fetch.br-config-explicit-merge
@@ -1,8 +1,8 @@
 # br-config-explicit-merge
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-config-explicit-merge_config-explicit b/t/t5515/fetch.br-config-explicit-merge_config-explicit
index 018bdd7..b1152b7 100644
--- a/t/t5515/fetch.br-config-explicit-merge_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-merge_config-explicit
@@ -1,8 +1,8 @@
 # br-config-explicit-merge config-explicit
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus b/t/t5515/fetch.br-config-explicit-octopus
index 36d0270..110577b 100644
--- a/t/t5515/fetch.br-config-explicit-octopus
+++ b/t/t5515/fetch.br-config-explicit-octopus
@@ -1,7 +1,7 @@
 # br-config-explicit-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-config-explicit-octopus_config-explicit b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
index 6654ad0..a29dd8b 100644
--- a/t/t5515/fetch.br-config-explicit-octopus_config-explicit
+++ b/t/t5515/fetch.br-config-explicit-octopus_config-explicit
@@ -1,7 +1,7 @@
 # br-config-explicit-octopus config-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge b/t/t5515/fetch.br-config-glob-merge
index 8bb5e8b..89f2596 100644
--- a/t/t5515/fetch.br-config-glob-merge
+++ b/t/t5515/fetch.br-config-glob-merge
@@ -1,7 +1,7 @@
 # br-config-glob-merge
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-config-glob-merge_config-glob b/t/t5515/fetch.br-config-glob-merge_config-glob
index 113c08d..2ba4832 100644
--- a/t/t5515/fetch.br-config-glob-merge_config-glob
+++ b/t/t5515/fetch.br-config-glob-merge_config-glob
@@ -1,7 +1,7 @@
 # br-config-glob-merge config-glob
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-config-glob-octopus
index 9bbd537..64994df 100644
--- a/t/t5515/fetch.br-config-glob-octopus
+++ b/t/t5515/fetch.br-config-glob-octopus
@@ -1,8 +1,8 @@
 # br-config-glob-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus_config-glob b/t/t5515/fetch.br-config-glob-octopus_config-glob
index 4e51043..681a725 100644
--- a/t/t5515/fetch.br-config-glob-octopus_config-glob
+++ b/t/t5515/fetch.br-config-glob-octopus_config-glob
@@ -1,8 +1,8 @@
 # br-config-glob-octopus config-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge b/t/t5515/fetch.br-remote-explicit-merge
index 7421b2c..d018b35 100644
--- a/t/t5515/fetch.br-remote-explicit-merge
+++ b/t/t5515/fetch.br-remote-explicit-merge
@@ -1,8 +1,8 @@
 # br-remote-explicit-merge
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
index b6975d3..0d3d780 100644
--- a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
@@ -1,8 +1,8 @@
 # br-remote-explicit-merge remote-explicit
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus b/t/t5515/fetch.br-remote-explicit-octopus
index 7681281..6f84304 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus
+++ b/t/t5515/fetch.br-remote-explicit-octopus
@@ -1,7 +1,7 @@
 # br-remote-explicit-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
index 4c896cf..3546a83 100644
--- a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
+++ b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
@@ -1,7 +1,7 @@
 # br-remote-explicit-octopus remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge b/t/t5515/fetch.br-remote-glob-merge
index 4b62b01..7e1a433 100644
--- a/t/t5515/fetch.br-remote-glob-merge
+++ b/t/t5515/fetch.br-remote-glob-merge
@@ -1,7 +1,7 @@
 # br-remote-glob-merge
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge_remote-glob b/t/t5515/fetch.br-remote-glob-merge_remote-glob
index 7478f1f..53571bb 100644
--- a/t/t5515/fetch.br-remote-glob-merge_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-merge_remote-glob
@@ -1,7 +1,7 @@
 # br-remote-glob-merge remote-glob
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-remote-glob-octopus
index 2543420..c7c8b6d 100644
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ b/t/t5515/fetch.br-remote-glob-octopus
@@ -1,8 +1,8 @@
 # br-remote-glob-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
index 5ffde9c..36076fb 100644
--- a/t/t5515/fetch.br-remote-glob-octopus_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
@@ -1,8 +1,8 @@
 # br-remote-glob-octopus remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
+0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
 6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-- 
1.7.8.2.334.ge177b0f
