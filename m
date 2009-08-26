From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 17:50:29 +0200
Message-ID: <20090826155029.GA5750@atjola.homenet>
References: <20090826121600.GA29098@atjola.homenet>
 <1251298007-18693-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Wed Aug 26 17:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgKlo-00049w-9y
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 17:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZHZPuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 11:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbZHZPue
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 11:50:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:38985 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751050AbZHZPue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 11:50:34 -0400
Received: (qmail invoked by alias); 26 Aug 2009 15:50:34 -0000
Received: from i59F555FB.versanet.de (EHLO atjola.homenet) [89.245.85.251]
  by mail.gmx.net (mp038) with SMTP; 26 Aug 2009 17:50:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18u1ONysfsu6NWuubdw9YDpbV5b8V9jSGXMAQtghb
	9Fkpj19W4X9ljw
Content-Disposition: inline
In-Reply-To: <1251298007-18693-1-git-send-email-catap@catap.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127103>

On 2009.08.26 18:46:47 +0400, Kirill A. Korinskiy wrote:
> @@ -518,8 +521,22 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
> =20
>  		mapped_refs =3D write_remote_refs(refs, refspec, reflog_msg.buf);
> =20
> -		remote_head =3D find_ref_by_name(refs, "HEAD");
> -		head_points_at =3D guess_remote_head(remote_head, mapped_refs, 0);
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
> +		head_points_at =3D guess_remote_head(remote_head, mapped_refs, 1);

Just setting "all" to 1 there is wrong. With "all" set to 1,
guess_remote_head() returns a linked list of _all_ matching refs. The
first entry in that list depends on the order of mapped_refs.

doener@atjola:h $ mkdir a; cd a; git init
Initialized empty Git repository in /home/doener/h/a/.git/
doener@atjola:a (master) $ git commit --allow-empty -m init
[master (root-commit) aa39247] init
doener@atjola:a (master) $ git branch foo
doener@atjola:a (master) $ cd ..

doener@atjola:h $ (git clone -b foo a foo; cd foo; git branch)
Initialized empty Git repository in /home/doener/h/foo/.git/
* foo

doener@atjola:h $ (git clone -b master a master; cd master; git branch)
Initialized empty Git repository in /home/doener/h/master/.git/
* foo

Here, "foo" was first in mapped_refs, and so "-b master" used that, too=
=2E

Using guess_remote_head() seems pretty wrong. With -b given, you don't
want to guess anymore, you _know_ which one you want. Unfortunately, I
don't see a straight-forward way to handle that (but I'm totally
clueless about the code, so don't let me scare you ;-)).

> diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
> new file mode 100755
> index 0000000..b5fec50
> --- /dev/null
> +++ b/t/t5706-clone-branch.sh
> @@ -0,0 +1,49 @@
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
> +	 git commit -m one && git branch foo &&
> +	 git checkout -b two &&
> +	 echo two >f && git add f && git commit -m two &&
> +	 git checkout master)
> +
> +'
> +
> +test_expect_success 'clone' '
> +
> +	git clone parent clone &&
> +	(cd clone &&
> +	test $(git rev-parse --verify HEAD) =3D \
> +	     $(git rev-parse --verify refs/remotes/origin/master) &&
> +	test $(git rev-parse --verify HEAD) !=3D \
> +	     $(git rev-parse --verify refs/remotes/origin/two))
> +
> +
> +'
> +
> +test_expect_success 'clone -b two' '
> +
> +	git clone -b two parent clone-b &&
> +	(cd clone-b &&
> +	test $(git rev-parse --verify HEAD) =3D \
> +	     $(git rev-parse --verify refs/remotes/origin/two) &&
> +	test $(git rev-parse --verify HEAD) !=3D \
> +	     $(git rev-parse --verify refs/remotes/origin/master))
> +
> +'
> +
> +test_expect_success 'clone -b foo' '
> +
> +	git clone -b foo parent clone-b-foo &&
> +	(cd clone-b-foo &&
> +	test $(git branch | grep \* | sed -e s:\*\ ::) =3D foo)

This should probably do "git symbolic-ref HEAD" instead of the branch +
grep + sed. And it should also verify that rev-parse foo =3D=3D rev-par=
se
origin/foo.

And to catch the above bug, you need a second test like that, but for
"master" instead of "foo".

HTH
Bj=F6rn
