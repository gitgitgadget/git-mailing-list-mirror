From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 00:36:37 +0200
Message-ID: <20090825223637.GA20523@atjola.homenet>
References: <1251228341-29434-1-git-send-email-catap@catap.ru>
 <1251228467-29638-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:36:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg4dH-00088P-EX
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 00:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbZHYWgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756248AbZHYWgm
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 18:36:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:42333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756244AbZHYWgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 18:36:41 -0400
Received: (qmail invoked by alias); 25 Aug 2009 22:36:41 -0000
Received: from i59F578C3.versanet.de (EHLO atjola.homenet) [89.245.120.195]
  by mail.gmx.net (mp008) with SMTP; 26 Aug 2009 00:36:41 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+AtDAxIemA5JTZvDxR0loanBWUWqfc36dgCJNJ3S
	EZ6yubeij9g+28
Content-Disposition: inline
In-Reply-To: <1251228467-29638-1-git-send-email-catap@catap.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127053>

On 2009.08.25 23:27:47 +0400, Kirill A. Korinskiy wrote:
> Sometimes (especially on production systems) we need to use only one
> remote branch for building software. It's really annoying to clone
> origin and then switch branch by hand everytime. So this patch
> provides functionality to clone a remote branch with one command
> without using checkout after clone.
>=20
> Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
> ---
>  Documentation/git-clone.txt |    4 ++++
>  builtin-clone.c             |   23 ++++++++++++++++++++---
>  t/t5706-clone-branch.sh     |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 3 deletions(-)
>  create mode 100755 t/t5706-clone-branch.sh
>=20
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index 2c63a0f..50446d2 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -127,6 +127,10 @@ objects from the source repository into a pack i=
n the cloned repository.
>  	Instead of using the remote name 'origin' to keep track
>  	of the upstream repository, use <name>.
> =20
> +--branch <name>::
> +-b <name>::
> +	Instead of using the remote HEAD as master, use <name> branch.

Hm, that's no good. The branch won't be called master, nor is HEAD used
as "master" anyway. If the remote repo's HEAD references refs/heads/foo=
,
you'll get refs/heads/foo locally as well, not "master", but see below.

Maybe: Create a local branch head for <name> instead of the branch
referenced by the remote repo's HEAD.

> @@ -65,6 +66,8 @@ static struct option builtin_clone_options[] =3D {
>  		   "reference repository"),
>  	OPT_STRING('o', "origin", &option_origin, "branch",
>  		   "use <branch> instead of 'origin' to track upstream"),
> +	OPT_STRING('b', "branch", &option_branch, "branch",
> +		   "use <branch> from 'origin' as HEAD"),

Using 'origin' there is unfortunate, as using "--origin foo" would make
clone call the remote "foo" instead of "origin". And it's not really
used "as" HEAD, but instead of the remote repo's HEAD to determine whic=
h
local branch head to create. Though I guess this affect the
refs/remotes/<remote>/HEAD symref as well?

> @@ -518,7 +521,21 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
> =20
>  		mapped_refs =3D write_remote_refs(refs, refspec, reflog_msg.buf);
> =20
> -		remote_head =3D find_ref_by_name(refs, "HEAD");
> +		if (option_branch) {
> +			strbuf_addf(&branch_head, "%s%s", src_ref_prefix, option_branch);
> +
> +			remote_head =3D find_ref_by_name(refs, branch_head.buf);
> +		}
> +
> +		if (!remote_head) {
> +			if (option_branch)
> +				warning("Remote branch %s not found in upstream %s"
> +					", using HEAD instead",
> +					option_branch, option_origin);
> +
> +			remote_head =3D find_ref_by_name(refs, "HEAD");
> +		}
> +
>  		head_points_at =3D guess_remote_head(remote_head, mapped_refs, 0);

This would still pick refs/heads/master if refs/heads/master and
refs/heads/<branch> reference the same commit. That's due to the check
in guess_remote_head() which prefers refs/heads/master over all other
refs. While this is acceptable for the HEAD lookup, I'd treat that as a
bug for this new option.

>  	}
>  	else {
> diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
> new file mode 100755
> index 0000000..8d83ac8
> --- /dev/null
> +++ b/t/t5706-clone-branch.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +
> +test_description=3D'branch clone options'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +
> +	mkdir parent &&
> +	(cd parent && git init &&
> +	 echo one >file && git add file &&
> +	 git commit -m one && git checkout -b two &&
> +	 echo two >f && git add f && git commit -m two &&
> +	 git checkout master)
> +
> +'
> +
> +test_expect_success 'clone' '
> +
> +	git clone parent clone &&
> +	(cd clone && git rev-parse --verify refs/remotes/origin/master)
> +
> +'
> +
> +test_expect_success 'clone -b' '
> +
> +	git clone -b two parent clone-b &&
> +	(cd clone-b && test $(git rev-parse --verify HEAD) =3D $(git rev-pa=
rse --verify refs/remotes/origin/two))

This should probably check not just that HEAD resolves to the same
commit as refs/remotes/origin/two, but that HEAD references
refs/heads/two as well, even if the remote's refs/heads/master
references the same commit as refs/heads/two (see above).

Bj=F6rn
