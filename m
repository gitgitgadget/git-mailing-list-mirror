From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] sequencer: factor code out of revert builtin
Date: Sun, 8 Jan 2012 14:38:00 -0600
Message-ID: <20120108203800.GM1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzQJ-00049g-5o
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab2AHUcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 15:32:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58222 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab2AHUcy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 15:32:54 -0500
Received: by iaeh11 with SMTP id h11so5711622iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8/8FZEa0VYNcNZBlUCiBKC8G2xVpUnMIwGQ2sMPDOlg=;
        b=t7PPXCu2BMogkwvuwjqyU+Nj1ZL9XlSmP94kuBSvOUKoRFHxlYZVSR5mUzDoSUgoUf
         m7FKIPljOnqihy6msHukpIBQf2y9W13Q6eKnaOslLA8bApOK9p9bosHfKdrgzcvALGnE
         KqNTMognFTKWbMo4RVaI6S3lpbUlhm1endM5E=
Received: by 10.42.153.6 with SMTP id k6mr13286292icw.30.1326054773545;
        Sun, 08 Jan 2012 12:32:53 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 5sm64881318ibe.8.2012.01.08.12.32.52
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 12:32:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326025653-11922-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188130>

Ramkumar Ramachandra wrote:

> Expose the cherry-picking machinery through a public
> sequencer_pick_revisions() (renamed from pick_revisions() in
> builtin/revert.c), so that cherry-picking and reverting are special
> cases of a general sequencer operation.  The cherry-pick builtin is
> now a thin wrapper that does command-line argument parsing before
> calling into sequencer_pick_revisions().  In the future, we can write
> a new "foo" builtin that calls into the sequencer like:

Nice.

I don't think the plan is actually a "foo" builtin.

I guess I would say "So now your 'foo' builtin can use the sequencer
machinery by implementing a 'parse_args_populate_opts' function and
then running the following:" so as to leave the reader more excited
and not to imply a promise we are not going to keep. :)

>   memset(&opts, 0, sizeof(opts));
>   opts.command = REPLAY_CMD_FOO;
>   opts.revisions = xmalloc(sizeof(*opts.revs));
>   parse_args_populate_opts(argc, argv, &opts);
>   init_revisions(opts.revs);
>   sequencer_pick_revisions(&opts);

Hm, I wonder if opts.command should be a string so each new caller
does not have to add to the enum and switch statements...

> This patch does not intend to make any functional changes.  Check
> with:
>
>   $ git blame -s -C HEAD^..HEAD -- sequencer.c

Neat.

[...]
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -24,6 +24,29 @@ enum replay_subcommand {
>  	REPLAY_ROLLBACK
>  };
>  
> +struct replay_opts {
[...]
> +};
[...]
> @@ -33,4 +56,6 @@ struct replay_insn_list {
[...]
> +int sequencer_pick_revisions(struct replay_opts *opts);

Looks sensible.  Maybe it would be useful to include a
Documentation/technical/api-sequencer.txt explaining how this is meant
to be used.  (Not much detail needed, just an overview.  See the
surrounding files for some examples.)

Haven't checked the code movement yet, since it is sitting on top of a
slushy base.  Next time, hopefully.

Thanks,
Jonathan
