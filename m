From: Junio C Hamano <gitster@pobox.com>
Subject: merge: do not create a signed tag merge under --ff-only option
Date: Sun, 05 Feb 2012 16:22:12 -0800
Message-ID: <7vmx8wdd57.fsf@alter.siamese.dyndns.org>
References: <CADeLxZTsq1M5oEb1u5Oqfxq3dYXL6E_uN9bXaTqaOZiA0fgdJQ@mail.gmail.com>
 <7vd39vlbgj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bart Trojanowski <bart@jukie.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 01:22:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuCM2-00046G-S3
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 01:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab2BFAWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 19:22:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab2BFAWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 19:22:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8718873CE;
	Sun,  5 Feb 2012 19:22:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WbAS2CFPYyj+XeKYfK7UM2rL7f4=; b=CACfStajzh/T9+U0DVhk
	k28bgfx9iQuZvGcKttkqdVdLoyrgL0RMvB4Z3qbJN3eNcE7PM2nGMLYVL3P6Ls9U
	AwsWCr//odk2RtUYNbs9cloTm8r7wOqXUwSg/gscT7L3ychtoorW70vPELjIJWCZ
	IjVz2YWHpzWQhWKd/wAP5x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=OPxb/cJXVm/h9xtROYeBDYfpX/IIHL1ddo1ru+Blu3Hx1S
	zLzOxL3JF7zmGoQcpzPM1ykOoCg/bPOph9N5o2t86Z2w6fZad4bTQDPZmaERN1c1
	Cunw7nT2gsaXCilbWO1VFWzCMO64oIsJyCrg0yr21BcOcPw85EWRhMQOq+CnY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DC3573CC;
	Sun,  5 Feb 2012 19:22:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBB0D73CB; Sun,  5 Feb 2012
 19:22:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E2FC446-5058-11E1-B1DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189989>

Starting at release v1.7.9, if you ask to merge a signed tag, "git merge"
always creates a merge commit, even when the tag points at a commit that
happens to be a descendant of your current commit.

Unfortunately, this interacts rather badly for people who use --ff-only to
make sure that their branch is free of local developments. It used to be
possible to say:

	$ git checkout -b frotz v1.7.9~30
        $ git merge --ff-only v1.7.9

and expect that the resulting tip of frotz branch matches v1.7.9^0 (aka
the commit tagged as v1.7.9), but this fails with the updated Git with:

	fatal: Not possible to fast-forward, aborting.

because a merge that merges v1.7.9 tag to v1.7.9~30 cannot be created by
fast forwarding.

We could teach users that now they have to do

	$ git merge --ff-only v1.7.9^0

but it is far more pleasant for users if we DWIMmed this ourselves.

When an integrator pulls in a topic from a lieutenant via a signed tag,
even when the work done by the lieutenant happens to fast-forward, the
integrator wants to have a merge record, so the integrator will not be
asking for --ff-only when running "git pull" in such a case. Therefore,
this change should not regress the support for the use case v1.7.9 wanted
to add.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

    We could solve this in one of two ways. We could tell them to merge
    v3.2.3^0 instead. Or we could just go ahead and do that for them
    automatically ourselves.  I am inclined to say that we should unwrap
    the tag given from the command line when --ff-only was given, i.e. we
    do the latter.

  And it turns out that it is just a single-liner patch.

 builtin/merge.c  |    3 ++-
 t/t7600-merge.sh |   13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3a45172..b4fbc60 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1283,7 +1283,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    sha1_to_hex(commit->object.sha1));
 		setenv(buf.buf, argv[i], 1);
 		strbuf_reset(&buf);
-		if (merge_remote_util(commit) &&
+		if (!fast_forward_only &&
+		    merge_remote_util(commit) &&
 		    merge_remote_util(commit)->obj &&
 		    merge_remote_util(commit)->obj->type == OBJ_TAG) {
 			option_edit = 1;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5d8c428..a598dfa 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -27,6 +27,7 @@ Testing basic merge operations/option parsing.
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
 
 printf '%s\n' 1 2 3 4 5 6 7 8 9 >file
 printf '%s\n' '1 X' 2 3 4 5 6 7 8 9 >file.1
@@ -670,4 +671,16 @@ test_expect_success 'merge --no-ff --edit' '
 	test_cmp actual expected
 '
 
+test_expect_success GPG 'merge --ff-only tag' '
+	git reset --hard c0 &&
+	git commit --allow-empty -m "A newer commit" &&
+	git tag -s -m "A newer commit" signed &&
+	git reset --hard c0 &&
+
+	git merge --ff-only signed &&
+	git rev-parse signed^0 >expect &&
+	git rev-parse HEAD >actual &&
+	test_cmp actual expect
+'
+
 test_done
