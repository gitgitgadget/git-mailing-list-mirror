From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Wed, 28 Nov 2007 00:43:36 -0800
Message-ID: <7vmysy7oav.fsf@gitster.siamese.dyndns.org>
References: <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
	<1196205847-22968-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:34:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKuq-00042w-83
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:16 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIbh-0003QB-Qd
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:49:21 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIbR-0003wr-Sn
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbXK1Ino (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 03:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752930AbXK1Ino
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 03:43:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59433 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbXK1Inn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 03:43:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A28A82F0;
	Wed, 28 Nov 2007 03:44:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FB00998E8;
	Wed, 28 Nov 2007 03:44:00 -0500 (EST)
In-Reply-To: <1196205847-22968-1-git-send-email-robin.rosenberg@dewire.com>
	(Robin Rosenberg's message of "Wed, 28 Nov 2007 00:24:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.8, required=5.0, autolearn=disabled, AWL=2.159,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 75D93CA4302940B90524C0E9CFD4BD42025E89BF
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -47 maxlevel 200 minaction 2 bait 0 mail/h: 73 total 724144 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66331>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> This patch makes it possible to drag files and directories from
> a graphical browser and drop them onto a shell and feed them
> to common git operations without editing away the path to the
> root of the work tree.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  setup.c               |   19 +++++++++++++++++
>  t/t3904-abspatharg.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 0 deletions(-)
>  create mode 100755 t/t3904-abspatharg.sh
>
> diff --git a/setup.c b/setup.c
> index f512ea0..ffc30bf 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -7,6 +7,25 @@ static int inside_work_tree = -1;
>  const char *prefix_path(const char *prefix, int len, const char *path)
>  {
>  	const char *orig = path;
> +	const char *work_tree = get_git_work_tree();
> +	if (is_absolute_path(path) && work_tree) {
> +		int n = strlen(work_tree);
> +		if (!strncmp(path, work_tree, n) && (path[n] == '/' || !path[n])) {
> +			if (path[n])
> +				path += n + 1;
> +			else
> +				path += n;
> +
> +			if (prefix && !strncmp(path, prefix, len - 1)) {
> +				if (path[len - 1] == '/')
> +					path += len;
> +				else
> +					if (!path[len - 1])
> +						path += len - 1;
> +			}
> +		}
> +	}
> +

This looks somewhat tighter than the previous one, but still made me
worried if the caller of prefix_path() has run the setup sequence enough
so that calling get_git_work_tree() is safe, so I ended up auditing the
callpath.  At least, I do not want to see that unconditional call to
get_git_work_tree() when we do not need to do this "ah prefix got an
unusual absolute path" stuff.

 * builtin-init-db.c uses prefix_path() to find where the template is
   (this is mingw fallout change); in general, I do not think we would
   want to trigger repository nor worktree discovery inside init-db,
   although I suspect this particular callpath could be made Ok (because
   it is taken only when template_dir is not absolute) if you do not
   unconditionally call get_git_work_tree() in prefix_path().

 * config.c uses prefix_path() to find the ETC_GITCONFIG that is not
   absolute (again, mingw fallout).  When git_config() is called, we
   already should have discovered repository but worktree may not have
   been found yet (config.worktree can be used to specify where it is,
   so you have a chicken and egg problem).  Again, this particular
   callpath happens to be Ok because this is used only for non-absolute
   path, but that is a bit subtle.

 * get_pathspec() uses prefix_path() for obvious reasons, and the prefix
   it gets must have been discovered by finding out where the worktree
   is, so by definition that one is safe.

Everybody else you would get from "git grep prefix_path" are after the
proper setup, so they should all be safe. 


> diff --git a/t/t3904-abspatharg.sh b/t/t3904-abspatharg.sh
> new file mode 100755
> index 0000000..cd4a52e
> --- /dev/null
> +++ b/t/t3904-abspatharg.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2007 Robin Rosenberg
> +#
> +
> +test_description='Test absolute filename arguments to various git
> +commands.  Absolute arguments pointing to a location within the git
> +work tree should behave the same as relative arguments.  '
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'add files using absolute path names' '
> +echo a >afile &&
> +echo b >bfile &&
> +git-add afile &&
> +git-add "$(pwd)/bfile" &&

This looks quite dense.  With indent like other existing tests this
would become a bit easier to read.

> +test "afile bfile" = "$(echo $(git ls-files))"

Hmmm.  Looks a bit ugly but Ok.

> +mkdir x &&
> +cd x &&
> +echo c >cfile &&
> +echo d >dfile &&
> +git-add cfile &&
> +git-add "$(pwd)" &&
> +cd .. &&

If this sequence fails in the middle, the next test will execute in a
wrong directory.  Instead of "cd there && ... && cd .. &&", it is safer
to do "( cd there && ... ) &&".

> +test "afile bfile x/cfile x/dfile" = "$(echo $(git ls-files))" &&
> +git ls-files x >f1 &&
> +git ls-files "$(pwd)/x" >f2 &&
> +diff f1 f2

"diff -u" is much easier for people who ends up reading the output when
something goes wrong.

Cases that are still not covered:

	try to add a file in the parent directory from a subdirectory,
	using absolute path;

	try to add a file in a directory that is too high (i.e. outside
	the work tree), using absolute path;

The latter I think should fail.  People tend to forget writing negative
tests when they are too excited with their shiny new features.

Perhaps adding something like:

	try to add a sub-subdirectory using an absolute path, and make
	sure paths in subdirectory are not added;

would also be prudent to catch future possible breakages (off by one
cutting the common directory prefix one level too deep or something),
but that is probably just me who tends to be paranoid.

Exactly the same comments apply to tests for other commands.  Also I
think mv, rm, reset and checkout take pathnames.
