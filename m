From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR
Date: Fri, 26 Jun 2015 10:15:21 -0700
Message-ID: <xmqqpp4iv1au.fsf@gitster.dls.corp.google.com>
References: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
	<1435315055-27011-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:15:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8XDt-0002Pg-AH
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbbFZRP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2015 13:15:26 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34199 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbbFZRPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:15:24 -0400
Received: by iebmu5 with SMTP id mu5so79601016ieb.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=CHAfReg6hRZC8lK6n727Iq7atCq2AD0sxD+Vo5J9bK4=;
        b=OMVYFXci1D/raG/rUZ8wT2Duy/LtgNhFqW7xCsklnJpWa6L4aGOeo2xrDUF5X+q86j
         AqXSNtf9JwQJr8i2zAcJ+KEddnBKWOU4+4iDbFg20zDYsael/cDjX5yeu0bnWEV1W+EP
         PpU7EUr25fo+UWrY9Jq44anrvgRDcEniMH1N1UEFoJWdIme7HRxAsne2UIj2BrSUj6Ca
         A3bjERbxX5Pyqxo8HkahPpI1vPGaGdC+UO47qAiqQR7gzc/tulwVFCiUa77GkYioOC4b
         3OuagNKQ2OvZVqentqPQkwq5XgKIMcVxQqkVpcocZOrf3NNYyF88sWq0A2anug3XxbZZ
         6+/g==
X-Received: by 10.50.79.129 with SMTP id j1mr4731123igx.12.1435338923841;
        Fri, 26 Jun 2015 10:15:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id o2sm1229449igr.9.2015.06.26.10.15.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 10:15:23 -0700 (PDT)
In-Reply-To: <1435315055-27011-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 26
 Jun 2015 17:37:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272801>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Bottom line is, when $GIT_DIR is set, $GIT_WORK_TREE should be set to=
o
> unless there's no work tree. But setting $GIT_WORK_TREE inside
> set_git_dir() may backfire. We don't know at that point if work tree =
is
> already configured by the caller. So set it when work tree is
> detected. It does not harm if $GIT_WORK_TREE is set while $GIT_DIR is
> not.

Hmmm, setting GIT_WORK_TREE locally without exporting it to our
subprocesses would not hurt even when we do not see GIT_DIR, so I
agree "It does not harm" is true for _us_, the process that runs
this code itself.

But I am not sure if it is true for our children (e.g. hooks,
filters etc. that is spawned by us).  With this change, they inherit
GIT_WORK_TREE and no GIT_DIR, in such a case.  If they set GIT_DIR
themselves for their own use, perhaps arranging to work in somewhere
else they know by chdir'ing there, they did not have to set
GIT_WORK_TREE=3D. before runing git in there, but now they do, because
we start exporting GIT_WORK_TREE to interfere what they have been
doing.

"It does not harm" is probably false for our children, I would
think.  The children can do new things to avoid the harm, though.


> Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  environment.c      |  2 ++
>  t/t0002-gitfile.sh | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/environment.c b/environment.c
> index 61c685b..8f1b249 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -231,6 +231,8 @@ void set_git_work_tree(const char *new_work_tree)
>  	}
>  	git_work_tree_initialized =3D 1;
>  	work_tree =3D xstrdup(real_path(new_work_tree));
> +	if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
> +		error("Could not set GIT_WORK_TREE to '%s'", work_tree);
>  }
> =20
>  const char *get_git_work_tree(void)
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 37e9396..9393322 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -99,4 +99,21 @@ test_expect_success 'check rev-list' '
>  	test "$SHA" =3D "$(git rev-list HEAD)"
>  '
> =20
> +test_expect_success 'setup_git_dir twice in subdir' '
> +	git init sgd &&
> +	(
> +		cd sgd &&
> +		git config alias.lsfi ls-files &&
> +		mv .git .realgit &&
> +		echo "gitdir: .realgit" >.git &&
> +		mkdir subdir &&
> +		cd subdir &&
> +		>foo &&
> +		git add foo &&
> +		git lsfi >actual &&
> +		echo foo >expected &&
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done
