From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin
 commands
Date: Tue, 10 Jan 2012 12:38:57 -0600
Message-ID: <20120110183857.GC22184@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkgWJ-0007Rt-U9
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349Ab2AJSd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:33:59 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40750 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab2AJSd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:33:58 -0500
Received: by yhjj63 with SMTP id j63so876057yhj.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=o/ALRVL2k0eUPxpf/Stt8tTAfZTF47L8pwjf4fLNl3M=;
        b=vsfxBujR+j6HTodhF80S7T4pubnegrtb0eY7Na/qcCh+14LogKYfXugFmNkB8R81xN
         VEzPksNw7euli4OYjFAc7x7cT5U6n2SHw7AqVxlFeSl64FHa0gDrGYHxSFXB3KR42CxC
         XrdwF2NIkvHBJlNNAAcFGe31MpZ0rOXCccQ+I=
Received: by 10.236.185.138 with SMTP id u10mr28331730yhm.57.1326220437634;
        Tue, 10 Jan 2012 10:33:57 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q15sm45888331anm.4.2012.01.10.10.33.56
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 10:33:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326212039-13806-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188277>

Ramkumar Ramachandra wrote:

> Currently, 'git cherry-pick' fills up the '.git/sequencer/todo'
> instruction sheet with "pick" actions, while 'git revert' fills it up
> with "revert" actions.  Inspired by the way 'rebase -i' works, we
> would like to permit mixing arbitrary actions in the same instruction
> sheet.

Ok.

>        To do this, we first have to decouple the notion of an action
> in the instruction sheet from builtin commands.

Wha?

I guess at this point I get lost because you are using jargon.  What
is the difference between an action in the instruction sheet and a
builtin command?  How does being a busybox-style hard link to the main
"git" binary as opposed to a separate binary (which is what "builtin"
means) have anything to do with this at all?

And I don't have any sense of the impact.  Will this change the
behavior of "git cherry-pick"?  Will it avoid some confusion on the
part of future people modifying the code?  Is it a necessary step
before some future change we want?  Does it just make the code
prettier, and help the sanity of future readers in the process (which
is definitely valuable, too)?  The above doesn't make it clear to me.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -52,7 +57,7 @@ enum replay_subcommand {
>  };
>  
>  struct replay_opts {
> -	enum replay_action action;
> +	enum replay_command command;
>  	enum replay_subcommand subcommand;

This part seems to be renaming "action" to "command".  A cosmetic
change, which I don't have an immediate opinion about either way.

[...]
> -static const char *action_name(const struct replay_opts *opts)
> +static const char *command_name(struct replay_opts *opts)

This part does a similar renaming, and drops a const while at it for
no intelligible reason.

[...]
> @@ -142,7 +147,7 @@ static void verify_opt_mutually_compatible(const char *me, ...)
>  static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  {
>  	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
> -	const char *me = action_name(opts);
> +	const char *me = command_name(opts);

The rest is stuff like this, which follows from the first part.

Stepping back, I think the idea is that "enum replay_action" is not a
good way to identify the command name in error messages like

	fatal: cherry-pick: --abort cannot be used with --continue

So you introduce a _new_ enum to represent the command name.  Why not
just use a string, so commands using the nice and generic sequencer
library do not have to register themselves in a global callers list to
use it?

Plus the renaming of the ->action field and action_name() function
feel gratuitous, and drowned out the actual changes in the noise.

Does that clarify?

I guess I agree with the problem you are solving, but I don't agree
with the solution at all.

Thanks,
Jonathan
