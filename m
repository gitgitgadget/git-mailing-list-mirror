From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in
 fill_project_list_info
Date: Thu, 09 Feb 2012 14:04:11 -0800
Message-ID: <7vhayzvf38.fsf@alter.siamese.dyndns.org>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
 <1328359648-29511-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 23:04:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvc6G-00006z-3i
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 23:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112Ab2BIWEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 17:04:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758319Ab2BIWEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 17:04:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F9E7052;
	Thu,  9 Feb 2012 17:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0jNKsGzFoQ89
	BGItmATo/9fXbl0=; b=j0ceZPqoesd6/XptZv0r1rLRBlOlG+/Gxmq0w29TjvGz
	wadkJIBUDPYydkamO4IlEZrojphRVGoiYqQiy6S69mwB8TyiiqTnC9aETvQbXz+v
	uoazoCruhVGZc5EIoRRvnA2NBLNg4B1UiRHagCwtim9kwbAmms/feJBjXYuLT6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EaXy9S
	SV75Gp7vIL6zKGuUSCealVaYR67tNWsdqm19vE3Wv5sNQO5B2ES2HOYxjTIexKnY
	msyLp2CRKDTuIE5nqEktT2t0PSuvb1xvRWwA32o8SI0T4vuSyw4JkzpEiYSjyu8Z
	aTpb8CS9rwvAqQRvW6ianHmE6mogQJgFulXlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F2B7051;
	Thu,  9 Feb 2012 17:04:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D49DA704F; Thu,  9 Feb 2012
 17:04:12 -0500 (EST)
In-Reply-To: <1328359648-29511-2-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Sat, 4 Feb 2012 13:47:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFF61090-5369-11E1-B1F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190333>

Jakub Narebski <jnareb@gmail.com> writes:

> This could have been squashed with the next commit, but this way it i=
s
> pure refactoring that shouldn't change gitweb behavior.

It is not obvious why this shouldn't change gitweb behaviour from the
patch text.

The old code says "Unconditionally call git_get_last_activity(), and if=
 we
found nothing, do not do anything extra for this project". The new code
says "we do that but only if the project does not know its 'age' yet".

The lack of any real use of @fill_only in this patch also makes it hard=
 to
judge if the new API gives a useful semantics.  I would, without lookin=
g
at the real usage in 2/5 patch, na=C3=AFvely expect that such a lazy fi=
lling
scheme would say "I am going to use A, B and C; I want to know if any o=
f
them is missing, because I need values for all of them and I am going t=
o
call a helper function to fill them if any of them is missing. Having A
and B is not enough for the purpose of this query, because I still need=
 to
know C and I would call the helper function that computes all of them i=
n
such a case. Even though it might be wasteful to recompute A and B,
computing all three at once is the only helper function available to me=
".

So for a person who does not have access to the real usage of the new A=
PI,
being able to give only a single $key *appears* make no sense at all, a=
nd
also the meaning of the @fill_only parameter is unclear, especially the
part that checks if that single $key appears in @fill_only.

> Adding project_info_needs_filling() subroutine could have been split
> into separate commit, but it would be subroutine without use...
>
>  gitweb/gitweb.perl |   41 +++++++++++++++++++++++++++++++----------
>  1 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 913a463..b7a3752 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5185,35 +5185,56 @@ sub git_project_search_form {
>  	print "</div>\n";
>  }
> =20
> +# entry for given $key doesn't need filling if either $key already e=
xists
> +# in $project_info hash, or we are interested only in subset of keys
> +# and given key is not among @fill_only.
> +sub project_info_needs_filling {
> +	my ($project_info, $key, @fill_only) =3D @_;
> +
> +	if (!@fill_only ||            # we are interested in everything
> +	    grep { $key eq $_ } @fill_only) { # or key is in @fill_only
> +		# check if key is already filled
> +		return !exists $project_info->{$key};
> +	}
> +	# uninteresting key, outside @fill_only
> +	return 0;
> +}
> +
>  # fills project list info (age, description, owner, category, forks)
>  # for each project in the list, removing invalid projects from
> -# returned list
> +# returned list, or fill only specified info (removing invalid proje=
cts
> +# only when filling 'age').
> +#
>  # NOTE: modifies $projlist, but does not remove entries from it
>  sub fill_project_list_info {
> -	my $projlist =3D shift;
> +	my ($projlist, @fill_only) =3D @_;
>  	my @projects;
> =20
>  	my $show_ctags =3D gitweb_check_feature('ctags');
>   PROJECT:
>  	foreach my $pr (@$projlist) {
> -		my (@activity) =3D git_get_last_activity($pr->{'path'});
> -		unless (@activity) {
> -			next PROJECT;
> +		if (project_info_needs_filling($pr, 'age', @fill_only)) {
> +			my (@activity) =3D git_get_last_activity($pr->{'path'});
> +			unless (@activity) {
> +				next PROJECT;
> +			}
> +			($pr->{'age'}, $pr->{'age_string'}) =3D @activity;
>  		}
> -		($pr->{'age'}, $pr->{'age_string'}) =3D @activity;
> -		if (!defined $pr->{'descr'}) {
> +		if (project_info_needs_filling($pr, 'descr', @fill_only)) {
>  			my $descr =3D git_get_project_description($pr->{'path'}) || "";
>  			$descr =3D to_utf8($descr);
>  			$pr->{'descr_long'} =3D $descr;
>  			$pr->{'descr'} =3D chop_str($descr, $projects_list_description_wi=
dth, 5);
>  		}
> -		if (!defined $pr->{'owner'}) {
> +		if (project_info_needs_filling($pr, 'owner', @fill_only)) {
>  			$pr->{'owner'} =3D git_get_project_owner("$pr->{'path'}") || "";
>  		}
> -		if ($show_ctags) {
> +		if ($show_ctags &&
> +		    project_info_needs_filling($pr, 'ctags', @fill_only)) {
>  			$pr->{'ctags'} =3D git_get_project_ctags($pr->{'path'});
>  		}
> -		if ($projects_list_group_categories && !defined $pr->{'category'})=
 {
> +		if ($projects_list_group_categories &&
> +		    project_info_needs_filling($pr, 'category', @fill_only)) {
>  			my $cat =3D git_get_project_category($pr->{'path'}) ||
>  			                                   $project_list_default_category=
;
>  			$pr->{'category'} =3D to_utf8($cat);
