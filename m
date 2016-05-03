From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] commit-tree: do not pay attention to commit.gpgsign
Date: Tue, 03 May 2016 11:01:11 -0700
Message-ID: <xmqqfutznhqw.fsf_-_@gitster.mtv.corp.google.com>
References: <xmqqlh3sqfze.fsf@gitster.mtv.corp.google.com>
	<20160503041256.GA30529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:01:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axedL-0001d8-Nn
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934287AbcECSBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:01:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932543AbcECSBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:01:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE23E165E3;
	Tue,  3 May 2016 14:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcvkVMtePW07wUI6SQWgoVZJYtQ=; b=ZJ//uH
	ROeERYmjjIDFJODr97USczB56fYE0ZSBy4EavpVlt2s4f6UZecDnlPpI9+b56Mgh
	TVqmo8Nrm3368d5oKGsV5bAp7NhwgxKPAia7QpgK27lm3ynEbBz6kt8exAWnAUT2
	4AHGeMhp52zg2AotD2TiifQRhMVfhu/qxEvAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDcdUpMFGXzr46H1iTCyGLeKyJTr/o7A
	IpQr6mOEPkxu9Dn0CCdyuUmGG27d13uLHNCJanKQimjE08xrPMkbJ6iiCSLbH9DZ
	E2bFS4fK9bnDxj8fIcyyoJNrPKyi/Klqsh8JYHnApjyr/NDPVTRybWBG7wlDs6Ea
	726RctUsokA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A4DFF165E2;
	Tue,  3 May 2016 14:01:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C38A5165E0;
	Tue,  3 May 2016 14:01:12 -0400 (EDT)
In-Reply-To: <20160503041256.GA30529@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 May 2016 00:12:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05C813F4-1159-11E6-B033-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293426>

Jeff King <peff@peff.net> writes:

> So I think the motivation and premise are good, but...
>
>> -static int commit_tree_config(const char *var, const char *value, void *cb)
>> -{
>> -	int status = git_gpg_config(var, value, NULL);
>> -	if (status)
>> -		return status;
>> -	if (!strcmp(var, "commit.gpgsign")) {
>> -		sign_commit = git_config_bool(var, value) ? "" : NULL;
>> -		return 0;
>> -	}
>> -	return git_default_config(var, value, cb);
>> -}
>> -
>
> I think this may be going too far. If I do "git commit-tree -S", I'd
> expect it to use gpg.program, but here you are dropping the call to
> git_gpg_config. Likewise for user.signingkey.

Thanks (and thanks Eric for typospotting).

-- >8 --
ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) introduced a
"signed commit" by teaching the --[no]-gpg-sign option and the
commit.gpgsign configuration variable to various commands that
create commits.

Teaching these to "git commit" and "git merge", both of which are
end-user facing Porcelain commands, was perfectly fine.  Allowing
the plumbing "git commit-tree" to suddenly change the behaviour to
surprise the scripts by paying attention to commit.gpgsign was not.

Among the in-tree scripts, filter-branch, quiltimport, rebase and
stash are the commands that run "commit-tree".  If any of these
wants to allow users to always sign every single commit, they should
offer their own configuration (e.g. "filterBranch.gpgsign") with an
option to disable signing (e.g. "git filter-branch --no-gpgsign").

Ignoring commit.gpgsign option _obviously_ breaks the backward
compatibility, but it is easy to follow the standard pattern in
scripts to honor whatever configuration variable they choose to
follow.  E.g.

	case $(git config --bool commit.gpgsign) in
	true) sign=-S ;;
	*) sign= ;;
	esac &&
	git commit-tree $sign ...whatever other args...

Do so to make sure that "git rebase" keeps paying attention to the
configuration variable, which unfortunately is a documented mistake.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit-tree.txt |  4 ++--
 builtin/commit-tree.c             |  4 ----
 git-rebase.sh                     |  5 ++++-
 t/t7510-signed-commit.sh          | 13 ++++++++++---
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index f5f2a8d..eb273c3 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -59,8 +59,8 @@ OPTIONS
 	GPG-sign commit.
 
 --no-gpg-sign::
-	Countermand `commit.gpgSign` configuration variable that is
-	set to force each and every commit to be signed.
+	Do not GPG-sign commit, to countermand a `--gpg-sign` option
+	given earlier on the command line.
 
 
 Commit Information
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 25aa2cd..15de7e8 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -33,10 +33,6 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
 	int status = git_gpg_config(var, value, NULL);
 	if (status)
 		return status;
-	if (!strcmp(var, "commit.gpgsign")) {
-		sign_commit = git_config_bool(var, value) ? "" : NULL;
-		return 0;
-	}
 	return git_default_config(var, value, cb);
 }
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 90854e3..4d46662 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -87,7 +87,10 @@ preserve_merges=
 autosquash=
 keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
-gpg_sign_opt=
+case "$(git config --bool commit.gpgsign)" in
+true)	gpg_sign_opt=-S ;;
+*)	gpg_sign_opt= ;;
+esac
 
 read_basic_state () {
 	test -f "$state_dir/head-name" &&
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 13331e5..7b365ee 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -45,12 +45,18 @@ test_expect_success GPG 'create signed commits' '
 	git tag seventh-signed &&
 
 	echo 8 >file && test_tick && git commit -a -m eighth -SB7227189 &&
-	git tag eighth-signed-alt
+	git tag eighth-signed-alt &&
+
+	# commit.gpgsign is still on but this must not be signed
+	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
+	# explicit -S of course must sign.
+	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
 '
 
 test_expect_success GPG 'verify and show signatures' '
 	(
-		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
+		for commit in initial second merge fourth-signed \
+			fifth-signed sixth-signed seventh-signed tenth-signed
 		do
 			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
@@ -60,7 +66,8 @@ test_expect_success GPG 'verify and show signatures' '
 		done
 	) &&
 	(
-		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
+		for commit in merge^2 fourth-unsigned sixth-unsigned \
+			seventh-unsigned ninth-unsigned
 		do
 			test_must_fail git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
-- 
2.8.2-486-gecbb083
