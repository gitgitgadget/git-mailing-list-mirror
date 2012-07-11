From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Teach "git remote" about remote.default.
Date: Wed, 11 Jul 2012 11:27:06 -0700
Message-ID: <7vk3yaduh1.fsf@alter.siamese.dyndns.org>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
 <1342020841-24368-4-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Wed Jul 11 20:29:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp1fQ-0001II-Bd
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 20:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282Ab2GKS3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 14:29:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758255Ab2GKS1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 14:27:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E324640CF;
	Wed, 11 Jul 2012 14:27:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Fz03k3OEKt22o0CA1aaJAjStDe4=; b=MPD+/a+8CVQNtXqTG+fM
	esyysIb1xeyknZRayc10VduSVWU6ufTj3IfH+E8xyTWNTG1CPRa9rC5z/QFhNBUV
	lkNtvVt+/hUAkIlChLa+FaT2eKXh0cA/MSqBcDlkOnqxG93gLBrCoKfLIUTgdPud
	897K/1RIFyqy6m+fERC0of0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wDh5scUKKE5uXdEVXWrbpNiAjyYAlvesXc+ZU7YX131/tt
	a2VAsdGeptbeynVEq+r43CwH+gBJ0cjF52F0VPaqCoCHQayzGTbecdtBkiKE8enH
	j3Hj0udoAxVEV/EiJGRngcR/IyK2ORQxZ37vrNMLpDD5tfVcJ7WqJO++U2gJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D981F40CE;
	Wed, 11 Jul 2012 14:27:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E79840CD; Wed, 11 Jul 2012
 14:27:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05CF93A8-CB86-11E1-A17D-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201323>

marcnarc@xiplink.com writes:

> From: Marc Branchaud <marcnarc@xiplink.com>
>
> The "rename" and "rm" commands now handle the case where the remote being
> changed is the default remote.

"handle the case" is way underspecified.

Until I peeked the patch, I couldn't tell if you were now allowing
"git remote rm" that does not say which remote to remove the remote
named via remote.default by default, and had to wonder if you made
"git remote rename frotz" without any other argument mean "git
remote rename <remote.default> frotz" or the other way around.

        The "rename" and "rm" commands adjusts the value of the
        remote.default variable when they make the current default
        remote disappear.

> If the "add" command is used to add the repo's first remote, that remote
> becomes the default remote.

Probably sensible, but I could easily imagine existing users to be
surprised, harmed and complain, especially now those who want this
behaviour already have a separate "remote default" command to set it
themselves.

> Also introduce a "default" sub-command to get or set the default remote:
>
>  - "git remote default" (with no parameter) displays the current default remote.
>
>  - "git remote default <remo>" checks if <remo> is a configured remote and if
>    so changes remote.default to <remo>.

Avoid cute and not-widely-used abbreviation; in other words s/<remo>/<remote>/.

> These changes needed a couple of new helper functions in remote.c:
>  - remote_get_default_name() returns default_remote_name.
>  - remote_count() returns the number of remotes.
>
> (The test in t5528 had to be changed because now with push.default=matching
> a plain "git push" succeeds with "Everything up-to-date".  It used to
> fail with "No configured push destination".)

I would like to see people think, when their "new feature" breaks
existing tests and needs adjustments, like this:

    Even test scripts gets upset with this unexpected behaviour
    change---real users may also be hurt the same way.  Should we
    really need to do this change?  What can we do to help them?

Even though I said "Probably sensible", I would prefer the "first
remote automatically replaces 'origin'" feature not to be part of
this patch.  It is something we can queue separately on top as a
separate feature.

I personally think in the long run it is probably the right thing to
do, but at the same time, I do not think it is something we want to
throw at the users as a flag-day event without transition planning.

> +'default'::
> +
> +Displays or sets the name of the repository's default remote.  When git needs
> +to automatically choose a remote to use, it first tries to use the remote
> +associated with the currently checked-out branch.  If the currently
> +checked-out branch has no remote, git uses the repository's default remote.
> +If the repository has no default remote, git tries to use a remote named
> +"origin" even if there is no actual remote named "origin".  (In other words,
> +the default value for the default remote name is "origin".)

After saying something long-winded and convoluted that you think it
needs "In other words," appended, try to re-read the sentence
without the long-winded part (and "In other words,").  I often find
that the long description is unnecessary after doing so myself.

I wonder if it makes the result easier to read if you consolidated
all the duplicated explanations of what the "default remote" is/does
in this patch and previous patches to a single place (perhaps
glossary) and refer to it from these places, e.g.

	default::

        	Display or sets the name of the default remote for
	        the repository.  See "default remote" in
	        linkgit:gitglossary[7].

>  'rename'::
>  
> -Rename the remote named <old> to <new>. All remote-tracking branches and
> +Renames the remote named <old> to <new>. All remote-tracking branches and

Why change the mood from imperative (which I thought was the norm
for these command descriptions) to third-person-present?

>  configuration settings for the remote are updated.
>  +
>  In case <old> and <new> are the same, and <old> is a file under
>  `$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
>  the configuration file format.
> ++
> +If <old> was the repository's default remote name, the default remote name
> +changes to <new>.

This is unrelated to your patch, but I wonder what should happen to
this repository:

	git config branch.foo.remote origin
        git remote rename origin upstream

Should branch.foo.remote be updated, and if so how (either set to
upstream or configuration removed)?

>  'rm'::
>  
> -Remove the remote named <name>. All remote-tracking branches and
> -configuration settings for the remote are removed.
> +Removes the remote named <name>. All remote-tracking branches and

Why change the mood from imperative (which I thought was the norm
for these command descriptions) to third-person-present?

> +configuration settings for the remote are removed.  If the remote was
> +the repository's default remote, then the repository's default remote
> +name is changed to "origin".  Use 'git remote default <name>' to set
> +the repository's default remote name.

I think your patch actually removes remote.default (which I think is
good), and describing it as "changes default remot to 'origin'" like
you did above is perfectly good.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 920262d..1fb272c 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -12,6 +12,7 @@ static const char * const builtin_remote_usage[] = {
>  	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>",
>  	"git remote rename <old> <new>",
>  	"git remote rm <name>",
> +	"git remote default [<name>]",
>  	"git remote set-head <name> (-a | -d | <branch>)",
>  	"git remote [-v | --verbose] show [-n] <name>",
>  	"git remote prune [-n | --dry-run] <name>",
> @@ -198,6 +199,9 @@ static int add(int argc, const char **argv)
>  	if (!valid_fetch_refspec(buf2.buf))
>  		die(_("'%s' is not a valid remote name"), name);
>  
> +	if (remote_count() == 1) /* remote_get() adds a remote if it's new */
> +		git_config_set("remote.default", name);
> +
>  	strbuf_addf(&buf, "remote.%s.url", name);
>  	if (git_config_set(buf.buf, url))
>  		return 1;
> @@ -656,6 +660,10 @@ static int mv(int argc, const char **argv)
>  		return error(_("Could not rename config section '%s' to '%s'"),
>  				buf.buf, buf2.buf);
>  
> +	if (!strcmp(oldremote->name, remote_get_default_name())) {
> +		git_config_set("remote.default", newremote->name);
> +	}
> +
>  	strbuf_reset(&buf);
>  	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
>  	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
> @@ -798,6 +806,10 @@ static int rm(int argc, const char **argv)
>  	if (git_config_rename_section(buf.buf, NULL) < 1)
>  		return error(_("Could not remove config section '%s'"), buf.buf);
>  
> +	if (!strcmp(remote->name, remote_get_default_name())) {
> +		git_config_set("remote.default", NULL);
> +	}
> +
>  	read_branches();
>  	for (i = 0; i < branch_list.nr; i++) {
>  		struct string_list_item *item = branch_list.items + i;
> @@ -845,6 +857,21 @@ static int rm(int argc, const char **argv)
>  	return result;
>  }
>  
> +static int deflt(int argc, const char **argv)

Perhaps it is a good time to update the naming convention of
functions that implement subcommands (e.g. cmd_default())?

> +{
> +	if (argc < 2)
> +		printf_ln("%s", remote_get_default_name());

Good.  If somebody anal cares about the vanilla hardcoded default
'origin' and 'remote.default' having 'origin' as a configured value,
he should be using "git config" to ask the difference.  Users of
"remote default" interface should not have to care.

> +	else {
> +		const char *name = argv[1];
> +		if (remote_is_configured(name)) {
> +			git_config_set("remote.default", name);
> +			printf_ln(_("Default remote set to '%s'."), name);
> +		} else
> +			return error(_("No remote named '%s'."), name);
> +	}

I am not sure if this is a good idea.  Shouldn't "git remote default
frotz" followed by "git remote add frotz" work?  I'd prefer to see
this demoted to a warning, perhaps like this:

	if (!remote_is_configured(name))
		warning(_("No remote named '%s' defined yet."),
		name);
	git_confg_set("remote.default", name);

without the noisy report of "I did what you told me to do".
