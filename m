From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 2/8] gitweb: Option for filling only specified info in fill_project_list_info
Date: Wed, 22 Feb 2012 23:05:12 +0100
Message-ID: <201202222305.14387.jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com> <1329338332-30358-3-git-send-email-jnareb@gmail.com> <7vfwe6ng8u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:05:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0KJc-0002OC-BY
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab2BVWFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:05:31 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58869 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab2BVWFa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 17:05:30 -0500
Received: by eekc4 with SMTP id c4so103493eek.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:05:29 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.14.193 as permitted sender) client-ip=10.213.14.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.14.193 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.14.193])
        by 10.213.14.193 with SMTP id h1mr31637eba.44.1329948329643 (num_hops = 1);
        Wed, 22 Feb 2012 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=fFyRYrEMEf2YjzVQd+LlR3cGr+yku142T7JfLIVh1gQ=;
        b=Fqsp9+4dUQAac+LQ48Xpz0gwWcRrI05XbjO4HsKJYiKqsasq0P7xPWvNzqw6M0btDW
         16dl1BAlq6q/v0bBdC61mqBflpc+/eYm1CSI/5jzqjyHZdwDNO3CW+eQiFu351HoUrzh
         8wVDD7pbTlTVQrBH+Cf0s6uN+A5PWRl8WkCx8=
Received: by 10.213.14.193 with SMTP id h1mr23534eba.44.1329948329477;
        Wed, 22 Feb 2012 14:05:29 -0800 (PST)
Received: from [192.168.1.13] (abvp35.neoplus.adsl.tpnet.pl. [83.8.213.35])
        by mx.google.com with ESMTPS id n52sm107256200eea.5.2012.02.22.14.05.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:05:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfwe6ng8u.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191293>

On Mon, 20 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Introduce project_info_needs_filling($pr, $key[, \%fill_only]), which
> 
> That's "project_info_needs_filling($pr, @key[, \%fill_only])", isn't it?

Yes it is.  I'm sorry, I have missed that this needs fixing from the
first version of patch series.  Since then I have noticed that in few
cases we fill two fields at once, so we have to ask about two fields
at once as well.

> > +# entry for given @keys needs filling if at least one of interesting keys
> > +# in list is not present in %$project_info; key is interesting if $fill_only
> > +# is not passed, or is empty (all keys are interesting in both of those cases),
> > +# or if key is in $fill_only hash
> > +#
> > +# USAGE:
> > +# * project_info_needs_filling($project_info, 'key', ...)
> > +# * project_info_needs_filling($project_info, 'key', ..., \%fill_only)
> > +#   where %fill_only = map { $_ => 1 } @fill_only;
> 
> The reason this spells bad to me is that it gives the readers (and anybody
> who may want to touch gitweb code) that the caller has _two_ ways to say
> the same thing.
> 
> If a caller is interested in finding out $key in $project_info, it can
> either (1) pass $key as one of the earlier parameters to the function and
> not pass any \%fill_only, or (2) pass $key and pass \%fill_only but after
> making sure \%fill_only also has $key defined.
> 
> And if the caller passes \%fill_only, it has to remember that it needs to
> add $key to it; otherwise the earlier request "I want $key" is ignored by
> the function.

Yes, you are right.  All of this is caused by fill_project_list_info()
trying to do *two* things, instead of doing one thing and doing it well,
as is Unix philosophy.  It tried to check both that key is needed and
that key is wanted.

> Why is it a good thing to have such a convoluted API?

Thanks for a sanity check.

> Is it that "fill_project_list_info" is called by multiple callers, and
> they do not necessarily need to see all the fields that can be filled by
> the function (namely, age, age_string, descr, descr_long, owner, ctags and
> category)?  If that is the case, I must say that the approach to put the
> set filtering logic inside project_info_needs_filling function smells like
> a bad API design.

You are right.

> In other words, wouldn't a callchain that uses a more natural set of API
> functions be like this?
> 
> 	# the top-level caller that is interested only in these two fields
> 	fill_project_list_info($projlist, 'age', 'owner');
> 
> 	# in fill_project_list_info()
> 	my $projlist = shift;
> 	my %wanted = map { $_ => 1 } @_;
> 
> 	foreach my $pr (@$projlist) {
> 		if (project_info_needs_filling($pr,
> 			filter_set(\%wanted, 'age', 'age_string'))) {

That or

 		if (project_info_needs_filling($pr,  'age', 'age_string') &&
 		    project_info_is_wanted(\%wanted, 'age', 'age_string')) {

and in your case there is no duplication of field names.

filter_set() is simply intersection of two sets, but it treats empty
%wanted as a full set.

> 			... get @activity ...
>                         ($pr->{'age'}, $pr->{'age_string'}) = @activity;
> 		}
> 		...
> 	}
> 
> That way, "needs_filling" has to do one and only one thing well: it checks
> if any of the fields it was asked is missing and answers.  And a generic
> set filtering helper that takes a filtering hashref and an array can be
> used later outside of the "needs_filling" function.

Right.

> >  sub project_info_needs_filling {
> > +	my $fill_only = ref($_[-1]) ? pop : undef;
> >  	my ($project_info, @keys) = @_;
> >  
> >  	# return List::MoreUtils::any { !exists $project_info->{$_} } @keys;
> >  	foreach my $key (@keys) {
> > -		if (!exists $project_info->{$key}) {
> > +		if ((!$fill_only || !%$fill_only || $fill_only->{$key}) &&
> > +		    !exists $project_info->{$key}) {
> >  			return 1;
> >  		}
> >  	}
> >  	return;
> >  }
> >  
> > -
> 
> Shouldn't the previous patch updated not to add this blank line in the
> first place?

O.K.

> >  # fills project list info (age, description, owner, category, forks)
> 
> Is this enumeration up-to-date?  If we cannot keep it up-to-date, it may
> make sense to show only a few as examples and add ellipses.

O.K.

> >  # for each project in the list, removing invalid projects from
> > -# returned list
> > +# returned list, or fill only specified info (removing invalid projects
> > +# only when filling 'age').
> 
> It is unclear what the added clause wants to say; especially, the link
> between the mention of 'age' and 'only when' is unclear.  Is asking of
> 'age' what makes a request a notable exception to remove invalid projects?
> Or is asking to partially fill fields what triggers the removal of invalid
> projects, and you mentioned 'age' as an example?
> 
> If it is the former (I am guessing it is), it would be much clearer to
> say:
> 
>     Invalid projects are removed from the returned list if and only if you
>     ask 'age' to be filled, because of such and such reasons.
 
O.K.


Sidenote: the reason is that to check that project is valid you really
have to run git command that requires repository in it[1].  Only when
filling 'age' and 'age_string' using git_get_last_activity() we always
run git command.

[1] Gitweb actually uses --git-dir=<PATH> parameter to git wrapper.

-- 
Jakub Narebski
Poland
