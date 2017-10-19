Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7858202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 15:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbdJSPkb (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 11:40:31 -0400
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:20382 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbdJSPka (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 11:40:30 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e5CuI-0007p8-5L; Thu, 19 Oct 2017 17:38:50 +0200
Date:   Thu, 19 Oct 2017 17:38:44 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] submodule: simplify decision tree whether to or
 not to fetch
Message-ID: <20171019153844.GA41283@book.hvoigt.net>
References: <20171016135623.GA12756@book.hvoigt.net>
 <20171016135905.GD12756@book.hvoigt.net>
 <20171018180322.GA155019@google.com>
 <xmqqshegj7mo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshegj7mo.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 09:36:47AM +0900, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > On 10/16, Heiko Voigt wrote:
> >> To make extending this logic later easier.
> >
> > This makes things so much clearer, thanks!
> 
> I agree that it is clear to see what the code after the patch does,
> but the code before the patch is so convoluted to follow that it is
> a bit hard to see if the code before and after are doing the same
> thing, though ;-)

That is why I would appreciate some extra pairs of eyes on this :) I
tried to be as careful as possible when refactoring this, but since it
is quite convoluted something might have slipped through. The testsuite
does not show anything, but there might be corner cases that are not
tested I guess.

Will hopefully have time to look into the comments to the main patch of
this series tomorrow. Did not get around to properly do that yet.

Cheers Heiko

> >> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> >> ---
> >>  submodule.c | 74 ++++++++++++++++++++++++++++++-------------------------------
> >>  1 file changed, 37 insertions(+), 37 deletions(-)
> >> 
> >> diff --git a/submodule.c b/submodule.c
> >> index 71d1773e2e..82d206eb65 100644
> >> --- a/submodule.c
> >> +++ b/submodule.c
> >> @@ -1187,6 +1187,31 @@ struct submodule_parallel_fetch {
> >>  };
> >>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
> >>  
> >> +static int get_fetch_recurse_config(const struct submodule *submodule,
> >> +				    struct submodule_parallel_fetch *spf)
> >> +{
> >> +	if (spf->command_line_option != RECURSE_SUBMODULES_DEFAULT)
> >> +		return spf->command_line_option;
> >> +
> >> +	if (submodule) {
> >> +		char *key;
> >> +		const char *value;
> >> +
> >> +		int fetch_recurse = submodule->fetch_recurse;
> >> +		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> >> +		if (!repo_config_get_string_const(the_repository, key, &value)) {
> >> +			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> >> +		}
> >> +		free(key);
> >> +
> >> +		if (fetch_recurse != RECURSE_SUBMODULES_NONE)
> >> +			/* local config overrules everything except commandline */
> >> +			return fetch_recurse;
> >> +	}
> >> +
> >> +	return spf->default_option;
> >> +}
> >> +
> >>  static int get_next_submodule(struct child_process *cp,
> >>  			      struct strbuf *err, void *data, void **task_cb)
> >>  {
> >> @@ -1214,46 +1239,21 @@ static int get_next_submodule(struct child_process *cp,
> >>  			}
> >>  		}
> >>  
> >> -		default_argv = "yes";
> >> -		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> >> -			int fetch_recurse = RECURSE_SUBMODULES_NONE;
> >> -
> >> -			if (submodule) {
> >> -				char *key;
> >> -				const char *value;
> >> -
> >> -				fetch_recurse = submodule->fetch_recurse;
> >> -				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> >> -				if (!repo_config_get_string_const(the_repository, key, &value)) {
> >> -					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> >> -				}
> >> -				free(key);
> >> -			}
> >> -
> >> -			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
> >> -				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
> >> -					continue;
> >> -				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
> >> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> >> -									 submodule->name))
> >> -						continue;
> >> -					default_argv = "on-demand";
> >> -				}
> >> -			} else {
> >> -				if (spf->default_option == RECURSE_SUBMODULES_OFF)
> >> -					continue;
> >> -				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
> >> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> >> -									  submodule->name))
> >> -						continue;
> >> -					default_argv = "on-demand";
> >> -				}
> >> -			}
> >> -		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
> >> -			if (!unsorted_string_list_lookup(&changed_submodule_names,
> >> +		switch (get_fetch_recurse_config(submodule, spf))
> >> +		{
> >> +		default:
> >> +		case RECURSE_SUBMODULES_DEFAULT:
> >> +		case RECURSE_SUBMODULES_ON_DEMAND:
> >> +			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
> >>  							 submodule->name))
> >>  				continue;
> >>  			default_argv = "on-demand";
> >> +			break;
> >> +		case RECURSE_SUBMODULES_ON:
> >> +			default_argv = "yes";
> >> +			break;
> >> +		case RECURSE_SUBMODULES_OFF:
> >> +			continue;
> >>  		}
> >>  
> >>  		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
> >> -- 
> >> 2.14.1.145.gb3622a4
> >> 
