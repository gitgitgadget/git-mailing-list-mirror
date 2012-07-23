From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Sun, 22 Jul 2012 22:09:52 -0700
Message-ID: <7vsjcjnjvj.fsf@alter.siamese.dyndns.org>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAv3-00055H-OO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 07:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab2GWFKd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jul 2012 01:10:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520Ab2GWFJ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2012 01:09:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D5F25B5E;
	Mon, 23 Jul 2012 01:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cfV1P7+eVRAi
	wVikCQ232tKpMgU=; b=jqgs7PVVSsFmHpHuAmL2DxTS/aPVoRB5djz1VS9z7q/C
	w7b45EWHGKMjPN4DaSgcB2mgmXokBeFW37+XnVkhYf2aDqnhbivCj0WCGI384oIh
	qzlZ8GC318D9TUfbffPBds6XFu/h0ANGYwSUUj3qcRblOYmhtcaGZq+uFBbBoDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=amuSOq
	vWS0WWlORxoNyZnc2TFN+wLvr/l7H0Wp+hnSBqeeQQu5XledJxg7ngotxI6IceQC
	3J4HPzsUYviDBb5jz9Kp/8iELmOLNNxVAYrdwz1+8olxXBySfISZvIbZ6rL656v9
	tNu7JmLgsQua2NfMB2sbSZGhU5e+2bSwpIYi8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 298A35B5D;
	Mon, 23 Jul 2012 01:09:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A91B5B59; Mon, 23 Jul 2012
 01:09:54 -0400 (EDT)
In-Reply-To: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com> ("Daniel
 =?utf-8?Q?Gra=C3=B1a=22's?= message of "Sun, 22 Jul 2012 11:49:44 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3967D8E-D484-11E1-8B64-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201899>

Daniel Gra=C3=B1a <dangra@gmail.com> writes:

> A common way to track dotfiles with git is using GIT_DIR and
> GIT_WORK_TREE to move repository out of ~/.git with something like:
>
>     git init --bare ~/.dotfiles
>     alias dotfiles=3D"GIT_DIR=3D~/.dotfiles GIT_WORK_TREE=3D~ git"
>
>     dotfiles add ~/.bashrc
>     dotfiles commit -a -m "add my bashrc"
>     ...
>
> but git-submodule complains when trying to add submodules:
>
>     dotfiles submodule add http://path.to/submodule
>     fatal: working tree '/home/user' already exists.
>
>     git --git-dir ~/.dotfiles submodule add http://path.to/submodule
>     fatal: /usr/lib/git-core/git-submodule cannot be used without a
> working tree.
>
> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
> ---

I think this is in line with what we discussed earlier on list when
the interaction between GIT_DIR/GIT_WORK_TREE and submodules came up
the last time.  Jens?

>  git-submodule.sh                       |    7 +++-
>  t/t7409-submodule-detached-worktree.sh |   61 ++++++++++++++++++++++=
++++++++++
>  2 files changed, 66 insertions(+), 2 deletions(-)
>  create mode 100755 t/t7409-submodule-detached-worktree.sh
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5629d87..88ee4ea 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -181,8 +181,11 @@ module_clone()
>  		rm -f "$gitdir/index"
>  	else
>  		mkdir -p "$gitdir_base"
> -		git clone $quiet -n ${reference:+"$reference"} \
> -			--separate-git-dir "$gitdir" "$url" "$sm_path" ||
> +		(
> +			clear_local_git_env
> +			git clone $quiet -n ${reference:+"$reference"} \
> +				--separate-git-dir "$gitdir" "$url" "$sm_path"
> +		) ||
>  		die "$(eval_gettext "Clone of '\$url' into submodule path
> '\$sm_path' failed")"

Line-wrapped broken patch?

>  	fi
>
> diff --git a/t/t7409-submodule-detached-worktree.sh
> b/t/t7409-submodule-detached-worktree.sh
> new file mode 100755
> index 0000000..db75642
> --- /dev/null
> +++ b/t/t7409-submodule-detached-worktree.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Daniel Gra=C3=B1a
> +#
> +
> +test_description=3D'Test submodules on detached working tree
> +
> +This test verifies that "git submodule" initialization, update and
> addition works

Line-wrapped broken patch?

> +on detahced working trees
> +'
> +
> +TEST_NO_CREATE_REPO=3D1
> +. ./test-lib.sh
> +
> +test_expect_success 'submodule on detached working tree' '
> +	git init --bare remote &&
> +	test_create_repo bundle1 &&
> +	(cd bundle1 && test_commit "shoot") &&
> +	mkdir home &&
> +	(
> +		cd home &&
> +		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
> +		git clone --bare ../remote .dotfiles &&
> +		git submodule add ../bundle1 .vim/bundle/sogood &&
> +		test_commit "sogood" &&
> +		git push origin master
> +	) &&

Don't you want to verify not just commands succeed, but leave a
reasonable result, e.g. by running "git rev-parse HEAD" in "remote"
and comparing the output with "git rev-parse HEAD" in .dotfiles, or
something?

> +	mkdir home2 &&
> +	(
> +		cd home2 &&
> +		export GIT_WORK_TREE=3D"$(pwd)" GIT_DIR=3D"$(pwd)/.dotfiles" &&
> +		git clone --bare ../remote .dotfiles &&
> +		git submodule update --init

Likewise.  What state, other than "submodule update --init" does not
barf, do you expect to see?

> +	)
> +'
> +
> +test_expect_success 'submodule on detached working pointed by core.w=
orktree' '
> +	mkdir home3 &&
> +	(
> +		cd home3 &&
> +		export GIT_DIR=3D"$(pwd)/.dotfiles" &&
> +		git clone --bare ../remote "$GIT_DIR" &&
> +		git config core.bare false &&
> +		git config core.worktree .. &&
> +		git submodule add ../bundle1 .vim/bundle/dupe &&
> +		test_commit "dupe" &&
> +		git push origin master

Likewise.

> +	) &&
> +	(
> +		cd home &&
> +		export GIT_DIR=3D"$(pwd)/.dotfiles" &&
> +		git config core.bare false &&
> +		git config core.worktree .. &&
> +		git pull &&
> +		git submodule update &&
> +		git submodule status &&
> +		test -d .vim/bundle/dupe

Likewise.  Is there something you want to verify in the branches in
the submodule and its working tree, other than the existence of that
directory?

> +	)
> +'
> +
> +test_done
