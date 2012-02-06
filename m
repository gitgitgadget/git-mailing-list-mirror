From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] branch --edit-description: protect against mistyped branch
 name
Date: Sun, 05 Feb 2012 17:26:31 -0800
Message-ID: <7vaa4wda60.fsf_-_@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <20120130214842.GA16149@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 02:26:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuDLs-0005az-PY
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 02:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab2BFB0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 20:26:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716Ab2BFB0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 20:26:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1643B7B98;
	Sun,  5 Feb 2012 20:26:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eNzeT4sduBkMse+UVDFe96bO/cQ=; b=pTq3ik
	erfuGUDn/ujSyDL7Imlr+bk1KTNU0JgCYagZIiQUfAmytUKXg2gDDimaZIduZ+Or
	6KzlCj68+voIWsuHHPtL9ykyK4k3iUFR62APGAGaIjOdcP8GVSSYCJcqLn7V3tdu
	4jabpIQZVN5kRR8dstQGtJyJeJKT4+p/Kg3as=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MQDCqrb15aGEE7TOlyM9mg8773vOfGgn
	xma3rdulaMsytWhULwueh/zOV4F4CaAJ6eZYWcCi1weqcihwZa0FsYmNrVgX47fX
	hkJqoIQLd58RGc0nxOmpaDjknXivfMLlOpNFhzvJ7sFIniFuvgz7a9kBmeXU6cRu
	XbUHHdf7Ztc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D7B97B97;
	Sun,  5 Feb 2012 20:26:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 500077B96; Sun,  5 Feb 2012
 20:26:33 -0500 (EST)
In-Reply-To: <20120130214842.GA16149@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 30 Jan 2012 16:48:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A95D8C6-5061-11E1-A578-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189993>

It is very easy to mistype the branch name when editing its description,
e.g.

	$ git checkout -b my-topic master
	: work work work
	: now we are at a good point to switch working something else
	$ git checkout master
	: ah, let's write it down before we forget what we were doing
	$ git branch --edit-description my-tpoic

The command does not notice that branch 'my-tpoic' does not exist.  It is
not lost (it becomes description of an unborn my-tpoic branch), but is not
very useful.  So detect such a case and error out to reduce the grief
factor from this common mistake.

This incidentally also errors out --edit-description when the HEAD points
at an unborn branch (immediately after "init", or "checkout --orphan"),
because at that point, you do not even have any commit that is part of
your history and there is no point in describing how this particular
branch is different from the branch it forked off of, which is the useful
bit of information the branch description is designed to capture.

We may want to special case the unborn case later, but that is outside the
scope of this patch to prevent more common mistakes before 1.7.9 series
gains too much widespread use.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Jeff King <peff@peff.net> writes:

  > IOW, the problem with the current code is that it allows typos and other
  > arbitrary bogus names to be silently described, even though doing so is
  > probably an error...

 builtin/branch.c  |   15 +++++++++++++++
 t/t3200-branch.sh |   41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7095718..0c1784f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -768,6 +768,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 				      with_commit, argv);
 	else if (edit_description) {
 		const char *branch_name;
+		struct strbuf branch_ref = STRBUF_INIT;
+
 		if (detached)
 			die("Cannot give description to detached HEAD");
 		if (!argc)
@@ -776,6 +778,19 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			branch_name = argv[0];
 		else
 			usage_with_options(builtin_branch_usage, options);
+
+		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
+		if (!ref_exists(branch_ref.buf)) {
+			strbuf_reset(&branch_ref);
+
+			if (!argc)
+				return error("No commit on branch '%s' yet.",
+					     branch_name);
+			else
+				return error("No such branch '%s'.", branch_name);
+		}
+		strbuf_reset(&branch_ref);
+
 		if (edit_branch_description(branch_name))
 			return 1;
 	} else if (rename) {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ea82424..dd1aceb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -3,11 +3,8 @@
 # Copyright (c) 2005 Amos Waterland
 #
 
-test_description='git branch --foo should not create bogus branch
+test_description='git branch assorted tests'
 
-This test runs git branch --help and checks that the argument is properly
-handled.  Specifically, that a bogus branch is not created.
-'
 . ./test-lib.sh
 
 test_expect_success \
@@ -620,4 +617,40 @@ test_expect_success 'use set-upstream on the current branch' '
 
 '
 
+test_expect_success 'use --edit-description' '
+	write_script editor <<-\EOF &&
+		echo "New contents" >"$1"
+	EOF
+	EDITOR=./editor git branch --edit-description &&
+		write_script editor <<-\EOF &&
+		git stripspace -s <"$1" >"EDITOR_OUTPUT"
+	EOF
+	EDITOR=./editor git branch --edit-description &&
+	echo "New contents" >expect &&
+	test_cmp EDITOR_OUTPUT expect
+'
+
+test_expect_success 'detect typo in branch name when using --edit-description' '
+	write_script editor <<-\EOF &&
+		echo "New contents" >"$1"
+	EOF
+	(
+		EDITOR=./editor &&
+		export EDITOR &&
+		test_must_fail git branch --edit-description no-such-branch
+	)
+'
+
+test_expect_success 'refuse --edit-description on unborn branch for now' '
+	write_script editor <<-\EOF &&
+		echo "New contents" >"$1"
+	EOF
+	git checkout --orphan unborn &&
+	(
+		EDITOR=./editor &&
+		export EDITOR &&
+		test_must_fail git branch --edit-description
+	)
+'
+
 test_done
-- 
1.7.9.172.ge26ae
