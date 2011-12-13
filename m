From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] push: --ignore-stale option
Date: Tue, 13 Dec 2011 15:35:13 -0800
Message-ID: <7vobvct58u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 00:35:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RabsZ-0007GW-5v
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab1LMXfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:35:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909Ab1LMXfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:35:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E8F17873;
	Tue, 13 Dec 2011 18:35:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	cHFypDD+JePg9VdAwV6YM774G0=; b=Ay9oy3caRZWRkVIWOReUFgydGo8dSWtma
	ZQhEunIszRHMptnFgpanMRwdOU/N8v29XsB0zUKFWsUJKUx5Fq1ylpIlyW4siK3m
	mDblojMK1EoukOc62eilMQEWpgb4f9JD3oRj2jKWSiGrkmhP1It+krFoFCo/BO/K
	DFJyYAZhhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=nbv
	tx0+b6HreIBcpTH10D9KKwp8jVF9iBZYCVTEGTlI9VpQ9AB4uh8BvLkgrXDfcuVs
	dxiXm6EL2AXUW7Ugi2+TKTV2rFQukVijMgxdWCC3O9URgRcqHUv2vHZ5KpNgeMFw
	KP6z1MNe1LmS7+hSbc1Hd6bgBDdLTD8Fwrm2jm3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 541D97872;
	Tue, 13 Dec 2011 18:35:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AE15786F; Tue, 13 Dec 2011
 18:35:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BDE1CD0-25E3-11E1-B3B0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187079>

If you forked many local branches that are not active from a shared
'origin' repository, it is sometimes convenient to say "I know many of my
branches are stale, so do not push them, but push ones that have my own
work". Using the usual 'matching refs' semantics that is designed for the
workflow to push into your own publishing repository is not suitable for
this purpose as-is, because many of your local branches are likely to have
been made stale by other people pushing into the same shared repository,
triggering 'no fast-forward' errors.

Teach a new "--ignore-stale" option to "git push" which tells it not to
push stale refs (i.e. the commit that would have been pushed without the
option is an ancestor of the commit that is at the destination). With this,
a lazy workflow could be like this:

    $ git clone <<origin>>
    $ git checkout -b topic1 origin/topic1
    $ work work work
    $ git push origin :
    $ git checkout -b topic2 origin/topic2
    $ work work work
    $ git push --ignore-stale origin :

and the second push does not have to worry about other people working on
topic1 and updating it in the central repository while you haven't touched
the corresponding local branch at all.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * You may end up having 47 local branches, 7 of them worked on recently
   and none of them pushed yet, which requires you to remember which 7 of
   them you need to push among 47. The reason you left these 7 unpushed
   even though you checked out other branches at least 6 times after
   making the last commit on these branches is probably because you wanted
   to make sure everything is in good order, delaying the pushout as much
   as possible, which by itself is a good discipline.

   You however should be testing these 7 before pushing them out anyway,
   and the sane way to do so is to check one out, test it, push it, and
   iterate that sequence 7 times. If you do so, a workable alternative is
   to use the configuration to push the current branch and you do not need
   this patch series at all.

   Perhaps this series encourages a wrong workflow in that sense. I dunno.

 Documentation/git-push.txt |   10 +++++++++-
 builtin/push.c             |    1 +
 builtin/send-pack.c        |    7 +++++++
 cache.h                    |    1 +
 remote.c                   |   20 ++++++++++++++++++++
 t/t5516-fetch-push.sh      |   31 +++++++++++++++++++++++++++++++
 transport.c                |    6 ++++++
 transport.h                |    1 +
 8 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index aede488..f2b5ee2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-v | --verbose] [-u | --set-upstream]
-	   [<repository> [<refspec>...]]
+	   [--ignore-stale] [<repository> [<refspec>...]]
 
 DESCRIPTION
 -----------
@@ -114,6 +114,14 @@ nor in any Push line of the corresponding remotes file---see below).
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
 
+--ignore-stale::
+	When the commit that is pushed is known to be an ancestor of the
+	commit that is at the remote ref, exclude it from the push
+	request. This can be used with the "matching" semantics to push
+	out only the branches that have your own work, when you know many
+	of your branches since they were forked from their upstream are
+	untouched and stale.
+
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
 	passed in the invocation. In this case, 'git push' derives the
diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..165d2be 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -261,6 +261,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
 		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
+		OPT_BIT(0, "ignore-stale", &flags, "ignore stale refs", TRANSPORT_PUSH_IGNORE_STALE),
 		OPT_END()
 	};
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index ec107ed..0cfc69a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -196,6 +196,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "up to date";
 			break;
 
+		case REF_STATUS_STALE:
+			res = "ok";
+			msg = "ignored stale";
+			break;
+
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 			res = "error";
 			msg = "non-fast forward";
@@ -282,6 +287,7 @@ int send_pack(struct send_pack_args *args,
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_UPTODATE:
+		case REF_STATUS_STALE:
 			continue;
 		default:
 			; /* do nothing */
@@ -379,6 +385,7 @@ int send_pack(struct send_pack_args *args,
 		switch (ref->status) {
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
+		case REF_STATUS_STALE:
 		case REF_STATUS_OK:
 			break;
 		default:
diff --git a/cache.h b/cache.h
index 8c98d05..696805d 100644
--- a/cache.h
+++ b/cache.h
@@ -1009,6 +1009,7 @@ struct ref {
 		REF_STATUS_OK,
 		REF_STATUS_REJECT_NONFASTFORWARD,
 		REF_STATUS_REJECT_NODELETE,
+		REF_STATUS_STALE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT
diff --git a/remote.c b/remote.c
index 95d7f37..9c63426 100644
--- a/remote.c
+++ b/remote.c
@@ -1224,11 +1224,25 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	return 0;
 }
 
+/*
+ * Do we know if the other side has newer commit than what we are
+ * trying to push (i.e. old_sha1 is descendant of new_sha1)? If so
+ * just ignore the request to push this particular bref under the
+ * "--ignore-stale" option.
+ */
+static int is_stale_push(unsigned char *old_sha1, unsigned char *new_sha1)
+{
+	if (!has_sha1_file(old_sha1) || !has_sha1_file(new_sha1))
+		return 0;
+	return ref_newer(old_sha1, new_sha1);
+}
+
 void set_ref_status_for_push(struct ref *remote_refs, unsigned flags)
 {
 	struct ref *ref;
 	int send_mirror = flags & TRANSPORT_PUSH_MIRROR;
 	int force_update = flags & TRANSPORT_PUSH_FORCE;
+	int ignore_stale = flags & TRANSPORT_PUSH_IGNORE_STALE;
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (ref->peer_ref)
@@ -1243,6 +1257,12 @@ void set_ref_status_for_push(struct ref *remote_refs, unsigned flags)
 			continue;
 		}
 
+		if (ignore_stale && !ref->deletion &&
+		    is_stale_push(ref->old_sha1, ref->new_sha1)) {
+			ref->status = REF_STATUS_STALE;
+			continue;
+		}
+
 		/* This part determines what can overwrite what.
 		 * The rules are:
 		 *
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b69cf57..c925640 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -979,4 +979,35 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 	test_cmp .git/foo .git/bar
 '
 
+test_expect_success 'push --ignore-stale' '
+	mk_empty &&
+	(
+		cd testrepo &&
+		git fetch --update-head-ok .. "refs/heads/*:refs/heads/*" &&
+		git checkout -b next master &&
+		git commit --allow-empty -m "updated next" &&
+		git push . next:master &&
+		git for-each-ref >../snapshot.before
+	) &&
+	git checkout branch1 &&
+	git commit --allow-empty -m "updated branch1" &&
+	test_must_fail git push testrepo : &&
+	git fetch testrepo "+refs/heads/*:refs/remotes/origin/*" &&
+	git push --ignore-stale testrepo : &&
+	(
+		cd testrepo &&
+		git for-each-ref >../snapshot.after
+	) &&
+
+	# branch1 must be updated and master must stay the same
+	git for-each-ref refs/heads/branch1 >expect &&
+	grep refs/heads/branch1 snapshot.after >actual &&
+	test_cmp expect actual &&
+
+	grep refs/heads/master snapshot.before >expect &&
+	grep refs/heads/master snapshot.after >actual &&
+	test_cmp expect actual
+
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 95556da..d124d70 100644
--- a/transport.c
+++ b/transport.c
@@ -566,6 +566,7 @@ static int push_had_errors(struct ref *ref)
 	for (; ref; ref = ref->next) {
 		switch (ref->status) {
 		case REF_STATUS_NONE:
+		case REF_STATUS_STALE:
 		case REF_STATUS_UPTODATE:
 		case REF_STATUS_OK:
 			break;
@@ -581,6 +582,7 @@ int transport_refs_pushed(struct ref *ref)
 	for (; ref; ref = ref->next) {
 		switch(ref->status) {
 		case REF_STATUS_NONE:
+		case REF_STATUS_STALE:
 		case REF_STATUS_UPTODATE:
 			break;
 		default:
@@ -690,6 +692,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 		print_ref_status('=', "[up to date]", ref,
 						 ref->peer_ref, NULL, porcelain);
 		break;
+	case REF_STATUS_STALE:
+		print_ref_status('=', "[stale ignored]", ref,
+						 ref->peer_ref, NULL, porcelain);
+		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "non-fast-forward", porcelain);
diff --git a/transport.h b/transport.h
index 059b330..5db8d23 100644
--- a/transport.h
+++ b/transport.h
@@ -102,6 +102,7 @@ struct transport {
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
+#define TRANSPORT_PUSH_IGNORE_STALE 128
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-- 
1.7.8.249.gb1b73
