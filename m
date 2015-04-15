From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] clean: improve performance when removing lots of directories
Date: Wed, 15 Apr 2015 10:56:50 -0700
Message-ID: <xmqqpp75l1gd.fsf@gitster.dls.corp.google.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
	<1428770587-9674-5-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:57:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiRYr-0003XX-Px
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbbDOR5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2015 13:57:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754295AbbDOR5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2015 13:57:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E99F47981;
	Wed, 15 Apr 2015 13:57:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cqozAA8PqAlz
	R12g19i0Q4yl06w=; b=sdENcaLIsBu8AY6VRcBS5JcQGhqniYW9nHdJDjp5xXCU
	8IPzO7oom/tmkPthHSDM2MFxC0xXLrkKcQFpNA0+wmsFqoa0BFu7ebgUXNqcgjlj
	Xy4kPoqye3vIkXCgoHfzoqqLRWr8MxSUTQ8xdTAUVNHNenFoA4pGaEVoXt47vGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XOpOWW
	10wfCCL9TBcGhzdS1Kq4PVqiCSPe3Z8F5NSd2XcZ3cQmM8NEuCf48/fQGwtZtgzc
	oRz9mecvtpLYV9Fc30vfkuBIkXoQFI975jCFsP9EDOHl3XHehsyKflnu566b74u3
	ZHW+lJf2neqGhaL+3wMpts+Jip+8IOENoUc0k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07EC747980;
	Wed, 15 Apr 2015 13:57:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC2214796A;
	Wed, 15 Apr 2015 13:56:51 -0400 (EDT)
In-Reply-To: <1428770587-9674-5-git-send-email-erik.elfstrom@gmail.com>
 ("Erik
	=?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Sat, 11 Apr 2015 18:43:07
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB921FD4-E398-11E4-95B8-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267225>

Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> Before this change, clean used resolve_gitlink_ref to check for the
> presence of nested git repositories. This had the drawback of creatin=
g
> a ref_cache entry for every directory that should potentially be
> cleaned. The linear search through the ref_cache list caused a massiv=
e
> performance hit for large number of directories.

I'd prefer to see the "current state" described in the current
tense, e.g.

    "git clean" uses resolve_gitlink_ref() to check for the presence of
    nested git repositories, but it has the drawback of creating a
    ref_cache entry for every directory that should potentially be
    cleaned. The linear search through the ref_cache list causes a
    massive performance hit for large number of directories.

> Teach clean.c:remove_dirs to use setup.c:is_git_directory
> instead. is_git_directory will actually open HEAD and parse the HEAD
> ref but this implies a nested git repository and should be rare when
> cleaning.

I am not sure what you wanted to say in this paragraph.  What does
it being rare have to do with it?  Even if it is not rare (i.e. the
top-level project you are working with has many submodules checked
out without using the more recent "a file .git pointing into
=2Egit/modules/ via 'gitdir: $overThere'" mechanism), if we found a
nested git repository, we treat it as special and exclude it from
cleaning it out, which is a good thing, no?

Doesn't this implementation get confused by modern submodule
checkouts and descend into and clean their working tree, though?
Module M with path P would have a directory P in the working tree of
the top-level project, and P/.git is a regular file that will fail
"is_git_directory()" test but records the location of the real
submodule repository i.e. ".git/modules/M" via the "gitdir:"
mechanism.

> Using is_git_directory should give a more standardized check for what
> is and what isn't a git repository but also gives a slight behavioral
> change. We will now detect and respect bare and empty nested git
> repositories (only init run). Update t7300 to reflect this.
>
> The time to clean an untracked directory containing 100000 sub
> directories went from 61s to 1.7s after this change.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
>  builtin/clean.c  | 24 ++++++++++++++++++++----
>  t/t7300-clean.sh |  4 ++--
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 98c103f..b679913 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -10,7 +10,6 @@
>  #include "cache.h"
>  #include "dir.h"
>  #include "parse-options.h"
> -#include "refs.h"
>  #include "string-list.h"
>  #include "quote.h"
>  #include "column.h"
> @@ -148,6 +147,25 @@ static int exclude_cb(const struct option *opt, =
const char *arg, int unset)
>  	return 0;
>  }
> =20
> +static int is_git_repository(struct strbuf *path)
> +{
> +	int ret =3D 0;
> +	if (is_git_directory(path->buf))
> +		ret =3D 1;
> +	else {
> +		size_t orig_path_len =3D path->len;
> +		assert(orig_path_len !=3D 0);
> +		if (path->buf[orig_path_len - 1] !=3D '/')
> +			strbuf_addch(path, '/');
> +		strbuf_addstr(path, ".git");
> +		if (is_git_directory(path->buf))
> +			ret =3D 1;
> +		strbuf_setlen(path, orig_path_len);
> +	}
> +
> +	return ret;
> +}
> +
>  static int remove_dirs(struct strbuf *path, const char *prefix, int =
force_flag,
>  		int dry_run, int quiet, int *dir_gone)
>  {
> @@ -155,13 +173,11 @@ static int remove_dirs(struct strbuf *path, con=
st char *prefix, int force_flag,
>  	struct strbuf quoted =3D STRBUF_INIT;
>  	struct dirent *e;
>  	int res =3D 0, ret =3D 0, gone =3D 1, original_len =3D path->len, l=
en;
> -	unsigned char submodule_head[20];
>  	struct string_list dels =3D STRING_LIST_INIT_DUP;
> =20
>  	*dir_gone =3D 1;
> =20
> -	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
> -			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
> +	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_git_repository(=
path)) {
>  		if (!quiet) {
>  			quote_path_relative(path->buf, prefix, &quoted);
>  			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir)=
,
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 58e6b4a..da294fe 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -455,7 +455,7 @@ test_expect_success 'nested git work tree' '
>  	! test -d bar
>  '
> =20
> -test_expect_failure 'nested git (only init) should be kept' '
> +test_expect_success 'nested git (only init) should be kept' '
>  	rm -fr foo bar &&
>  	git init foo &&
>  	mkdir bar &&
> @@ -465,7 +465,7 @@ test_expect_failure 'nested git (only init) shoul=
d be kept' '
>  	test_path_is_missing bar
>  '
> =20
> -test_expect_failure 'nested git (bare) should be kept' '
> +test_expect_success 'nested git (bare) should be kept' '
>  	rm -fr foo bar &&
>  	git init --bare foo &&
>  	mkdir bar &&
