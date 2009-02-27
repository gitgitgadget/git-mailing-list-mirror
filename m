From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-branch: a detached HEAD and branch called HEAD are
 different
Date: Thu, 26 Feb 2009 22:10:13 -0800
Message-ID: <7vvdqwo1fe.fsf_-_@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <86d4c5e00902262027y13b19eb7nf89a45e83b986801@mail.gmail.com>
 <7veixkpi4a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Deskin Miller <deskinm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 07:12:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcvxc-0006rb-31
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 07:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbZB0GK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 01:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbZB0GK2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 01:10:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZB0GK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 01:10:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B1D109D749;
	Fri, 27 Feb 2009 01:10:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB6E89D747; Fri,
 27 Feb 2009 01:10:14 -0500 (EST)
In-Reply-To: <7veixkpi4a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Feb 2009 21:24:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50A0E032-0495-11DE-9D5A-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111631>

While on a detached HEAD, builtin-branch.c passed string "HEAD" around in
the varilable "head" that held the current branch name.  This did not
allow you to distinguish between a local branch whose name is "HEAD" and a
detached HEAD.

Allow the variable to contain NULL when the HEAD is detached.  The change
is primarily to protect !strcmp(head, name) to see if we are try to
manipulate the current branch with "head &&"; we won't be futzing with the
current branch when the HEAD is detached by definition.

Creating a local branch "HEAD" is not useful at all, but if you managed to
create one by mistake, "git branch -d HEAD" couldn't delete it while your
HEAD is detached, due to this bug.

One of the functions, rename_branch(), even expected NULL to signal this
situation, to prevent "git branch -m othername" while on detached HEAD,
and this change incidentally fixes this unrelated bug.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I wasn't personally very much interested in these "C-rewrites" of
   Porcelains, and I have never looked at the implementation very
   carefully, but some parts of them are disgustingly crappy, and I am
   finding these inconsistencies after looking at them only for 5
   minutes.  Oh well...

   Anyway, this is a preparatory clean-up.

 branch.c         |    2 +-
 builtin-branch.c |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 1f00e44..e287eab 100644
--- a/branch.c
+++ b/branch.c
@@ -121,7 +121,7 @@ void create_branch(const char *head,
 	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
 		if (!force)
 			die("A branch named '%s' already exists.", name);
-		else if (!is_bare_repository() && !strcmp(head, name))
+		else if (!is_bare_repository() && head && !strcmp(head, name))
 			die("Cannot force update the current branch.");
 		forcing = 1;
 	}
diff --git a/builtin-branch.c b/builtin-branch.c
index 504a981..c34af27 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -126,7 +126,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 		if (interpret_nth_last_branch(argv[i], &bname) != len)
 			strbuf_add(&bname, argv[i], len);
 
-		if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
+		if (kinds == REF_LOCAL_BRANCH && head && !strcmp(head, bname.buf)) {
 			error("Cannot delete the branch '%s' "
 			      "which you are currently on.", bname.buf);
 			ret = 1;
@@ -408,7 +408,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	for (i = 0; i < ref_list.index; i++) {
 		int current = !detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
-			!strcmp(ref_list.list[i].name, head);
+			head && !strcmp(ref_list.list[i].name, head);
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
 			       abbrev, current);
 	}
@@ -541,6 +541,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	head = xstrdup(head);
 	if (!strcmp(head, "HEAD")) {
 		detached = 1;
+		head = NULL;
 	} else {
 		if (prefixcmp(head, "refs/heads/"))
 			die("HEAD not found below refs/heads!");
@@ -561,7 +562,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	else if (rename && (argc == 2))
 		rename_branch(argv[0], argv[1], rename > 1);
 	else if (argc <= 2)
-		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(head, argv[0],
+			      (argc == 2) ? argv[1] : head ? head : "HEAD",
 			      force_create, reflog, track);
 	else
 		usage_with_options(builtin_branch_usage, options);
