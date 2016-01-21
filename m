From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] merge: add --rename-notes
Date: Thu, 21 Jan 2016 09:53:23 -0800
Message-ID: <xmqqtwm6yg30.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMJQJ-0001c2-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 18:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900AbcAURx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2016 12:53:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755545AbcAURx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2016 12:53:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DD133AB1E;
	Thu, 21 Jan 2016 12:53:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8BAHM6Liy0Bf
	aj+0hONVYhveK+c=; b=JiR7zbZdDA0BjGF9Ug5K2rluUEV9FddbemSitkCaLASt
	NYKclr2zdzvuT818Fusm02eyDpVzV5IYMyjGFVmQK5kWlSLfTJ+r7a7sri4BMd9W
	XPN46nANRy9r7RhCMVJ3ZhdOH8LQsozeI3i8vgOiFRzQ/odmPe3c53XB6X/am+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N7yiv7
	5wjnu30u2WEoRqWAVY2BcE0zlEJzUOAMotgwpn6fjIAZaw2ipJq8s6EBRJk7rdfm
	skmxKGj4naNp8Es8mp/TkNLvtqpqKFYIkgMS1RPKbDFG1awLwZLkgSs8grzvWgtl
	cdF8THscDzljJLHqOHvxSojBk9oVoZo0mA6Sg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 756BA3AB1D;
	Thu, 21 Jan 2016 12:53:25 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E61283AB1C;
	Thu, 21 Jan 2016 12:53:24 -0500 (EST)
In-Reply-To: <1453287968-26000-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Jan 2016 18:06:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE5E3402-C067-11E5-AE10-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284517>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +/*
> + * Traverse through the given notes tree, convert all "path to path"
> + * rename lines into "blob to blob" and return it. If cache_file is
> + * non-NULL, return it's content if still valid. Otherwise save the
> + * new content in it.
> + */
> +static void merge_rename_notes(struct strbuf *cache,
> +			       struct notes_tree *t, const char *cache_file)
> +{
> +	struct object_id notes_oid;
> +
> +	if (cache_file) {
> +	...
> +	}
> +
> +	strbuf_reset(cache);
> +	for_each_note(t, 0, merge_rename_note, cache);

This uses _all_ merge notes attached to _any_ commit in the history,
without even checking if the commit is involved in the current merge
being done?  How would that be useful?

I also suspect that the data structure to keep track renames by
using notes needs a better design.  You seem to have a note per
commit and one note records a set of "this goes to that", and
that is the reason why you need to discriminately read everything
under the sun.

I think the index into the notes tree for the purpose of this use
case should not be "which commit records this set of renames?",
but by "what is the destination blob of possible rename
operations?".  IOW, if a path that held blob X was moved to
another path that holds blob Z in commit A, and if a path that
held blob Y was moved to another path that holds blob Z in commit
B, attach a note to blob Z that records "moved from X in A" and
"moved from Y in B".

Then, after diffcore-rename has enumerated the potential rename
destinations, look these destination blobs up in the notes.  You
see a path with blob Z created, and you know if you have removed
path that held X or Y in the potential rename source set, you
found a manually recorded rename.  If you have ancestry
information when you do it, you could even reject "move from X to
Z" when you know commit A is not involved in the ancestry path
involved in the merge, but that is optional (as you may be
comparing two states that may not be related with each other).

=46or the purpose of helping "git log", a notes tree reorganized in
such a way would be useful.  Again, when you find a potential
rename destination that has blob Z as the result of the change,
you read the note attached to the blob to learn that it may have
come from a path that held blob X (if we are dealing with commit
A), or it may have come from a path that held blob Y (if we are
dealing with commit B).  So you can add a new field in diffopt
structure and allow the caller somewhere in the callchain
(log_tree_diff(), perhaps?) to pass which resulting commit it
wants the recorded renames to be used from.  When it is time for
"git log -M -p" to show commit A, diffcore-rename down in the
callchain will get the diff_queue that contains "diff A^..A",
among which there is a path that used to have blob Z that goes
away, reads the notes for blob Z and notice that commit A moved a
path with blob X that is going away was renamed to it, discarding
the other record for blob Z that talks about the change in commit
B that is not relevant for the purpose of showing commit A.

Hmm?

> @@ -1260,10 +1359,25 @@ int cmd_merge(int argc, const char **argv, co=
nst char *prefix)
>  		usage_with_options(builtin_merge_usage,
>  			builtin_merge_options);
> =20
> +	if (rename_file && rename_note_ref)
> +		die(_("--rename-file and --rename-notes are incompatible"));
> +
>  	if (rename_file &&
>  	    strbuf_read_file(&manual_renames, rename_file, 0) =3D=3D -1)
>  		die(_("unable to read %s"), rename_file);
> =20
> +	if (rename_note_ref) {
> +		struct notes_tree rename_notes;
> +		struct strbuf ref =3D STRBUF_INIT;
> +
> +		strbuf_addstr(&ref, rename_note_ref);
> +		expand_notes_ref(&ref);
> +		init_notes(&rename_notes, ref.buf, NULL, 0);
> +		strbuf_release(&ref);
> +		merge_rename_notes(&manual_renames, &rename_notes,
> +				   git_path("GIT_RENAME_CACHE"));
> +	}
> +

These new hunks must move way below the codepath and be run only
after we are certain that we need to do a real merge.  The merge
logic that follows this line tries to handle light-weight special
cases (like an obvious fast-forward and already up-to-date cases)
as early as possible to avoid doing unnecessary things.

This patch (and the earlier one adds strbuf-read-file of the
rename-file) breaks the design by doing these new heavyweight
operations whose result may not be used at all too early, I
think.

If you go the route of reorganizing the rename notes around the
destination blobs, then you wouldn't even be reading everything
here very high in the callchain (you would be doing so only after
diffcore-rename decides that rename notes may be worth reading),
and that would fix this.

>  	if (!head_commit) {
>  		struct commit *remote_head;
>  		/*

Thanks.
