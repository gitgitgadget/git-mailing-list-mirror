From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Sun, 04 Oct 2009 15:19:25 -0700
Message-ID: <7vbpkmn6oi.fsf@alter.siamese.dyndns.org>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de>
 <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 00:23:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuZUJ-0003Pv-SV
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 00:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZJDWUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 18:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZJDWUT
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 18:20:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbZJDWUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 18:20:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2CDB6BD4E;
	Sun,  4 Oct 2009 18:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=l+WP2WcayfRquYNXbu1phqCha9A=; b=EbdAiU61tF4xVeobNfW2pl1
	MOkiGjO64LR3sTb5b9rB/A7MPmgCmVNjgGFbNq+BOOh7/pqvn4NKGMSY3PgiaD82
	mEWDYNxLL05ZlX5Ga2n2rVgJcHYXn40E045nZiGB4bPGTPS3ECsiWAu7R/KaOkyk
	D+uVZrAxszpMirv7D6X0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WrY1wkQLHEqVW0aRUwj+UHuKVV05EecWuEzDZrIWsPVVbk9pj
	fb51GAuhx8Uwwf+CXh9gONYGmWrYrycyOdUFeT57mfJ8yxQXYBDgJCPrFvllV341
	Gqe0vBNYGMCbcxbPQqXffwSpX4BA2dq3ECIH10MbcH8zUsPLoEwMppjLcw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA7216BD4D;
	Sun,  4 Oct 2009 18:19:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F237F6BD4C; Sun,  4 Oct 2009
 18:19:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD3DF08C-B133-11DE-B1C5-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129520>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Now you can see the submodule summaries inlined in the diff, instead of
> not-quite-helpful SHA-1 pairs.

This looks useful, but I do not think this is --summary.  It is not part
of the "summary" output but is about making output for Submoodules more
verbose.  I'd suggest naming it --verbose-submodule or something.

> The format imitates what "git submodule summary" shows.

The output format needs to be described better here and also in
Documentation/diff-format.txt.

> To do that, <path>/.git/objects/ is added to the alternate object
> databases (if that directory exists).

Is it always true that <path>/.git is the GIT_DIR for that submodule?  Not
complaining but checking sanity.

> diff --git a/diff.c b/diff.c
> index 9e00131..cdef322 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1557,6 +1558,17 @@ static void builtin_diff(const char *name_a,
>  	const char *a_prefix, *b_prefix;
>  	const char *textconv_one = NULL, *textconv_two = NULL;
>  
> +	if (DIFF_OPT_TST(o, SUMMARIZE_SUBMODULES) &&
> +			(!one->mode || S_ISGITLINK(one->mode)) &&
> +			(!two->mode || S_ISGITLINK(two->mode))) {
> +		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
> +		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
> +		show_submodule_summary(o->file, one ? one->path : two->path,
> +				one->sha1, two->sha1,
> +				del, add, reset);
> +		return;
> +	}
> +

Isn't this "textual diff" codepath?

I would have expected --submodule-summary output to be near the --summary
output and to be generated in the same codepath to generate it; if this
were named --verbose-submodule, I would certainly understand it, and I
think the placement is saner in the textual diff.

> diff --git a/submodule.c b/submodule.c
> new file mode 100644
> index 0000000..3f2590d
> --- /dev/null
> +++ b/submodule.c
> @@ -0,0 +1,108 @@
> +#include "cache.h"
> +#include "submodule.h"
> +#include "dir.h"
> +#include "diff.h"
> +#include "commit.h"
> +#include "revision.h"
> +
> +int add_submodule_odb(const char *path)
> +{
> +	struct strbuf objects_directory = STRBUF_INIT;
> +	struct alternate_object_database *alt_odb;
> +
> +	strbuf_addf(&objects_directory, "%s/.git/objects/", path);
> +	if (!is_directory(objects_directory.buf))
> +		return -1;
> +
> +	/* avoid adding it twice */
> +	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
> +		if (alt_odb->name - alt_odb->base == objects_directory.len &&
> +				!strncmp(alt_odb->base, objects_directory.buf,
> +					objects_directory.len))
> +			return 0;
> +	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
> +	alt_odb->next = alt_odb_list;
> +	strcpy(alt_odb->base, objects_directory.buf);
> +	alt_odb->name = alt_odb->base + objects_directory.len;
> +	alt_odb->name[2] = '/';
> +	alt_odb->name[40] = '\0';
> +	alt_odb->name[41] = '\0';
> +	alt_odb_list = alt_odb;
> +	prepare_alt_odb();

The lines after "avoid adding it twice" look somewhat familiar.

Don't we already have other codepaths to add an alternate odb that need to
be careful in the same way (i.e. do not add twice, do not loop, etc.), and
if so don't you want to reuse it after refactoring?

> +void show_submodule_summary(FILE *f, const char *path,
> +		unsigned char one[20], unsigned char two[20],
> +		const char *del, const char *add, const char *reset)
> +{
> +	struct rev_info rev;
> +	struct commit *commit, *left, *right;
> +	struct commit_list *merge_bases, *list;
> +	const char *message = NULL;
> +	struct strbuf sb = STRBUF_INIT;
> +	static const char *format = "    %m %s";
> +	int fast_forward = 0, fast_backward = 0;
> +
> +	if (add_submodule_odb(path))
> +		message = "(not checked out)";
> +	else if (is_null_sha1(one))
> +		message = "(new submodule)";
> +	else if (is_null_sha1(two))
> +		message = "(submodule deleted)";

Are you sure about this?  Wouldn't "git diff HEAD" (not looking at the
index) give you the 0{40} on the "two" side when the path is modified?

> +	if (!message) {
> +		init_revisions(&rev, NULL);
> +		setup_revisions(0, NULL, &rev, NULL);
> +		rev.left_right = 1;
> +		left->object.flags |= SYMMETRIC_LEFT;
> +		add_pending_object(&rev, &left->object, path);
> +		add_pending_object(&rev, &right->object, path);
> +		merge_bases = get_merge_bases(left, right, 1);
> +		if (merge_bases) {
> +			if (merge_bases->item == left)
> +				fast_forward = 1;
> +			else if (merge_bases->item == right)
> +				fast_backward = 1;
> +		}
> +		for (list = merge_bases; list; list = list->next) {
> +			list->item->object.flags |= UNINTERESTING;
> +			add_pending_object(&rev, &list->item->object,
> +				sha1_to_hex(list->item->object.sha1));
> +		}
> +		if (prepare_revision_walk(&rev))
> +			message = "(revision walker failed)";

If prepare_revision_walk() failed for whatever reason, can we trust
fast_forward/fast_backward at this point?

> +	}
> +
> +	strbuf_addf(&sb, "Submodule %s %s..", path,
> +			find_unique_abbrev(one, DEFAULT_ABBREV));
> +	if (!fast_backward && !fast_forward)
> +		strbuf_addch(&sb, '.');
> +	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
> +	if (message)
> +		strbuf_addf(&sb, " %s\n", message);
> +	else
> +		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");

No corresponding "(fast-forward)" label?

> +	fwrite(sb.buf, sb.len, 1, f);
> +
> +	if (!message) {
> +		while ((commit = get_revision(&rev))) {
> +			strbuf_setlen(&sb, 0);
> +			if (del)
> +				strbuf_addstr(&sb, commit->object.flags &
> +						SYMMETRIC_LEFT ? del : add);
> +			format_commit_message(commit, format, &sb,
> +					rev.date_mode);
> +			if (del)
> +				strbuf_addstr(&sb, reset);

Three points, two of which are minor.

 - Checking "del" to decide if you want to say "reset" feels funny.

 - In the "ANSI-terminal only" world view, adding colors to strbuf and
   writing it out together with the actual strings is an easy thing to do.
   Don't Windows folks have trouble converting this kind of code to their
   color control call that is separate from writing strings out?  If it is
   not a problem, I do not have any objection to it, but otherwise I'd
   suggest not to add any more code that stores color escape sequence in
   strbuf, so that we would not make later conversion by Windows folks
   harder than necessary.

 - The output is similar but different from "submodule --summary" and
   there is no justification described in the patch nor the proposed
   commit log message.

   o Why does "submodule --summary" use --first-parent and this patch
     doesn't?

   o "submodule --summary" allows users to limit the walk but this seems
     to give the full list---is it useful (or even sane) to always give
     a full list?

> +			strbuf_addch(&sb, '\n');
> +			fwrite(sb.buf, sb.len, 1, f);
> +		}
> +		clear_commit_marks(left, ~0);
> +		clear_commit_marks(right, ~0);
> +	}

Aren't object flags shared between the outer revision walker that walks
the log and this new walker?  If the supermodule history and submodule
history share commits (e.g. when later git.git starts using submodules to
bind gitk and git-gui), wouldn't this break "git log -p" a big way?

In any case, thanks for an interesting patch.  Looking forward to see how
this topic evolves.
