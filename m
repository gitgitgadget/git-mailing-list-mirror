From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 02/11] notes-merge: use opendir/readdir instead of
 using read_directory()
Date: Tue, 25 Oct 2011 12:27:12 -0700
Message-ID: <7vzkgo3m9b.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 21:27:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RImes-0001mH-9s
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 21:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1JYT13 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 15:27:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab1JYT1P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 15:27:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CF8A6011;
	Tue, 25 Oct 2011 15:27:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mQbxXhf06Fks
	s7t4DJmkdwb1L3U=; b=w8Ip+zvj5brQuig9ufcufYoXmaYhj0deolD5noVc1x4w
	quc1iMqZVkiMmQdIghdcU7hmyYFWIQuC+mjT2nH1eh4fVY6sUFbBSxO4g2n3SzL/
	5jq6e0AkhGJ9L00mJ38Ubua9q+H0kfVTnXp9KAL2/4w9wt8+D/cSqrJC1aQJm38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jdKW/j
	Vkol3tnz6sdSCRKUbhVYHZd0074jowGTydevTV9ssGov8fqnbOCl9ZTlPkt8R7lS
	aVmRQwNIxqMfAu86lVUxOU8uB4OB6Kih0qUExDrrJbs3Ucxo+UMIEvOji00Jxihv
	SarhuJ7WsvhZqFpDTDJ32vXv9xEK603oUM8MA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84800600F;
	Tue, 25 Oct 2011 15:27:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E40F7600D; Tue, 25 Oct 2011
 15:27:13 -0400 (EDT)
In-Reply-To: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 17:36:07 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57A30E08-FF3F-11E0-AF03-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184234>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> notes_merge_commit() only needs to list all entries (non-recursively)
> under a directory, which can be easily accomplished with
> opendir/readdir and would be more lightweight than read_directory().
>
> read_directory() is designed to list paths inside a working
> directory. Using it outside of its scope may lead to undesired effect=
s.

Technically isn't the directory structure this codepath looks at a work=
ing
tree that has extract of a notes tree commit?

Looking at the result of the patch I do not have strong opinions either
way, though. It isn't like we care about gitignore or attributes rules =
in
the notes tree, so using read_directory() does feel like an overkill.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  notes-merge.c |   45 +++++++++++++++++++++++++++------------------
>  1 files changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/notes-merge.c b/notes-merge.c
> index e9e4199..80d64a2 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -680,48 +680,57 @@ int notes_merge_commit(struct notes_merge_optio=
ns *o,
>  	 * commit message and parents from 'partial_commit'.
>  	 * Finally store the new commit object SHA1 into 'result_sha1'.
>  	 */
> -	struct dir_struct dir;
> -	char *path =3D xstrdup(git_path(NOTES_MERGE_WORKTREE "/"));
> -	int path_len =3D strlen(path), i;
> +	DIR *dir;
> +	struct dirent *e;
> +	struct strbuf path =3D STRBUF_INIT;
>  	const char *msg =3D strstr(partial_commit->buffer, "\n\n");
> +	int baselen;
> =20
> -	OUTPUT(o, 3, "Committing notes in notes merge worktree at %.*s",
> -	       path_len - 1, path);
> +	strbuf_addstr(&path, git_path(NOTES_MERGE_WORKTREE));
> +	OUTPUT(o, 3, "Committing notes in notes merge worktree at %s", path=
=2Ebuf);
> =20
>  	if (!msg || msg[2] =3D=3D '\0')
>  		die("partial notes commit has empty message");
>  	msg +=3D 2;
> =20
> -	memset(&dir, 0, sizeof(dir));
> -	read_directory(&dir, path, path_len, NULL);
> -	for (i =3D 0; i < dir.nr; i++) {
> -		struct dir_entry *ent =3D dir.entries[i];
> +	dir =3D opendir(path.buf);
> +	if (!dir)
> +		die_errno("could not open %s", path.buf);
> +
> +	strbuf_addch(&path, '/');
> +	baselen =3D path.len;
> +	while ((e =3D readdir(dir)) !=3D NULL) {
>  		struct stat st;
> -		const char *relpath =3D ent->name + path_len;
>  		unsigned char obj_sha1[20], blob_sha1[20];
> =20
> -		if (ent->len - path_len !=3D 40 || get_sha1_hex(relpath, obj_sha1)=
) {
> -			OUTPUT(o, 3, "Skipping non-SHA1 entry '%s'", ent->name);
> +		if (is_dot_or_dotdot(e->d_name))
> +			continue;
> +
> +		if (strlen(e->d_name) !=3D 40 || get_sha1_hex(e->d_name, obj_sha1)=
) {
> +			OUTPUT(o, 3, "Skipping non-SHA1 entry '%s%s'", path.buf, e->d_nam=
e);
>  			continue;
>  		}
> =20
> +		strbuf_addstr(&path, e->d_name);
>  		/* write file as blob, and add to partial_tree */
> -		if (stat(ent->name, &st))
> -			die_errno("Failed to stat '%s'", ent->name);
> -		if (index_path(blob_sha1, ent->name, &st, HASH_WRITE_OBJECT))
> -			die("Failed to write blob object from '%s'", ent->name);
> +		if (stat(path.buf, &st))
> +			die_errno("Failed to stat '%s'", path.buf);
> +		if (index_path(blob_sha1, path.buf, &st, HASH_WRITE_OBJECT))
> +			die("Failed to write blob object from '%s'", path.buf);
>  		if (add_note(partial_tree, obj_sha1, blob_sha1, NULL))
>  			die("Failed to add resolved note '%s' to notes tree",
> -			    ent->name);
> +			    path.buf);
>  		OUTPUT(o, 4, "Added resolved note for object %s: %s",
>  		       sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
> +		strbuf_setlen(&path, baselen);
>  	}
> =20
>  	create_notes_commit(partial_tree, partial_commit->parents, msg,
>  			    result_sha1);
>  	OUTPUT(o, 4, "Finalized notes merge commit: %s",
>  	       sha1_to_hex(result_sha1));
> -	free(path);
> +	strbuf_release(&path);
> +	closedir(dir);
>  	return 0;
>  }
