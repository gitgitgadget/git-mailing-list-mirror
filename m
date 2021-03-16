Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCA9C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74B764F90
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhCPVyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:54:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:38938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhCPVyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:54:33 -0400
Received: (qmail 21593 invoked by uid 109); 16 Mar 2021 21:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 21:54:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2363 invoked by uid 111); 16 Mar 2021 21:54:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 17:54:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 17:54:32 -0400
From:   Jeff King <peff@peff.net>
To:     SURA via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, SURA <sura907@hotmail.com>
Subject: Re: [PATCH] builtin/fetch.c: clean tmp pack after receive signal
Message-ID: <YFEpGGLBgLSdR40V@coredump.intra.peff.net>
References: <pull.890.git.1615863217226.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.890.git.1615863217226.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 02:53:36AM +0000, SURA via GitGitGadget wrote:

> In Gitee.com, I often use scripts to start a time-limited

Not related to your patch, but I think this name falls afoul of Git's
trademark policy. See:

  https://git-scm.com/trademark

There's also some discussion in this thread:

  https://lore.kernel.org/git/20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net/

> "git fetch". When the execution time of'git fetch' is too
> long, send a signal (such as SIGINT) to the'git fetch' process
> 
> But I found that after the process exits, there are some
> files in the format of 'objects/pack/tmp_pack_XXXXXX' on the disk.
> They are usually very large (some of them exceed 5G), and'git gc'
> has no effect on them.

This isn't quite true. "git gc" will clean up the temporary files, but
only if the mtime is sufficiently old. The purpose here is to give a
grace period to avoid deleting a file that is actively being written to.
However, we use the same grace period that we use for deleting
unreachable objects, which is absurdly long for this purpose: 2 weeks.
Probably something like an hour would be more appropriate (since the
mtime is updated on each write, this would imply a process not making
forward progress).

That said...

> Obviously this is only a temporary solution, I think it should be fixed from git
> 
> I found fetch will start a 'index-pack' sub-process, this sub-process
> create the tmp_pack
>   1. make 'index-pack' unlink tmp_pack when get signal
>   2. make 'fetch' send signal to 'index-pack' when get signal

I do think this is worth doing. One of the reasons we haven't
traditionally cleaned up temporary packfiles is that the failed state is
sometimes useful for analyzing what went wrong, or even recovering
partial data. But that probably should not be the default mode of
operation (i.e., a config option or environment variable should probably
be able to turn it on for debugging).

Looking at the implementation itself...

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0b90de87c7a2..a87efa23ceb5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -224,8 +224,18 @@ static void unlock_pack(void)
>  		transport_unlock_pack(gsecondary);
>  }
>  
> +static void send_signo_to_index_pack(int signo)
> +{
> +	if (gtransport && gtransport->index_pack_pid > 0)
> +		kill(gtransport->index_pack_pid, signo);
> +
> +	if (gsecondary && gsecondary->index_pack_pid > 0)
> +		kill(gsecondary->index_pack_pid, signo);
> +}
> +
>  static void unlock_pack_on_signal(int signo)
>  {
> +	send_signo_to_index_pack(signo);
>  	unlock_pack();
>  	sigchain_pop(signo);
>  	raise(signo);

We'd probably want to also trigger this if we just hit die(), I'd think.
We have a system for killing process children when we exit unexpectedly.
I think just setting the "clean_on_exit" flag on the index-pack
child_process struct would turn this into a one-liner.

Likewise, we'd probably want to do this from receive-pack, too (so that
pushes don't accumulate temporary packfiles on the receiving side).

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index bad57488079c..27d1ebba746e 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> [...]
> +static void remove_tmp_pack(void)
> +{
> +	if (tmp_pack_name) 
> +		unlink_or_warn(tmp_pack_name);
> +}
> +
> +static void remove_tmp_pack_on_signal(int signo)
> +{
> +	remove_tmp_pack();
> +	sigchain_pop(signo);
> +	raise(signo);
> +}

Likewise, we have a tempfile cleanup system already.

I think this hunk:

> @@ -336,6 +339,7 @@ static const char *open_pack_file(const char *pack_name)
>  			output_fd = odb_mkstemp(&tmp_file,
>  						"pack/tmp_pack_XXXXXX");
>  			pack_name = strbuf_detach(&tmp_file, NULL);
> +			tmp_pack_name = pack_name;

...can just call register_tempfile(). It should also record the result
so that we don't try to unlink() it after we've already moved it away
from its temporary name (though it's fairly unlikely for somebody else
to have used the name in the interim).

I think you'd want to do the same for the tmp_idx_* files, too. Likewise
for ".rev" files we create starting in v2.31.

I think it would also make sense in create_tmp_packfile(), which is used
during repacking (a different problem space, but really the same thing:
if repacking fails for some reason, we probably shouldn't leave a
useless gigantic half-finished packfile on disk).

We should possibly also do so for tmp_obj_* files. Those can be written
for a fetch or push via unpack-objects (as well as normal local
commands). They're not usually as big as a pack, obviously, but I think
the same principle applies.

> [...]

It would be nice to see some tests covering this functionality, too.
Reproducing it with signals is likely to be racy and not worth it. But I
think that right now index-pack reading a bogus pack (say, one that
fails fsck checks) will leave the tmp_pack_* on disk. And it would not
if we cleanup tempfiles (again, this would be on any exit, not just
signal death, but I think that is what we'd want, and also what
register_tempfile() will do).

-Peff
