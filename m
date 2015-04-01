From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trying to push into empty repo, get fatal: bad revision 'HEAD'
Date: Tue, 31 Mar 2015 23:15:45 -0700
Message-ID: <xmqq4mp0nzla.fsf@gitster.dls.corp.google.com>
References: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
	<xmqqego4ogxw.fsf@gitster.dls.corp.google.com>
	<xmqq8uecocjg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Samuel Williams <space.ship.traveller@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 08:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdBwQ-0006nK-Re
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 08:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbbDAGPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 02:15:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750981AbbDAGPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 02:15:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D21F33C35B;
	Wed,  1 Apr 2015 02:15:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ymvpfpRkTVlhB9xKwOCQNIHRhJQ=; b=kXDuM+
	ORCRTa/+VRGyUI7Y4WwLh+rwMb5sVu5rzKYz01pyR91XsIteoPod2Vkwz1Lq8FSW
	fupMJg8tn28fJeBMrVFToc7we6fcePIguewNclNmYS2i4VoW/jCRSAoiOE5VFgZQ
	7Ld6BJ26M2BT0IvZfJVfRmNYNrb4uPHm4NjoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HrOjquL6iKXpdmQFrFPukvwAfPXSbvkF
	NxZchN6tK+mC2r2kBgE53NwCRZ6WBCOA5wcBRI6FuC1FjegdkTVtho4FGud1r8pp
	qlKgHKiJtEZP22CtovVIwSm96iJZgiX9xqUgMCYOQ8HGumct6tc4PJ8S0QM3Hhng
	IQhj8/vU/+c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAD1B3C358;
	Wed,  1 Apr 2015 02:15:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 428CD3C357;
	Wed,  1 Apr 2015 02:15:47 -0400 (EDT)
In-Reply-To: <xmqq8uecocjg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 31 Mar 2015 18:36:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 896551D4-D836-11E4-A1B1-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266591>

Junio C Hamano <gitster@pobox.com> writes:

> A fix (or is it an enhancement) would probably look like this.
> ...

And this time with a pair of tests.  It probably should be extended
to make sure it fails when the pushed HEAD records paths that are
floating in the working tree (as that would mean overwrting them),
but it is getting late and I am lazy, so ... ;-)

-- >8 --
Subject: [PATCH] push-to-deploy: allow pushing into an unborn branch and updating it

Setting receive.denycurrentbranch to updateinstead and pushing into
the current branch, when the working tree and the index is truly
clean, is supposed to reset the working tree and the index to match
the tree of the pushed commit.  This did not work when pushing into
an unborn branch.

The code that drives push-to-checkout hook needs no change, as the
interface is defined so that hook can decide what to do when the
push is coming to an unborn branch and take an appropriate action
since the beginning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 21 ++++++++++++++++++-
 t/t5516-fetch-push.sh  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fc8ec9c..0c0a261 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -733,6 +733,22 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
+/*
+ * NEEDSWORK: we should consolidate various implementions of "are we
+ * on an unborn branch?" test into one, and make the unified one more
+ * robust. !get_sha1() based check used here and elsewhere would not
+ * allow us to tell an unborn branch from corrupt ref, for example.
+ * For the purpose of fixing "deploy-to-update does not work when
+ * pushing into an empty repository" issue, this should suffice for
+ * now.
+ */
+static int head_has_history(void)
+{
+	unsigned char sha1[20];
+
+	return !get_sha1("HEAD", sha1);
+}
+
 static const char *push_to_deploy(unsigned char *sha1,
 				  struct argv_array *env,
 				  const char *work_tree)
@@ -745,7 +761,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	};
 	const char *diff_index[] = {
 		"diff-index", "--quiet", "--cached", "--ignore-submodules",
-		"HEAD", "--", NULL
+		NULL, "--", NULL
 	};
 	const char *read_tree[] = {
 		"read-tree", "-u", "-m", NULL, NULL
@@ -772,6 +788,9 @@ static const char *push_to_deploy(unsigned char *sha1,
 	if (run_command(&child))
 		return "Working directory has unstaged changes";
 
+	/* diff-index with either HEAD or an empty tree */
+	diff_index[4] = head_has_history() ? "HEAD" : EMPTY_TREE_SHA1_HEX;
+
 	child_process_init(&child);
 	child.argv = diff_index;
 	child.env = env->argv;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index e4436c1..329d7d4 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1430,8 +1430,22 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 		test $(git -C .. rev-parse HEAD^^) = $(git rev-parse HEAD) &&
 		git diff --quiet &&
 		test fifth = "$(cat path3)"
-	)
+	) &&
 
+	# (5) push into void
+	rm -fr void &&
+	git init void &&
+	(
+		cd void &&
+		git config receive.denyCurrentBranch updateInstead
+	) &&
+	git push void master &&
+	(
+		cd void &&
+		test $(git -C .. rev-parse master) = $(git rev-parse HEAD) &&
+		git diff --quiet &&
+		git diff --cached --quiet
+	)
 '
 
 test_expect_success 'updateInstead with push-to-checkout hook' '
@@ -1494,6 +1508,45 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		test "$(cat path5)" = irrelevant &&
 		test "$(git diff --name-only --cached HEAD)" = path5 &&
 		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
+	) &&
+
+	# push into void
+	rm -fr void &&
+	git init void &&
+	(
+		cd void &&
+		git config receive.denyCurrentBranch updateInstead &&
+		write_script .git/hooks/push-to-checkout <<-\EOF
+		if git rev-parse --quiet --verify HEAD
+		then
+			has_head=yes
+			echo >&2 updating from $(git rev-parse HEAD)
+		else
+			has_head=no
+			echo >&2 pushing into void
+		fi
+		echo >&2 updating to "$1"
+
+		git update-index -q --refresh &&
+		case "$has_head" in
+		yes)
+			git read-tree -u -m HEAD "$1" ;;
+		no)
+			git read-tree -u -m "$1" ;;
+		esac || {
+			status=$?
+			echo >&2 read-tree failed
+			exit $status
+		}
+		EOF
+	) &&
+
+	git push void master &&
+	(
+		cd void &&
+		git diff --quiet &&
+		git diff --cached --quiet &&
+		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
 	)
 '
 
-- 
2.4.0-rc0-179-ge750d7b
