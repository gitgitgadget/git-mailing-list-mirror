From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] sequencer: factor code out of revert builtin
Date: Sat, 5 Nov 2011 19:12:32 -0500
Message-ID: <20111106001232.GC27272@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:12:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqLw-00026q-M7
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab1KFAMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 20:12:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45159 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab1KFAMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 20:12:42 -0400
Received: by ywf7 with SMTP id 7so3892461ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6yF/MkYph1hV9hbGF9qy9+y4bIuXsm7BvLpC9YIqnhc=;
        b=KTQOQMxU5/zjmhLiCAPNCC33Unnwq9XBV7AMt8BFd9xGCi6+k+WeB//5/BuL9ro/Op
         ANmPCaH9dwO+67evwm3Y4CnN4GTWXKhO+1sbd9kJfBcRWGMDn7i6UUqmwRLzs+spWvCI
         4fbTNsA+J4R8ACKOMhTVwBZZ33a3iaDrPat2s=
Received: by 10.50.188.225 with SMTP id gd1mr26506060igc.50.1320538361681;
        Sat, 05 Nov 2011 17:12:41 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a2sm3402401igj.7.2011.11.05.17.12.40
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 17:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320510586-3940-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184883>

Ramkumar Ramachandra wrote:

> Start building the generalized sequencer by moving code from revert.c
> into sequencer.c and sequencer.h.  Make the builtin responsible only
> for command-line parsing, and expose a new sequencer_pick_revisions()
> to do the actual work of sequencing commits.
>
> This is intended to be almost a pure code movement patch with no
> functional changes.  Check with:

Do I understand correctly that the purpose of this patch is to expose
some functions through the "sequencer.h" API, which patches later in
the series will use?  Which functions?  What is this generalized
sequencer which we are starting to build?  Why should I be happy about
(or care about, for that matter) code having moved from one source
file to another?

Rule of thumb for commit messages: after reading a commit message, I
should be able to predict what the patch will do, without reading the
patch.

I am guessing the above description started sane and then went through
a few revisions without a person reading it all the way through again.
Please consider just rewriting it.

[...]
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -1,19 +1,9 @@
>  #include "cache.h"
>  #include "builtin.h"
> -#include "object.h"
> -#include "commit.h"
> -#include "tag.h"
> -#include "run-command.h"
> -#include "exec_cmd.h"
> -#include "utf8.h"
>  #include "parse-options.h"
> -#include "cache-tree.h"
>  #include "diff.h"
>  #include "revision.h"
>  #include "rerere.h"
> -#include "merge-recursive.h"
> -#include "refs.h"
> -#include "dir.h"
>  #include "sequencer.h"

Hoorah!

[snipping lots of deletion of code from builtin/revert.c]
> @@ -1011,7 +194,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>  	opts.action = REPLAY_REVERT;
>  	git_config(git_default_config, NULL);
>  	parse_args(argc, argv, &opts);
> -	res = pick_revisions(&opts);
> +	res = sequencer_pick_revisions(&opts);

The new sequencer_pick_revisions is just a new name for the old
pick_revisions.  Sane, but probably worth mentioning in the log
message.

[...]
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1,7 +1,27 @@
>  #include "cache.h"
> +#include "object.h"
> +#include "commit.h"
> +#include "tag.h"
> +#include "run-command.h"
> +#include "exec_cmd.h"
> +#include "utf8.h"
> +#include "cache-tree.h"
> +#include "diff.h"
> +#include "revision.h"
> +#include "rerere.h"
> +#include "merge-recursive.h"
> +#include "refs.h"
> -#include "sequencer.h"
> -#include "strbuf.h"
>  #include "dir.h"
> +#include "sequencer.h"

Why did sequencer.h move to after dir.h?  Wow, we use a lot of headers
here --- I wonder if there are some pieces that could be split out
(that's not due to your patch, though).

[...]
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -8,6 +8,30 @@
>  #define SEQ_OPTS_FILE	"sequencer/opts"
>  
>  enum replay_action { REPLAY_REVERT, REPLAY_PICK };
> +enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
> +
> +struct replay_opts {
[...]
> @@ -25,4 +49,6 @@ struct replay_insn_list {
>   */
>  void remove_sequencer_state(int aggressive);
>  
> +int sequencer_pick_revisions(struct replay_opts *opts);

Ah, so this moves most of the logic of "git cherry-pick" to the sequencer
but the only new API that needs to be exposed is pick_revisions().  The
calling sequence looks like this:

	memset(&opts, o, sizeof(opts));
	opts.action = REPLAY_PICK;
	opts.revs = xmalloc(sizeof(*opts.revs));

	init_revisions(opts.revs);
	add_pending_object / setup_revisions / etc

	sequencer_pick_revisions(&opts);

The small exposed interface makes this a relatively uninvasive patch,
and the immediate advantage is that we plan to reuse some of the
functionality used in pick_revisions() in other, new APIs to be used
by commands other than cherry-pick.  No functional change yet intended.

Except for the commit message, looks reasonable (though I haven't
tried the "git blame" magic to check the code movement part).  Thanks.
