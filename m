From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git add on deleted file
Date: Mon, 13 Aug 2012 10:54:10 -0700
Message-ID: <7vipcmekzh.fsf@alter.siamese.dyndns.org>
References: <CAOBOgRZRSk7+jxMg+v=GWcn3F9ZfDTGC89YhJ1s7o9=HaOx4Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Angus Hammond <angusgh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:54:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0yqJ-0007xn-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab2HMRyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:54:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab2HMRyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 13:54:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41E0F95F9;
	Mon, 13 Aug 2012 13:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XeAOs6PU+Cq2fwDORDdeRbqp+Ac=; b=mVLz9w
	dnUNPSNHx0eRvAfBfR6dxX/gMl2kIvn/au3/mL7+EHsv5iRZjHXxNtyrgw0NeuRn
	iRd0PmP1wtQJwiIBGblrNlD0WSNuTaFpmpZ+wa5tx9LxfKJu5I776poCNFW6UIPq
	mxci9Mx+PSGu5szwT8bGg5jc6Ua8P+PYfVAPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HR/4CF6lN6dK8AgB3hqvwyikn4EED6S+
	1tu2wZhKHVpDN0yxL6HfCzYGILTN1pR9nlIxAdQOcEhfMnSDpytY4TY7fM6b9LfS
	RuvJl85zCV6FAVkoTE0q5N8MgBX+xVlgOd+lbAUZYXzO5fb5x3dcHTgpboJSducu
	PFvdPxVv85s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F31595F8;
	Mon, 13 Aug 2012 13:54:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76C3995F5; Mon, 13 Aug 2012
 13:54:12 -0400 (EDT)
In-Reply-To: <CAOBOgRZRSk7+jxMg+v=GWcn3F9ZfDTGC89YhJ1s7o9=HaOx4Bg@mail.gmail.com> (Angus
 Hammond's message of "Mon, 13 Aug 2012 18:34:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3DE236E-E56F-11E1-AA16-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203350>

Angus Hammond <angusgh@gmail.com> writes:

> ... Personally I'd like to see
> "git add foo" here be equivalent "git rm --cached foo", but I can
> understand how others might prefer git add not to be destructive like
> that.

Funny that you bring it up this week.  As I wrote in

  http://git-blame.blogspot.com/2012/08/leftover-bits.html

I think the following topic should be revisited:

  http://thread.gmane.org/gmane.comp.version-control.git/171811/focus=171841

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 19 Apr 2011 12:18:20 -0700
Subject: [PATCH] git add: notice removal of tracked paths by default

When run without "-u" or "-A" option,

    $ edit subdir/x
    $ create subdir/y
    $ rm subdir/z
    $ git add subdir/

does not notice removal of paths (e.g. subdir/z) from the working tree.
Make "git add" to pretend as if "-A" is given when there is a pathspec on
the command line.  "git add" without any argument continues to be a no-op.

When resolving a conflict to remove a path, the current code tells you to
"git rm $path", but now with this patch you can say "git add $path".  Of
course you can do "git add -A $path" without this patch.

In either case, the operation "git add" is about "adding the state of the
path in the working tree to the index".  The state may happen to be "path
removed", not "path has an updated content".

The semantic change can be seen by a breakage in t2200, test #15.  There,
a merge has conflicts in path4 and path6 (which are removed from the
working tree), and test checks "git add path4" to resolve it must fail,
and makes sure "add -u" needs to be used.  We do not have to do this
anymore.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c         | 3 +++
 t/t2200-add-update.sh | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 89dce56..4eae028 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -389,6 +389,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
+	/* default "git add pathspec..." to "git add -A pathspec..." */
+	if (!take_worktree_changes && argc)
+		addremove = 1;
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 	if ((addremove || take_worktree_changes) && !argc) {
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 4cdebda..b2fcd01 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -150,10 +150,6 @@ test_expect_success 'add -u resolves unmerged paths' '
 	echo 2 >path3 &&
 	echo 2 >path5 &&
 
-	# Explicit resolving by adding removed paths should fail
-	test_must_fail git add path4 &&
-	test_must_fail git add path6 &&
-
 	# "add -u" should notice removals no matter what stages
 	# the index entries are in.
 	git add -u &&
-- 
1.7.12.rc2.85.g1de7134
