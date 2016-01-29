From: =?utf-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: AW: [PATCH 1/2] stash--helper: implement "git stash--helper"
Date: Fri, 29 Jan 2016 20:32:45 +0100
Message-ID: <BLU436-SMTP10996033F3EBFE2E8639F96A5DB0@phx.gbl>
References: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>	<0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com> <xmqqr3h1l2x8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Thomas Gummerer'" <t.gummerer@gmail.com>,
	"'Stefan Beller'" <sbeller@google.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 20:32:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPEmu-0002Da-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 20:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbcA2Tcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 14:32:53 -0500
Received: from blu004-omc3s17.hotmail.com ([65.55.116.92]:56233 "EHLO
	BLU004-OMC3S17.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753904AbcA2Tcv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 14:32:51 -0500
Received: from BLU436-SMTP109 ([65.55.116.73]) by BLU004-OMC3S17.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Fri, 29 Jan 2016 11:32:51 -0800
X-TMN: [eyI83iepCYE3zm05uNdDwBjzbC624sxm]
X-Originating-Email: [mha1993@live.de]
In-Reply-To: <xmqqr3h1l2x8.fsf@gitster.mtv.corp.google.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIM34RO7ltaDI9lRGPrCDtl8pHldAFSRr5uAUFOBJOehw058A==
Content-Language: de
X-OriginalArrivalTime: 29 Jan 2016 19:32:49.0756 (UTC) FILETIME=[D6B5E1C0:01D15ACB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285089>

> Hmph, why not have everything inside builtin/stash--helper.c?  I do n=
ot quite see a point of having the other two "library-ish" looking file=
s.
>=20
> Also I personally feel that it would be easier to review when these t=
wo patches are squashed into one.  I had to go back and forth while rea=
ding the "non-patch" C function to see what logic from the scripted ver=
sion it is trying to replace.

I can certainly do that.

> This is meant to replace this sequence:
>
>	git read-tree --index-output=3D"$TMPindex" -m $i_tree &&
>	GIT_INDEX_FILE=3D"$TMPindex" &&
>	export GIT_INDEX_FILE &&
>	git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
>	git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
>	git write-tree &&
>	rm -f "$TMPindex"
>
> And outside of this section of the script, $TMPindex is never looked =
at after this part finishes (which is obvious as the last thing the sec=
tion does is to remove it).  As you are rewriting this whole section in=
 C, you should wonder if you can do it without using a temporary file i=
n the filesystem at all.

I assumed the path to $TMPindex was still available in GIT_INDEX_FILE a=
fter this, as it gets exported, but I guess the surrounding $() imply a=
 subshell.

> Honestly, I had high hopes after seeing the "we are rewriting it in C=
" but I am not enthused after seeing this.  I was hoping that the rewri=
tten version would do this all in-core, by calling these functions that=
 we already have:

These functions might be obvious to you, but I'm new to git's source co=
de, so I worked with the things I found documented and those that were =
brought to my attention by Johannes Schindelin. The run-command API is =
documented and seemed to be the "official" method of calling any git co=
mmands from within native git  code. On the other hand, the documentati=
on for the in-core index API boils down to "TODO: document this". This =
lead me to believe I did this the intended way and just calling random =
functions that sound  similar to the  original command may be frowned u=
pon at best.

> A C rewrite that works all in-core does not even need to write out a =
temporary; it can just read the current index and do various things up =
to writing the contents of the in-core index as a tree, and the result =
would be correct as long as you do not forget *NOT* to write the in-cor=
e index out to $GIT_INDEX_FILE.

I'll be working on a v2 that incorporates the feedback from you, Thomas=
 Gummerer  and Stefan Beller then. Further feedback is of course welcom=
e.

-----Urspr=C3=BCngliche Nachricht-----
Von: Junio C Hamano [mailto:gitster@pobox.com]=20
Gesendet: Freitag, 29. Januar 2016 00:06
An: Matthias Asshauer <mha1993@live.de>
Cc: git@vger.kernel.org
Betreff: Re: [PATCH 1/2] stash--helper: implement "git stash--helper"

Matthias Asshauer <mha1993@live.de> writes:

> From: Matthias A=C3=9Fhauer <mha1993@live.de>
>
> This patch implements a new "git stash--helper" builtin plumbing=20
> command that will be used to migrate "git-stash.sh" to C.
>
> We start by implementing only the "--non-patch" option that will=20
> handle the core part of the non-patch stashing.
>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  Makefile                |  2 ++
>  builtin.h               |  1 +
>  builtin/stash--helper.c | 13 ++++++++++
>  git.c                   |  1 +
>  stash.c                 | 65 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>  stash.h                 | 11 +++++++++

Hmph, why not have everything inside builtin/stash--helper.c?  I do not=
 quite see a point of having the other two "library-ish" looking files.

Also I personally feel that it would be easier to review when these two=
 patches are squashed into one.  I had to go back and forth while readi=
ng the "non-patch" C function to see what logic from the scripted versi=
on it is trying to replace.

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c new=20
> file mode 100644 index 0000000..542e782
> --- /dev/null
> +++ b/builtin/stash--helper.c
> @@ -0,0 +1,13 @@
> +#include "../stash.h"
> +#include <string.h>
> +
> +static const char builtin_stash__helper_usage[] =3D {
> +	"Usage: git stash--helper --non-patch <tmp_indexfile> <i_tree>"
> +};
> +
> +int cmd_stash__helper(int argc, const char **argv, const char=20
> +*prefix) {
> +	if (argc =3D=3D 4 && !strcmp("--non-patch", argv[1]))
> +		return stash_non_patch(argv[2], argv[3], prefix);
> +	usage(builtin_stash__helper_usage);
> +}

This is meant to replace this sequence:

	git read-tree --index-output=3D"$TMPindex" -m $i_tree &&
	GIT_INDEX_FILE=3D"$TMPindex" &&
	export GIT_INDEX_FILE &&
	git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
	git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
	git write-tree &&
	rm -f "$TMPindex"

And outside of this section of the script, $TMPindex is never looked at=
 after this part finishes (which is obvious as the last thing the secti=
on does is to remove it).  As you are rewriting this whole section in C=
, you should wonder if you can do it without using a temporary file in =
the filesystem at all.

> diff --git a/stash.c b/stash.c
> new file mode 100644
> index 0000000..c3d6e67
> --- /dev/null
> +++ b/stash.c
> @@ -0,0 +1,65 @@
> +#include "stash.h"
> +#include "strbuf.h"
> +
> +static int prepare_update_index_argv(struct argv_array *args,
> +	struct strbuf *buf)
> +{
> +	struct strbuf **bufs, **b;
> +
> +	bufs =3D strbuf_split(buf, '\0');
> +	for (b =3D bufs; *b; b++)
> +		argv_array_pushf(args, "%s", (*b)->buf);
> +	argv_array_push(args, "--");
> +	strbuf_list_free(bufs);
> +
> +	return 0;
> +}
> +
> +int stash_non_patch(const char *tmp_indexfile, const char *i_tree,
> +	const char *prefix)
> +{
> +	int result;
> +	struct child_process read_tree =3D CHILD_PROCESS_INIT;
> +	struct child_process diff =3D CHILD_PROCESS_INIT;
> +	struct child_process update_index =3D CHILD_PROCESS_INIT;
> +	struct child_process write_tree =3D CHILD_PROCESS_INIT;
> +	struct strbuf buf =3D STRBUF_INIT;
> +
> +	argv_array_push(&read_tree.args, "read-tree");
> +	argv_array_pushf(&read_tree.args, "--index-output=3D%s", tmp_indexf=
ile);
> +	argv_array_pushl(&read_tree.args, "-m", i_tree, NULL);
> +
> +	argv_array_pushl(&diff.args, "diff", "--name-only", "-z", "HEAD", "=
--",
> +		NULL);
> +
> +	argv_array_pushl(&update_index.args, "update-index", "--add",
> +		"--remove", NULL);
> +
> +	argv_array_push(&write_tree.args, "write-tree");

Honestly, I had high hopes after seeing the "we are rewriting it in C" =
but I am not enthused after seeing this.  I was hoping that the rewritt=
en version would do this all in-core, by calling these functions that w=
e already have:

 * read_index() to read the current index into the_index;

 * unpack_trees() to overlay the contents of i_tree to the contents
   of the index;

 * run_diff_index() to make the comparison between the result of the
   above and HEAD to collect the paths that are different (you'd use
   DIFF_FORMAT_CALLBACK mechanism to collect paths---see wt-status.c
   for existing code that already does this for hints);

 * add_to_index() to add or remove paths you found in the previous
   step to the in-core index;

 * write_cache_as_tree() to write out the resulting index of the
   above sequence of calls to a new tree object;

 * sha1_to_hex() to convert that resulting tree object name to hex
   format;

 * puts() to output the result.


Actually, because i_tree is coming from $(git write-tree) that was done=
 earlier on the current index, the unpack_trees() step should not even =
be necessary.

The first three lines of the scripted version:

	git read-tree --index-output=3D"$TMPindex" -m $i_tree &&
	GIT_INDEX_FILE=3D"$TMPindex" &&
	export GIT_INDEX_FILE &&

are creating a new file $TMPindex on the filesystem while preserving th=
e cached stat info when it can, which is a glorified version of:

	cp -p $GIT_INDEX_FILE $TMPindex

In fact, versions of "git stash" before 3ba2e865 (stash: copy the index=
 using --index-output instead of cp -p, 2011-03-16) simply did a "cp -p=
".

A C rewrite that works all in-core does not even need to write out a te=
mporary; it can just read the current index and do various things up to=
 writing the contents of the in-core index as a tree, and the result wo=
uld be correct as long as you do not forget *NOT* to write the in-core =
index out to $GIT_INDEX_FILE.
