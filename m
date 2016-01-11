From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 2/2] builtin/grep: add grep.fallbackToNoIndex config
Date: Mon, 11 Jan 2016 23:35:24 +0100
Message-ID: <20160111223524.GF10612@hank>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
 <1452547580-30687-3-git-send-email-t.gummerer@gmail.com>
 <20160111214846.GC21131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:35:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIl3O-0006hF-M0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 23:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760426AbcAKWfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 17:35:04 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33335 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760063AbcAKWfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 17:35:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so28298766wmu.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X25LI4CUr/6tqAKKC6XV+MNV06/QahutWZGdLijEU30=;
        b=MOt86QfHVeTlB5e3RyPQUfquXfvW6KvcXS6EPlVlqA2FGFt6bURapUer+b30lZ+EZt
         KkJdYChZD7pY1PX6PrLstLYzKk8B+1drfkQaQfqupCKxZv1QUSPTa2KzBVErnxIYYV9s
         BrJfrTIrWzk2htt2i/P9Zkal6MwvMrMcwrXEQVSxlAjTqnqQ178cZNCjh8s9+E0pxA+0
         qQhzkpu8OGHejysHoLBH2rjISy/3On2oRMw98+0hnNG5tn1OoFA9tZYy45l0hhIB9MG6
         jRmo/+iIgwDWPQIsWJfuCwvRBcFx7kHrQJIhHoD/kVNAz/c/hJJXu55UpmmhkPBtYct+
         48jw==
X-Received: by 10.194.9.169 with SMTP id a9mr135209488wjb.60.1452551701194;
        Mon, 11 Jan 2016 14:35:01 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id e136sm14744634wma.23.2016.01.11.14.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 14:34:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160111214846.GC21131@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283730>

On 01/11, Jeff King wrote:
> On Mon, Jan 11, 2016 at 10:26:20PM +0100, Thomas Gummerer wrote:
>
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 4229cae..5efe9bb 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -755,9 +755,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  			     PARSE_OPT_STOP_AT_NON_OPTION);
> >  	grep_commit_pattern_type(pattern_type_arg, &opt);
> >
> > -	if (use_index && !startup_info->have_repository)
> > -		/* die the same way as if we did it at the beginning */
> > -		setup_git_directory();
> > +	if (use_index && !startup_info->have_repository) {
> > +		int fallback = 0;
> > +		git_config_get_bool("grep.fallbacktonoindex", &fallback);
> > +		if (fallback) {
> > +			int nongit = 0;
> > +
> > +			setup_git_directory_gently(&nongit);
> > +			if (nongit)
> > +				use_index = 0;
> > +		} else {
> > +			/* die the same way as if we did it at the beginning */
> > +			setup_git_directory();
> > +		}
> > +	}
>
> Hmm. We used to have problems accessing config before calling
> setup_git_directory(). I am not sure if that is still the case, though.

A few lines earlier, git_config() is called, so I guess we're fine
here.

> I guess the startup sequence is muddied here, though. cmd_grep() is
> marked as RUN_SETUP_GENTLY, so we would have already run setup, and here
> we are following the "we are not in a repository" code path (i.e., we
> saw "!startup_info->have_repository").
>
> And the existing setup_git_directory() is just there to die(), as the
> comment explains. So what is the new setup_git_directory_gently() doing?
> We know we've already done setup, and that we're not in a git repo,
> right? Shouldn't we just be able to set use_index to 0 and keep going?
> Under what circumstances would it _not_ return "nongit == 1"?

I don't think it ever does return nongit == 1.  I'm not sure why I
thought that could be the case, will fix in the re-roll.

> > @@ -874,12 +885,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  		setup_pager();
> >
> >  	if (!use_index && (untracked || cached))
> > -		die(_("--cached or --untracked cannot be used with --no-index."));
> > +		die(_("--cached or --untracked cannot be used with --no-index "
> > +		      "or outside of a git repository"));
>
> I'm lukewarm on this (and the other) change. What you've written is
> technically correct, but it's getting rather verbose. We've presented
> the option already as "turn on --no-index by default outside a
> repository", so I'm not sure we need to clarify it here. Since it's a
> feature people must turn on manually, presumably they would know that.

Yes, I think I agree with you.  The original error message should give
enough information for users.  Will revert the change in the re-roll.

> I don't know, maybe it would help somebody. I'm not strongly opposed.
>
> -Peff
