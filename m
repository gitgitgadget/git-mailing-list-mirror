From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Wed, 26 Feb 2014 15:58:42 -0800
Message-ID: <xmqqzjld1l59.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 00:59:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIoNW-0002hx-HK
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 00:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaBZX6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 18:58:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaBZX6q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 18:58:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C26E70BFA;
	Wed, 26 Feb 2014 18:58:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0Gam3qugGGEN
	aroOq8mVhViofV0=; b=d/33naps05sgc4dMLAhHHrsg/lMWuQUyoWkgRgAyb6cJ
	sbXFMEOmDpGqUmyYQPOYFaGVOsrvr194E4+niPd4pIeYzPV7gXYOx0FD47Dlx/53
	EC9Ne82qXII516xuCYiPL46BDvO630bJWUtIqpiQPnUSPYPWvYN4J8WjOLza/mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mqRcUu
	x33sTYF6KvEEfFGqh9lbFlgBrQbQV1L2zUpiiZhMXL6/LFwgY43nyeaSdfmSbIv9
	VxXir3V9XGAnYrz5IIHwKPngg/QLLBj9yP9+VvinrbYTXvML0Uf1kWQbs1+Uwt8J
	kD1faGCkzLVIe0DbgXR8lVCF4SN4Af8sgHx5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8713270BF9;
	Wed, 26 Feb 2014 18:58:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDE2870BF8;
	Wed, 26 Feb 2014 18:58:44 -0500 (EST)
In-Reply-To: <1392730814-19656-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:39:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ECECC950-9F41-11E3-9EE4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242774>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Note that logs/refs/.tmp-renamed-log is used to prepare new reflog
> entry and it's supposed to be on the same filesystem as the target
> reflog file. This is not guaranteed true for logs/HEAD when it's
> mapped to repos/xx/logs/HEAD because the user can put "repos"
> directory on different filesystem. Don't mess with .git unless you
> know what you're doing.

Hmph.  I am puzzled.

We use TMP_RENAMED_LOG in rename_ref() in this sequence:

 * First move refs/logs/$oldname to TMP_RENAMED_LOG;
 * Delete refs/$oldname;
 * Delete refs/$newname if exists;
 * Move TMP_RENAMED_LOG to refs/logs/$newname;
 * Create refs/$newname.

in rename_ref(), and TMP_RENAMED_LOG or the helper function
rename_tmp_log() that does the actual rename do not seem to be
called by any other codepath.

How would logs/HEAD get in the picture?  Specifically, I am not sure
if we ever allow renaming the HEAD (which typically is a symref but
could be detached) via rename_ref() at all.

> The redirection is done by git_path(), git_pathdup() and
> strbuf_git_path(). The selected list of paths goes to $GIT_COMMON_DIR=
,
> not the other way around in case a developer adds a new
> worktree-specific file and it's accidentally promoted to be shared
> across repositories (this includes unknown files added by third party
> commands)
>
> The list of known files that belong to $GIT_DIR are:
>
> ADD_EDIT.patch BISECT_ANCESTORS_OK BISECT_EXPECTED_REV BISECT_LOG
> BISECT_NAMES CHERRY_PICK_HEAD COMMIT_MSG FETCH_HEAD HEAD MERGE_HEAD
> MERGE_MODE MERGE_RR NOTES_EDITMSG NOTES_MERGE_WORKTREE ORIG_HEAD
> REVERT_HEAD SQUASH_MSG TAG_EDITMSG fast_import_crash_* logs/HEAD
> next-index-* rebase-apply rebase-merge rsync-refs-* sequencer/*
> shallow_*
>
> Path mapping is NOT done for git_path_submodule(). Multi-checkouts ar=
e
> not supported as submodules.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Other than the "I do not understand why logs/HEAD is an issue", the
other aspect of the above design feels sound to me.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 02bbc08..2c4a055 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -773,6 +773,14 @@ Git so take care if using Cogito etc.
>  	an explicit repository directory set via 'GIT_DIR' or on the
>  	command line.
> =20
> +'GIT_COMMON_DIR'::
> +	If this variable is set to a path, non-worktree files that are
> +	normally in $GIT_DIR will be taken from this path
> +	instead. Worktree-specific files such as HEAD or index are
> +	taken from $GIT_DIR. This variable has lower precedence than
> +	other path variables such as GIT_INDEX_FILE,
> +	GIT_OBJECT_DIRECTORY...
> +

We may want to add something (not necessarily with this commit) to
repository-layout and glossary to describe this new "officially
supported" way to implement what contrib/workdir wanted to do.

> diff --git a/path.c b/path.c
> index 0f8c3dc..2d757dc 100644
> --- a/path.c
> +++ b/path.c
> @@ -90,6 +90,32 @@ static void replace_dir(struct strbuf *buf, int le=
n, const char *newdir)
>  		buf->buf[newlen] =3D '/';
>  }
> =20
> +static void update_common_dir(struct strbuf *buf, int git_dir_len)
> +{
> +	const char *common_dir_list[] =3D {
> +		"branches", "hooks", "info", "logs", "lost-found", "modules",
> +		"objects", "refs", "remotes", "rr-cache", "svn",
> +		NULL
> +	};
> +	const char *common_top_file_list[] =3D {
> +		"config", "gc.pid", "packed-refs", "shallow", NULL
> +	};
> +	char *base =3D buf->buf + git_dir_len;
> +	const char **p;
> +	if (is_dir_file(base, "logs", "HEAD"))

Just a style, but could you have a blank line between the series of
decls and the first statement?  It would be easier to read that way.

> +		return;	/* keep this in $GIT_DIR */
> +	for (p =3D common_dir_list; *p; p++)
> +		if (dir_prefix(base, *p)) {
> +			replace_dir(buf, git_dir_len, get_git_common_dir());
> +			return;
> +		}
> +	for (p =3D common_top_file_list; *p; p++)
> +		if (!strcmp(base, *p)) {
> +			replace_dir(buf, git_dir_len, get_git_common_dir());
> +			return;
> +		}
> +}
> +
>  static void adjust_git_path(struct strbuf *buf, int git_dir_len)
>  {
>  	const char *base =3D buf->buf + git_dir_len;
> @@ -101,6 +127,8 @@ static void adjust_git_path(struct strbuf *buf, i=
nt git_dir_len)
>  			      get_index_file(), strlen(get_index_file()));
>  	else if (git_db_env && dir_prefix(base, "objects"))
>  		replace_dir(buf, git_dir_len + 7, get_object_directory());
> +	else if (git_common_dir_env)
> +		update_common_dir(buf, git_dir_len);
>  }
> =20
>  static void do_git_path(struct strbuf *buf, const char *fmt, va_list=
 args)
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 1d29901..f9a77e4 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -241,5 +241,20 @@ test_expect_success 'setup fake objects director=
y foo' 'mkdir foo'
>  test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects foo
>  test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects/foo foo/foo
>  test_git_path GIT_OBJECT_DIRECTORY=3Dfoo objects2 .git/objects2
> +test_expect_success 'setup common repository' 'git --git-dir=3Dbar i=
nit'
> +test_git_path GIT_COMMON_DIR=3Dbar index                    .git/ind=
ex
> +test_git_path GIT_COMMON_DIR=3Dbar HEAD                     .git/HEA=
D
> +test_git_path GIT_COMMON_DIR=3Dbar logs/HEAD                .git/log=
s/HEAD
> +test_git_path GIT_COMMON_DIR=3Dbar objects                  bar/obje=
cts
> +test_git_path GIT_COMMON_DIR=3Dbar objects/bar              bar/obje=
cts/bar
> +test_git_path GIT_COMMON_DIR=3Dbar info/exclude             bar/info=
/exclude
> +test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remo=
tes/bar
> +test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/bran=
ches/bar
> +test_git_path GIT_COMMON_DIR=3Dbar logs/refs/heads/master   bar/logs=
/refs/heads/master
> +test_git_path GIT_COMMON_DIR=3Dbar refs/heads/master        bar/refs=
/heads/master
> +test_git_path GIT_COMMON_DIR=3Dbar hooks/me                 bar/hook=
s/me
> +test_git_path GIT_COMMON_DIR=3Dbar config                   bar/conf=
ig
> +test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pack=
ed-refs
> +test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/shal=
low
> =20
>  test_done
