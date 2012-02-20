From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/8] gitweb: Option for filling only specified info in
 fill_project_list_info
Date: Sun, 19 Feb 2012 22:58:09 -0800
Message-ID: <7vfwe6ng8u.fsf@alter.siamese.dyndns.org>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
 <1329338332-30358-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 07:58:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzNCr-0003KX-RA
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 07:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796Ab2BTG6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 01:58:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab2BTG6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 01:58:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7C99311D;
	Mon, 20 Feb 2012 01:58:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kVyTk7sbpeoI9vw8CLO5RaNj67w=; b=yEhQ5V
	PkeM2mPRySp7ii3wibcr5P77gyHIvaUlaXeeIMmUtfAyqXwDLtA7Lh1SQcD1auJn
	/22JaCtsYhABMuwPzyC9NS0SvwsF2VuY4+lLJKDBrrj9qUrNX0OwQ6vNeg3lCgoX
	Vu/rGSghJj8j1KvqjnLuqczFCX5FM14iugYws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rAk2sSlL4LfCtBATmAoBSbuQeCW+Yqbn
	5UgAZRBAGXrKa5XAVtezUXY/o6/wywMyQFRDZSkLYyz/7UtJbNVAY7zt68N8l5eT
	mZArwS9LJLeyK9o7R6s0MLfwAFBLyjLjCn8WL9lEXeuXfgZG6wD1cTkV+loTV4Oi
	o0fC217cW+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF714311B;
	Mon, 20 Feb 2012 01:58:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27AD33119; Mon, 20 Feb 2012
 01:58:11 -0500 (EST)
In-Reply-To: <1329338332-30358-3-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 15 Feb 2012 21:38:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40670476-5B90-11E1-AA7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191046>

Jakub Narebski <jnareb@gmail.com> writes:

> Introduce project_info_needs_filling($pr, $key[, \%fill_only]), which

That's "project_info_needs_filling($pr, @key[, \%fill_only])", isn't it?

> +# entry for given @keys needs filling if at least one of interesting keys
> +# in list is not present in %$project_info; key is interesting if $fill_only
> +# is not passed, or is empty (all keys are interesting in both of those cases),
> +# or if key is in $fill_only hash
> +#
> +# USAGE:
> +# * project_info_needs_filling($project_info, 'key', ...)
> +# * project_info_needs_filling($project_info, 'key', ..., \%fill_only)
> +#   where %fill_only = map { $_ => 1 } @fill_only;

The reason this spells bad to me is that it gives the readers (and anybody
who may want to touch gitweb code) that the caller has _two_ ways to say
the same thing.

If a caller is interested in finding out $key in $project_info, it can
either (1) pass $key as one of the earlier parameters to the function and
not pass any \%fill_only, or (2) pass $key and pass \%fill_only but after
making sure \%fill_only also has $key defined.

And if the caller passes \%fill_only, it has to remember that it needs to
add $key to it; otherwise the earlier request "I want $key" is ignored by
the function.

Why is it a good thing to have such a convoluted API?

Is it that "fill_project_list_info" is called by multiple callers, and
they do not necessarily need to see all the fields that can be filled by
the function (namely, age, age_string, descr, descr_long, owner, ctags and
category)?  If that is the case, I must say that the approach to put the
set filtering logic inside project_info_needs_filling function smells like
a bad API design.

In other words, wouldn't a callchain that uses a more natural set of API
functions be like this?

	# the top-level caller that is interested only in these two fields
        fill_project_list_info($projlist, 'age', 'owner');

        # in fill_project_list_info()
	my $projlist = shift;
        my %wanted = map { $_ => 1 } @_;

	foreach my $pr (@$projlist) {
		if (project_info_needs_filling($pr,
			filter_set(\%wanted, 'age', 'age_string'))) {
			... get @activity ...
                        ($pr->{'age'}, $pr->{'age_string'}) = @activity;
		}
		...
	}

That way, "needs_filling" has to do one and only one thing well: it checks
if any of the fields it was asked is missing and answers.  And a generic
set filtering helper that takes a filtering hashref and an array can be
used later outside of the "needs_filling" function.

>  sub project_info_needs_filling {
> +	my $fill_only = ref($_[-1]) ? pop : undef;
>  	my ($project_info, @keys) = @_;
>  
>  	# return List::MoreUtils::any { !exists $project_info->{$_} } @keys;
>  	foreach my $key (@keys) {
> -		if (!exists $project_info->{$key}) {
> +		if ((!$fill_only || !%$fill_only || $fill_only->{$key}) &&
> +		    !exists $project_info->{$key}) {
>  			return 1;
>  		}
>  	}
>  	return;
>  }
>  
> -

Shouldn't the previous patch updated not to add this blank line in the
first place?

>  # fills project list info (age, description, owner, category, forks)

Is this enumeration up-to-date?  If we cannot keep it up-to-date, it may
make sense to show only a few as examples and add ellipses.

>  # for each project in the list, removing invalid projects from
> -# returned list
> +# returned list, or fill only specified info (removing invalid projects
> +# only when filling 'age').

It is unclear what the added clause wants to say; especially, the link
between the mention of 'age' and 'only when' is unclear.  Is asking of
'age' what makes a request a notable exception to remove invalid projects?
Or is asking to partially fill fields what triggers the removal of invalid
projects, and you mentioned 'age' as an example?

If it is the former (I am guessing it is), it would be much clearer to
say:

    Invalid projects are removed from the returned list if and only if you
    ask 'age' to be filled, because of such and such reasons.
