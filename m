From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v3 3/4] submodule: Teach 'add' about a configurable local-branch
Date: Wed, 15 Jan 2014 01:18:12 +0100
Message-ID: <CALas-iiLQHVpH9-KbWHVJzYSho3cV-ELmG4+R_8XGT7Pb+=gWQ@mail.gmail.com>
References: <20140108040627.GD29954@odin.tremily.us> <cover.1389247320.git.wking@tremily.us>
 <75e8c98df73273c2c8174e726e3fc961fbebd6a7.1389247320.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Jan 15 01:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3EBp-0000NG-In
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 01:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaAOASe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 19:18:34 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:44891 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaAOASd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 19:18:33 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so434165oag.11
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 16:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GXGUfoRdoTIxbsbWOwaM2ym8EzL2T2Js6xaCRf2atrw=;
        b=uY/V8WTGTUrOnUWsMRQSrNQaQpAJgO+/W8XbLMW6PF7gAigUbuJ5TRpxZBq92OFXg7
         i14f5+1HWarOjrRa9TMNdEww5YU6V3YW3csqroxEOw/b6pAN12nThPg7aJVJUypcllU9
         HaHFBvLr/nfGgCEEuF97z4WAB0tSFfSTgd2By629avhwVwGpnRTvmxCYExiqaF7EngDv
         UdGuET+gwGEgibSLVURqQ+9+69+DlWqrdHu2B2ahX84Roqy/4EBej2F+t9E3CsBGql0o
         jKF2jbNWvD2pRURnbAOtCvZgG3ZahJyWQWURnPeNPYW6u2wMBvj3hwoEnSU+GxG1CAUs
         4iNA==
X-Received: by 10.60.51.6 with SMTP id g6mr3637303oeo.5.1389745112544; Tue, 14
 Jan 2014 16:18:32 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 14 Jan 2014 16:18:12 -0800 (PST)
In-Reply-To: <75e8c98df73273c2c8174e726e3fc961fbebd6a7.1389247320.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240427>

I've matured this opinion about "local-branch" some days ago, but I
couldn't join the discussion because I was extremely busy. Hope it's
is still current (and correct).

2014/1/9 W. Trevor King <wking@tremily.us>
>
> @@ -339,7 +339,19 @@ module_clone()
>         echo "gitdir: $rel/$a" >"$sm_path/.git"
>
>         rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> -       (clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
> +       superproject_branch=$(get_current_branch)
> +       default_local_branch=$(get_submodule_config "$sm_name" local-branch)
> +       (
> +               clear_local_git_env
> +               cd "$sm_path" &&
> +               GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> +               local_branch=$(get_local_branch "${superproject_branch}" "${default_local_branch}") &&
> +               # ash fails to wordsplit ${branch:+-b "$branch"...}
> +               case "$branch" in
> +               '') git checkout -f -q -B "$local_branch" ;;
> +               ?*) git checkout -f -q -B "$local_branch" "origin/$branch" ;;
> +               esac
> +       ) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>  }
>

also

2014/1/8 W. Trevor King <wking@tremily.us>:
>  To elaborate the idea I sketched out here [2], say
> you want:
>
>   Superproject branch  Submodule branch  Upstream branch
>   ===================  ================  ===============
>   master               master            master
>   super-feature        master            master
>   my-feature           my-feature        master
>   other-feature        other-feature     other-feature
>
> That's only going to work with per-superproject-branch configs for
> both the local and remote branches.  Using the same name for both
> local and remote branches does not work.
>
> Let me motivate each of the combinations in the above table:
>
> * master, master, master: The stable trunk.
> * super-feature, master, master: A superproject feature that works
>   with the stock submodule.
> * my-feature, my-feature, master: A superproject feature that needs an
>   improved submodule, but wants to integrate upstream master changes
>   during development.
> * other-feature, other-feature, other-feature: A superproject feature
>   that needs an improved submodule, and wants to integrate
>   other-feature changes that are also being developed upstream

The "local-branch" feature means to my brain the following: I,
maintainer, decide for you, developer, what name should be the branch
you are checking out. While, in general, it makes sense for a
developer to switch to a differently named "feature branch" that can
pull the original remote branch if he's actively developing (on any
repository, not only a submodule), this leads me to the following
questions: would it be good to introduce such enforcement? Do we allow
something similar on regular repositories? In short I believe this
workflow may reflect a personal attitude. In that case I'm unsure if
git should ease it so specifically.
