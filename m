Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1241FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 10:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422754AbdD1KQb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 06:16:31 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:5917 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939018AbdD1KQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 06:16:28 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Apr 2017 06:16:28 EDT
Received: from [192.168.2.201] ([92.22.34.197])
        by smtp.talktalk.net with SMTP
        id 42oxddMqyHGLw42oxdwWkQ; Fri, 28 Apr 2017 11:08:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1493374096; bh=8xBbCkcyCW0Daz2QWpyfEU6sXQa3ITE7iGNhWIg9Y+0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DafZUyfN2ci30JZ8mO5+affo5R7CejWdlGqcV6hw7klkMt+99YlZHaAC4f0iK90LJ
         Ps5j/1GQUy4eYujeUMbu+5qSOAWKK4iHUdIWY90Gy+PmqVwkeKR/fG8yeKEAadaijj
         Z3UpFLBY51z3FbYTrJehrXUB3TQUZGC+EIldwsRg=
X-Originating-IP: [92.22.34.197]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=hA2HGApHRYQPBHGSl800fg==:117
 a=hA2HGApHRYQPBHGSl800fg==:17 a=IkcTkHD0fZMA:10 a=eo8JNWxsu0E-LZbjFUQA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
 <cover.1493207864.git.johannes.schindelin@gmx.de>
 <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net>
Date:   Fri, 28 Apr 2017 11:08:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGMraC0zGOkBytJfjDE8UDaToRChYoV4rUMAowQ1cKf5KQmIDIoqZwrXEW7IvF7gMo1f3/MGkd8BTJjWNcxUYuu+8lJpwZbBkrn283AlVwMLsHwYnvYA
 ZUiM1vf6O19+brP0z9JBJOBm6DXBENjAreGQJCmVVS2CpBnkIG87OZi3aK4CX0PR+13C/JY6FQ3MUPvxxEvz6iB/WkKwURcMgfeFUMlXkgGpcpUS8yc9juh4
 g7RWMrKGKIzircE/wOuFqK8z9P/YQMLpsVJ5HmqZONTq39AYHZW3nLh6q6ufRWi6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/04/17 12:59, Johannes Schindelin wrote:
> The first step of an interactive rebase is to generate the so-called "todo
> script", to be stored in the state directory as "git-rebase-todo" and to
> be edited by the user.
> 
> Originally, we adjusted the output of `git log <options>` using a simple
> sed script. Over the course of the years, the code became more
> complicated. We now use shell scripting to edit the output of `git log`
> conditionally, depending whether to keep "empty" commits (i.e. commits
> that do not change any files).
> 
> On platforms where shell scripting is not native, this can be a serious
> drag. And it opens the door for incompatibilities between platforms when
> it comes to shell scripting or to Unix-y commands.
> 
> Let's just re-implement the todo script generation in plain C, using the
> revision machinery directly.
> 
> This is substantially faster, improving the speed relative to the
> shell script version of the interactive rebase from 2x to 3x on Windows.
> 
> Note that the rearrange_squash() function in git-rebase--interactive
> relied on the fact that we set the "format" variable to the config setting
> rebase.instructionFormat. Relying on a side effect like this is no good,
> hence we explicitly perform that assignment (possibly again) in
> rearrange_squash().
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase--helper.c   |  8 +++++++-
>  git-rebase--interactive.sh | 44 +++++++++++++++++++++++---------------------
>  sequencer.c                | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  sequencer.h                |  3 +++
>  4 files changed, 78 insertions(+), 22 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 77afecaebf0..e858a976279 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2388,3 +2388,48 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  
>  	strbuf_release(&sob);
>  }
> +
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv)
> +{
> +	char *format = xstrdup("%s");
> +	struct pretty_print_context pp = {0};
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rev_info revs;
> +	struct commit *commit;
> +
> +	init_revisions(&revs, NULL);
> +	revs.verbose_header = 1;
> +	revs.max_parents = 1;
> +	revs.cherry_pick = 1;
> +	revs.limited = 1;
> +	revs.reverse = 1;
> +	revs.right_only = 1;
> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> +	revs.topo_order = 1;
> +
> +	revs.pretty_given = 1;
> +	git_config_get_string("rebase.instructionFormat", &format);

Firstly thanks for all your work on speeding up rebase -i, it definitely
feels faster.

This changes the behaviour of
git -c rebase.instructionFormat= rebase -i
The shell version treats the rebase.instructionFormat being unset or set
to the empty string as equivalent. This version generates a todo list
with lines like 'pick <abbrev sha1>' rather than 'pick <abbrev sha1>
<subject>'

I only picked this up because I have a script that does 'git -c
rebase.instructionFormat= rebase -i' with a custom sequence editor. I
can easily add '%s' in the appropriate place but I thought I'd point it
out in case other people are affected by the change.

Please CC me in any replies as I'm not subscribed to this list

Best Wishes

Phillip

> +	get_commit_format(format, &revs);
> +	free(format);
> +	pp.fmt = revs.commit_format;
> +	pp.output_encoding = get_log_output_encoding();
> +
> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		return error(_("make_script: unhandled options"));
> +
> +	if (prepare_revision_walk(&revs) < 0)
> +		return error(_("make_script: error preparing revisions"));
> +
> +	while ((commit = get_revision(&revs))) {
> +		strbuf_reset(&buf);
> +		if (!keep_empty && is_original_commit_empty(commit))
> +			strbuf_addf(&buf, "%c ", comment_line_char);
> +		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
> +		pretty_print_commit(&pp, commit, &buf);
> +		strbuf_addch(&buf, '\n');
> +		fputs(buf.buf, out);
> +	}
> +	strbuf_release(&buf);
> +	return 0;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index f885b68395f..83f2943b7a9 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -45,6 +45,9 @@ int sequencer_continue(struct replay_opts *opts);
>  int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv);
> +
>  extern const char sign_off_header[];
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
> 

