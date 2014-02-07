From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 1/9] submodule: prepare for recursive checkout of
 submodules
Date: Fri, 07 Feb 2014 22:01:37 +0100
Message-ID: <52F549B1.7050305@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com> <52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de> <52EFF290.5090501@web.de> <20140204000150.GJ30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:01:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsYb-00022m-4V
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbaBGVBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:01:41 -0500
Received: from mout.web.de ([212.227.15.3]:49311 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbaBGVBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:01:39 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M3jwL-1VKsIC2nw1-00rHSp for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140204000150.GJ30398@google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:9hE1BP9YDFkoyv4DpHLeC80xbGFKluquhpb5KpZc/MpOMBSFFKE
 cLcz2EfP7Cg26w0Df1J0mmmObYYwappEtFCYT0nGDm6tzMsfwbUuzErCjVbPhpcIQevYY5F
 5VX4cFTNVo+DMbcJX4Uhsi+7OLpmFi6ZEgcVKsPxsrBmw5MSHKSQvKRD0LudVPM00V18U8v
 TGHoARK3e3f8mfsBbZHgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241797>

Am 04.02.2014 01:01, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> --- /dev/null
>> +++ b/Documentation/recurse-submodules-update.txt
>> @@ -0,0 +1,8 @@
>> +--[no-]recurse-submodules::
>> +	Using --recurse-submodules will update the work tree of all
>> +	initialized submodules according to the commit recorded in the
>> +	superproject if their update configuration is set to checkout'. If
>> +	local modifications in a submodule would be overwritten the checkout
>> +	will fail unless forced. Without this option or with
>> +	--no-recurse-submodules is, the work trees of submodules will not be
>> +	updated, only the hash recorded in the superproject will be updated.
> 
> Tweaks:
> 
>  * Spelling out "--no-recurse-submodules, --recurse-submodules" (imitating
>    e.g. --decorate in git-log(1))
> 
>  * Shortening, using imperative mood
>  
>  * Skipping description of safety check, since it matches how checkout
>    works in general
> 
> That would make
> 
> 	--no-recurse-submodules::
> 	--recurse-submodules::
> 		Perform the checkout in submodules, too.  This only affects
> 		submodules with update strategy `checkout` (which is the
> 		default update strategy; see `submodule.<name>.update` in
> 		link:gitmodules[5]).
> 	+
> 	The default behavior is to update submodule entries in the superproject
> 	index and to leave the inside of submodules alone.  That behavior can also
> 	be requested explicitly with --no-recurse-submodules.

Much better, thanks!

> Ideas for further work:
> 
>  * The safety check probably deserves a new section where it could be
>    described in detail alongside a description of the corresponding check
>    for plain checkout.  Then the description of the -f option could
>    point to that section.

Good idea.

>  * What happens when update = merge, rebase, or !command?  I think
>    skipping them for now like suggested above is fine, but:
> 
>    - It would be even better to error out when there are changes to carry
>      over with update = merge or rebase

In the first round I'd rather do nothing (just like we do now) for merge
or rebase. These two should be tackled in a follow up series (especially
as I currently do not think everybody agrees on the desired behavior when
the branch config is set yet)

>    - Better still to perform the rebase when update = rebase
> 
>    - I have no idea what update = merge should do for non-fast-forward
>      moves

The same it does for checkout when we would overwrite local changes:
error out before doing anything and let the user sort things out?

>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -16,6 +16,8 @@ static struct string_list config_name_for_path;
>>  static struct string_list config_fetch_recurse_submodules_for_name;
>>  static struct string_list config_ignore_for_name;
>>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
>> +static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
>> +static int option_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> 
> Confusingly, config_update_recurse_submodules is set using the
> --recurse-submodules-default option, not configuration.  There's
> precedent for that in fetch.recurseSubmodules handling, but perhaps
> a comment would help --- something like
> 
> 	/*
> 	 * When no --recurse-submodules option was passed, should git fetch
> 	 * from submodules where submodule.<name>.fetchRecurseSubmodules
> 	 * doesn't indicate what to do?
> 	 *
> 	 * Controlled by fetch.recurseSubmodules.  The default is determined by
> 	 * the --recurse-submodules-default option, which propagates
> 	 * --recurse-submodules from the parent git process when recursing.
> 	 */
> 	static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> 
> 	/*
> 	 * When no --recurse-submodules option was passed, should git update
> 	 * the index and worktree within submodules (and in turn their
> 	 * submodules, etc)?
> 	 *
> 	 * Controlled by the --recurse-submodules-default option, which
> 	 * propagates --recurse-submodules from the parent git process
> 	 * when recursing.
> 	 */
> 	static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;

Makes lots of sense.

> [...]
>> @@ -382,6 +384,48 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
>>  	}
>>  }
>>
>> +int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
>> +{
>> +	switch (git_config_maybe_bool(opt, arg)) {
>> +	case 1:
>> +		return RECURSE_SUBMODULES_ON;
>> +	case 0:
>> +		return RECURSE_SUBMODULES_OFF;
>> +	default:
>> +		if (!strcmp(arg, "checkout"))
>> +			return RECURSE_SUBMODULES_ON;
> 
> Hm, is this arg == checkout case futureproofing for when
> --recurse-submodules learns to handle submodules without
> 'update = checkout', too?

Right.

> Is it safe to leave it out for now?

Yes it is.

> [...]
>> +int submodule_needs_update(const char *path)
> 
> Return value convention: 1 means "do update"; 0 means "don't update".
> 
> Some day later I suppose 2 or -1 could mean "error out".  Ok.
> 
> Naming nit: needs_update sounds like it's checking if there was a
> change at that path.  How about something like submodule_should_update(),
> !submodule_ignore_for_update(), or update_should_recurse_into_submodule()?

Good point, will do.

> [...]
>> @@ -589,6 +633,12 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>>  	return ret;
>>  }
>>
>> +void set_config_update_recurse_submodules(int default_value, int option_value)
>> +{
>> +	config_update_recurse_submodules = default_value;
>> +	option_update_recurse_submodules = option_value;
>> +}
> 
> Could option_parse_update_submodules set
> option_update_recurse_submodules directly?  Alternatively, could this
> function examine option_value so that submodule.c would only need one
> variable?
> 
> 	if (option_value == RECURSE_SUBMODULES_DEFAULT)
> 		update_recurse_submodules = default_value;
> 	else
> 		update_recurse_submodules = option_value;
> 
> If .gitmodules some day grows a submodule.<name>.checkoutRecurseSubmodules
> option then it would be convenient to have the option that overrides and
> the default tracked separately.  Is that the idea here?

Correct. I intend to add a global and per-submodule "autoupdate" setting
just like those we have for fetch.

> I might try writing a dummy command to test this basic --recurse-submodules
> option handling as a separate patch.

Hmm, I haven't thought of that. So far I was testing this in the regular
test cases and intended to add that to the test framework. Will think
about that.
