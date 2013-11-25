From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/28] shallow.c: add remove_reachable_shallow_points()
Date: Mon, 25 Nov 2013 13:53:36 -0800
Message-ID: <xmqqpppow3kv.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 22:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl46C-0003Q4-LS
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab3KYVxk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 16:53:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab3KYVxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 16:53:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7798F55A5A;
	Mon, 25 Nov 2013 16:53:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=y+jMlS+9nkTV
	CEPNVkMJh0Y2KNg=; b=H6Il9T1jMFVFItDpqwnrpIDCqDwT774PYL++Pn3JZONQ
	VbNEk1zIG404Lu5LxYMj9kesZH8ztifhL+N4DlTUv5ISUXenBgYwOg4xtsEIJUa4
	Z0TYfKoMgYXNk1CPlI68/BqOTXLH9XtEzhTaD50L6la69fYLSDsuJvUUqrRGFkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BgKdHW
	tFdPaWC+8VxvVWuvgf003vR32dTSsBTN4G+lwUoOnuahs88jaTZ+v74mShBPbWVw
	2JpkoDiUgFydl1z8TeEUaCxR1GBCiJoevdoOaUuGBD3siEv/XiSjFvaLf1uG6RRI
	PSeyRIxt/YtmOo8N1Y++2swKUtFlqpqap5eL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EFE455A59;
	Mon, 25 Nov 2013 16:53:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61F3755A55;
	Mon, 25 Nov 2013 16:53:38 -0500 (EST)
In-Reply-To: <1385351754-9954-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 25
 Nov 2013 10:55:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A5C2356-561C-11E3-8343-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238360>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When we receive a pack and the shallow points from another repository=
,
> we may want to add more shallow points to current repo to make sure n=
o
> commits point to nowhere. However we do not want to add unnecessary
> shallow points and cut our history short because the other end is a
> shallow version of this repo. The output shallow points may or may no=
t
> be added to .git/shallow, depending on whether they are actually
> reachable in the new pack.
>
> This function filters such shallow points out, leaving ones that migh=
t
> potentially be added. A simple has_sha1_file won't do because we may
> have incomplete object islands (i.e. not connected to any refs) and
> the shallow points are on these islands. In that case we want to keep
> the shallow points as candidates until we figure out if the new pack
> connects to such object islands.
>
> Typical cases that use remove_reachable_shallow_points() are:
>
>  - fetch from a repo that has longer history: in this case all remote
>    shallow roots do not exist in the client repo, this function will
>    be cheap as it just does a few lookup_commit_graft and
>    has_sha1_file.

It is unclear why.  If you fetched from a repository more complete
than you, you may deepen your history which may allow you to unplug
the shallow points you originally had, and remote "shallow root" (by
the way, lets find a single good phrase to represent this thing and
stick to it) may want to replace them, no?

>  - fetch from a repo that has exactly the same shallow root set
>    (e.g. a clone from a shallow repo): this case may trigger
>    in_merge_bases_many all the way to roots. An exception is made to
>    avoid such costly path with a faith that .git/shallow does not
>    usually points to unreachable commit islands.

=2E.. and when the faith is broken, you will end up with a broken
repository???

>  - push from a shallow repo that has shorter history than the
>    server's: in_merge_bases_many() is unavoidable, so the longer
>    history the client has the higher the server cost is. The cost may
>    be reduced with the help of pack bitmaps, or commit cache, though.
>
>  - push from a shallow clone that has exactly the same shallow root
>    set: the same as the second fetch case above, .i.e. cheap by
>    exception.
>
> The function must be called before the new pack is installed, or we
> won't know which objects are ours, which theirs.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  commit.h  |  3 +++
>  connect.c |  2 +-
>  remote.h  |  1 +
>  shallow.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/commit.h b/commit.h
> index a879526..98044e6 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -193,6 +193,7 @@ extern struct commit_list *get_octopus_merge_base=
s(struct commit_list *in);
>  /* largest positive number a signed 32-bit integer can contain */
>  #define INFINITE_DEPTH 0x7fffffff
> =20
> +struct extra_have_objects;
>  extern int register_shallow(const unsigned char *sha1);
>  extern int unregister_shallow(const unsigned char *sha1);
>  extern int for_each_commit_graft(each_commit_graft_fn, void *);
> @@ -206,6 +207,8 @@ extern void setup_alternate_shallow(struct lock_f=
ile *shallow_lock,
>  				    const char **alternate_shallow_file);
>  extern char *setup_temporary_shallow(void);
>  extern void advertise_shallow_grafts(int);
> +extern void remove_reachable_shallow_points(struct extra_have_object=
s *out,
> +					    const struct extra_have_objects *in);
> =20
>  int is_descendant_of(struct commit *, struct commit_list *);
>  int in_merge_bases(struct commit *, struct commit *);
> diff --git a/connect.c b/connect.c
> index d0602b0..80e4360 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -45,7 +45,7 @@ int check_ref_type(const struct ref *ref, int flags=
)
>  	return check_ref(ref->name, strlen(ref->name), flags);
>  }
> =20
> -static void add_extra_have(struct extra_have_objects *extra, unsigne=
d char *sha1)
> +void add_extra_have(struct extra_have_objects *extra, unsigned char =
*sha1)
>  {
>  	ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);
>  	hashcpy(&(extra->array[extra->nr][0]), sha1);
> diff --git a/remote.h b/remote.h
> index 773faa9..ff604ff 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -145,6 +145,7 @@ extern struct ref **get_remote_heads(int in, char=
 *src_buf, size_t src_len,
>  				     struct ref **list, unsigned int flags,
>  				     struct extra_have_objects *have,
>  				     struct extra_have_objects *shallow);
> +extern void add_extra_have(struct extra_have_objects *extra, unsigne=
d char *sha1);
> =20
>  int resolve_remote_symref(struct ref *ref, struct ref *list);
>  int ref_newer(const unsigned char *new_sha1, const unsigned char *ol=
d_sha1);
> diff --git a/shallow.c b/shallow.c
> index 9552512..a974d2d 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -2,6 +2,8 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "pkt-line.h"
> +#include "remote.h"
> +#include "refs.h"
> =20
>  static int is_shallow =3D -1;
>  static struct stat shallow_stat;
> @@ -235,3 +237,46 @@ void advertise_shallow_grafts(int fd)
>  		return;
>  	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
>  }
> +
> +struct commit_array {
> +	struct commit **commits;
> +	int nr, alloc;
> +};
> +
> +static int add_ref(const char *refname,
> +		   const unsigned char *sha1, int flags, void *cb_data)
> +{
> +	struct commit_array *ca =3D cb_data;
> +	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
> +	ca->commits[ca->nr++] =3D lookup_commit(sha1);
> +	return 0;
> +}

Can't a ref point at a non-commit-ish?  Is the code prepared to deal
with such an entry (possibly a NULL pointer) in the commit_array
struct?

> +void remove_reachable_shallow_points(struct extra_have_objects *out,
> +				     const struct extra_have_objects *in)
> +{
> +	struct commit_array ca;
> +	int i;
> +
> +	memset(&ca, 0, sizeof(ca));
> +	head_ref(add_ref, &ca);
> +	for_each_ref(add_ref, &ca);
> +	for (i =3D 0; i < in->nr; i++) {
> +		struct commit_graft *graft =3D lookup_commit_graft(in->array[i]);
> +		/*
> +		 * For a clone from a shallow upstream, the clone has
> +		 * the same shallow roots as upstream and it will
> +		 * trigger in_merge_bases_many() all the way to roots.
> +		 * Avoid that costly path and assume .git/shallow is
> +		 * good most of the time.
> +		 */
> +		if (graft && graft->nr_parent < 0)
> +			continue;
> +		if (has_sha1_file(in->array[i]) &&
> +		    in_merge_bases_many(lookup_commit(in->array[i]),
> +					ca.nr, ca.commits))
> +			continue;
> +		add_extra_have(out, in->array[i]);
> +	}
> +	free(ca.commits);
> +}
