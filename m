Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A373C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3701520872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 22:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vK46rSDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgJGWTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 18:19:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51076 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJGWTy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 18:19:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 202ED8EA62;
        Wed,  7 Oct 2020 18:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=omzCrnUOnMdQnHzVQs8H0H5Zzwc=; b=vK46rS
        DW9eshTJJogwU2SpdL43JG3H2QINEX6Knc1106HZvCoTUqp65Vm8BstFlds0jzLI
        GBYtBmeJFbtWn0zjZMuwdvIuqOES6Po1wp5PbRT2N3GcaG4jDVhkjoLwiKw4J2sx
        h0zcUYpW6zdLBwe9gbNvm+NhZHI1c7xpHjsAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k0vwZcRun8MF79Q9hmLhS8imbLbBG7NU
        RexDxL+smSG9Aoi051S/umkN2kwiZB8rhYH/epLRTzC97d56Wf6ZOD8EBtOd75fA
        cMdi3yyNwKgqzsNMI9Qit4AIl8GVXinwFYO6DZxflwboQZpnTIK/8sY4lf4B+zMI
        qieCXZgjtTY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 161AF8EA61;
        Wed,  7 Oct 2020 18:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82C598EA5C;
        Wed,  7 Oct 2020 18:19:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from
 shell to C
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
        <20201007074538.25891-3-shouryashukla.oo@gmail.com>
Date:   Wed, 07 Oct 2020 15:19:46 -0700
In-Reply-To: <20201007074538.25891-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 7 Oct 2020 13:15:37 +0530")
Message-ID: <xmqqo8ldznjx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35A9EC08-08EB-11EB-AC7E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> +static void fprintf_submodule_remote(const char *str)

The fact that the helper happens to use fprintf() to do its job is
much less important than it writes to the standard error stream.
Name it after what it does than how it does so.  Is there a word
that explains at a higher-level concept than "print to stderr" that
this function tries to achieve?  

Same question for the name of the only caller of this function,
modify_remote_v().  That name does not mean anything to readers
other than that it futz with output from "remote -v" command, which
is the least interesting piece of information.  What does it try to
achieve by using "remote -v"?  Can we name the function after that?

> +{
> +	const char *p = str;
> +	const char *start;
> +	const char *end;
> +	char *name, *url;
> +
> +	start = p;
> +	while (*p != ' ')
> +		p++;
> +	end = p;
> +	name = xstrndup(start, end - start);
> +	while(*p == ' ')
> +		p++;

Perhaps make a small helper out of these seven lines, so that the
caller can say something like

    p = str;
    name = parse_token(&p);
    url = parse_token(&p);

This one you should be able to do without any extra allocation,
though.  Just write a parse_token() that finds start and length,
prepare "char *name; int namelen" and the same pair for URL,
and then

	fprintf(stderr, "  %.*s\t%.*s\n",
		namelen, name, urllen, url);

> +	fprintf(stderr, "  %s\t%s\n", name, url);
> +	free(name);
> +	free(url);
> +}

> +static int check_sm_exists(unsigned int force, const char *path) {
> +
> +	int cache_pos, dir_in_cache = 0;

Have a blank line here to separate decl and the first statement.

> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
> +	cache_pos = cache_name_pos(path, strlen(path));
> +	if(cache_pos < 0 && (directory_exists_in_index(&the_index,
> +	   path, strlen(path)) == index_directory))
> +		dir_in_cache = 1;

Funny line wrapping.  Try to cut long line at an operator as close
to the root of the parse tree (in this case, &&) as possible, i.e.

	if (cache_pos < 0 &&
	    directory_exists_in_index(&the_index, path, strlen(path)) == index_directory)

It is OK to further wrap after == if the second line bothers you.

A bigger question.  Can the path be a regular file but at a higher
stage because we are in the middle of a conflicted merge?  We'd get
cache_pos that is negative in that case, too, and we definitely would
want to say the path already exists in the index in such a case, but ...

> +
> +	if (!force) {
> +		if (cache_pos >= 0 || dir_in_cache)
> +			die(_("'%s' already exists in the index"), path);

... the current code may not trigger this die() in such a case, no?

> +	} else {
> +		struct cache_entry *ce = NULL;
> +		if (cache_pos >= 0)
> +			ce = the_index.cache[cache_pos];
> +		if (dir_in_cache || (ce && !S_ISGITLINK(ce->ce_mode)))
> +			die(_("'%s' already exists in the index and is not a "
> +			      "submodule"), path);

Likewise here.  cache_pos < 0 does not automatically mean it does
not exist.  It tells you that it does not exist as a merged entry.

> +	}
> +	return 0;
> +}
> +
> +static void modify_remote_v(struct strbuf *sb)

This roughly corresponds to this part of the original

    grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',,

I actualy would suggest moving the "git remote -v" invocation and
capturing of its output to this helper function and name it after
what it does, which seems to be "show fetch remotes" to me.

> +{
> +	int i;
> +	for (i = 0; i < sb->len; i++) {
> +		const char *start = sb->buf + i;
> +		const char *end = start;
> +		while (sb->buf[i++] != '\n')
> +			end++;
> +		if (!strcmp("fetch", xstrndup(end - 6, 5)))

The original makes sure the 'fetch' appears inside "()" but this
does not.  Any reason why we want to do it differently?

> +			fprintf_submodule_remote(xstrndup(start, end - start - 7));

The result of xstrndup() is leaking here.

In any case, with a helper function like parse_token() suggested
before, you can get rid of the fprintf_submodule_remote() helper and
open code it here, without any temporary allocation and freeing.
You'd have the start of each line of "git remote -v" output (so you
know where it starts and it ends), and a parser that roughly does
this:

	/*
	 * cp points at the current location, and ep points the
	 * end of the buffer.  find the tail of the current string
	 * and store its length in *len, skip over whitespaces and
	 * return the location to be used as the new cp.
	 */
	const char *parse_token(char *cp, char *ep, int *len);

and make the latter half of this function (former half would be
spawning "remote -v" and capturing its output in sb) a loop whose
body may look like

	{
		char *end, *name, *url, *tail;
		int namelen, urllen;

		end = strchrnul(start, '\n');
		name = start;
		url = parse_token(name, end, &namelen);
		tail = parse_token(url, end, &urllen);
		if (!memcmp(tail, "(fetch)", 7))
			fprintf(stderr, ...); /* see above */
		start = *end ? end + 1 : end;
	}

> +static int add_submodule(struct add_data *info)
> +{
> +	/* perhaps the path exists and is already a git repo, else clone it */
> +	if (is_directory(info->sm_path)) {
> +		char *sub_git_path = xstrfmt("%s/.git", info->sm_path);
> +		if (is_directory(sub_git_path) || file_exists(sub_git_path))
> +			printf(_("Adding existing repo at '%s' to the index\n"),
> +				 info->sm_path);
> +		else
> +			die(_("'%s' already exists and is not a valid git repo"),
> +			      info->sm_path);
> +		free(sub_git_path);
> +	} else {
> +		struct strvec clone_args = STRVEC_INIT;
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		char *submodule_git_dir = xstrfmt(".git/modules/%s", info->sm_name);
> +
> +		if (is_directory(submodule_git_dir)) {
> +			if (!info->force) {

As I said, it would be a better organization to have a helper
function that does what is done from here ...

> +				struct child_process cp_rem = CHILD_PROCESS_INIT;
> +				struct strbuf sb_rem = STRBUF_INIT;
> +				cp_rem.git_cmd = 1;
> +				fprintf(stderr, _("A git directory for '%s' is "
> +					"found locally with remote(s):\n"),
> +					info->sm_name);
> +				strvec_pushf(&cp_rem.env_array,
> +					     "GIT_DIR=%s", submodule_git_dir);
> +				strvec_push(&cp_rem.env_array, "GIT_WORK_TREE=.");
> +				strvec_pushl(&cp_rem.args, "remote", "-v", NULL);
> +				if (!capture_command(&cp_rem, &sb_rem, 0)) {
> +					modify_remote_v(&sb_rem);
> +				}

... up to here.  Can you say what the purpose of that helper
function?  I'd say it is for a given git repository (specified by
submodule_git_dir, which we will pass as the parameter to that
helper), report the names and URLs of fetch remotes defined in that
repository.  So, perhaps its signature might be:

	static void report_fetch_remotes(FILE *output, const char *git_dir);

where we would make a call to it from here like so:

				report_fetch_remotes(stderr, submodule_git_dir);

> +				error(_("If you want to reuse this local git "
> +				      "directory instead of cloning again from\n "
> +				      "  %s\n"
> +				      "use the '--force' option. If the local "
> +				      "git directory is not the correct repo\n"
> +				      "or you are unsure what this means choose "
> +				      "another name with the '--name' option."),
> +				      info->realrepo);
> +				return 1;
> +			} else {
> +				printf(_("Reactivating local git directory for "
> +					 "submodule '%s'."), info->sm_path);
> +			}
> +		}
> +		free(submodule_git_dir);

I think I've reviewed up to this point this time around.

Thanks.

