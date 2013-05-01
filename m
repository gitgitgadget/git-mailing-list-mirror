From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] fetch-pack: prepare updated shallow file before fetching the pack
Date: Wed, 01 May 2013 13:27:20 -0700
Message-ID: <7v61z25tuf.fsf@alter.siamese.dyndns.org>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 22:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXdcf-0000P4-3B
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab3EAU1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 16:27:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757186Ab3EAU1Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 May 2013 16:27:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D561B20E;
	Wed,  1 May 2013 20:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dKK5StIYSMBj
	rEOo+Xe0vDgXBz4=; b=kNoLGYPadZ8Hr7U5+f1cMOwHWy1K88yU1OcHWmU+YeVn
	/mKR1t8+ijeYwmn1R4u+nB0xpepnf5FvCYQQFdgy+v+qs6JhC87lTvz8XKvsDLi7
	lo727SIkF4U4mOu5nuqVFOzOu4accfnGyOF4xBr3Ed/BpTT6XpNXspkxinGhtj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BwnFr4
	tjNk02nz09vkQhv/AzhayFbF9fJTimxB5lr3MGgj3z/oM65vQeIaTETcXlFAfXeu
	8AGlfwUJm5Iioe4zqB8vK9vgJPvD2ky2f10aFf70ERMuEmnRvyrsrfH47FvfT6EI
	a68o+5J6zUOxZQSqDqjsiNeVaneY0DuOd7FAQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41C5D1B20D;
	Wed,  1 May 2013 20:27:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 601801B20C;
	Wed,  1 May 2013 20:27:22 +0000 (UTC)
In-Reply-To: <1367405974-22190-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 1 May
 2013 17:59:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 874C1BBE-B29D-11E2-B826-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223137>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> index-pack --strict looks up and follows parent commits. If shallow
> information is not ready by the time index-pack is run, index-pack ma=
y
> be lead to non-existent objects. Make fetch-pack save shallow file to
> disk before invoking index-pack.
>
> A new environment variable GIT_SHALLOW_FILE is used to inform
> index-pack to use an alternate shallow file. This variable is for
> internal use and thus not advertised in git.txt.

The idea to tell the index-pack to use a different shallow file is
sound, but is the environment variable the best way to go?  I am
mostly worried about it being an implicit "apply everywhere"
mechanism and while I do not particularly like the idea of doing
everything in the same process as the top-level while dealing with
submodules, I am reasonably sure people would want to "clone"
recursively inside the same top-level process in the future, and
this new environment variable adds one more thing to be cleansed
when crossing a repository boundary.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  commit.h              |  1 +
>  fetch-pack.c          | 65 ++++++++++++++++++++++++-----------------=
----------
>  shallow.c             | 30 ++++++++++++++++++++++--
>  t/t5500-fetch-pack.sh |  7 ++++++
>  4 files changed, 67 insertions(+), 36 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index 67bd509..0cef659 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -176,6 +176,7 @@ extern int for_each_commit_graft(each_commit_graf=
t_fn, void *);
>  extern int is_repository_shallow(void);
>  extern struct commit_list *get_shallow_commits(struct object_array *=
heads,
>  		int depth, int shallow_flag, int not_shallow_flag);
> +extern void check_shallow_file_for_update(void);
> =20
>  int is_descendant_of(struct commit *, struct commit_list *);
>  int in_merge_bases(struct commit *, struct commit *);
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f156dd4..17cfa88 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -20,6 +20,7 @@ static int no_done;
>  static int fetch_fsck_objects =3D -1;
>  static int transfer_fsck_objects =3D -1;
>  static int agent_supported;
> +static struct lock_file shallow_lock;
> =20
>  #define COMPLETE	(1U << 0)
>  #define COMMON		(1U << 1)
> @@ -779,6 +780,26 @@ static int cmp_ref_by_name(const void *a_, const=
 void *b_)
>  	return strcmp(a->name, b->name);
>  }
> =20
> +static void setup_alternate_shallow(void)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int fd;
> +
> +	check_shallow_file_for_update();
> +	fd =3D hold_lock_file_for_update(&shallow_lock, git_path("shallow")=
,
> +				       LOCK_DIE_ON_ERROR);
> +	if (write_shallow_commits(&sb, 0)) {
> +		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
> +			die_errno("failed to write to %s", shallow_lock.filename);
> +		if (setenv("GIT_SHALLOW_FILE", shallow_lock.filename, 1))
> +			die_errno("failed to set GIT_SHALLOW_FILE");
> +	} else {
> +		if (setenv("GIT_SHALLOW_FILE", "", 1))
> +			die_errno("failed to set GIT_SHALLOW_FILE");
> +	}
> +	strbuf_release(&sb);
> +}
> +
>  static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  				 int fd[2],
>  				 const struct ref *orig_ref,
> @@ -858,6 +879,8 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
> =20
>  	if (args->stateless_rpc)
>  		packet_flush(fd[1]);
> +	if (args->depth > 0)
> +		setup_alternate_shallow();
>  	if (get_pack(args, fd, pack_lockfile))
>  		die("git fetch-pack: fetch failed.");
> =20
> @@ -936,15 +959,9 @@ struct ref *fetch_pack(struct fetch_pack_args *a=
rgs,
>  		       struct ref **sought, int nr_sought,
>  		       char **pack_lockfile)
>  {
> -	struct stat st;
>  	struct ref *ref_cpy;
> =20
>  	fetch_pack_setup();
> -	if (args->depth > 0) {
> -		if (stat(git_path("shallow"), &st))
> -			st.st_mtime =3D 0;
> -	}
> -
>  	if (nr_sought)
>  		nr_sought =3D remove_duplicates_in_refs(sought, nr_sought);
> =20
> @@ -955,34 +972,14 @@ struct ref *fetch_pack(struct fetch_pack_args *=
args,
>  	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lo=
ckfile);
> =20
>  	if (args->depth > 0) {
> -		static struct lock_file lock;
> -		struct cache_time mtime;
> -		struct strbuf sb =3D STRBUF_INIT;
> -		char *shallow =3D git_path("shallow");
> -		int fd;
> -
> -		mtime.sec =3D st.st_mtime;
> -		mtime.nsec =3D ST_MTIME_NSEC(st);
> -		if (stat(shallow, &st)) {
> -			if (mtime.sec)
> -				die("shallow file was removed during fetch");
> -		} else if (st.st_mtime !=3D mtime.sec
> -#ifdef USE_NSEC
> -				|| ST_MTIME_NSEC(st) !=3D mtime.nsec
> -#endif
> -			  )
> -			die("shallow file was changed during fetch");
> -
> -		fd =3D hold_lock_file_for_update(&lock, shallow,
> -					       LOCK_DIE_ON_ERROR);
> -		if (!write_shallow_commits(&sb, 0)
> -		 || write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
> -			unlink_or_warn(shallow);
> -			rollback_lock_file(&lock);
> -		} else {
> -			commit_lock_file(&lock);
> -		}
> -		strbuf_release(&sb);
> +		struct stat st;
> +		if (!fstat(shallow_lock.fd, &st) &&
> +		    st.st_size =3D=3D 0) {
> +			unlink_or_warn(git_path("shallow"));
> +			rollback_lock_file(&shallow_lock);
> +		} else
> +			commit_lock_file(&shallow_lock);
> +		unsetenv("GIT_SHALLOW_FILE");
>  	}
> =20
>  	reprepare_packed_git();
> diff --git a/shallow.c b/shallow.c
> index 6be915f..9c03806 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -3,6 +3,7 @@
>  #include "tag.h"
> =20
>  static int is_shallow =3D -1;
> +static struct stat shallow_stat;
> =20
>  int register_shallow(const unsigned char *sha1)
>  {
> @@ -21,12 +22,15 @@ int is_repository_shallow(void)
>  {
>  	FILE *fp;
>  	char buf[1024];
> +	const char *path;
> =20
>  	if (is_shallow >=3D 0)
>  		return is_shallow;
> =20
> -	fp =3D fopen(git_path("shallow"), "r");
> -	if (!fp) {
> +	path =3D getenv("GIT_SHALLOW_FILE");
> +	if (!path)
> +		path =3D git_path("shallow");
> +	if (stat(path, &shallow_stat) || (fp =3D fopen(path, "r")) =3D=3D N=
ULL) {
>  		is_shallow =3D 0;
>  		return is_shallow;
>  	}
> @@ -108,3 +112,25 @@ struct commit_list *get_shallow_commits(struct o=
bject_array *heads, int depth,
> =20
>  	return result;
>  }
> +
> +void check_shallow_file_for_update(void)
> +{
> +	struct stat st;
> +
> +	if (getenv("GIT_SHALLOW_FILE"))
> +		die("GIT_SHALLOW_FILE should not be manually set");
> +
> +	if (!is_shallow)
> +		return;
> +	else if (is_shallow =3D=3D -1)
> +		die("BUG: shallow must be initialized by now");
> +
> +	if (stat(git_path("shallow"), &st))
> +		die("shallow file was removed during fetch");
> +	else if (st.st_mtime !=3D shallow_stat.st_mtime
> +#ifdef USE_NSEC
> +		 || ST_MTIME_NSEC(st) !=3D ST_MTIME_NSEC(shallow_stat)
> +#endif
> +		   )
> +		die("shallow file was changed during fetch");
> +}
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d574085..557b073 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -135,6 +135,13 @@ test_expect_success 'clone shallow depth 1' '
>  	test "`git --git-dir=3Dshallow0/.git rev-list --count HEAD`" =3D 1
>  '
> =20
> +test_expect_success 'clone shallow depth 1 with fsck' '
> +	git config --global fetch.fsckobjects true &&
> +	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0fs=
ck &&
> +	test "`git --git-dir=3Dshallow0fsck/.git rev-list --count HEAD`" =3D=
 1 &&
> +	git config --global --unset fetch.fsckobjects
> +'
> +
>  test_expect_success 'clone shallow' '
>  	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
>  '
