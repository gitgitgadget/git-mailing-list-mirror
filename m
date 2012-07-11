From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 3/6] Teach "git remote" about remote.default.
Date: Wed, 11 Jul 2012 16:41:17 -0400
Message-ID: <4FFDE4ED.8020502@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com> <1342020841-24368-4-git-send-email-marcnarc@xiplink.com> <7vk3yaduh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:41:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp3iv-0005DZ-4r
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 22:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225Ab2GKUlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 16:41:17 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:37950 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933218Ab2GKUlP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 16:41:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 815701C01A5;
	Wed, 11 Jul 2012 16:41:14 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp26.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 18BF81C00FE;
	Wed, 11 Jul 2012 16:41:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vk3yaduh1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201329>

On 12-07-11 02:27 PM, Junio C Hamano wrote:
> marcnarc@xiplink.com writes:
> 
>> From: Marc Branchaud <marcnarc@xiplink.com>
>>
>> The "rename" and "rm" commands now handle the case where the remote being
>> changed is the default remote.
> 
> "handle the case" is way underspecified.
> 
> Until I peeked the patch, I couldn't tell if you were now allowing
> "git remote rm" that does not say which remote to remove the remote
> named via remote.default by default, and had to wonder if you made
> "git remote rename frotz" without any other argument mean "git
> remote rename <remote.default> frotz" or the other way around.
> 
>         The "rename" and "rm" commands adjusts the value of the
>         remote.default variable when they make the current default
>         remote disappear.

I'll use that.

>> If the "add" command is used to add the repo's first remote, that remote
>> becomes the default remote.
> 
> Probably sensible, but I could easily imagine existing users to be
> surprised, harmed and complain, especially now those who want this
> behaviour already have a separate "remote default" command to set it
> themselves.

As you suggest below, it makes more sense to put the
first-remote-is-the-default change in a separate patch.  I'll combine it with
the git-clone change in patch #4.

>> Also introduce a "default" sub-command to get or set the default remote:
>>
>>  - "git remote default" (with no parameter) displays the current default remote.
>>
>>  - "git remote default <remo>" checks if <remo> is a configured remote and if
>>    so changes remote.default to <remo>.
> 
> Avoid cute and not-widely-used abbreviation; in other words s/<remo>/<remote>/.

OK.

>> These changes needed a couple of new helper functions in remote.c:
>>  - remote_get_default_name() returns default_remote_name.
>>  - remote_count() returns the number of remotes.
>>
>> (The test in t5528 had to be changed because now with push.default=matching
>> a plain "git push" succeeds with "Everything up-to-date".  It used to
>> fail with "No configured push destination".)
> 
> I would like to see people think, when their "new feature" breaks
> existing tests and needs adjustments, like this:
> 
>     Even test scripts gets upset with this unexpected behaviour
>     change---real users may also be hurt the same way.  Should we
>     really need to do this change?  What can we do to help them?

I did not think the change was that important, because the fact that the
command failed looked like a bug to me (ie. just because I used "-o foo" when
I cloned shouldn't make "git push" with push.default=matching fail).  So it
feels to me like the patch is just making things work the way they should
have in the first place.

> Even though I said "Probably sensible", I would prefer the "first
> remote automatically replaces 'origin'" feature not to be part of
> this patch.  It is something we can queue separately on top as a
> separate feature.

Agreed.

However, this push.default=matching change isn't caused by the "first remote
automatically replaces 'origin'" stuff.  It's a direct result of having
remote.default set.

> I personally think in the long run it is probably the right thing to
> do, but at the same time, I do not think it is something we want to
> throw at the users as a flag-day event without transition planning.

Fair enough.

What about a warning displayed if "remote.default" is not set?  Something like:

	This repository does not have an explicitly configured default
	remote.  Selecting "origin" as the default remote repository.
	To suppress this warning, or if you wish to have a different
	default remote repository, run "git remote default <name>".
	In git X.Y, the default remote will be automatically configured
	as the first remote added to the repository.

>> +'default'::
>> +
>> +Displays or sets the name of the repository's default remote.  When git needs
>> +to automatically choose a remote to use, it first tries to use the remote
>> +associated with the currently checked-out branch.  If the currently
>> +checked-out branch has no remote, git uses the repository's default remote.
>> +If the repository has no default remote, git tries to use a remote named
>> +"origin" even if there is no actual remote named "origin".  (In other words,
>> +the default value for the default remote name is "origin".)
> 
> After saying something long-winded and convoluted that you think it
> needs "In other words," appended, try to re-read the sentence
> without the long-winded part (and "In other words,").  I often find
> that the long description is unnecessary after doing so myself.

I'll take another crack at it.

> I wonder if it makes the result easier to read if you consolidated
> all the duplicated explanations of what the "default remote" is/does
> in this patch and previous patches to a single place (perhaps
> glossary) and refer to it from these places, e.g.
> 
> 	default::
> 
>         	Display or sets the name of the default remote for
> 	        the repository.  See "default remote" in
> 	        linkgit:gitglossary[7].

Good idea!

>>  'rename'::
>>  
>> -Rename the remote named <old> to <new>. All remote-tracking branches and
>> +Renames the remote named <old> to <new>. All remote-tracking branches and
> 
> Why change the mood from imperative (which I thought was the norm
> for these command descriptions) to third-person-present?

This was to make the file consistent -- some parts were already in
third-person-present.  I simply chose the wrong tense -- will change it to
all-imperative.

>>  configuration settings for the remote are updated.
>>  +
>>  In case <old> and <new> are the same, and <old> is a file under
>>  `$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
>>  the configuration file format.
>> ++
>> +If <old> was the repository's default remote name, the default remote name
>> +changes to <new>.
> 
> This is unrelated to your patch, but I wonder what should happen to
> this repository:
> 
> 	git config branch.foo.remote origin
>         git remote rename origin upstream
> 
> Should branch.foo.remote be updated, and if so how (either set to
> upstream or configuration removed)?

I believe it should be updated, and that it should be set to "upstream".

An lo!  This is exactly what git already does...  :)

>>  'rm'::
>>  
>> -Remove the remote named <name>. All remote-tracking branches and
>> -configuration settings for the remote are removed.
>> +Removes the remote named <name>. All remote-tracking branches and
> 
> Why change the mood from imperative (which I thought was the norm
> for these command descriptions) to third-person-present?
> 
>> +configuration settings for the remote are removed.  If the remote was
>> +the repository's default remote, then the repository's default remote
>> +name is changed to "origin".  Use 'git remote default <name>' to set
>> +the repository's default remote name.
> 
> I think your patch actually removes remote.default (which I think is
> good), and describing it as "changes default remot to 'origin'" like
> you did above is perfectly good.
> 
>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index 920262d..1fb272c 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -12,6 +12,7 @@ static const char * const builtin_remote_usage[] = {
>>  	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>",
>>  	"git remote rename <old> <new>",
>>  	"git remote rm <name>",
>> +	"git remote default [<name>]",
>>  	"git remote set-head <name> (-a | -d | <branch>)",
>>  	"git remote [-v | --verbose] show [-n] <name>",
>>  	"git remote prune [-n | --dry-run] <name>",
>> @@ -198,6 +199,9 @@ static int add(int argc, const char **argv)
>>  	if (!valid_fetch_refspec(buf2.buf))
>>  		die(_("'%s' is not a valid remote name"), name);
>>  
>> +	if (remote_count() == 1) /* remote_get() adds a remote if it's new */
>> +		git_config_set("remote.default", name);
>> +
>>  	strbuf_addf(&buf, "remote.%s.url", name);
>>  	if (git_config_set(buf.buf, url))
>>  		return 1;
>> @@ -656,6 +660,10 @@ static int mv(int argc, const char **argv)
>>  		return error(_("Could not rename config section '%s' to '%s'"),
>>  				buf.buf, buf2.buf);
>>  
>> +	if (!strcmp(oldremote->name, remote_get_default_name())) {
>> +		git_config_set("remote.default", newremote->name);
>> +	}
>> +
>>  	strbuf_reset(&buf);
>>  	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
>>  	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
>> @@ -798,6 +806,10 @@ static int rm(int argc, const char **argv)
>>  	if (git_config_rename_section(buf.buf, NULL) < 1)
>>  		return error(_("Could not remove config section '%s'"), buf.buf);
>>  
>> +	if (!strcmp(remote->name, remote_get_default_name())) {
>> +		git_config_set("remote.default", NULL);
>> +	}
>> +
>>  	read_branches();
>>  	for (i = 0; i < branch_list.nr; i++) {
>>  		struct string_list_item *item = branch_list.items + i;
>> @@ -845,6 +857,21 @@ static int rm(int argc, const char **argv)
>>  	return result;
>>  }
>>  
>> +static int deflt(int argc, const char **argv)
> 
> Perhaps it is a good time to update the naming convention of
> functions that implement subcommands (e.g. cmd_default())?

I struggled with the naming here, so I agree.  I thought of using _default().

Since the "cmd_" prefix is already used for the main commands, perhaps
another prefix for subcommands?  Maybe "sub_"?  Some of the shell-based
commands use the main command itself as a prefix (e.g. bisect_start()).
Doing that here would mean "remote_default()" etc.  Any preference?

>> +{
>> +	if (argc < 2)
>> +		printf_ln("%s", remote_get_default_name());
> 
> Good.  If somebody anal cares about the vanilla hardcoded default
> 'origin' and 'remote.default' having 'origin' as a configured value,
> he should be using "git config" to ask the difference.  Users of
> "remote default" interface should not have to care.
> 
>> +	else {
>> +		const char *name = argv[1];
>> +		if (remote_is_configured(name)) {
>> +			git_config_set("remote.default", name);
>> +			printf_ln(_("Default remote set to '%s'."), name);
>> +		} else
>> +			return error(_("No remote named '%s'."), name);
>> +	}
> 
> I am not sure if this is a good idea.  Shouldn't "git remote default
> frotz" followed by "git remote add frotz" work?

To me it feels wrong to allow the user to set the default remote to something
that doesn't actually exist.  It's like trying to add a non-existent file.
And what if the user forgets the second step?

It seems saner for a command to fail if it knows a change it's about to make
will cause problems.

> I'd prefer to see
> this demoted to a warning, perhaps like this:
> 
> 	if (!remote_is_configured(name))
> 		warning(_("No remote named '%s' defined yet."),
> 		name);
> 	git_confg_set("remote.default", name);

The warning helps, but it still feels wrong.

Plus the wording doesn't make it clear that the configuration was changed
anyway.  (Yes, it says "warning" and all, but as a user I can't be sure.)  If
we were to use a warning, it should be "Set the default remote to '%s' even
though no remote with that name exists."

> without the noisy report of "I did what you told me to do".

I'll drop the noise.

		M.
