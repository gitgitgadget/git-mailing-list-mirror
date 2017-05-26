Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB563209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946756AbdEZDPu (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:15:50 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36674 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163487AbdEZDPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:15:36 -0400
Received: by mail-it0-f67.google.com with SMTP id i206so410469ita.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0mAuHo5ey5NPhKn4Wbe3rW1IRpQnhHkPOxFl2y4V5E=;
        b=FDqv8bEPUKm9hMEy8/L8Z15t6umbXiGPbs/EOBbQaZIyc7IWlSAmw/ACpRGTar8Eug
         zz1XAZ22BYcM9iHb2huO7eEVwT7yy8Z8v+Wl8QClidpIQj1bsKO1dAvg0n3EAl2rc2Pr
         jTBpnOUDVvCA5P5n6Nh88RpX3/UvjWYCiFVuv6DmhdUc7b9z727UDw51BxoKZqf8ek9M
         K/m8J16x7RyaBsYsPvtR0+VRqxdqdaz5YWSB818mndXsFMYcgBe1ueeSxbsFdQikhj1W
         SbAQw/TA0YQRjrTGast9kS0n0kgEL/qVYoLvepxwM1H22GhsiwZbbWL/E+3sDc2orYyu
         5oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0mAuHo5ey5NPhKn4Wbe3rW1IRpQnhHkPOxFl2y4V5E=;
        b=Dh11Vp78N1HliQyRsXp5zTn5B8S6/ZfxaP62OWt8NIMgHorOobxinZlppKbRXh7vrV
         uwIa47daYs66/YKy5hjdzX8Xbse0B9TD+V6nK/sd9F8rXDF3qzgnYSiEnmWvB9bemRrj
         qwn7iBZQmNx8KsloUj0r8iZaUttBZSACXKMcyLQaK1beVsI7C7n3/AeHbbla+Mpw/Jf/
         Rlfhnf2Jc25FwaGla9yS2F2OqITXMmAilfj1IjTRfOVl3uoPC2SSXPll7yMFAsPG1zM1
         QBTtetb3EqTT4XV4d/mboUIyxhRb/lCe4+ApHY69ihYH3y41+VRRKMYi8xjg5nrCtcVj
         6N0g==
X-Gm-Message-State: AODbwcAOFR0o6q5JhI2g1u8x3OJZb9hsoEhPI27dNhC8EyCWwxgSsZ+W
        uPyrTJvp/YGabg==
X-Received: by 10.36.105.13 with SMTP id e13mr11246697itc.64.1495768535684;
        Thu, 25 May 2017 20:15:35 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id u135sm4104788itu.10.2017.05.25.20.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 20:15:35 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
Subject: [PATCH v4 05/10] rebase -i: also expand/collapse the SHA-1s via the rebase--helper
Date:   Thu, 25 May 2017 23:15:30 -0400
Message-Id: <20170526031530.29162-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <6cf1bcd39672474230b179a3d12c5eeab353ae0c.1493414945.git.johannes.schindelin@gmx.de>
References: <6cf1bcd39672474230b179a3d12c5eeab353ae0c.1493414945.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> This is crucial to improve performance on Windows, as the speed is now
> mostly dominated by the SHA-1 transformation (because it spawns a new
> rev-parse process for *every* line, and spawning processes is pretty
> slow from Git for Windows' MSYS2 Bash).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase--helper.c   | 10 +++++++-
>  git-rebase--interactive.sh | 27 ++--------------------
>  sequencer.c                | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  sequencer.h                |  2 ++
>  4 files changed, 70 insertions(+), 26 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index 821058d452d..9444c8d6c60 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -13,7 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
>  	int keep_empty = 0;
>  	enum {
> -		CONTINUE = 1, ABORT, MAKE_SCRIPT
> +		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -24,6 +24,10 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  				ABORT),
>  		OPT_CMDMODE(0, "make-script", &command,
>  			N_("make rebase script"), MAKE_SCRIPT),
> +		OPT_CMDMODE(0, "shorten-sha1s", &command,
> +			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
> +		OPT_CMDMODE(0, "expand-sha1s", &command,
> +			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),

Since work is being done to convert to `struct object_id` would it
not be best to use a more generic name instead of 'sha1'?
maybe something like {shorten,expand}-hashs

>  		OPT_END()
>  	};
>  
> @@ -42,5 +46,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!sequencer_remove_state(&opts);
>  	if (command == MAKE_SCRIPT && argc > 1)
>  		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
> +	if (command == SHORTEN_SHA1S && argc == 1)
> +		return !!transform_todo_ids(1);
> +	if (command == EXPAND_SHA1S && argc == 1)
> +		return !!transform_todo_ids(0);
>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 214af0372ba..82a1941c42c 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -750,35 +750,12 @@ skip_unnecessary_picks () {
>  		die "$(gettext "Could not skip unnecessary pick commands")"
>  }
>  
> -transform_todo_ids () {
> -	while read -r command rest
> -	do
> -		case "$command" in
> -		"$comment_char"* | exec)
> -			# Be careful for oddball commands like 'exec'
> -			# that do not have a SHA-1 at the beginning of $rest.
> -			;;
> -		*)
> -			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
> -			if test "a$rest" = "a${rest#*[	 ]}"
> -			then
> -				rest=$sha1
> -			else
> -				rest="$sha1 ${rest#*[	 ]}"
> -			fi
> -			;;
> -		esac
> -		printf '%s\n' "$command${rest:+ }$rest"
> -	done <"$todo" >"$todo.new" &&
> -	mv -f "$todo.new" "$todo"
> -}
> -
>  expand_todo_ids() {
> -	transform_todo_ids
> +	git rebase--helper --expand-sha1s
>  }
>  
>  collapse_todo_ids() {
> -	transform_todo_ids --short
> +	git rebase--helper --shorten-sha1s
>  }
>  
>  # Rearrange the todo list that has both "pick sha1 msg" and
> diff --git a/sequencer.c b/sequencer.c
> index 88819a1a2a9..201d45b1677 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2437,3 +2437,60 @@ int sequencer_make_script(int keep_empty, FILE *out,
>  	strbuf_release(&buf);
>  	return 0;
>  }
> +
> +
> +int transform_todo_ids(int shorten_sha1s)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int fd, res, i;
> +	FILE *out;
> +
> +	strbuf_reset(&todo_list.buf);
> +	fd = open(todo_file, O_RDONLY);
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), todo_file);
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		return error(_("could not read '%s'."), todo_file);
> +	}
> +	close(fd);
> +
> +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
> +	if (res) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable instruction sheet: '%s'"), todo_file);

As you pointed out last time, the name of the "todo script" can be a
source of confusion. The migration to C could be a good opportunity to
clarify this.
I don't know which is the preferred name but we could go with
"todo list" as it is the most common across the code base.

$ git grep  'todo[ -]list' | wc -l
20
$ git grep  'rebase[ -]script' | wc -l
0
$ git grep  'instruction[ -]list' | wc -l
1
$ git grep  'instruction[ -]sheet' | wc -l
20
$ git grep  'instruction[ -]sheet' | grep -v ^po | wc -l
8

> +	}
> +
> +	out = fopen(todo_file, "w");
> +	if (!out) {
> +		todo_list_release(&todo_list);
> +		return error(_("unable to open '%s' for writing"), todo_file);
> +	}
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct todo_item *item = todo_list.items + i;
> +		int bol = item->offset_in_buf;
> +		const char *p = todo_list.buf.buf + bol;
> +		int eol = i + 1 < todo_list.nr ?
> +			todo_list.items[i + 1].offset_in_buf :
> +			todo_list.buf.len;
> +
> +		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
> +			fwrite(p, eol - bol, 1, out);
> +		else {
> +			const char *sha1 = shorten_sha1s ?
> +				short_commit_name(item->commit) :
> +				oid_to_hex(&item->commit->object.oid);

We could also use 'hash' or 'ids' here instead of 'sha1'.

> +			int len;
> +
> +			p += strspn(p, " \t"); /* left-trim command */
> +			len = strcspn(p, " \t"); /* length of command */
> +
> +			fprintf(out, "%.*s %s %.*s\n",
> +				len, p, sha1, item->arg_len, item->arg);
> +		}
> +	}
> +	fclose(out);
> +	todo_list_release(&todo_list);
> +	return 0;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index 83f2943b7a9..47a81034e76 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -48,6 +48,8 @@ int sequencer_remove_state(struct replay_opts *opts);
>  int sequencer_make_script(int keep_empty, FILE *out,
>  		int argc, const char **argv);
>  
> +int transform_todo_ids(int shorten_sha1s);
> +
>  extern const char sign_off_header[];
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
> -- 
> 2.12.2.windows.2.800.gede8f145e06

Liam
