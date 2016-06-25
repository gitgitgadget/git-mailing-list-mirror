Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2011FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbcFYQNG (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:13:06 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:32947 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbcFYQNF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:13:05 -0400
Received: from app03.ox.hosteurope.de ([92.51.170.10]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	id 1bGqCb-0003SQ-A9; Sat, 25 Jun 2016 18:13:01 +0200
Date:	Sat, 25 Jun 2016 18:13:01 +0200 (CEST)
From:	Thomas Braun <thomas.braun@virtuell-zuhause.de>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Cc:	git@vger.kernel.org, peff@peff.net,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
Message-ID: <1072705888.508793.1466871181310.JavaMail.open-xchange@app03.ox.hosteurope.de>
In-Reply-To: <20160610151020.Horde.AfAwgXgKC_jSSpyr60T85sW@webmail.informatik.kit.edu>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com> <20160603183426.13140-1-thomas.braun@virtuell-zuhause.de> <20160603183426.13140-3-thomas.braun@virtuell-zuhause.de> <20160610151020.Horde.AfAwgXgKC_jSSpyr60T85sW@webmail.informatik.kit.edu>
Subject: Re: [PATCH v4 2/3] completion: add __git_get_option_value helper
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.2-Rev55
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1466871185;003eac5c;
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> SZEDER Gábor <szeder@ira.uka.de> hat am 10. Juni 2016 um 15:10 geschrieben:
> 
> Hallo Thomas,
> 
> I saw v5 hit my mailbox while writing this.  I glanced it over and it
> seems my comments here apply to that version as well.

Hi Gábor,

thanks for your comments.
I plan to send a reroll in the near future adressing your remarks.

Bye,
Thomas

> Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:
> 
> > This function allows to search the commmand line and config
> > files for an option, long and short, with mandatory value.
> >
> > The function would return e.g. for the command line
> > "git status -uno --untracked-files=all" the result
> > "all" regardless of the config option.
> 
> Wow, regarding my earlier remark about bonus points: I didn't realize
> that there were so many bonus point to give away :)
> 
> > Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> > ---
> > contrib/completion/git-completion.bash | 44  
> > ++++++++++++++++++++++++++++++++++
> > 1 file changed, 44 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash  
> > b/contrib/completion/git-completion.bash
> > index addea89..4bd17aa 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -803,6 +803,50 @@ __git_find_on_cmdline ()
> > 	done
> > }
> >
> > +# Echo the value of an option set on the command line or config
> > +#
> > +# $1: short option name
> > +# $2: long option name including =
> 
> I'm not sure about requiring the '=', the function could just append
> it as necessary.  More on this below.
> 
> > +# $3: list of possible values
> > +# $4: config string (optional)
> 
> I don't understand why the list of possible values is necessary.
> 
> This function will be called when the caller wants to take different
> actions based on different values, so the caller will process the
> function's output with a case statement or an if-else chain, both of
> which would be perfectly capable to ignore whatever invalid value the
> user might have specified.  Therefore, I think this function doesn't
> need the list of possible values, it should just return whatever value
> it found after the option.
> 
> > +# example:
> > +# result="$(__git_get_option_value "-d" "--do-something="\
> > +#     "yes no" "core.doSomething")"
> > +#
> > +# result is then either empty (no option set) or "yes" or "no"
> > +#
> > +# __git_get_option_value requires 3 arguments
> > +__git_get_option_value ()
> > +{
> > +	local c short_opt long_opt val
> > +	local result= values config_key word
> > +
> > +	short_opt="$1"
> > +	long_opt="$2"
> > +	values="$3"
> > +	config_key="$4"
> 
> These can be assigned when the variables are declared, saving a couple
> of lines.
> 
> > +	((c = $cword - 1))
> > +	while [ $c -ge 0 ]; do
> 
> Searching from the end of the command line, so even if someone were to
> do a 'git status -uall -unormal -uno <TAB>', this would still do the
> right thing.  Good!
> 
> However ;)
> Just for fun imagine following:
> 
>        $ >-uno
>        $ git status -- -uno <TAB>
> 
> 'git status' treats that '-uno' after the doubledash as a filename,
> but this function interprets it as an option, and on the subsequent
> TAB the completion script won't list untracked files.
> 
> I'm tempted to say that this is such a pathological corner case that
> it doesn't worth worrying about.
> 
> > +		word="${words[c]}"
> > +		for val in $values; do
> 
> Without the possible values argument this inner loop could go away.
> 
> > +			if [ "$short_opt$val" = "$word" ]
> > +			|| [ "$long_opt$val"  = "$word" ]; then
> > +				result="$val"
> > +				break 2
> 
> You could just 'echo "$val"' or rather ${word#$short_opt} and return
> here ...
> 
> > +			fi
> > +		done
> > +		((c--))
> > +	done
> > +
> > +	if [ -n "$config_key" ] && [ -z "$result" ]; then
> 
> ... and that would make the second condition unnecessary here ...
> 
> > +		result="$(git --git-dir="$(__gitdir)" config "$config_key")"
> 
> ... and this could just be a simple 'git config' execution, without
> command substitution ...
> 
> > +	fi
> > +
> > +	echo "$result"
> 
> ... and this echo could go away as well.
> 
> > +}
> > +
> > __git_has_doubledash ()
> > {
> > 	local c=1
> > --
> > 2.8.3.windows.1
> 
> 
> However, I'm not sure we need or want this helper function _at the
> moment_.  Yes, in general helper functions are good, and in this case
> it makes _git_status() easier to follow, but it has some drawbacks,
> too:
> 
>    - It has a single callsite: the upcoming _git_status().  No other
>      existing case springs to mind where it could be used, i.e. where
>      different values of an option would require different actions from
>      the completion script.  Maybe we'll have one in the future, maybe
>      not.
> 
>    - This function works only with the "stuck" form of options, i.e.
>      '--opt=val' or '-oval', which is mostly sufficient in this case,
>      because 'git status' understands only this form.  However, it
>      doesn't work with "unstuck" options, i.e. '--opt val' or '-o val'.
>      In many cases git supports only this "unstuck" form, and there are
>      many cases where it supports both for a given option.  We can't know
>      which form a future callsite might need, but requiring the '=' as
>      part of the long option seems to paint us into a corner.
> 
>    - I wrote "mostly sufficient" above, because 'git status' does accept
>      a valueless '-u|--untracked-files' option, too, e.g.:
> 
>        $ git config status.showUntrackedFiles no
>        $ git status --untracked-files
> 
>      lists untracked files, therefore the completion script should list
>      them as well.  Your function can't cope with this case, and I'm not
>      sure how it and its caller could differentiate between the presence
>      of such a valueless option and no option at all.  Perhaps with an
>      additional optional function parameter holding the default value
>      that should be echo-ed when a valueless option is encountered.
> 
> If this function were not a function but its logic were embedded into
> _git_status(), then we wouldn't have to spend any effort _now_ to come
> up with a proper calling convention that can cope with stuck vs.
> unstuck vs. both forms of options and with valueless options.  We would
> deal with all that and the necessary refactorization when (or if ever)
> there's a second potential callsite.  Embedding into _git_status()
> would give you more freedom to deal with the valueless '-u' option,
> too.  If embedded, some of my in-code comments wouldn't apply anymore,
> of course.
> 
> I'm in favor of crossing the bridge when we get there.
> 
> 
> Gábor
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
