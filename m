From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/4] submodule update: add --remote for submodule's
 upstream changes
Date: Mon, 03 Dec 2012 08:46:46 -0800
Message-ID: <7v8v9ft761.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
 <ec5d0235322619aff6c1c64b0a346efb0e4d0a32.1354417618.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Dec 03 17:47:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfZAh-0004gI-7C
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 17:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab2LCQqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2012 11:46:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754869Ab2LCQqu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2012 11:46:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DACB99EA7;
	Mon,  3 Dec 2012 11:46:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XhCISlCmSXdh
	hBYLqW55+nNieMQ=; b=pTDGmKsgaE+3xtFGXGtnEOsY4zYUlPU9MdCDxqfuq/w5
	cr8ybSjlj3i5APaXVSavnqrjwH/kkmTG3Db9Lspjk5LLwh93DuTcF0g6iuHj7tuZ
	hMhKUlZzQQcjxeNOXGKcN6W7WTD03HFYNhoNob++bKHysi5lRmdkft4k6a+okzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w2HnNB
	bNRVj1WIdvSBaGj9ggTQEfkWcO24XnNcglZevxk9u8ViMffKTjMfcp1JTBBX+BWL
	NsFs8vxneA/Gl4yTXb2teQfdHfka81HVJ/d9g6LS35aGpJcV2G3DdBZtXYCthXJt
	UHaiMzm/u4DpfQ6gQDkUFc7jizcBOlNTsI0TQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F209EA6;
	Mon,  3 Dec 2012 11:46:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 028E39EA2; Mon,  3 Dec 2012
 11:46:47 -0500 (EST)
In-Reply-To: <ec5d0235322619aff6c1c64b0a346efb0e4d0a32.1354417618.git.wking@tremily.us>
 (W. Trevor King's message of "Sat, 01 Dec 2012 22:17:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07745C7A-3D69-11E2-99F8-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211043>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> The current `update` command incorporates the superproject's gitlinke=
d
> SHA-1 ($sha1) into the submodule HEAD ($subsha1).  Depending on the
> options you use, it may checkout $sha1, rebase the $subsha1 onto
> $sha1, or merge $sha1 into $subsha1.  This helps you keep up with
> changes in the upstream superproject.
>
> However, it's also useful to stay up to date with changes in the
> upstream subproject.  Previous workflows for incorporating such
> changes include the ungainly:
>
>   $ git submodule foreach 'git checkout $(git config --file $toplevel=
/.gitmodules submodule.$name.branch) && git pull'
>
> With this patch, all of the useful functionality for incorporating
> superproject changes can be reused to incorporate upstream subproject
> updates.  When you specify --remote, the target $sha1 is replaced wit=
h
> a $sha1 of the submodule's origin/master tracking branch.  If you wan=
t
> to merge a different tracking branch, you can configure the
> `submodule.<name>.branch` option in `.gitmodules`.  You can override
> the `.gitmodules` configuration setting for a particular superproject
> by configuring the option in that superproject's default configuratio=
n
> (using the usual configuration hierarchy, e.g. `.git/config`,
> `~/.gitconfig`, etc.).
>
> Previous use of submodule.<name>.branch
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Because we're adding a new configuration option, it's a good idea to
> check if anyone else is already using the option.  The foreach-pull
> example above was described by =C3=86var in
>
>   commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
>   Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>   Date:   Fri May 21 16:10:10 2010 +0000
>
>     git-submodule foreach: Add $toplevel variable
>
> Gerrit uses the same interpretation for the setting, but because
> Gerrit has direct access to the subproject repositories, it updates
> the superproject repositories automatically when a subproject changes=
=2E
> Gerrit also accepts the special value '.', which it expands into the
> superproject's branch name.
>
> Although the --remote functionality is using `submodule.<name>.branch=
`
> slightly differently, the effect is the same.  The foreach-pull
> example uses the option to record the name of the local branch to
> checkout before pulls.  The tracking branch to be pulled is recorded
> in `.git/modules/<name>/config`, which was initialized by the module
> clone during `submodule add` or `submodule init`.  Because the branch
> name stored in `submodule.<name>.branch` was likely the same as the
> branch name used during the initial `submodule add`, the same branch
> will be pulled in each workflow.
>
> Implementation details
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In order to ensure a current tracking branch state, `update --remote`
> fetches the submodule's remote repository before calculating the
> SHA-1.  However, I didn't change the logic guarding the existing fetc=
h:
>
>   if test -z "$nofetch"
>   then
>     # Run fetch only if $sha1 isn't present or it
>     # is not reachable from a ref.
>     (clear_local_git_env; cd "$path" &&
>       ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>        test -z "$rev") || git-fetch)) ||
>     die "$(eval_gettext "Unable to fetch in submodule path '\$path'")=
"
>   fi
>
> There will not be a double-fetch, because the new $sha1 determined
> after the `--remote` triggered fetch should always exist in the
> repository.  If it doesn't, it's because some racy process removed it
> from the submodule's repository and we *should* be re-fetching.

As you hinted in the first paragraph, you could flip between merge,
rebase, and detach with a command line option when running the
"update" subcommand, but I would imagine that the expected use
pattern is that for a particular project, you would choose one mode
and consistently stick to that mode.  To make it easier, the user
can set submodule.$name.update once and run "update" without having
to give any flags.

And this is about adding another mode to the "update" subcommand
where the HEAD is not detached, nor merged, nor rebased, but is set
to follow whatever commit a remote branch points at.

Shouldn't the patch add a way for the user to set a configuration
variable to signal that this new mode is always used when "update"
is run without a command line flag?

As the user has to configure submodule.$name.branch in order to use
this mode anyway, I have a feeling that taking that as a signal, and
ignoring submodule.$name.update altogether, might be a simpler
interface from the end user's point of view.  That is,

 (1) if you are not interested in the submodule $name, you do not
     "init" it; you "init" it for all of the following.

 (2) if you want to have the tree state as recorded in the
     superproject, you do "update" without any option to make the
     HEAD of the submodule detached at the commit the superproject's
     tree records;

 (3) if you want to follow the upstream project of the submodule,
     you set submodule.$name.branch to the branch you want to
     follow, and you do "update"---submodule.$name.update is ignored
     and you will make the HEAD of the submodule detached at the tip
     of the branch at the remote (using remote-tracking branch);

 (4) if you want to --merge or --rebase, you give them from the
     command line, or use submodule.$name.update.

I may be oversimplifying a bit, but a separate
submodule.$name.remote feels very wrong; if it were a new token
"remote" that can be set as the value of submodule.$name.update (in
addition to existing "none", "rebase" and "merge"), it might be a
bit more understandable, though.

How does this compare with the floating submodules Heiko has been
working on?
