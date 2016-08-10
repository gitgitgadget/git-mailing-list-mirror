Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9E51F859
	for <e@80x24.org>; Wed, 10 Aug 2016 03:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbcHJDhR (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 23:37:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932550AbcHJDhR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 23:37:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93D8734AC8;
	Tue,  9 Aug 2016 23:37:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ouRACXMvt25gQV/Ozxq0h10SJg=; b=dUTzjn
	BDSErY3fQdL/piiJCoMIClti6j2jiXdQdbw3MOTYEiGIgx6N3fyBnh1CWTzH328t
	SvFCIWR4ts1IBwJtuGBNDMI16sktV+iCs0A0hAfa2BTFc6RiH5EYRLnUvGtN+iVX
	jP8c/n9rrtqhGWbgynJ3mrhS9yJ7OIaIG0oQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qRy6qrdt21iekwqXvnJrZbpntrR+larf
	DOFd71I0RHiqFbsuE/G//l9Ksf3KQmMuATHeLarhdzrSHqpAJ76J9HoVzG4zYVJ1
	+WcjAvvLJSq9UW4rmnjQB0v21UEcASBYVxieKAGv9O9g4J1xHdfVzXnEUIs1ynRf
	yh8f/bFFNR4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CD7C34AC7;
	Tue,  9 Aug 2016 23:37:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 048B834AC6;
	Tue,  9 Aug 2016 23:37:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH RFC v2] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160810002315.25236-1-jacob.e.keller@intel.com>
Date:	Tue, 09 Aug 2016 20:37:13 -0700
In-Reply-To: <20160810002315.25236-1-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Tue, 9 Aug 2016 17:23:15 -0700")
Message-ID: <xmqqtwet70ra.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAFD3CA0-5EAB-11E6-AB50-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> +void show_submodule_diff(FILE *f, const char *path,
> +		const char *line_prefix,
> +		unsigned char one[20], unsigned char two[20],
> +		unsigned dirty_submodule, const char *meta,
> +		const char *reset)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf submodule_git_dir = STRBUF_INIT;
> +	const char *git_dir, *message = NULL;
> +	int create_dirty_diff = 0;
> +	FILE *diff;
> +	char c;
> +
> +	if ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
> +	    (dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
> +		create_dirty_diff = 1;
> +
> +	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
> +			find_unique_abbrev(one, DEFAULT_ABBREV));
> +	strbuf_addf(&sb, "%s:%s\n", !create_dirty_diff ?
> +		    find_unique_abbrev(two, DEFAULT_ABBREV) : "", reset);
> +	fwrite(sb.buf, sb.len, 1, f);
> +
> +	strbuf_addf(&submodule_git_dir, "%s/.git", path);
> +	git_dir = read_gitfile(submodule_git_dir.buf);
> +	if (!git_dir)
> +		git_dir = submodule_git_dir.buf;
> +	if (!is_directory(git_dir)) {
> +		strbuf_reset(&submodule_git_dir);
> +		strbuf_addf(&submodule_git_dir, ".git/modules/%s", path);
> +		git_dir = submodule_git_dir.buf;
> +	}
> +
> +	cp.git_cmd = 1;
> +	if (!create_dirty_diff)
> +		cp.dir = git_dir;
> +	else
> +		cp.dir = path;
> +	cp.out = -1;
> +	cp.no_stdin = 1;
> +	argv_array_push(&cp.args, "diff");
> +	argv_array_pushf(&cp.args, "--src-prefix=a/%s/", path);
> +	argv_array_pushf(&cp.args, "--dst-prefix=b/%s/", path);

I think this is wrong.  Imagine when the caller gave you prefixes
that are different from a/ and b/ (think: the extreme case is that
you are a sub-sub-module, and the caller is recursing into you with
its own prefix, perhaps set to a/sub and b/sub).  Use the prefixes
you got for a/ and b/ instead of hardcoding them and you'd be fine,
I'd guess.

> +	argv_array_push(&cp.args, sha1_to_hex(one));
> +
> +	/*
> +	 * If the submodule has untracked or modified contents, diff between
> +	 * the old base and the current tip. This had the advantage of showing
> +	 * the full difference of the submodule contents.
> +	 */
> +	if (!create_dirty_diff)
> +		argv_array_push(&cp.args, sha1_to_hex(two));
> +
> +	if (start_command(&cp))
> +		die("Could not run 'git diff' command in submodule %s", path);
> +
> +	diff = fdopen(cp.out, "r");
> +
> +	c = fgetc(diff);
> +	while (c != EOF) {
> +		fputc(c, f);
> +		c = fgetc(diff);
> +	}
> +
> +	fclose(diff);
> +	finish_command(&cp);

I do not think you need to do this.  If "f" is already a FILE * to
which the output must go, then instead of reading from the pipe and
writing it, you can just let the "diff" spit out its output to the
same file descriptor, by doing something like:

	fflush(f);
        cp.out = dup(fileno(f));
        ... other setup ...
        run_command(&cp);

no?  I do not offhand recall run_command() closes cp.out after done,
and if it doesn't you may have to close it yourself after the above
sequence.

While I personally do not want to see code to access submodule's
object store by temporarily adding it as alternates, the "show
left-right log between the commits" code already does so, so I
should point out that running "diff" internally without spawning it
as a subprocess shouldn't be too hard.  The diff API is reasonably
libified and there shouldn't be additional "libification" preparation
work required to do this, if you really wanted to.
