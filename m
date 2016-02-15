From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] dir.c: support marking some patterns already matched
Date: Mon, 15 Feb 2016 15:47:34 -0800
Message-ID: <xmqqio1po7s9.fsf@gitster.mtv.corp.google.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
	<1455527019-7787-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:47:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVSrl-00017S-Ha
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbcBOXrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 18:47:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752361AbcBOXrg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 18:47:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D00DE459D0;
	Mon, 15 Feb 2016 18:47:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kftDEAqO/8nh
	nGKsb4jDLUhoHmI=; b=Pfl/Mnxywx9jAVwVMYz0yAyDH+Anr4yebzDsfjatV5cH
	8n8MAKtqZmwkzphcKIiSCxZ/io2SPkdBXPyHPh0QBJND5d4lSsShXA5aIJykfrDa
	YK/n88EqAlhN2+XAR10cD9Ugs5VrhL8wPJXlsaroogtF8tHLF1VBOf7EBvAc8io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AhMJES
	8YEwYzFcOANyXDjDjG9Ftjb10qRjetTIC89HEE7y8u6VtlOQ+XTcztPCeULK8jxQ
	ys7l5vCGQiNJ9kCpTQAQ58rFJoSbxDASFeuvEYDll9vRw1KIS5pFr1ivfz2HjAdT
	t30gCnWHuF6mFkjW0BxYQsiis+VLc56kY7DzQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C719F459CF;
	Mon, 15 Feb 2016 18:47:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 35E76459CB;
	Mon, 15 Feb 2016 18:47:35 -0500 (EST)
In-Reply-To: <1455527019-7787-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15
 Feb 2016 16:03:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7CD9233C-D43E-11E5-B727-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286290>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Given path "a" and the pattern "a", it's matched. But if we throw pat=
h
> "a/b" to pattern "a", the code fails to realize that if "a" matches
> "a" then "a/b" should also be matched.
>
> When the pattern is matched the first time, we can mark it "sticky", =
so
> that all files and dirs inside the matched path also matches. This is=
 a
> simpler solution than modify all match scenarios to fix that.

I am not quite sure what this one tries to achieve.  Is this a
performance thing, or is it a correctness thing?

"This is a simpler solution than" is skimpy on the description of
what the solution is.

When you see 'a' and path 'a/', you would throw it in the sticky
list.  when you descend into 'a/' and see things under it,
e.g. 'a/b', you would say "we have a match" because 'a' is sticky.
Do you throw 'a/b' also into the sticky list so that you would catch
'a/b/c' later?  Do you rely on the order of tree walking to cull
entries from the sticky list that are no longer relevant?
e.g. after you enumerate everything in 'a/b', you do not need 'a/b'
anymore.

Or do you notice that 'a/' matched at the top-level and stop
bothering the sticky list when you descend into 'a/b' and others?

How does this interact with negative patterns?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++---
>  dir.h |  3 +++
>  2 files changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 0be7cf1..8a9d8c0 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -521,6 +521,7 @@ void add_exclude(const char *string, const char *=
base,
>  	x->baselen =3D baselen;
>  	x->flags =3D flags;
>  	x->srcpos =3D srcpos;
> +	string_list_init(&x->sticky_paths, 1);
>  	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
>  	el->excludes[el->nr++] =3D x;
>  	x->el =3D el;
> @@ -561,8 +562,10 @@ void clear_exclude_list(struct exclude_list *el)
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < el->nr; i++)
> +	for (i =3D 0; i < el->nr; i++) {
> +		string_list_clear(&el->excludes[i]->sticky_paths, 0);
>  		free(el->excludes[i]);
> +	}
>  	free(el->excludes);
>  	free(el->filebuf);
> =20
> @@ -889,6 +892,44 @@ int match_pathname(const char *pathname, int pat=
hlen,
>  				 WM_PATHNAME) =3D=3D 0;
>  }
> =20
> +static void add_sticky(struct exclude *exc, const char *pathname, in=
t pathlen)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int i;
> +
> +	for (i =3D exc->sticky_paths.nr - 1; i >=3D 0; i--) {
> +		const char *sticky =3D exc->sticky_paths.items[i].string;
> +		int len =3D strlen(sticky);
> +
> +		if (pathlen < len && sticky[pathlen] =3D=3D '/' &&
> +		    !strncmp(pathname, sticky, pathlen))
> +			return;
> +	}
> +
> +	strbuf_add(&sb, pathname, pathlen);
> +	string_list_append_nodup(&exc->sticky_paths, strbuf_detach(&sb, NUL=
L));
> +}
> +
> +static int match_sticky(struct exclude *exc, const char *pathname, i=
nt pathlen, int dtype)
> +{
> +	int i;
> +
> +	for (i =3D exc->sticky_paths.nr - 1; i >=3D 0; i--) {
> +		const char *sticky =3D exc->sticky_paths.items[i].string;
> +		int len =3D strlen(sticky);
> +
> +		if (pathlen =3D=3D len && dtype =3D=3D DT_DIR &&
> +		    !strncmp(pathname, sticky, len))
> +			return 1;
> +
> +		if (pathlen > len && pathname[len] =3D=3D '/' &&
> +		    !strncmp(pathname, sticky, len))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Scan the given exclude list in reverse to see whether pathname
>   * should be ignored.  The first match (i.e. the last on the list), =
if
> @@ -914,6 +955,16 @@ static struct exclude *last_exclude_matching_fro=
m_list(const char *pathname,
>  		const char *exclude =3D x->pattern;
>  		int prefix =3D x->nowildcardlen;
> =20
> +		if (x->sticky_paths.nr) {
> +			if (*dtype =3D=3D DT_UNKNOWN)
> +				*dtype =3D get_dtype(NULL, pathname, pathlen);
> +			if (match_sticky(x, pathname, pathlen, *dtype)) {
> +				exc =3D x;
> +				break;
> +			}
> +			continue;
> +		}
> +
>  		if (x->flags & EXC_FLAG_MUSTBEDIR) {
>  			if (*dtype =3D=3D DT_UNKNOWN)
>  				*dtype =3D get_dtype(NULL, pathname, pathlen);
> @@ -947,9 +998,10 @@ static struct exclude *last_exclude_matching_fro=
m_list(const char *pathname,
>  		return NULL;
>  	}
> =20
> -	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D=
> %s\n",
> +	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D=
> %s%s\n",
>  			 pathlen, pathname, exc->pattern, exc->srcpos,
> -			 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes");
> +			 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes",
> +			 exc->sticky_paths.nr ? " (stuck)" : "");
>  	return exc;
>  }
> =20
> @@ -2005,6 +2057,25 @@ static struct untracked_cache_dir *validate_un=
tracked_cache(struct dir_struct *d
>  	return root;
>  }
> =20
> +static void clear_sticky(struct dir_struct *dir)
> +{
> +	struct exclude_list_group *g;
> +	struct exclude_list *el;
> +	struct exclude *x;
> +	int i, j, k;
> +
> +	for (i =3D EXC_CMDL; i <=3D EXC_FILE; i++) {
> +		g =3D &dir->exclude_list_group[i];
> +		for (j =3D g->nr - 1; j >=3D 0; j--) {
> +			el =3D &g->el[j];
> +			for (k =3D el->nr - 1; 0 <=3D k; k--) {
> +				x =3D el->excludes[k];
> +				string_list_clear(&x->sticky_paths, 0);
> +			}
> +		}
> +	}
> +}
> +
>  int read_directory(struct dir_struct *dir, const char *path, int len=
, const struct pathspec *pathspec)
>  {
>  	struct path_simplify *simplify;
> diff --git a/dir.h b/dir.h
> index cd46f30..3ec3fb0 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -4,6 +4,7 @@
>  /* See Documentation/technical/api-directory-listing.txt */
> =20
>  #include "strbuf.h"
> +#include "string-list.h"
> =20
>  struct dir_entry {
>  	unsigned int len;
> @@ -34,6 +35,8 @@ struct exclude {
>  	 * and from -1 decrementing for patterns from CLI args.
>  	 */
>  	int srcpos;
> +
> +	struct string_list sticky_paths;
>  };
> =20
>  /*
