Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD0B207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755579AbcIPXcL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 19:32:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61999 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754384AbcIPXcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 19:32:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E724C40654;
        Fri, 16 Sep 2016 19:32:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E7SIcAqLuG3vBQv71MQhVvFZiRE=; b=VoV1xK
        6Stu9yY4I4V7iIan+T1DwVp7qoZL1+a9q9VjXxZGqr5+B1nlwJCvMeuQiw2QyFn3
        zFTmFZcz33SaIx9DpLQGVnQ8WVJ9XTQ8f1bqpyXsPSFkn0gg6uQtUgfkBxiCkUJT
        uKsTMo4blzqfi7MX+rWa1Ipk/AJwNFQ8lZL/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e/iPJfW2NbSNWQgcrRBRS6pdOM67sXVg
        gXT1EvXInZalV8l7Zb6gchVpDsj/7o/dgWmCE/aIxTvHSQ/B/GeSv5lUdoDPeM7L
        aWfinTHePC2dzHW0oSHx54kbApl3YacQyvn/TQimzNM7lemLBOj7ERrymlSz3sSH
        RSDxmBURjFE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E090440653;
        Fri, 16 Sep 2016 19:32:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5583140652;
        Fri, 16 Sep 2016 19:32:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/11] Resumable clone: implement primer logic in git-clone
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
Date:   Fri, 16 Sep 2016 16:32:05 -0700
In-Reply-To: <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
        (Kevin Wern's message of "Thu, 15 Sep 2016 20:12:22 -0400")
Message-ID: <xmqqy42rh156.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C83227C8-7C65-11E6-98A6-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> writes:

> Use transport_download_primer and transport_prime_clone in git clone.
> This only supports a fully connected packfile.
>
> transport_prime_clone and transport_download_primer are executed
> completely independent of transport_(get|fetch)_remote_refs, et al.
> transport_download_primer is executed based on the existence of an
> alt_resource. The idea is that the "prime clone" execution should be
> able to attempt retrieving an alternate resource without dying, as
> opposed to depending on the result of upload pack's "capabilities" to
> indicate whether or not the client can attempt it.
>
> If a resumable resource is available, execute a codepath with the
> following modular components:
> - downloading resource to a specific directory
> - using the resource (for pack, indexing and generating the bundle
>   file)
> - cleaning up the resource (if the download or use fails)
> - cleaning up the resource (if the download or use succeeds)
>
> If resume is interrupted on the client side, the alternate resource
> info is written to the RESUMABLE file in the git directory.
>
> On resume, the required info is extracted by parsing the created
> config file, and that info is used to determine the work and git
> directories. If these cannot be determined, the program exits.
> The writing of the refspec and determination of the initial git
> directories are skipped, along with transport_prime_clone.
>
> The main purpose of this series of patches is to flesh out a codepath
> for automatic resuming, manual resuming, and leaving a resumable
> directory on exit--the logic for when to do these still needs more
> work.
>
> Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
> ---
>  Documentation/git-clone.txt |  16 ++
>  builtin/clone.c             | 590 +++++++++++++++++++++++++++++++++++++-------
>  t/t9904-git-prime-clone.sh  | 181 ++++++++++++++
>  3 files changed, 698 insertions(+), 89 deletions(-)
>  create mode 100755 t/t9904-git-prime-clone.sh
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index b7c467a..5934bb6 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	  [--depth <depth>] [--[no-]single-branch]
>  	  [--recursive | --recurse-submodules] [--] <repository>
>  	  [<directory>]
> +'git clone --resume <resumable_dir>'
>  
>  DESCRIPTION
>  -----------
> @@ -172,6 +173,12 @@ objects from the source repository into a pack in the cloned repository.
>  	via ssh, this specifies a non-default path for the command
>  	run on the other end.
>  
> +--prime-clone <prime-clone>::
> +-p <prime-clone>::

Not many other options have single letter shorthand.  Is it expected
that it is worth to let this option squat on a short-and-sweet "-p",
perhaps because it is so frequently used?

> +--resume::
> +	Resume a partially cloned repo in a "resumable" state. This
> +	can only be specified with a single local directory (<resumable
> +	dir>). This is incompatible with all other options.
> +
> +<resumable_dir>::
> +	The directory of the partial clone. This could be either the
> +	work directory or the git directory.

I think these should be described this way:

    --resume <resumable_dir>::
            description if what resume option does and how resumable_dir
            is used by the option.

in a single bullet point.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9ac6c01..d9a13dc 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -8,7 +8,9 @@
>   * Clone a repository into a different directory that does not yet exist.
>   */
>  
> +#include "cache.h"
>  #include "builtin.h"

I do not think you need to include cache.h if you are including
builtin.h; Documentation/CodingGuidelines says:

 - The first #include in C files, except in platform specific compat/
   implementations, must be either "git-compat-util.h", "cache.h" or
   "builtin.h".  You do not have to include more than one of these.

> @@ -40,17 +42,20 @@ static const char * const builtin_clone_usage[] = {
>  
>  static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
>  static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
> +static int option_resume;
>  static char *option_template, *option_depth;
> -static char *option_origin = NULL;
> +static const char *option_origin = NULL;

Is this change related to anything you are doing here?

If you are fixing things while at it, please don't ;-) If you really
want to, please also remove " = NULL", from this line and also from
the next line.  Also do not add " = NULL" at the end of alt_res.

>  static char *option_branch = NULL;
>  ...
> +static const struct alt_resource *alt_res = NULL;

> +static char *get_filename(const char *dir)
> +{
> +	char *dir_copy = xstrdup(dir);
> +	strip_trailing_slashes(dir_copy);
> +	char *filename, *final = NULL;
> +
> +	filename = find_last_dir_sep(dir);
> +
> +	if (filename && *(++filename))
> +		final = xstrdup(filename);
> +
> +	free(dir_copy);
> +	return final;
> +}

Hmph, don't we have our own basename(3) lookalike that knows about
dir-sep already?

> @@ -451,6 +475,7 @@ static const char *junk_work_tree;
>  static const char *junk_git_dir;
>  static enum {
>  	JUNK_LEAVE_NONE,
> +	JUNK_LEAVE_RESUMABLE,
>  	JUNK_LEAVE_REPO,
>  	JUNK_LEAVE_ALL
>  } junk_mode = JUNK_LEAVE_NONE;
> @@ -460,6 +485,29 @@ N_("Clone succeeded, but checkout failed.\n"
>     "You can inspect what was checked out with 'git status'\n"
>     "and retry the checkout with 'git checkout -f HEAD'\n");
>  
> +static const char junk_leave_resumable_msg[] =
> +N_("Clone interrupted while copying resumable resource.\n"
> +   "Try using 'git clone --resume <new_directory>',\n"
> +   "where <new_directory> is either the new working \n"
> +   "directory or git directory.\n\n"
> +   "If this does not succeed, it could be because the\n"
> +   "resource has been moved, corrupted, or changed.\n"
> +   "If this is the case, you should remove <new_directory>\n"
> +   "and run the original command.\n");
> +
> +static void write_resumable_resource()
> +{
> +	const char *filename = git_path_resumable();
> +	struct strbuf content = STRBUF_INIT;
> +	strbuf_addf(&content, "%s\n%s\n", alt_res->url, alt_res->filetype);
> +	int fd = open(filename, O_WRONLY | O_CREAT, 0666);
> +	if (fd < 0)
> +		die_errno(_("Could not open '%s' for writing"), filename);
> +	if (write_in_full(fd, content.buf, content.len) != content.len)
> +		die_errno(_("Could not write to '%s'"), filename);
> +	close(fd);
> +}
>
>  static void remove_junk(void)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> @@ -467,7 +515,11 @@ static void remove_junk(void)
>  	switch (junk_mode) {
>  	case JUNK_LEAVE_REPO:
>  		warning("%s", _(junk_leave_repo_msg));
> -		/* fall-through */
> +		return;
> +	case JUNK_LEAVE_RESUMABLE:
> +		write_resumable_resource();
> +		warning("%s", _(junk_leave_resumable_msg));
> +		return;

Nice.

> @@ -562,7 +614,7 @@ static void write_remote_refs(const struct ref *local_refs)
>  		die("%s", err.buf);
>  
>  	for (r = local_refs; r; r = r->next) {
> -		if (!r->peer_ref)
> +		if (!r->peer_ref || ref_exists(r->peer_ref->name))
>  			continue;
>  		if (ref_transaction_create(t, r->peer_ref->name, r->old_oid.hash,
>  					   0, NULL, &err))

What is this change about?


> @@ -820,11 +872,296 @@ static void dissociate_from_references(void)
>  	free(alternates);
>  }
>  
> +static int do_index_pack(const char *in_pack_file, const char *out_idx_file)
> +{
> +	const char *argv[] = { "index-pack", "--clone-bundle", "-v",
> +			       "--check-self-contained-and-connected", "-o",
> +			       out_idx_file, in_pack_file, NULL };
> +	return run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDOUT);
> +}

That looks vaguely familiar ;-)

> +static const char *setup_and_index_pack(const char *filename)
> +{
> +	const char *primer_idx_path = NULL, *primer_bndl_path = NULL;
> +	primer_idx_path = replace_extension(filename, ".pack", ".idx");
> +	primer_bndl_path = replace_extension(filename, ".pack", ".bndl");
> +
> +	if (!(primer_idx_path && primer_bndl_path)) {
> +		warning("invalid pack filename '%s', falling back to full "
> +			"clone", filename);
> +		return NULL;
> +	}
> +
> +	if (!file_exists(primer_bndl_path)) {
> +		if (do_index_pack(filename, primer_idx_path)) {
> +			warning("could not index primer pack, falling back to "
> +				"full clone");
> +			return NULL;
> +		}
> +	}

Can it be another (undetected) failure mode that .bndl somehow
already existed, but not .idx, leaving the resulting object store in
an incosistent state?  Can do_index_pack() fail and leave .bndl
behind to get you into such a state?

> +static int write_bundle_refs(const char *bundle_filename)
> +{
> +	struct ref_transaction *t;
> +	struct bundle_header history_tips;
> +	const char *temp_ref_base = "resume";
> +	struct strbuf err = STRBUF_INIT;
> +	int i;
> +
> +	init_bundle_header(&history_tips, bundle_filename);
> +	read_bundle_header(&history_tips);
> +
> +	t = ref_transaction_begin(&err);
> +	for (i = 0; i < history_tips.references.nr; i++) {
> +		struct strbuf ref_name = STRBUF_INIT;
> +		strbuf_addf(&ref_name, "refs/temp/%s/%s/temp-%s",
> +			    option_origin, temp_ref_base,
> +			    sha1_to_hex(history_tips.references.list[i].sha1));

Can we do this without polluting refs/temp/ namespace?

I am imagining that you are first fetching the .pack file from
sideways when primer service is available, running index-pack on it
to produce the bundle, and the step after that is to run "git fetch"
against the original remote to fill the gap between the bit-stale
history you got in the bundle and the reality that has progressed
since the primer pack was made, and you need a way to tell to the
other end that you already have the history leading to these refs
when you run "git fetch".  I think a bit better way to do so is to
send these has ".have" while you run the "fetch".

Wouldn't it do if you add the "--advertise-bundle-tips=<bndl>"
option to "git fetch", move the code to read the bundle header to
it, and point the bundle's filename with the option when you spawn
"git fetch"?
