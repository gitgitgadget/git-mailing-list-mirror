From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Sun, 19 Apr 2015 14:53:59 +0200
Message-ID: <5533A567.7070301@web.de>
References: <55300D2C.9030903@web.de> <1429319946-19890-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dennis@kaarsemaker.net
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 14:54:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjoji-0006Ij-KM
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 14:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbbDSMyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2015 08:54:06 -0400
Received: from mout.web.de ([212.227.17.11]:52561 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbbDSMyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 08:54:04 -0400
Received: from [192.168.178.41] ([79.211.115.96]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LaCXK-1ZCngc1Y0k-00m3h4; Sun, 19 Apr 2015 14:54:00
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1429319946-19890-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:rPQHtmJO1lLAGK5OtLse/b/MBC0I77UbBkCntrXm1D1YGy5Txv9
 Ca6Iv0rtV+VxpfhRQWTv4yxZ1Pncx30qGLNjUlsLAYcu24Vu+WEXcjssK/MFF14NFASzCZ6
 UpAvRxVZ2acImBe/le9lZM6HdcVGX8pAQcqtBt/F0WPM3lNura7/DLrAiIAMXfiFRuHCbkm
 RGnclytrhsvD9rkk2Lh+g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267439>

Am 18.04.2015 um 03:19 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
> A path(spec) from git perspective consists of two parts, the prefix,
> and the rest. The prefix covers the part of `pwd` after expanding "..=
"
> components. The split is to support case-insensitive match in a sane
> way (see 93d9353, especially the big comment block added in dir.c).
>
> Normally the prefix is found after prefix_path_gently() and that will
> be it. Unfortunately the *STRIP_SUBMODULE* flags can strip the
> trailing slash (see 2ce53f9 for the reason) and cut into this prefix
> part. In the test, the prefix is "submodule/", but the final path is
> just "submodule". We need to readjust prefix info when this happens.
>
> The assert() that catches this is turned to die() to make sure it's
> always active. prefix_pathspec() is not in any critical path to be a
> performance concern because of this change.
>
> 93d9353 (parse_pathspec: accept :(icase)path syntax - 2013-07-14)
> 2ce53f9 (git add: do not add files from a submodule - 2009-01-02)
>
> Noticed-by: djanos_ (via irc)
> Helped-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>   On Fri, Apr 17, 2015 at 2:27 AM, Jens Lehmann <Jens.Lehmann@web.de>=
 wrote:
>   > The problem seems to be that "subrepo" is still registered as a
>   > submodule in the index. But we should see a proper error message
>   > instead of an assert in that case ... CCed Duy who knows much
>   > more about pathspec.c than me.
>
>   This deals with the bug in pathspec code. I leave it to you to deci=
de
>   how git-add should do when a submodule is registered in index, but
>   it's no longer a submodule in worktree. Yeah maybe it should error
>   out.

Thanks for answering with a patch! I tested it and it silences the
assert and doesn't add anything below the gitlink to the index.

And me thinks it should error out. We already do that when trying
to add a specific file from above the gitlink:

    $ git add subrepo/a
    fatal: Pathspec 'subrepo/a' is in submodule 'subrepo'

And from below the gitlink:

    $ cd subrepo
    $ git add a
    fatal: Pathspec 'a' is in submodule 'subrepo'

I think we should do the same when using "git add ." below the
gitlink.

>   pathspec.c                    | 18 +++++++++++++++---
>   t/t3703-add-magic-pathspec.sh |  8 ++++++++
>   2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 9304ee3..aa5e2c7 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -262,7 +262,6 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
>   	} else
>   		item->original =3D elt;
>   	item->len =3D strlen(item->match);
> -	item->prefix =3D prefixlen;
>
>   	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
>   	    (item->len >=3D 1 && item->match[item->len - 1] =3D=3D '/') &&
> @@ -292,6 +291,15 @@ static unsigned prefix_pathspec(struct pathspec_=
item *item,
>   				     elt, ce_len, ce->name);
>   		}
>
> +	/*
> +	 * Adjust prefixlen if the above trailing slash stripping cuts
> +	 * into the prefix part
> +	 */
> +	if ((flags & (PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
> +		      PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)) &&
> +	    prefixlen > item->len)
> +		prefixlen =3D item->len;
> +
>   	if (magic & PATHSPEC_LITERAL)
>   		item->nowildcard_len =3D item->len;
>   	else {
> @@ -299,6 +307,7 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
>   		if (item->nowildcard_len < prefixlen)
>   			item->nowildcard_len =3D prefixlen;
>   	}
> +	item->prefix =3D prefixlen;
>   	item->flags =3D 0;
>   	if (magic & PATHSPEC_GLOB) {
>   		/*
> @@ -313,8 +322,11 @@ static unsigned prefix_pathspec(struct pathspec_=
item *item,
>   	}
>
>   	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <=3D item->len &&
> -	       item->prefix         <=3D item->len);
> +	if (!(item->nowildcard_len <=3D item->len &&
> +	      item->prefix         <=3D item->len))
> +		die("BUG: item->nowildcard_len (%d) or item->prefix (%d)"
> +		    " is longer than item->len (%d)",
> +		    item->nowildcard_len, item->prefix, item->len);
>   	return magic;
>   }
>
> diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathsp=
ec.sh
> index 5115de7..cced8c4 100755
> --- a/t/t3703-add-magic-pathspec.sh
> +++ b/t/t3703-add-magic-pathspec.sh
> @@ -55,4 +55,12 @@ test_expect_success COLON_DIR 'a file with the sam=
e (short) magic name exists' '
>   	git add -n "./:/bar"
>   '
>
> +test_expect_success 'prefix is updated after trailing slash is strip=
ped' '
> +	git init submodule &&
> +	( cd submodule && test_commit test ) &&
> +	git add submodule &&
> +	mv submodule/.git submodule/dotgit &&
> +	( cd submodule && git add . )
> +'
> +
>   test_done
>
