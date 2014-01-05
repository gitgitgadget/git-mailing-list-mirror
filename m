From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH] submodule: Respect reqested branch on all clones
Date: Sun, 5 Jan 2014 04:53:12 +0100
Message-ID: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
 <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Jan 05 04:53:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzemQ-00076t-4K
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 04:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbaAEDxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 22:53:34 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49027 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaAEDxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jan 2014 22:53:33 -0500
Received: by mail-oa0-f47.google.com with SMTP id k1so17591569oag.34
        for <git@vger.kernel.org>; Sat, 04 Jan 2014 19:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QIb3NSSFmej0kIjxXD4z0/5Z4nyDcSdyNNdmU5zN+Ak=;
        b=woWrVGex1dEl8vSeM7zHUqerlGaVGszFz3Hvd+Jo7i2R+vwJEbPkZ9H9mRllynUgpV
         XExCT/AS3cBlrF3+9D+5D0NjZdh1taKyxRj4NppyGc/E90QTxf2nI/kUOjeRuF8ipQtD
         9rLTK3pc4mQzCG/8XC84Ak9BcnaudyxFfyBzQLfH9SQm/FkI4VqgZZgRyLvdyZdjsSfR
         kuB+JVNB3MVQhQBKSSYBnsQwga7SrW7JA7CSo/bIz/wGYjpc1nlwwEtDGU6wxrSlvDwZ
         c44bzIkVVYkcL9DTdFd91AEI4VvJpRZNQzRyfuzIOvz7Yo92gWpoi+ydrj+A21sRMDul
         oL0A==
X-Received: by 10.182.78.68 with SMTP id z4mr66952665obw.29.1388894013016;
 Sat, 04 Jan 2014 19:53:33 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Sat, 4 Jan 2014 19:53:12 -0800 (PST)
In-Reply-To: <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239957>

Thanks for adding your contribute. My comments below:

2014/1/3 W. Trevor King <wking@tremily.us>:
>
> The previous code only checked out the requested branch in cmd_add.
> This commit moves the branch-checkout logic into module_clone, where
> it can be shared by cmd_add and cmd_update.  I also update the initial
> checkout command to use 'rebase' to preserve branches setup during
> module_clone.
> [...]
> @@ -306,7 +307,14 @@ module_clone()
>         echo "gitdir: $rel/$a" >"$sm_path/.git"
>
>         rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> -       (clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
> +       (
> +               clear_local_git_env
> +               cd "$sm_path" &&
> +               GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> +               if test -n "$branch"; then
> +                       git checkout -f -q -B "$branch" "origin/$branch" && echo "checked out $branch"
> +               fi
> +       ) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
>  }

If I understand it correctly, looking at your intervention in
module_clone and cmd_update, when "submodule.<module>.branch" is set
during "update" the resulting first clone will always be a branch
checkout (cause $branch is filled with "branch" property). I believe
this will break a lot of tests, as the the documentation says that in
this configuration the HEAD should be detached. Also it could break
some users that rely on the current behavior.
